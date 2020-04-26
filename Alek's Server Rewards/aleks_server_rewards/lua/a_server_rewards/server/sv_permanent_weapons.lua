//Functions

function AsrGiveWeapons(ply)
  if !ply:IsValid() or !ply:IsPlayer() then return end

  local refers = ply:AsrRefers()
  local ismember = ply:AsrIsGroupMember()
  local isadvertiser = ply:AsrIsAdvertiser()

  local refersreward = table.Copy(ASR.PermanentWeaponsPerRefer)
  local groupreward = table.Copy(ASR.PermanentWeaponsOnGroupJoin)
  local nametagreward = table.Copy(ASR.PermanentWeaponsOnNameTagCheck)

  if #refersreward > 0 and refers > 0 then
    table.sort(refersreward, function(a, b) return a["requiredReferrals"] < b["requiredReferrals"] end)

    for _, v in pairs(refersreward) do
      local requiredReferrals = v["requiredReferrals"]
      local weaponClass = v["weaponClass"]

      if refers >= requiredReferrals then
        if !ply:HasWeapon(weaponClass) then
          local weapon = ply:Give(weaponClass)

          if weapon:IsWeapon() then
            weapon.AsrPerma = true
          end
        end

        if !ASR.GiveAllPermanentWeaponsPerRefer then break end
      else
        break
      end
    end
  end

  if #groupreward > 0 and ismember then
    for _, v in pairs(groupreward) do
      if !ply:HasWeapon(v) then
        local weapon = ply:Give(v)

        if weapon:IsWeapon() then
          weapon.AsrPerma = true
        end
      end
    end
  end

  if #nametagreward > 0 and isadvertiser then
    for _, v in pairs(nametagreward) do
      if !ply:HasWeapon(v) then
        local weapon = ply:Give(v)

        if weapon:IsWeapon() then
          weapon.AsrPerma = true
        end
      end
    end
  end
end

//Hooks

hook.Add("PlayerLoadout", "AsrGivePermanentWeapons", AsrGiveWeapons)

hook.Add("canDropWeapon", "AsrPreventPermaDrop", function(ply, weap)
  if !ply:IsValid() or !ply:IsPlayer() or !weap:IsWeapon() then return end

  if weap.AsrPerma then
    AsrNotify("You can't drop a permanent weapon!", ply)

    return false
  end
end)
