color = "white"

bang = function(e, i)
	e:AddComponent("GraphicComponent")
	gComp = e:GetGC()
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()

	graphic = e:GetGC()
	graphic:SetImage("Tilesheet.png")

	width = 128/16

	if i then
		bx = tonumber(i)-1
		by = 0

		while bx >= width do
			bx = bx - width
			by = by + 1
		end
		graphic:SetFrameSize(16,16)
		graphic:AddFrame("Tile", bx, by)
		graphic:Play("Tile")
	end

	if e:GetLayer() == 1 then
		e:AddComponent("CollisionComponent")
		collider = e:GetCC()
		collider:SetTransform(e:GetTransform())
		collider:SetType("Block")
	end
end

display = function(e)
	if gComp then
		if color == "blue" then
			graphic:SetColor(50,50,255)
		elseif color == "white" then
			graphic:SetColor(255,255,255)
		end
        gComp:Display(e:GetTransform().x,e:GetTransform().y)
	end 
end

recieveSignal = function(e, signal)
	if signal == "white" then
		color = "white"
	elseif signal == "blue" then
		color = "blue"
	end
end