graphic = nil
eaten = false

deathTimer = 0.0
deathTime = 12.0

flipped = false
flipping = false

bang = function(e)
	e:AddComponent("GraphicComponent")
	e:AddComponent("TransformComponent")
	e:AddComponent("CollisionComponent")
	e:AddComponent("ScreenComponent")
	screen = e:GetScreen()
	e:AddComponent("SoundComponent")
	sound = e:GetSC()
	sound:Load("Resources/Sound/pellet2.wav")
	collider = e:GetCC()
	collider:SetType("FlipPellet")
	graphic = e:GetGC()
	graphic:SetImage("FP.png")
end

update = function(e)
end

display = function(e)

	if eaten == true then
		deathTimer = deathTimer + e:GetDeltaTime()
	end

	if deathTimer > deathTime then
		deathTimer = 0
		eaten = false
		graphic:Show(true)
		collider:SetType("FlipPellet")
	end

	if graphic then
		graphic:Display(e:GetTransform().x, e:GetTransform().y)
	end
end

onKeyPress = function(e,k)
end

recieveSignal = function(e, signal)
	if signal == "FlipT" then
		flipped = true
	elseif signal == "FlipF" then
		flipped = false
	end
end

recieveMessage = function(e, message)
	if message == "Eat" then
		sound:Play()
		eaten = true
		collider:SetType("Eaten")
		graphic:Disappear()
		screen:ScreenShake(.25,-2)

		flipping = true

		if flipped == false then
			e:Signal("FlipT")
			flipped = true
			e:SetScreenColor( 0, 0, 0 )
		elseif flipped == true then
			e:Signal("FlipF")
			flipped = false
			e:SetScreenColor( 253, 244, 235 )
		end
	end
end