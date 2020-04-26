//Functions

function AsrGiveULXGroup(ply, act)
  if !ply:IsValid() or !ply:IsPlayer() then return end

  local refers = ply:AsrRefers()
  local refersreward = table.Copy(ASR.UlxGroupPerRefer)

  if act == 1 then
    if #refersreward > 0 then
      table.sort(refersreward, function(a, b) return a["requiredReferrals"] > b["requiredReferrals"] end)

      for _, v in pairs(refersreward) do
        local requiredReferrals = v["requiredReferrals"]
        local group = v["group"]

        if refers == requiredReferrals then
          if !ply:IsUserGroup(group) then
            ulx.adduser(Entity(0), ply, group)

            break
          end
        elseif refers > requiredReferrals then
          break
        end
      end
    end
  elseif act == 2 then
    if ASR.UlxGroupOnGroupJoin != "" and !ply:IsUserGroup(ASR.UlxGroupOnGroupJoin) then
      ulx.adduser(Entity(0), ply, ASR.UlxGroupOnGroupJoin)
    end
  elseif act == 3 then
    if ASR.UlxGroupOnNameTagCheck != "" and !ply:IsUserGroup(ASR.UlxGroupOnNameTagCheck) then
      ulx.adduser(Entity(0), ply, ASR.UlxGroupOnNameTagCheck)
    end
  end
end
