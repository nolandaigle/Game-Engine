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
	e:GetCC():SetType("player")
	e:AddComponent("MapComponent")
	map = e:GetMap()
	e:AddComponent("ScreenComponent")
	screen = e:GetScreen()
	medTimer = 0.0
	medTime = 5
end

update = function(e)

	if signaled == false then
		changeColor(e, color)
		signaled = true
	end
	
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


	--Meditation Timer
	if medTimer > -1 then
		medTimer = medTimer + e:GetDeltaTime()
	end

	if medTimer > medTime then
		graphic:Play("Meditate")
		--e:GetScreen():SetPixelate( true, .5, .0001)
		if medTimer > teleportTime and stuck == false then
			changeColor(e, "White")
			e:Message("Map", "Clones.json")
		end
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

	other = e:GetCC():CollidingType("all")
	if other == "Tripper" or other == "bullet" then
		if color == "White" then
			changeColor(e, "Blue")
			graphic:Play("Hurt")
			e:Message("Music", "Resources/Music/spirit.wav")
			e:Message("Music", "Loop")
			e:Message("Music", "Play")
		elseif color == "Blue" then
		end
	end


	--Tile Collision detection and resolution
	while e:GetCC():CollidingType("left") == "Sokobox" do
		if color == "White" then
			s = e:GetCC():CollidingName("left")
			e:Message(s, "left")
		end
		transform.x = transform.x + 1;
	end
	while e:GetCC():CollidingType("right") == "Sokobox" do
		if color == "White" then
			s = e:GetCC():CollidingName("right")
			e:Message(s, "right")
		end
		transform.x = transform.x - 1;
	end
	while e:GetCC():CollidingType("top") == "Sokobox" do
		if color == "White" then
			s = e:GetCC():CollidingName("top")
			e:Message(s, "up")
		end
		transform.y = transform.y + 1;
	end
	while e:GetCC():CollidingType("bottom") == "Sokobox" do
		if color == "White" then
			s = e:GetCC():CollidingName("bottom")
			e:Message(s, "down")
		end
		transform.y = transform.y - 1;
	end

	--Tile Collision detection and resolution
	while e:GetCC():CollidingType("left") == "Block" do
		if color == "Red" then
			hell(e)
		end
		transform.x = transform.x + 1;
	end
	while e:GetCC():CollidingType("right") == "Block" do
		if color == "Red" then
			hell(e)
		end
		transform.x = transform.x - 1;
	end
	while e:GetCC():CollidingType("top") == "Block" do
		if color == "Red" then
			hell(e)
		end
		transform.y = transform.y + 1;
	end
	while e:GetCC():CollidingType("bottom") == "Block" do
		if color == "Red" then
			hell(e)
		end
		transform.y = transform.y - 1;
	end
end

display = function(e)
	if graphic and showing == true then
		if color == "Blue" then
			graphic:SetColor(50,50,255)
		elseif color == "White" then
			graphic:SetColor(255,255,255)
		end
		if color == "Red" then
			graphic:SetColor(255,50,50)
		end
		graphic:Display(math.floor(transform.x), math.floor(transform.y))
	end
end

onKeyPress = function(e,k)

	medTimer = 0

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
		e:Signal(color)
	end 

	--Changeworlds
	if k == "r" then
		changeColor(e, "White")
	elseif k == "t" then
		changeColor(e, "Blue")
	end
end

onKeyRelease = function(e,k)
end

recieveMessage = function(e, message)
	if message == "Die" then
		changeColor(e, "Blue")
	end
	if message == "Hell" then
		changeColor(e, "Red")
	end
end

recieveSignal = function(e, signal)
	if signal == "Eat Player" then
			showing = false
	end
	if signal == "Stuck" then
		stuck = true
	end
	if signal == "BreakConv" then
		stuck = false
		medTimer = 0
	end
end

hell = function( e )
	file:OpenFile("Game.save")
	file:SetVariable("Warp", "2")
	file:WriteFile()
	e:Message("Map", "Hell.json")
end

changeColor = function(e, newcolor)
	color = newcolor
	file:OpenFile("Game.save")
	file:SetVariable("Color", color)
	file:WriteFile()
	e:Signal(color)
end