//Network Strings

util.AddNetworkString("CH_ViewLaws")
util.AddNetworkString("CH_LoadLaws")
util.AddNetworkString("CH_ReloadLaws")
util.AddNetworkString("CH_LawChanged")

//Show laws help to Mayor on spawn

hook.Add("PlayerSpawn", "ShowHelp", function(ply)
	if ply:isMayor() then
		ply:ChatPrint("Congratulations, you are the new mayor of the city! Use /laws to edit the current laws, and make the city a better place!")
	end
end)

//Open laws board

hook.Add("PlayerSay", "CommandCheck", function(ply, text, team)
	if text == "!"..CartoonHudConfig.ViewOrChangeLawsCommand or text == "/"..CartoonHudConfig.ViewOrChangeLawsCommand or text == "/placelaws" or text == "/addlaw" or text == "/placelawboard" or text == "/viewlaws" then
		mayors = 0
		for k, ply in pairs( player.GetAll() ) do
			if ply:isMayor() then 
				mayors = mayors + 1 
			end
		end
		if mayors == 0 and CartoonHudConfig.DisableLawsWhenNoMayor then
			ply:ChatPrint("The city has no current Mayor, therefore, there are no active laws!")
		else
			net.Start("CH_ViewLaws")
			net.Send(ply)
		end
	end
end)

//Load the laws

hook.Add("PlayerInitialSpawn", "LoadLaws", function(ply)
	net.Start("CH_LoadLaws")
	net.WriteTable(CHS_Laws)
	net.Send(ply)
end)

//When a law is changed

net.Receive("CH_LawChanged",function(length, ply)
	if ply:isMayor() then
		local newlawtable = net.ReadTable()
		newlaw = CHS_Laws[newlawtable[1]]
		newlaw[2] = newlawtable[2]
		CHS_Laws[newlawtable[1]] = newlaw
		net.Start("CH_ReloadLaws")
		net.WriteTable(CHS_Laws)
		net.Broadcast()
		for k, ply in pairs( player.GetAll() ) do
			ply:ChatPrint(newlaw[1].." is now "..newlawtable[2].."!")
		end
		DarkRP.notify(player.GetAll(), 4, 4, ply:Nick().." has made "..newlaw[1].." "..newlawtable[2].."!")
	else
		DarkRP.notify(ply, 1, 4, "An unexpected error has occurred!")
	end
end)

print("Cartoon Hud's persistent laws system has been successfully loaded! (server-side)")