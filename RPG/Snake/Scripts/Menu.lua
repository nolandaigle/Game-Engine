dtw = 10
gametype = "Single Level"
selected = 0;

bang = function(e)
	
	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("save.txt")
	dtw = tonumber(file:GetLine())
	gametype = file:GetLine()
	file:CloseFile()

	e:AddComponent("GUIComponent")
	gui = e:GetGUI()
	gui:SetString("Dots to win: " .. tostring(dtw))
	gui:SetColor( 0, 0, 0 )
	gui:Select(selected-1)
end

update = function(e)
	gui:SetString("Dots to win: " .. tostring(dtw))
end

display = function(e)

	if gui then
		if selected == 0 then
			gui:SetColor(200, 200, 0)
		else
			gui:SetColor( 0, 0, 0 )
		end
		gui:Display(400, 200)
	end
end

onKeyPress = function(e,k)
	if k == "up" or k == "right" then
		selected = selected - 1

		if selected < 0 then
			selected = 0
		end
	elseif k == "down" or k == "left" then
		selected = selected + 1

		if selected > 0 then
			selected = 0
		end
	else
		e:Message("Map", "Snake.json")
		e:Message("Music", "Stop")
		e:Message("Music", "Resources/Music/japanintro.wav")
		e:Message("Music", "Play")
	end

	gui:Select(selected-1)

	if selected == 0 then
		if k == "right" then
			dtw = dtw + 1
		end
		if k == "left" then
			if dtw > 1 then
				dtw = dtw -1 
		 	end
		end
	elseif selected > 0 then
		if k == "right" then
			gui:Swipe("right")
		elseif k == "left" then
			gui:Swipe("left")
		end

		gui:Select(0)
		gametype = gui:GetSelected()
	end

	file = io.open("save.txt", "w")
	file:write(dtw)
	file:write("\n")
	file:write(gametype)
	file:close()
end

recieveMessage = function(e, message)
end