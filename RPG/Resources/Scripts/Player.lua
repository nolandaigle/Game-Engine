xvel = 0.0
yvel = 0.0
speed = 2.0
acceleration = .5
recoil = 3.5
facing = 1

showing = true

red = 0
blue = 0

bang = function(e)
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Player.png")
	graphic:SetFrameSize(8,16)
	graphic:AddFrame("WalkRight", 0, 0)
	graphic:AddFrame("WalkRight", 1, 0)
	graphic:AddFrame("WalkLeft", 0, 1)
	graphic:AddFrame("WalkLeft", 1, 1)
	graphic:AddFrame("Hurt", 0, 3)
	graphic:AddFrame("Hurt", 1, 3)
	graphic:Play("WalkRight")
	graphic:Stop()
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(8, 16)
	e:AddComponent("CollisionComponent")
	e:GetCC():SetType("player")
	e:AddComponent("MapComponent")
	map = e:GetMap()
	e:AddComponent("ScreenComponent")
	screen = e:GetScreen()
end

update = function(e)
	
	pressing = false

	--Movement Input
	if e:KeyPressed("right") == true then
		pressing = true
		
		if xvel < speed then
			xvel = xvel + acceleration
		end
	elseif e:KeyPressed("left") == true then
		pressing = true
		if xvel > -speed then
			xvel = xvel - acceleration
		end
	else
		if xvel > 0 then
			xvel = xvel - acceleration
		elseif xvel < 0 then
			xvel = xvel + acceleration
		end
	end
	
	if e:KeyPressed("up") == true then
		pressing = true
		if yvel > -speed then
			yvel = yvel - acceleration
		end
	elseif e:KeyPressed("down") == true then
		pressing = true
		if yvel < speed then
			yvel = yvel + acceleration
		end
	else
		yvel = 0
	end

	if pressing == false then
		graphic:Stop()
	else
	end

	--Map Exits
	if map then
		if transform.x < 0 then
			e:Signal("Left")
		elseif transform.y < 0 then
			e:Signal("Top")
		elseif transform.x > map:GetWidth() then
			e:Signal("Right")
		elseif transform.y > map:GetHeight() then
			e:Signal("Bottom")
		end
	end

	if xvel < .01 and xvel > -.01 then
		xvel = 0
	end

	--Move transform position by xvel and yvel
	transform.x = (transform.x+xvel)
	transform.y = (transform.y+yvel)

	--Tile Collision detection and resolution
	while e:GetCC():CollidingType("left") == "Block" do
		transform.x = transform.x + 1;
	end
	while e:GetCC():CollidingType("right") == "Block" do
		transform.x = transform.x - 1;
	end
	while e:GetCC():CollidingType("top") == "Block" do
		transform.y = transform.y + 1;
	end
	while e:GetCC():CollidingType("bottom") == "Block" do
		transform.y = transform.y - 1;
	end

	other = e:GetCC():CollidingName("all")
	if other ~= "" then
		e:Message(other, "PlayerTouch")
	end
end

display = function(e)
	if graphic and showing == true then
		graphic:Display(math.floor(transform.x), math.floor(transform.y))
	end
end

onKeyPress = function(e,k)

	--Movement/Animation
	if k == "left" then
		facing = -1
		graphic:Play("WalkLeft")
		e:Signal("BreakConv")
	elseif k == "right" then
		facing = 1
		graphic:Play("WalkRight")
		e:Signal("BreakConv")
	end
	if k == "up" then
		if facing == 1 then
			graphic:Play("WalkRight")
		else
			graphic:Play("WalkLeft")
		end
		e:Signal("BreakConv")
	elseif k == "down" then
		if facing == 1 then
			graphic:Play("WalkRight")
		else
			graphic:Play("WalkLeft")
		end
		e:Signal("BreakConv")
	end

	--NPC interaction
	npc = ""
	if k == "x" then
		npc = e:GetCC():CollidingName("all")
		if npc ~= "" then
			stuck = true
			e:Message(npc, "Dialogue")
		end
	end

	--Shooting
	if k == "z" then
		e:CreateEntity( transform.x + (facing*9), transform.y + 8, "Bullet", facing )
		xvel = -facing*recoil
	end 
end

onKeyRelease = function(e,k)
end

recieveMessage = function(e, message)
end

recieveSignal = function(e, signal)
	if signal == "KillRed" then
		blue = blue + 25
		graphic:SetColor(255 - blue,255 - blue - red,255 - red)
	end
	if signal == "KillBlue" then
		red = red + 5
		graphic:SetColor(255 - blue,255 - blue - red,255 - red)
	end
end