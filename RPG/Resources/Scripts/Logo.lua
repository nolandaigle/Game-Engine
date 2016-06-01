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

	timer =  0
end

update = function(e)
	timer = timer + e:GetDeltaTime()
	if timer > 6.5 then
		e:Message("Map", "Intro.json")
	end
end

display = function(e)
	if graphic then
		graphic:Display(428, 100)
	end
end

onKeyPress = function(e,k)
	if k == "q" then
		e:Message("Map", "caveNetwork.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "1")
		file:WriteFile()
	else
		e:Message("Map", "Clones.json")
		file:OpenFile("Game.save")
		file:SetVariable("Color", "White")
		file:WriteFile()
	end
end