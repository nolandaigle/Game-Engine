graphic = nil
eaten = false

deathTimer = 0.0
deathTime = 5.0

bang = function(e)
	e:AddComponent("GraphicComponent")
	e:AddComponent("TransformComponent")
	e:AddComponent("CollisionComponent")
	e:AddComponent("ScreenComponent")
	screen = e:GetScreen()
	e:AddComponent("SoundComponent")
	sound = e:GetSC()
	sound:Load("Resources/Sound/pellet.wav")
	collider = e:GetCC()
	collider:SetType("Powerpellet")
	graphic = e:GetGC()
	graphic:SetImage("PP.png")
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
		collider:SetType("Powerpellet")
	end

	if graphic then
		graphic:Display(e:GetTransform().x, e:GetTransform().y)
	end
end

onKeyPress = function(e,k)
end

recieveMessage = function(e, message)
	if message == "Eat" then
		sound:Play()
		eaten = true
		collider:SetType("Eaten")
		graphic:Disappear()
		screen:ScreenShake(.25,-2)
	end
end