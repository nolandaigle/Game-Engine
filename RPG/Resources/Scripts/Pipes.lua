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
	e:GetScreen():Zoom(.25)
end

update = function(e)
end

recieveSignal = function(e, signal)
	if signal == "Top" then
		e:Message("Map", "Stomach.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "2")
		file:WriteFile()
	end
	if signal == "Bottom" then
		file:OpenFile("Quest.save")
	
		if file:GetVariable("SharkBelly") == "not" then 
			e:Message("Music", "Stop")
			e:Message("Music", "Resources/Music/Waves.wav")
			e:Message("Music", "Play")
			e:Message("Map", "JesusLand.json")
			file:OpenFile("Game.save")
			file:SetVariable("Warp", "2")
			file:WriteFile()
		elseif file:GetVariable("SharkBelly") == "eaten" then
			e:Message("Map", "Hell.json")
			file:OpenFile("Game.save")
			file:SetVariable("Warp", "1")
			file:WriteFile()
		end
	end
end