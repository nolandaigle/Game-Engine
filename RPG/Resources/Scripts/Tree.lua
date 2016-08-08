color = "White"

bang = function(e)
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()

	d = math.random(0, 4)

	if d == 0 then
		graphic:SetImage("tree4.png")
	elseif d == 1 then
		graphic:SetImage("tree5.png")
	elseif d == 2 then
		graphic:SetImage("tree6.png")
	elseif d == 3 then
		graphic:SetImage("tree7.png")
	elseif d == 4 then
		graphic:SetImage("tree8.png")
	end

	graphic:SetFrameSize(64,64)
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(64, 64)
	e:AddComponent("CollisionComponent")
	collision = e:GetCC()
	collision:SetType("Block")

	e:SetUpdate(false)
end

update = function(e)
end

display = function(e)
	if graphic then
		if color == "Blue" then
			graphic:Display(transform.x, transform.y)
		end
		if color == "White" then
			graphic:Display(transform.x, transform.y)
		end
	end
end

recieveSignal = function(e, signal)
	if signal == "White" then
		color = "White"
		graphic:SetColor(255,255,255)
	elseif signal == "Blue" then
		color = "Blue"
		graphic:SetColor(50,50,255)
	elseif signal == "Red" then
		color = "Red"
	end
end