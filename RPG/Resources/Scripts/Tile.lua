color = "White"

bang = function(e, i)
	e:AddComponent("GraphicComponent")
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


	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Game.save")
	color = file:GetVariable("Color")
	if color == "White" then
		graphic:SetColor(255,255,255)
	elseif color == "Blue" then
		graphic:SetColor(50,50,255)
	elseif color == "Red" then
		graphic:SetColor(255,50,50)
	end

	if e:GetLayer() == 1 then
		e:AddComponent("CollisionComponent")
		collider = e:GetCC()
		collider:SetTransform(e:GetTransform())
		collider:SetType("Block")
	end

end

display = function(e)
	if graphic then
		if e:GetCC():CollidingType("all") == "player" then
			transform:Display(false)
		end
        graphic:Display(e:GetTransform().x,e:GetTransform().y)
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
		graphic:SetColor(255,50,50)
	end
end