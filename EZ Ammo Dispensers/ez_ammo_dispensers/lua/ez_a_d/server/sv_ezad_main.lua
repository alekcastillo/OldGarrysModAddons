//Net Functions
net.Receive("EZAD_BuyAmmo", function(_, ply)
	local ammoToBuy = net.ReadInt(32)
	local bought = false
	local ammoTable = EZAD_AmmoTypes[ammoToBuy]
	local ammoPriceType = ammoTable[5]				--I know this variables look ugly a f but they'll help me edit this in the future
	local ammoPrice = ammoTable[6]
	local ammoType = ammoTable[2]
	local ammoQuant = ammoTable[4]

	if ammoPriceType == 1 and ply:canAfford(ammoPrice) then
		ply:addMoney(-ammoPrice)
		bought = true
	elseif ammoPriceType == 2 and ply:PS_GetPoints() >= ammoPrice then
		ply:PS_TakePoints(ammoPrice)
		bought = true
	elseif ammoPriceType == 3 and ply.PS2_Wallet.points >= ammoPrice then
		ply:PS2_AddStandardPoints(-ammoPrice) --Thanks to Omnitica for this :D
		bought = true
	end

	if bought then
		ply:GiveAmmo(ammoQuant, ammoType, false)
	else
		EZAD_Notify(EZAD_Lang.CantAfford, ply)
	end
end)

net.Receive("EZAD_ThanksReceived", function(_, ply)
	if file.Exists("ez_a_d/thanks_received.txt", "DATA") then return end

	file.Write("ez_a_d/thanks_received.txt", "༼ つ ◕_◕ ༽つ NOTHING TO SEE HERE :D")
end)

//Hooks
hook.Add("PlayerInitialSpawn", "EZAD_Variables", function(ply)
	EZAD_ReloadAmmoTable(ply)

	if ply:IsSuperAdmin() and !file.Exists("ez_a_d/thanks_received.txt", "DATA") then
		net.Start("EZAD_Thanks")
		net.Send(ply)
	end
end)

hook.Add("PlayerSay", "EZAD_Commands", function(ply, text)
	if (text == "!ezadreview") or (text == "/ezadreview") then
		net.Start("EZAD_Thanks")
		net.Send(ply)
	elseif (text == "!ezadversion") or (text == "/ezadversion") then
		EZAD_Notify("EZ Ammo Dispensers version "..EZAD_Version, ply)
	end
end)
