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
	end

	e:AddComponent("ScreenComponent")
	e:GetScreen():Reset()
	e:GetScreen():Zoom(.35)

	e:Message("Music", "Resources/Music/Title Screen.wav")
	e:Message("Music", "Unloop")
	e:Message("Music", "Play")
end

update = function(e)
	e:Signal("Stuck")
end

recieveSignal = function(e, signal)
	if signal == "Bottom" then
		e:Message("Map", "APath.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "2")
		file:WriteFile()
	end
end