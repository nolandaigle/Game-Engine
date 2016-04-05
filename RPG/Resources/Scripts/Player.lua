xvel = 0
yvel = 0

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
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
	e:AddComponent("ScreenComponent")

	medTimer = 0.0
	teleportTime = 5

	e:GetTransform():CenterView()
end

update = function(e)

	--Meditation Timer
	medTimer = medTimer + e:GetDeltaTime()

	if medTimer > teleportTime then
		e:GetScreen():SetPixelate( true, .5, .0001)
		graphic:Play("Meditate")
		if medTimer > teleportTime + 5 then 
			e:Message("Music", "Stop")
		end
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

	if e:GetCC():CollidingType("all") == "Tunnel" then
		e:Message("Map", "Tunnel.json")
	end
	
	--Move transform position by xvel and yvel
	transform.x = transform.x + xvel
	transform.y = transform.y + yvel
end

display = function(e)
	if graphic then
		graphic:Display(transform.x, transform.y)
	end
end

onKeyPress = function(e,k)
	
	medTimer = 0
	e:GetScreen():SetPixelate( false, 0, .0001)

	if k == "up" then
		yvel = yvel - 1
	elseif k == "down" then
		yvel = yvel + 1
	end
	if k == "left" then
		xvel = xvel - 1
		graphic:Play("WalkLeft")
	elseif k == "right" then
		graphic:Play("WalkRight")
		xvel = xvel + 1
	end
end

onKeyRelease = function(e,k)
	
	medTimer = 0
	e:GetScreen():SetPixelate( false, 0, .0001)

	if k == "up" then
		yvel = yvel + 1
	elseif k == "down" then
		yvel = yvel - 1
	end
	if k == "left" then
		xvel = xvel + 1
		graphic:Stop()
	elseif k == "right" then
		xvel = xvel - 1
		graphic:Stop()
	end
end