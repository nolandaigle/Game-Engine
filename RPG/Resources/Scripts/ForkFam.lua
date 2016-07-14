
locked = true
reset = false

bang = function(e)
	e:AddComponent("MapComponent")
	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Game.save")
	enterWarp = file:GetVariable("Warp")
	file:OpenFile("Sokoban.save")
	file:SetVariable("Switch-number", "1")
	file:WriteFile()
	file:OpenFile("ForkFam.save")

	if file:GetVariable("locked") == "true" then
		locked = true
	elseif file:GetVariable("locked") == "false" then
		locked = false
	end

	if enterWarp == "1" then
		e:Message("1", "Create" )
	elseif enterWarp == "2" then
		e:Message("2", "Create" )
	elseif enterWarp == "3" then
		e:Message("3", "Create" )
	end

	e:AddComponent("ScreenComponent")
	e:GetScreen():Reset()
	e:GetScreen():Zoom(.3)


end

update = function(e)
	if locked == false and reset == false then
		e:Signal("unlocked")
	end
end

display = function(e)
end

onKeyPress = function(e,k)
end

onKeyRelease = function(e,k)
end

recieveSignal = function(e, signal)
	if signal == "reset" then
		reset = true
	end
	if signal == "Left" then
		e:Message("Map", "Ray2.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "1")
		file:WriteFile()
		file:OpenFile("ForkFam.save")
		file:SetVariable("locked", "true")
		file:WriteFile()
		e:Signal("unlocked")
	elseif signal == "Right" then
		e:Message("Map", "caveNetwork.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "4")
		file:WriteFile()
		file:OpenFile("ForkFam.save")
		file:SetVariable("locked", "true")
		file:WriteFile()
		e:Signal("unlocked")
	elseif signal == "Top" then
		e:Message("Map", "FamilyRoom.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "1")
		file:WriteFile()
		file:OpenFile("ForkFam.save")
		file:SetVariable("locked", "false")
		file:WriteFile()
		e:Signal("unlocked")
	end
end
