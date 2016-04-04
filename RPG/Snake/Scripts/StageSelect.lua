dtw = 10
gametype = "Single Stage"
selected = 0
menuSize = 1

bang = function(e)

	e:AddComponent("GUIComponent")
	gui = e:GetGUI()
	gui:AddSelector("Stage")
	gui:AddOption(0, "Stage 1")
	gui:AddOption(0, "Stage 2")
	gui:AddOption(0, "Stage 3")
	gui:AddOption(0, "Stage 4")
	gui:AddOption(0, "Stage 5")
	gui:Select(0)

	e:AddComponent("TransformComponent")
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("StageSelect.png")
	graphic:AddFrame("Stage 1", 0, 0)
	graphic:AddFrame("Stage 2", 0, 1)
	graphic:AddFrame("Stage 3", 0, 2)
	graphic:AddFrame("Stage 4", 0, 3)
	graphic:AddFrame("Stage 5", 0, 4)
	graphic:SetFrameSize(640,480)

	print("Heyyy")
	print(gametype)
	if gametype  == "Full" then
	elseif gametype == "Single" then
		gui:Select(0)
		gui:Swipe("right")
	end
end

update = function(e)
end

display = function(e)

	if gui then
		graphic:Display(150, 0)
		gui:Display()
	end
end

onKeyPress = function(e,k)
	if k == "up" then
		selected = selected - 1

		if selected < 0 then
			selected = menuSize
		end
	elseif k == "down" then
		selected = selected + 1

		if selected > menuSize then
			selected = 0
		end
	elseif k == "right" then
		gui:Swipe("right")
	elseif k == "left" then
		gui:Swipe("left")
	else

		e:Message("Music", "Stop")
		e:Message("Music", "Resources/Music/japanintro.wav")
		e:Message("Music", "Play")
		
		if gui:GetSelected() == "Stage 1" then
			e:Message("Map", "Snake.json")
		elseif gui:GetSelected() == "Stage 2" then
			e:Message("Map", "Snake2.json")
		elseif gui:GetSelected() == "Stage 3" then
			e:Message("Map", "Snake3.json")
		elseif gui:GetSelected() == "Stage 4" then
			e:Message("Map", "Snake4.json")
		elseif gui:GetSelected() == "Stage 5" then
			e:Message("Map", "Snake5.json")
		end
	end
	graphic:Play(gui:GetSelected())
end

recieveMessage = function(e, message)
end