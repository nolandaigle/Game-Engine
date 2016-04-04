bang = function(e)
	e:SetScreenColor( 253, 244, 235 )
end

update = function(e)
end

display = function(e)
end

onKeyPress = function(e,k)
	if k == "u" then
		e:Message("Map", "Snake3.json")
	end
	if k == "y" then
		e:Message("Music", "Resources/Music/japanintro.wav")
		e:Message("Music", "Play")
		e:Message("Map", "GameMenu.json")
	end
end

recieveMessage = function(e, message)
end

recieveSignal = function(e, signal)
	if signal == "ChangeMap" then
		e:Message("Map", "Snake3.json")
	end
end