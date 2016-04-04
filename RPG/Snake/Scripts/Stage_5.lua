timer = 0.0
flipped = false
flipping = false
volume = 0

bang = function(e)
	e:AddComponent("SoundComponent")
	sound = e:GetSC()
	sound:Load("Resources/Sound/bell.wav")
	e:SetScreenColor( 253, 244, 235 )
end

update = function(e)
	timer = timer + e:GetDeltaTime()

	if flipping == true then
		volume = volume + 1
		sound:SetVolume(volume)
	end

	if timer > 8 and flipping == false then
		sound:Play()
		flipping = true
		volume = 0
	end
	if volume > 100 and flipping == true then
		flipping = false
		sound:Stop()
		timer = 0
	
		if flipped == false then
			e:Signal("FlipT")
			flipped = true
			e:SetScreenColor( 0, 0, 0 )
			sound:Load("Resources/Sound/bell.wav")
			sound:Play()
		elseif flipped == true then
			e:Signal("FlipF")
			flipped = false
			e:SetScreenColor( 253, 244, 235 )
		end
	end
end

display = function(e)
end

onKeyPress = function(e,k)
	if k == "u" then
		e:Message("Map", "Snake.json")
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
	if signal == "FlipT" then
		flipped = true
	elseif signal == "FlipF" then
		flipped = false
	elseif signal == "ChangeMap" then
		e:Message("Map", "Snake.json")
	end
end