bang = function(e)
	e:AddComponent("ScreenComponent")
	e:GetScreen():Reset()
	e:GetScreen():Zoom(.3)
	e:AddComponent("TransformComponent")

	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Game.save")
	enterWarp = file:GetVariable("Warp")
	file:OpenFile("Sokoban.save")
	file:SetVariable("Switch-number", "2")
	file:WriteFile()

	if enterWarp == "1" then
		e:Message("1", "Create" )
		locked = true
	elseif enterWarp == "2" then
		e:Message("2", "Create" )
		locked = false
	end
end

update = function(e)
end

display = function(e)
end

onKeyPress = function(e,k)
end

onKeyRelease = function(e,k)
end

recieveSignal = function(e, signal)
	if signal == "Left" then
		e:Message("Map", "SokobanFork.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "2")
		file:WriteFile()
		e:Signal("unlocked")
	end
	if signal == "Right" then
		e:Message("Map", "Sokoban4.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "1")
		file:WriteFile()
		e:Signal("unlocked")
	end
end