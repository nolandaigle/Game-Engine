xvel = 0.0
yvel = 0.0
speed = 2.0
acceleration = .5
recoil = 4
facing = 1

bullets = {}
bulletNum = 0

color = "Blue"

bang = function(e)

	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Game.save")
	color = file:GetVariable("Color")

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
	screen = e:GetScreen()
	medTimer = 0.0
	teleportTime = 5
end

update = function(e)
	
	pressing = false

	--Movement Input
	if e:KeyPressed("left") == true then
		pressing = true
		medTimer = 0
		if xvel < speed then
			xvel = xvel + acceleration
		end
	elseif e:KeyPressed("right") == true then
		pressing = true
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
		pressing = true
		medTimer = 0
		if yvel > -speed then
			yvel = yvel - acceleration
		end
	elseif e:KeyPressed("up") == true then
		pressing = true
		medTimer = 0
		if yvel < speed then
			yvel = yvel + acceleration
		end
	else
		yvel = 0
	end

	if pressing == false then
		graphic:Stop()
	end


	--Meditation Timer
	if medTimer > -1 then
		medTimer = medTimer + e:GetDeltaTime()
	end

	if medTimer > teleportTime then
		graphic:Play("Meditate")
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

	if e:GetCC():CollidingType("all") == "Tripper" then
		if color == "White" then
			changeColor(e, "Blue")
			graphic:Play("Hurt")
		elseif color == "Blue" then
		end
	end


	--Tile Collision detection and resolution
	while e:GetCC():CollidingType("left") == "Sokobox" do
		s = e:GetCC():CollidingName("left")
		e:Message(s, "left")
		transform.x = transform.x + 1;
	end
	while e:GetCC():CollidingType("right") == "Sokobox" do
		s = e:GetCC():CollidingName("right")
		e:Message(s, "right")
		transform.x = transform.x - 1;
	end
	while e:GetCC():CollidingType("top") == "Sokobox" do
		s = e:GetCC():CollidingName("top")
		e:Message(s, "up")
		transform.y = transform.y + 1;
	end
	while e:GetCC():CollidingType("bottom") == "Sokobox" do
		s = e:GetCC():CollidingName("bottom")
		e:Message(s, "down")
		transform.y = transform.y - 1;
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
end

display = function(e)
	if graphic then
		if color == "Blue" then
			graphic:SetColor(50,50,255)
		elseif color == "White" then
			graphic:SetColor(255,255,255)
		end
		graphic:Display(math.floor(transform.x), math.floor(transform.y))
	end
end

onKeyPress = function(e,k)

	medTimer = -1

	--Movement/Animation
	if k == "a" then
		file:OpenFile("Game.save")
		file:SetVariable("Player-exit", "Top")
		file:WriteFile()
		e:Message("Map", "ThreesCompany.json")
	end
	if k == "right" then
		facing = -1
		graphic:Play("WalkLeft")
		e:Signal("BreakConv")
	elseif k == "left" then
		facing = 1
		graphic:Play("WalkRight")
		e:Signal("BreakConv")
	end
	if k == "down" then
		if facing == 1 then
			graphic:Play("WalkRight")
		else
			graphic:Play("WalkLeft")
		end
		e:Signal("BreakConv")
	elseif k == "up" then
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
			e:Message(npc, "Dialogue")
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
		changeColor(e, "White")
		file:OpenFile("Game.save")
		file:SetVariable("Color", "White")
		file:WriteFile()
	elseif k == "t" then
		changeColor(e, "Blue")
		file:OpenFile("Game.save")
		file:SetVariable("Color", "Blue")
		file:WriteFile()
	end
end

onKeyRelease = function(e,k)
	
	medTimer = 0
end

changeColor = function(e, newcolor)
	color = newcolor
	file:OpenFile("Game.save")
	file:SetVariable("Color", color)
	file:WriteFile()
	e:Signal(color)
	if color == "Blue" then
		e:Message("Music", "Stop")
		e:Message("Music", "Resources/Music/spirit.wav")
		e:Message("Music", "Play")
	end
end