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
		graphic:Display(transform.x, transform.y)
	end
end

onKeyPress = function(e,k)
end

onKeyRelease = function(e,k)
end