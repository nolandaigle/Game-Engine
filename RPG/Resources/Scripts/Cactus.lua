bang = function(e)
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()

	d = math.random(0, 1)

	if d == 0 then
		graphic:SetImage("Cowboy/cactus1.png")
		graphic:SetFrameSize(8, 12)
	elseif d == 1 then
		graphic:SetImage("Cowboy/cactus2.png")
		graphic:SetFrameSize(8, 8)
	end


	graphic:AddFrame("Stand", 0, 0)
	graphic:Play("Stand")

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