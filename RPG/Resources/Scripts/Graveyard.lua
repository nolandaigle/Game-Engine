bang = function(e)


	e:AddComponent("MapComponent")
	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Game.save")
	enterWarp = file:GetVariable("Warp")

	if enterWarp == "1" then
		e:Message("1", "Create" )
		e:Message("Music", "Stop")
		e:Message("Music", "Resources/Music/Gospel.wav")
		e:Message("Music", "Play")
	elseif enterWarp == "2" then
		e:Message("2", "Create" )
	elseif enterWarp == "3" then
		e:Message("3", "Create" )
	end

	e:AddComponent("ScreenComponent")
	e:GetScreen():Reset()
	e:GetScreen():Zoom(.25)
end

update = function(e)
end

recieveSignal = function(e, signal)
if signal == "Left" then
		e:Message("Map", "Cry.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "2")
		file:WriteFile()
	end
end