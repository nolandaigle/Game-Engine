bang = function(e)
	e:AddComponent("MapComponent")
	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Game.save")
	enterWarp = file:GetVariable("Warp")

	if enterWarp == "1" then
		e:Message("1", "Create" )
	elseif enterWarp == "2" then
		e:Message("2", "Create" )
	elseif enterWarp == "3" then
		e:Message("3", "Create" )
	elseif enterWarp == "4" then
		e:Message("4", "Create" )
	end

	e:AddComponent("ScreenComponent")
	e:GetScreen():Reset()
	e:GetScreen():Zoom(.35)

	e:Message("Music", "Stop")
	e:Message("Music", "Resources/Music/Robojazz.wav")
	e:Message("Music", "Play")
end

update = function(e)
end

recieveSignal = function(e, signal)
	if signal == "Bottom" then
		e:Message("Map", "SokobanFork.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "3")
		file:WriteFile()
		e:Message("Music", "Stop")
	end
	if signal == "Top" then
		e:Message("Map", "RoboCorner.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "1")
		file:WriteFile()
	end
end