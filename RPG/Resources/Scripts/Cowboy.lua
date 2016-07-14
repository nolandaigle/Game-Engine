xvel = 0.0
yvel = 0.0
speed = 2.0
acceleration = .5
recoil = 4
facing = 1

bullets = {}
bulletNum = 0

color = "Blue"

signaled = false

showing = true

medTimer = 0.0
medTime = 10
teleportTime = 25
stuck = false

bang = function(e)
	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Game.save")
	color = file:GetVariable("Color")

	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Cowboy/Cowboy.png")
	graphic:SetFrameSize(8,8)
	graphic:AddFrame("WalkRight", 0, 0)
	graphic:AddFrame("WalkRight", 1, 0)
	graphic:AddFrame("WalkRight", 2, 0)
	graphic:AddFrame("WalkRight", 3, 0)
	graphic:AddFrame("WalkLeft", 4, 0)
	graphic:AddFrame("WalkLeft", 5, 0)
	graphic:AddFrame("WalkLeft", 6, 0)
	graphic:AddFrame("WalkLeft", 7, 0)
	graphic:Play("WalkRight")
	graphic:Stop()
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(8, 8)
	e:AddComponent("CollisionComponent")
	e:GetCC():SetType("cowboy")
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
		bullets[bulletNum] = e:CreateEntity( transform.x + (facing*9), transform.y + 8, "Bullet", facing )
		bulletNum = bulletNum + 1
		xvel = -facing*recoil
	end 
end

onKeyRelease = function(e,k)
end

recieveMessage = function(e, message)
end

recieveSignal = function(e, signal)
	if signal == "Stuck" then
		stuck = true
	end
	if signal == "BreakConv" then
		stuck = false
		medTimer = 0
	end
end