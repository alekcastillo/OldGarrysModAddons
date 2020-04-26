local function AsrBLogsInit()
 bLogs.CreateCategory("Alek's Server Rewards", ASR.ChatTagColor)

 bLogs.DefineLogger("Referral rewards", "Alek's Server Rewards")
 bLogs.DefineLogger("Steam group rewards", "Alek's Server Rewards")
 bLogs.DefineLogger("Name tag rewards", "Alek's Server Rewards")
end

if (bLogsInit) then
  AsrBLogsInit()
else
  hook.Add("bLogsInit","AsrBLogsInit", AsrBLogsInit)
end

--This is a WIP and will be added on a future version
