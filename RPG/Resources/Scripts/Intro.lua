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
	sound:Load("Resources/Sound/Startup.wav", "Startup")
	sound:Play("Startup")

	file = io.open("playercolor.save", "w")
	file:write("white")
	file:close()
end

update = function(e)
	timer = timer + e:GetDeltaTime()
	if timer > 6.5 then
		e:Message("Map", "Box.json")
	end
end

display = function(e)
	if graphic then
		graphic:Display(428, 100)
	end
end

onKeyPress = function(e,k)
	if k == "q" then
		file = io.open("playerexit.save", "w")
		file:write("Top")
		file:close()
		e:Message("Map", "Field.json")
	else
		e:Message("Map", "Clones.json")
	end
end