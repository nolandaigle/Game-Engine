color = "White"

bang = function(e)
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("tree2.png")
	graphic:SetFrameSize(64,64)
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(64, 64)
	e:AddComponent("CollisionComponent")
	collision = e:GetCC()
	collision:SetType("Block")
end

update = function(e)
end

display = function(e)
	if graphic then
		if color == "Blue" then
			graphic:SetColor(50,50,255)
			graphic:Display(transform.x, transform.y)
		end
		if color == "White" then
			graphic:SetColor(255,255,255)
			graphic:Display(transform.x, transform.y)
		end
	end
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