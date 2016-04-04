bang = function(e)
	e:AddComponent("GraphicComponent")
	e:AddComponent("SoundComponent")
	e:AddComponent("MapComponent")
	e:AddComponent("ScreenComponent")
	e:GetSC():Load("Resources/Sound/Song_1.wav")

	timer = 0.0
	timeCap = 15.0

	volume = 0.0
end

update = function(e)
	timer = timer + e:GetDeltaTime()
	if timer > timeCap then
		e:GetSC():SetVolume(volume)
		if volume < 100 then
			volume = volume + 1
		end
		if timer < 100 then
			e:GetSC():Play()
			e:GetMap():Multiply()
		end
		timer = 100
	end
end

display = function(e)
end

onKeyPress = function(e,k)
	timer = 0
end