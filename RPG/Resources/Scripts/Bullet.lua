xvel = 0
speed = 3
color = "white"
alive = true

bang = function(e, i)
	xvel = tonumber(i)*speed
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Bullet.png")
	graphic:SetFrameSize(2,2)
	graphic:AddFrame("Shooting", 0, 0)
	graphic:Play("Shooting")
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(8, 8)
	e:AddComponent("CollisionComponent")
	e:GetCC():SetType("bullet")
	e:AddComponent("MapComponent")
	map = e:GetMap()
end

update = function(e)
	
	if transform.x > map:GetWidth() then
		transform.x = 0
	end

	if alive == true then
		other = e:GetCC():CollidingName("all")
		if other ~= "" then
			e:Message(other, "bullet")
			alive = false
			e:GetCC():SetType("open")
		end
	end

	transform.x = transform.x + xvel
end

display = function(e)
	if graphic and alive == true then
		if color == "blue" then
			graphic:SetColor(50,50,255)
		elseif color == "white" then
			graphic:SetColor(255,255,255)
		end
		graphic:Display(transform.x, transform.y)
	end
end

onKeyPress = function(e,k)
end

onKeyRelease = function(e,k)
end

recieveMessage = function(e, message)
end

recieveSignal = function(e, signal)
	if signal == "white" then
		color = "white"
	elseif signal == "blue" then
		color = "blue"
	end
end