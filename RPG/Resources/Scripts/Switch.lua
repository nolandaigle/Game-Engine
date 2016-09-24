locked = true

bang = function(e)
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Trigger.png")
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	e:AddComponent("CollisionComponent")
	collision = e:GetCC()
	collision:SetType("switch")
	e:AddComponent("SoundComponent")
	sound = e:GetSC()
	sound:Load("Resources/Sound/Switch.wav", "Switch")
end

update = function(e)
	if locked == true then
		if collision:CollidingType("all") == "Sokobox" then
			e:Signal("reset")
			locked = false
			sound:Play("Switch")
		end
	elseif locked == false then
		if collision:CollidingType("all") ~= "Sokobox" then
			locked = true
			e:Signal("reset")
			sound:Play("Switch")
		end
	end
end

display = function(e)
	if graphic then
		if color == "Blue" then
			graphic:SetColor(50,50,255)
			graphic:Display(transform.x, transform.y)
		end
		if color == "White" and alive == true then
			graphic:SetColor(255,255,255)
			graphic:Display(transform.x, transform.y)
		end
		if color == "Red" and alive == true then
			graphic:SetColor(255,50,50)
			graphic:Display(transform.x, transform.y)
		end
	end
end

onKeyPress = function(e,k)
end

onKeyRelease = function(e,k)
end

recieveSignal = function(e, signal)

	if signal == "White" then
		color = "White"
	elseif signal == "Blue" then
		color = "Blue"
	elseif signal == "Red" then
		color = "Red"
	end
end