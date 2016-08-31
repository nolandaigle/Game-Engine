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

	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Game.save")
	file:SetVariable("Warp", "1")
	file:SetVariable("Color", "White")
	file:WriteFile()
	file:OpenFile("Quest.save")
	file:SetVariable("SharkBelly", "not")
	file:WriteFile()

	timer =  0
end

update = function(e)
	timer = timer + e:GetDeltaTime()
	if timer > 10 then
		e:Message("Map", "Box.json")
	end
end

display = function(e)
	if graphic then
		graphic:Display(428, 100)
	end
end

onKeyPress = function(e,k)
	if k == "e" then
		e:Message("Map", "DogPark.json")
	else
		e:Message("Map", "Clones.json")
	end
end