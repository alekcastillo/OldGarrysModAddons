//Variables

local meta = FindMetaTable( "Player" )
if not meta then return end

//Functions

function AsrSetGroupMemberSID(steamid, num)
  if !AsrIsRecordedSID(steamid) then return end

  for _, v in pairs(asr_data) do
    if v["steamid"] == steamid then
      v["groupmember"] = num

      break
    end
  end

  if ASR.UseMySQL and sqlSuccess then
    AsrQuery("update asr_data set groupmember = "..num.." where steamid = '"..steamid.."';")
  else
    file.Write("server_rewards/asr_data.txt", util.TableToJSON(asr_data))
  end

  AsrUpdateTable(steamid)
end

function meta:AsrSetGroupMember(num)
  AsrSetGroupMemberSID(self:SteamID(), num)
end

function AsrSetAdvertiserSID(steamid, num)
  if !AsrIsRecordedSID(steamid) then return end

  for _, v in pairs(asr_data) do
    if v["steamid"] == steamid then
      v["advertiser"] = num

      break
    end
  end

  if ASR.UseMySQL and sqlSuccess then
    AsrQuery("update asr_data set advertiser = "..num.." where steamid = '"..steamid.."';")
  else
    file.Write("server_rewards/asr_data.txt", util.TableToJSON(asr_data))
  end

  AsrUpdateTable(steamid)
end

function meta:AsrSetAdvertiser(num)
  AsrSetAdvertiserSID(self:SteamID(), num)
end

function AsrSetRefersSID(steamid, relative, num)
  if !AsrIsRecordedSID(steamid) then return end

  local refers = 0

  if relative then
    refers = AsrRefersSID(steamid) + num
  else
    refers = num
  end

  for _, v in pairs(asr_data) do
    if v["steamid"] == steamid then
      v["refers"] = refers

      break
    end
  end

  if ASR.UseMySQL and sqlSuccess then
    AsrQuery("update asr_data set refers = "..refers.." where steamid = '"..steamid.."';")
  else
    file.Write("server_rewards/asr_data.txt", util.TableToJSON(asr_data))
  end

  AsrUpdateTable(steamid)
end

function meta:AsrSetRefers(relative, num)
  AsrSetRefersSID(self:SteamID(), relative, num)
end

function AsrSetReferrerSID(steamid, referrer)
  if !AsrIsRecordedSID(steamid) then return end

  for _, v in pairs(asr_data) do
    if v["steamid"] == steamid then
      v["referrer"] = referrer

      break
    end
  end

  if ASR.UseMySQL and sqlSuccess then
    AsrQuery("update asr_data set referrer = '"..referrer.."' where steamid = '"..steamid.."';")
  else
    file.Write("server_rewards/asr_data.txt", util.TableToJSON(asr_data))
  end

  AsrUpdateTable(steamid)
end

function meta:AsrSetReferrer(referrer)
  AsrSetReferrerSID(self:SteamID(), referrer)
end

function AsrSetNickSID(steamid, name)
  if !AsrIsRecordedSID(steamid) then return end

  local nick = AsrAntiInjection(name)

  for _, v in pairs(asr_data) do
    if v["steamid"] == steamid then
      v["nick"] = nick

      break
    end
  end

  if ASR.UseMySQL and sqlSuccess then
    AsrQuery("update asr_data set nick = '"..nick.."' where steamid = '"..steamid.."';")
  else
    file.Write("server_rewards/asr_data.txt", util.TableToJSON(asr_data))
  end

  AsrUpdateTable(steamid)
end

function meta:AsrSetNick(name)
  AsrSetNickSID(self:SteamID(), name)
end

function AsrRecordPlayerSID(steamid, name, referrer, ismember, isadvertiser, refers)
  local codeNotUsed = false
  local referCode = ""

  while !codeNotUsed do
    referCode = AsrGenerateCode(6)

    if !AsrSIDFromCode(referCode) then
      codeNotUsed = true
    end
  end

  local nick = AsrAntiInjection(name)
  local plyDataTbl = {steamid = steamid, nick = nick, refercode = referCode, referrer = referrer, groupmember = ismember, advertiser = isadvertiser, refers = refers}

  if asr_data[1]["steamid"] == "steamid" then
    table.remove(asr_data, 1)
  end

  table.insert(asr_data, plyDataTbl)

  if ASR.UseMySQL and sqlSuccess then
    AsrQuery("insert into asr_data(steamid, nick, refercode, referrer, isgroupmember, isadvertiser, refers) values ('"..steamid.."', '"..nick.."', '"..referCode.."', "..ismember..", "..isadvertiser..", "..refers..");")
  else
    file.Write("server_rewards/asr_data.txt", util.TableToJSON(asr_data))
  end

  AsrSetRefersSID(referrer, true, 1)

  AsrUpdateTable(steamid)
end

function meta:AsrRecordPlayer(referrer, ismember, isadvertiser, refers)
  return AsrRecordPlayerSID(self:SteamID(), self:Nick(), referrer, ismember, isadvertiser, refers)
end

function AsrRemoveRecordSID(steamid)
  if !AsrIsRecordedSID(steamid) then return end

  for _, v in pairs(asr_data) do
    if v["steamid"] == steamid then
      table.remove(asr_data, k)

      break
    end
  end

  if ASR.UseMySQL and sqlSuccess then
    AsrQuery("delete from asr_data where steamid = '"..steamid.."');")
  else
    file.Write("server_rewards/asr_data.txt", util.TableToJSON(asr_data))
  end
end
