timer =  0

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Logo.png")
	graphic:SetFrameSize(64,128)
	graphic:SetScale(2,2)
	graphic:SetFade(0)
	graphic:FadeTo(255)
	e:AddComponent("SoundComponent")
	sound = e:GetSC()
	sound:Load("Resources/Sound/Startup.wav")
	sound:Play()
end

update = function(e)
	timer = timer + e:GetDeltaTime()
	if timer > 6.5 then
		e:Message("Music", "Resources/Music/The God Head.wav")
		e:Message("Music", "Play")
		e:Message("Map", "Box.json")
	end
end

display = function(e)
	if graphic then
		graphic:Display(428, 100)
	end
end

onKeyPress = function(e,k)
	e:Message("Music", "Resources/Music/The God Head.wav")
	e:Message("Music", "Play")
	e:Message("Map", "Box.json")
end