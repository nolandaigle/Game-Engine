color = "White"

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
	e:GetScreen():Zoom(.25)
end

update = function(e)
end

recieveSignal = function(e, signal)
	if signal == "White" then
		color = "White"
	elseif signal == "Blue" then
		color = "Blue"
	elseif signal == "Red" then
		color = "Red"
	end

	if signal == "Top" then
		file:OpenFile("Quest.save")
		if file:GetVariable("SharkBelly") == "eaten" and color == "Blue" then 
			e:Message("Music", "Stop")
			e:Message("Music", "Resources/Music/Gospel.wav")
			e:Message("Music", "Play")
			e:Message("Map", "Graveyard.json")
			file:OpenFile("Game.save")
			file:SetVariable("Warp", "3")
			file:WriteFile()
			file:OpenFile("Quest.save")
			file:SetVariable("SharkBelly", "not")
			file:WriteFile()
		elseif file:GetVariable("SharkBelly") == "eaten" and color == "Red" then 
			e:Message("Map", "LoveLand.json")
			file:OpenFile("Game.save")
			file:SetVariable("Warp", "1")
			file:WriteFile()
			file:OpenFile("Quest.save")
			file:SetVariable("SharkBelly", "not")
			file:WriteFile()
		elseif file:GetVariable("SharkBelly") == "not" then
			e:Message("Map", "Mirror.json")
			file:OpenFile("Game.save")
			file:SetVariable("Warp", "1")
			file:WriteFile()
		end
	end
	if signal == "Bottom" then
		e:Message("Map", "Stomach.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "1")
		file:WriteFile()
	end
	if signal == "Right" then
		e:Message("Map", "Right.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "1")
		file:WriteFile()
	end
	if signal == "Left" then
		e:Message("Map", "Left.json")
		file:OpenFile("Game.save")
		file:SetVariable("Player-exit", "Ray")
		file:WriteFile()
	end
end