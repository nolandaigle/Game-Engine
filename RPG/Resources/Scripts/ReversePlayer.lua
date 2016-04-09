xvel = 0.0
yvel = 0.0
speed = 2.0
acceleration = .5
recoil = 4
facing = 1

bullets = {}
bulletNum = 0

color = "blue"

bang = function(e)

	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("playercolor.save")
	color = file:GetLine()
	file:CloseFile()

	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Player.png")
	graphic:SetFrameSize(8,16)
	graphic:AddFrame("WalkRight", 0, 0)
	graphic:AddFrame("WalkRight", 1, 0)
	graphic:AddFrame("WalkLeft", 0, 1)
	graphic:AddFrame("WalkLeft", 1, 1)
	graphic:AddFrame("Meditate", 0, 2)
	graphic:AddFrame("Meditate", 1, 2)
	graphic:AddFrame("Hurt", 0, 3)
	graphic:AddFrame("Hurt", 1, 3)
	graphic:Play("Meditate")
	graphic:Stop()
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(8, 16)
	e:AddComponent("CollisionComponent")
	e:AddComponent("MapComponent")
	map = e:GetMap()
	e:AddComponent("ScreenComponent")
	medTimer = 0.0
	teleportTime = 5
end

update = function(e)

	--Movement Input
	if e:KeyPressed("left") == true then
		medTimer = 0
		if xvel < speed then
			xvel = xvel + acceleration
		end
	elseif e:KeyPressed("right") == true then
		medTimer = 0
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
	
	if e:KeyPressed("down") == true then
		medTimer = 0
		if yvel > -speed then
			yvel = yvel - acceleration
		end
	elseif e:KeyPressed("up") == true then
		medTimer = 0
		if yvel < speed then
			yvel = yvel + acceleration
		end
	else
		yvel = 0
	end


	--Meditation Timer
	if medTimer > -1 then
		medTimer = medTimer + e:GetDeltaTime()
	end

	if medTimer > teleportTime then
		graphic:Play("Meditate")
	end

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
	transform.x = e:Round(transform.x+xvel)
	transform.y = e:Round(transform.y+yvel)

	--SIGNAL color
	e:Signal(color)
end

display = function(e)
	if graphic then
		if color == "blue" then
			graphic:SetColor(50,50,255)
		elseif color == "white" then
			graphic:SetColor(255,255,255)
		end
		graphic:Display(transform.x, transform.y)
	end
end

onKeyPress = function(e,k)

	medTimer = -1

	--Movement/Animation
	if k == "right" then
		facing = -1
		graphic:Play("WalkLeft")
		e:Signal("BreakConv")
	elseif k == "left" then
		facing = 1
		graphic:Play("WalkRight")
		e:Signal("BreakConv")
	end
	if k == "down" and facing == -1 then
		graphic:Play("WalkLeft")
		e:Signal("BreakConv")
	elseif k == "up" and facing == 1 then
		graphic:Play("WalkRight")
		e:Signal("BreakConv")
	end

	--NPC interaction
	guru = ""
	if k == "x" then
		guru = e:GetCC():CollidingName("all")
		if guru ~= "" then
			e:Message(guru, "Dialogue")
		end
	end

	--Shooting
	if k == "z" then
		bullets[bulletNum] = e:CreateEntity( transform.x + (facing*4), transform.y + 8, "Bullet", facing )
		bulletNum = bulletNum + 1
		xvel = -facing*recoil
	end

	--Changeworlds
	if k == "r" then
		color = "white"
		file = io.open("playercolor.save", "w")
		file:write(color)
		file:close()
		e:Signal(color)
	elseif k == "t" then
		color = "blue"
		file = io.open("playercolor.save", "w")
		file:write(color)
		file:close()
		e:Signal(color)
	end
end

onKeyRelease = function(e,k)
	
	medTimer = 0

	if k == "right" then
		graphic:Stop()
	elseif k == "left" then
		graphic:Stop()
	end
end