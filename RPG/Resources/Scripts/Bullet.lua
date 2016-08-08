xvel = 0
yvel = 0
speed = 3
color = "white"
alive = true

bang = function(e, i)
	xvel = tonumber(i)*speed

	if tonumber(i) == 0 then
		xvel = 0
		yvel = -2
	end

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
			if e:GetEntity(other):GetCC():GetType() ~= "" then
				e:Message(other, "bullet")
                alive = falsezz
			end
		end
	end

	transform.x = transform.x + xvel
	transform.y = transform.y + yvel
end

display = function(e)
	if graphic and alive == true then
		if color == "Blue" then
			graphic:SetColor(50,50,255)
		elseif color == "Blue" then
			graphic:SetColor(255,255,255)
		elseif color == "Red" then
			graphic:SetColor(255,50,50)
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
	if signal == "White" then
		color = "White"
	elseif signal == "Blue" then
		color = "Blue"
	elseif signal == "Red" then
		color = "Red"
	end
end