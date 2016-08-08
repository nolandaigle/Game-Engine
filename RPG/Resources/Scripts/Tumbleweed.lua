bang = function(e)
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Cowboy/Tumbleweed.png")
	graphic:SetFrameSize(8, 8)
	graphic:AddFrame("Right", 0, 0)
	graphic:AddFrame("Right", 1, 0)
	graphic:AddFrame("Right", 2, 0)
	graphic:AddFrame("Right", 3, 0)
	graphic:AddFrame("Right", 4, 0)
	graphic:AddFrame("Right", 5, 0)
	graphic:AddFrame("Left", 5, 0)
	graphic:AddFrame("Left", 4, 0)
	graphic:AddFrame("Left", 3, 0)
	graphic:AddFrame("Left", 2, 0)
	graphic:AddFrame("Left", 1, 0)
	graphic:AddFrame("Left", 0, 0)
	graphic:Play("Right")

	e:AddComponent("TransformComponent")
	transform = e:GetTransform()

	startX = transform.x
	startY = transform.y

	e:AddComponent("MapComponent")
	map = e:GetMap()
end

update = function(e)
	if map then
		if transform.x > map:GetWidth() then
			transform.x = 0
		end
	end

	transform.x = transform.x + 1
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