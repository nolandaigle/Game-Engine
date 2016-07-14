xvel = 0
yvel = 0
medTimer = 0
enterWarp = "1"
created = false
locked = true
reset = false

bang = function(e)
	e:AddComponent("ScreenComponent")
	e:GetScreen():Reset()
	e:GetScreen():Zoom(.25)
	e:AddComponent("TransformComponent")

	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Game.save")
	enterWarp = file:GetVariable("Warp")
	file:OpenFile("Sokoban.save")
	file:SetVariable("Switch-number", "1")
	file:WriteFile()
	file:OpenFile("SokobanFork.save")

	if file:GetVariable("locked") == "true" then
		locked = true
	elseif file:GetVariable("locked") == "false" then
		locked = false
	end

	if enterWarp == "1" then
		e:Message("1", "Create" )
		locked = true
	elseif enterWarp == "2" then
		e:Message("2", "Create" )
		locked = false
	elseif enterWarp == "3" then
		e:Message("3", "Create" )
		locked = true
	end
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
	if signal == "Top" then
		e:Message("Map", "Arcade.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "1")
		file:WriteFile()

		file:OpenFile("SokobanFork.save")
		file:SetVariable("locked", "true")
		file:WriteFile()
		e:Signal("unlocked")
	end
	if signal == "Right" then
		e:Message("Map", "Sokoban3.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "1")
		file:WriteFile()
		file:OpenFile("SokobanFork.save")
		file:SetVariable("locked", "false" )
		file:WriteFile()
		e:Signal("unlocked")
	end
	if signal == "Left" then
		e:Message("Map", "Sokoban2.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "2")
		file:WriteFile()
		file:OpenFile("SokobanFork.save")
		file:SetVariable("locked", "true" )
		file:WriteFile()
		e:Signal("unlocked")
	end
end