bang = function(e)
	e:AddComponent("TransformComponent")
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Menu.png")
	graphic:SetFrameSize(960,540)

	e:Message("Music", "Resources/Music/indiaintro.wav")
	e:Message("Music", "Play")
end

update = function(e)
end

display = function(e)
	if graphic then
		graphic:Display(0, 0)
	end
end

onKeyPress = function(e,k)
	e:Message("Map", "GameMenu.json")
end

recieveMessage = function(e, message)
end