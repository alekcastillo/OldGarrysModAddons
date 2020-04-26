//Network Strings

util.AddNetworkString("PLS_ViewLaws")
util.AddNetworkString("PLS_LoadLaws")
util.AddNetworkString("PLS_ReloadLaws")
util.AddNetworkString("PLS_LawChanged")

//Show laws help to Mayor on spawn

hook.Add("PlayerSpawn", "ShowHelp", function(ply)
	if ply:isMayor() then
		ply:ChatPrint("Congratulations, you are the new mayor of the city! Use /laws to edit the current laws, and make the city a better place!")
	end
end)

//Open laws board

hook.Add("PlayerSay", "CommandCheck", function(ply, text, team)
	if text == "!"..PLS.ViewOrChangeLawsCommand or text == "/"..PLS.ViewOrChangeLawsCommand or text == "/placelaws" or text == "/addlaw" or text == "/placelawboard" or text == "/viewlaws" then
		mayors = 0
		for k, ply in pairs( player.GetAll() ) do
			if ply:isMayor() then 
				mayors = mayors + 1 
			end
		end
		if mayors == 0 and PLS.DissableLawsWhenNoMayor then
			ply:ChatPrint("The city has no current Mayor, therefore, there are no active laws!")
		else
			net.Start("PLS_ViewLaws")
			net.Send(ply)
		end
	end
end)

//Load the laws

hook.Add("PlayerInitialSpawn", "LoadLaws", function(ply)
	net.Start("PLS_LoadLaws")
	net.WriteTable(PLS_Laws)
	net.Send(ply)
end)

//When a law is changed

net.Receive("PLS_LawChanged",function(length, ply)
	if ply:isMayor() then
		local newlawtable = net.ReadTable()
		newlaw = PLS_Laws[newlawtable[1]]
		newlaw[2] = newlawtable[2]
		PLS_Laws[newlawtable[1]] = newlaw
		net.Start("PLS_ReloadLaws")
		net.WriteTable(PLS_Laws)
		net.Broadcast()
		for k, ply in pairs( player.GetAll() ) do
			ply:ChatPrint(newlaw[1].." is now "..newlawtable[2].."!")
		end
		DarkRP.notify(player.GetAll(), 4, 4, ply:Nick().." has made "..newlaw[1].." "..newlawtable[2].."!")
	else
		DarkRP.notify(ply, 1, 4, "An unexpected error has occurred!")
	end
end)

print("Persistent Laws System (server) successfully loaded!")