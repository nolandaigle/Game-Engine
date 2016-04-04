bang = function(e, i)
	e:AddComponent("GraphicComponent")
	e:AddComponent("TransformComponent")

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
	transform = e:GetTransform()

	gComp = e:GetGC()

	if gComp then

        gComp:Display(e:GetTransform().x,e:GetTransform().y)
	end 
end