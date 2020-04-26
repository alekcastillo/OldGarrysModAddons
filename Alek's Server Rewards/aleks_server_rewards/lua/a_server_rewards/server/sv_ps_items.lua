//Functions

function AsrGivePointshopItems(ply, act)
  if !ply:IsValid() or !ply:IsPlayer() then return end

  local refers = ply:AsrRefers()

  local refersreward = table.Copy(ASR.PointshopItemsPerRefer)
  local groupreward = table.Copy(ASR.PointshopItemsOnGroupJoin)
  local nametagreward = table.Copy(ASR.PointshopItemsOnNameTagCheck)

  if act == 1 then
    if #refersreward > 0 then
      table.sort(refersreward, function(a, b) return a["requiredReferrals"] < b["requiredReferrals"] end)

      for _, v in pairs(refersreward) do
        local requiredReferrals = v["requiredReferrals"]
        local item = v["item"]

        if requiredReferrals == 0 then
          ply:PS_GiveItem(item)
        elseif refers == requiredReferrals then
          ply:PS_GiveItem(item)
        elseif refers < requiredReferrals then
          break
        end
      end
    end
  elseif act == 2 then
    if #groupreward > 0 then
      for _, v in pairs(groupreward) do
        ply:PS_GiveItem(v)
      end
    end
  elseif act == 3 then
    if #nametagreward > 0 then
      for k, v in pairs(nametagreward) do
        ply:PS_GiveItem(v)
      end
    end
  end
end

function AsrGivePointshop2Items(ply, act)
  if !ply:IsValid() or !ply:IsPlayer() then return end

  local refers = ply:AsrRefers()

  local refersreward = table.Copy(ASR.Pointshop2ItemsPerRefer)
  local groupreward = table.Copy(ASR.Pointshop2ItemsOnGroupJoin)
  local nametagreward = table.Copy(ASR.Pointshop2ItemsOnNameTagCheck)

  if act == 1 then
    if #refersreward > 0 then
      table.sort(refersreward, function(a, b) return a["requiredReferrals"] < b["requiredReferrals"] end)

      for _, v in pairs(refersreward) do
        local requiredReferrals = v["requiredReferrals"]
        local item = v["item"]

        if requiredReferrals == 0 then
          ply:PS2_EasyAddItem(item)
        elseif refers == requiredReferrals then
          ply:PS2_EasyAddItem(item)
        elseif refers < requiredReferrals then
          break
        end
      end
    end
  elseif act == 2 then
    if #groupreward > 0 then
      for _, v in pairs(groupreward) do
        ply:PS2_EasyAddItem(v)
      end
    end
  elseif act == 3 then
    if #nametagreward > 0 then
      for k, v in pairs(nametagreward) do
        ply:PS2_EasyAddItem(v)
      end
    end
  end
end
