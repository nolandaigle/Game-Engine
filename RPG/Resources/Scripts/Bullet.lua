xvel = 0
yvel = 0
speed = 4
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
	transform:SetSize(2, 2)
	e:AddComponent("CollisionComponent")
	e:GetCC():SetType("Bullet")
	e:AddComponent("MapComponent")
	map = e:GetMap()
end

update = function(e)

	if alive == true then

        other = e:GetCC():CollidingTTN("all", "Red")

		if other ~= "" then
            e:Message(other, "Bullet")
            e:GetCC():SetType("")
            alive = false
		end
	end

	transform.x = transform.x + xvel
	transform.y = transform.y + yvel
end

display = function(e)
	if graphic and alive == true then
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
end