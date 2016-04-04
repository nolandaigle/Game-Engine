dtw = 10
gametype = "Single Stage"
selected = 0
menuSize = 1

bang = function(e)
	
	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("save.txt")
	dtw = tonumber(file:GetLine())
	gametype = file:GetLine()
	file:CloseFile()

	e:AddComponent("GUIComponent")
	gui = e:GetGUI()
	gui:AddSelector("GameType")
	gui:AddOption(0, "Full Match")
	gui:AddOption(0, "Single Stage")
	gui:AddSelector("Set Controls")
	gui:AddOption(1, "Player1")
	gui:AddOption(1, "Player2")
	gui:Select(0)

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
		gui:Display(400, 200)
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
		if gui:GetSelected() == "Single Stage" then
			e:Message("Map", "StageSelect.json")
		elseif gui:GetSelected() == "Full Match" then
			e:Message("Map", "Menu.json")
		end
	end

	gui:Select(0)
	gametype = gui:GetSelected()
	gui:Select(selected)

	file = io.open("save.txt", "w")
	file:write(dtw)
	file:write("\n")
	file:write(gametype)
	file:close()
end

recieveMessage = function(e, message)
end