targetx = 0
targety = 0

starty = 0
starty = 0
bang = function(e)
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Sokobox.png")
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	e:AddComponent("CollisionComponent")
	collision = e:GetCC()
	collision:SetType("Sokobox")

	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Sokoban.save")


	targetx = transform.x
	targety = transform.y
end

update = function(e)

	transform.x = transform.x + e:Lerp(transform.x, targetx, 0.1)
	transform.y = transform.y + e:Lerp(transform.y, targety, 0.1)

	if transform.x - targetx < 3 and transform.x - targetx > -3 then
		if transform.y - targety < 3 and transform.y - targety > -3 then
			switch = collision:CollidingName("all")
			if switch ~= "" then
				if e:GetEntity(switch):GetCC():GetType() == "switch" then
					targetx = e:GetEntity(switch):GetTransform().x+1
					targety = e:GetEntity(switch):GetTransform().y+1
				end
			end
		end
	end

	--Tile Collision detection and resolution
	while collision:CollidingType("left") == "Block" do
		transform.x = transform.x + 1;
	end
	while collision:CollidingType("right") == "Block" do
		transform.x = transform.x - 1;
	end
	while collision:CollidingType("top") == "Block" do
		transform.y = transform.y + 1;
	end
	while collision:CollidingType("bottom") == "Block" do
		transform.y = transform.y - 1;
	end
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

onKeyPress = function(e,k)
	if k == "g" then
		transform.x = startx
		targetx = startx
		transform.y = starty
		targety = starty
	end
end

recieveSignal = function(e, signal)
	if signal == "White" then
		color = "White"
	elseif signal == "Blue" then
		color = "Blue"
	end
end

recieveMessage = function(e, message)
	if message == "left" then
		targetx = transform.x - 8
	end
	if message == "right" then
		targetx = transform.x + 8
	end
	if message == "up" then
		targety = transform.y - 8
	end
	if message == "down" then
		targety = transform.y + 8
	end
end