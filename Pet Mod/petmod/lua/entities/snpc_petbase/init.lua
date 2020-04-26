//
/*
  Pet base AI
  by Nautical
*/

include("shared.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

// Pooled strings
util.AddNetworkString("SNPC_PETBASE_INFO")
util.AddNetworkString("SNPC_PETBASE_UPDATE_STATE")
util.AddNetworkString("SNPC_PETBASE_BIRTHDAY")
util.AddNetworkString("SNPC_PETBASE_DISOWN")

local function QuickTrace(p1,p2,mask,filter)

  local t = {}
  t.start = p1
  t.endpos = p2
  t.mask = mask
  t.filter = filter

  return util.TraceLine(t)
end
// Entity base

function ENT:Initialize()

  // Attributes
  self.loco:SetJumpHeight(65)
  self.maxHp = 250
  self.maxSize = 2
  self.age = 0
  self.maxAge = 10
  self.model = ""

  // Locomotion
  self.walkAnimation = ""
  self.runAnimation = ""
  self.idleAnimation = ""
  self.attackAnimation = ""

  self.walkSpeed = 110
  self.runSpeed = 210

  self.walkAnimRate = 1
  self.runAnimRate = 1
  self.attackAnimRate = 1

  self.onAttack = nil

  // Sounds
  self.idleSounds = {}
  self.walkSounds = {}
  self.runSounds = {}
  self.attackSounds = {}

  // DO NOT TOUCH
  self.attackDuration = 0;
  self.lastAge = 0
  self.path = Path("Follow")
  self.owner = nil
  self.currentAnimation = ""
  self.nextAnimTime = 0
  self.enemies = {}
  self.lastAttack = 0
  self.lastUse = 0
  self.name = ""
  self.stay = false

  self:SetModel("models/police.mdl") // base model
  self:SetCollisionGroup(COLLISION_GROUP_WORLD)
end

function ENT:SetPetName(name)
  name = name || nil;
  if (name == nil) then
    local randUser = http.Fetch("https://randomuser.me/api/",function(body)

      local decode = util.JSONToTable(body)

      decode = decode.results[1]

      self:SetDisplayName(string.FormatName(decode.name.title .. ". " .. decode.name.first .. " " .. decode.name.last));
    end)
  else
    self:SetDisplayName(string.FormatName(name));
  end
end

function ENT:Use(activator)

  if (CurTime() - self.lastUse < 1.5) then return end

  local data = {

    ent = self,
    name = self:GetDisplayName(),
    owner = self.owner,
    age = self.age,
    health = self:Health(),
    stay = self.stay,
  }

  net.Start("SNPC_PETBASE_INFO")

    net.WriteTable(data)
  net.Send(activator)

  self.lastUse = CurTime()
end

function ENT:Prep(info)

  for k,v in next, info do

    self[k] = v
  end

  if (!PetConfig.shouldAge) then
    self.age = self.maxAge
  end

  self:SetModel(self.model)
  local scaleCoeff = (math.min(self.age,self.maxAge) / self.maxAge)
  self:SetModelScale(math.max(0.2,scaleCoeff * self.maxSize), rate) // scale our model relative to our age

  local attackSeqId, attackSeqDuration = self:LookupSequence(self.attackAnimation);
  self.attackDuration = attackSeqDuration;
end
 
function ENT:Age()

  if (!PetConfig.shouldAge) then
    return false
  end

  if (CurTime() - self.lastAge < PetConfig.ageRate) then
    return false
  end

  self.age = self.age + 1

  local rate = 5
  if (self.age == 1) then
    rate = 0
  end

  if (self.age + 1 <= self.maxAge) then

    // scale our model
    local scaleCoeff = (self.age / self.maxAge)
    self:SetModelScale(math.max(0.2,scaleCoeff * self.maxSize), rate) // scale our model relative to our age
    self:SetHealth(scaleCoeff * self.maxHp)

  else

    self:SetHealth(self.maxHp)
  end

  self.lastAge = CurTime()

  return true
end


function ENT:PlayAnimation(sequence, force, rate, wait)

  rate = rate || 1
  force = force || false
  wait = wait || false

  if (!force) then
    if (sequence == self.currentAnimation) then
      return true
    end
    if (CurTime() < self.nextAnimTime) then
      return false;
    end
  end

  local sequenceID, sequenceDuration = self:LookupSequence(sequence)

  if (sequenceID == -1) then // invalid sequence
    return false
  end

  if (wait) then
    self.nextAnimTime = CurTime() + sequenceDuration;
  end

  self:ResetSequenceInfo()
  self:SetCycle(0)
  self:SetPlaybackRate(rate)
  self:ResetSequence(sequenceID)

  self.currentAnimation = sequence
  return true
end

function ENT:PlaySound(tab)

  if (!PetConfig.soundEffects) then
    return
  end

  if (CurTime() - tab.last > tab.delay) then

    local pitch = 255 - (self.age / self.maxAge) * 155
    pitch = math.max(90, pitch)

    self:EmitSound(table.Random(tab.src), PetConfig.soundLevel, pitch, tab.volume, CHAN_AUTO)
    tab.last = CurTime()
  end
end

function ENT:Follow(target, mode) // mode = 1 (walk), mode = 2 (run)

  if (target == nil || !target:IsValid()) then // nobody to follow

    return false
  end

  if (self.stay && mode == 1) then
    return false
  end

  if (self:GetPos():Distance(target:GetPos()) < 100) then

    return false
  end

  self.path:SetMinLookAheadDistance(200)
  self.path:SetGoalTolerance(100)
  self.path:Compute(self, target:GetPos())

  if (mode == 1) then
    self.loco:SetDesiredSpeed(self.walkSpeed)
    self:PlayAnimation(self.walkAnimation,false,self.walkAnimRate, true)
    self:PlaySound(self.walkSounds)
  elseif (mode == 2) then

    self.loco:SetDesiredSpeed(self.runSpeed)
    self:PlayAnimation(self.runAnimation,false,self.runAnimRate, true)
    self:PlaySound(self.walkSounds)
  end

  self.path:Update(self)

  if (self.loco:IsStuck()) then

    self:HandleStuck()
    return false
  end

  return true
end

function ENT:IsVisible(ply, mask)

  mask = mask || MASK_SHOT

  local res = QuickTrace(self:EyePos(), ply:LocalToWorld(ply:OBBCenter()), mask, {self,ply})

  if (!res.Hit) then

    return true
  else

    return false
  end
end

function ENT:AddEnemy(ply)

  if (ply == self.owner) then
    return
  end

  if (!table.HasValue(self.enemies, ply)) then

    backup = backup || false

    table.insert(self.enemies , ply)
  end
end

function ENT:GetClosestEnemy()

  local best = {0,nil}
  for k,v in next, self.enemies do

    if (!v:IsValid()) then
      self.enemies[k] = nil
      continue
    end

    if (!self:IsVisible(v)) then
      continue
    end

    local dist = self:GetPos():Distance(v:GetPos())

    if (dist < best[1] ||  best[2] == nil) then

      best = {dist, v}
    end
  end

  return best[2]
end

function ENT:ForgetEnemy(ent)

  for k,v in next, self.enemies do

    if (v == ent) then

      self.enemies[k] = nil
    end
  end
end

function ENT:Attack(ent)

  if (CurTime() - self.lastAttack < self.attackDuration) then
    return false
  end

  if (!IsValid(ent)) then
    self:ForgetEnemy(ent)
    return false
  end

  if (ent:Health() <= 0) then
    self:ForgetEnemy(ent)
    return false
  end

  if (self:GetPos():Distance(ent:GetPos()) > 200) then
    return false
  end

  self.loco:FaceTowards(ent:GetPos())
  self:PlayAnimation(self.attackAnimation, true, self.attackAnimRate, true)
  self:PlaySound(self.attackSounds)

  self.lastAttack = CurTime()

  if (self.onAttack != nil) then
    self.onAttack(self, ent)
  end

  timer.Simple(0.5,function()

    if (self == nil || !self:IsValid()) then
      return
    end
    if (ent == nil || !ent:IsValid()) then
      return
    end

    local dmgInfo = DamageInfo()
    dmgInfo:SetAttacker(self)
    dmgInfo:SetDamage(math.min(PetConfig.maxDamage,math.random(10,20) * (self.age / self.maxAge)))

    ent:TakeDamageInfo(dmgInfo)
  end)

  return true
end

function ENT:HandleStuck()

  self.loco:ClearStuck()
  self:SetPos(self.owner:GetPos())
end

function ENT:OnKilled()

  if (self.owner != nil && self.owner:IsValid()) then
    self.owner:ChatPrint("[PetsMod] Your pet has been killed!")
    pmRemovePermaPet(self.owner)
  end

  self:Remove()
end

function ENT:OnInjured(info)

  if (!PetConfig.canDefend) then
    return
  end

  if (info:GetAttacker() == nil || !info:GetAttacker():IsValid()) then
    return
  end

  self:AddEnemy(info:GetAttacker())
end

function ENT:Idle()
  self:PlayAnimation(self.idleAnimation)
  // Random chance for idle sound
  local chance = math.random(1,50);
  if (chance == 25 && PetConfig.idleSounds) then
    self:PlaySound(self.idleSounds)
  end
end

// Behaviour code
function ENT:RunBehaviour()

  while (true) do

    if (self.owner == nil || !self.owner:IsValid()) then
      self:OnKilled()
    end

    if (PetConfig.petGodMode) then
      self:SetHealth(self.maxHp)
    end

    if (self:Age()) then

      //print("AGING!") do something here, like a birthday noise and effect
      net.Start("SNPC_PETBASE_BIRTHDAY")
        net.WriteEntity(self);
      net.Broadcast()
      // update the pet for perma pets
      pmUpdatePermaPet(self.owner, self.age)
    end

    local enemy = self:GetClosestEnemy()

    if (enemy != nil && enemy:IsValid()) then // Chase enemy

      if (!self:Follow(enemy, 2)) then // If we can't follow, try attacking
        if (!self:Attack(enemy)) then
          self:Idle();

        end
      end

    elseif(self.owner != nil && self.owner:IsValid()) then // Follow owner

      if (!self:Follow(self.owner, 1)) then // If we can't follow the owner, then idle

        self:Idle()
      end
    end

    coroutine.wait(0.1)
  end
end

// Hooks

local function OnDeath(ply)

  for k,v in next, ents.FindByClass("snpc_petbase") do

    v:ForgetEnemy(ply)
  end
end

hook.Add("PlayerDeath", "SNPC_PETBASE.PlayerDeath", OnDeath)

local function PlayerArrested(criminal, time, actor)

  for k,v in next, ents.FindByClass("snpc_petbase") do

    v:ForgetEnemy(criminal)
  end
end

hook.Add("playerArrested", "SNPC_PETBASE.PlayerArrested", PlayerArrested)

local function EntityTakeDamage(target, info)

  if (!PetConfig.canDefend) then
    return;
  end

  if (target == nil || !target:IsValid()) then
    return
  end

  if (info:GetAttacker() == nil || !info:GetAttacker():IsValid()) then
    return
  end

  if (!info:GetAttacker():IsPlayer() && !info:GetAttacker():IsNPC()) then
    return
  end

  if (!target:IsPlayer()) then
    return
  end

  for k,v in next, ents.FindByClass("snpc_petbase") do
    if (v.owner != nil) then
      if (v.owner == target) then

        v:AddEnemy(info:GetAttacker())
      end
    end
  end
end

hook.Add("EntityTakeDamage", "SNPC_PETBASE.EntityTakeDamage", EntityTakeDamage)

net.Receive("SNPC_PETBASE_UPDATE_STATE", function(len,ply)
  local data = net.ReadTable()

  if (data.ent == nil || !data.ent:IsValid()) then
    return
  end

  if (data.ent.owner != ply) then
    return
  end

  data.ent.stay = data.stay
end)

net.Receive("SNPC_PETBASE_DISOWN", function(len,ply)

  local data = net.ReadTable()

  if (data.ent == nil || !data.ent:IsValid()) then
    return
  end

  if (data.ent.owner != ply) then
    return
  end

  data.ent:Remove()
  pmRemovePermaPet(ply)
  ply:ChatPrint("[Pet Mod] You have disowned your pet!")
end)
