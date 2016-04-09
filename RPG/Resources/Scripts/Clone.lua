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
	e:AddComponent("MapComponent")
	map = e:GetMap()

	medTimer = 0.0
	teleportTime = 5
end

update = function(e)

	--Movement Input
	if e:KeyPressed("right") == true then
		if graphic:GetCurrentAnimation() ~= "WalkRight" then
			graphic:Play("WalkRight")
		end
		xvel = 1
	elseif e:KeyPressed("left") == true then
		if graphic:GetCurrentAnimation() ~= "WalkLeft" then
			graphic:Play("WalkLeft")
		end
		xvel = -1
	else
		xvel = 0
	end
	
	if e:KeyPressed("up") == true then
		if facing == 1 then
			if graphic:GetCurrentAnimation() ~= "WalkRight" then
				graphic:Play("WalkRight")
			end
		elseif facing == -1 then
			if graphic:GetCurrentAnimation() ~= "WalkLeft" then
				graphic:Play("WalkLeft")
			end
		end
		yvel = -1
	elseif e:KeyPressed("down") == true then
		if facing == 1 then
			if graphic:GetCurrentAnimation() ~= "WalkRight" then
				graphic:Play("WalkRight")
			end
		elseif facing == -1 then
			if graphic:GetCurrentAnimation() ~= "WalkLeft" then
				graphic:Play("WalkLeft")
			end
		end
		yvel = 1
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
	if transform.x < -32 then
		e:Signal("Left")
	elseif transform.y < 32 then
		e:Signal("Top")
	elseif transform.x > 32+map:GetWidth() then
		e:Signal("Right")
	elseif transform.y > 32+map:GetHeight() then
		e:Signal("Bottom")
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

	medTimer = -1

	if k == "left" then
		graphic:Play("WalkLeft")
	elseif k == "right" then
		graphic:Play("WalkRight")
	end
end

onKeyRelease = function(e,k)
	
	medTimer = 0

	if k == "left" then
		graphic:Stop()
	elseif k == "right" then
		graphic:Stop()
	end
end