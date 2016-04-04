parent = "Player2"
tailed = ""

xvel = 0
yvel = 0
speed = 2

nextX = {}
nextY = {}
nextDir = {}
count = 0

distance = 20

alive = true

color = "blue"

flipped = false

bang = function(e, info)
	e:AddComponent("GraphicComponent")
	e:AddComponent("TransformComponent")
	e:AddComponent("ScreenComponent")
	screen = e:GetScreen()
	e:AddComponent("CollisionComponent")
	collider = e:GetCC()
	collider:SetType("Tail2")
	graphic = e:GetGC()
	graphic:SetImage("Player.png")
	graphic:AddFrame("blue", 0, 0 )
	graphic:AddFrame("red", 0, 1)
	graphic:AddFrame("yellow", 0, 2)
	e:AddComponent("SoundComponent")
	sound = e:GetSC()
	sound:Load("Resources/Sound/Death.wav")
	parent = info
	table.insert(nextX, 1, e:GetEntity(parent):GetTransform().x)
	table.insert(nextY, 1, e:GetEntity(parent):GetTransform().y)

	if e:GetTransform().x < nextX[1] then
		table.insert(nextDir, 1, "right")
	elseif e:GetTransform().x > nextX[1] then
		table.insert(nextDir, 1, "left")
	elseif e:GetTransform().y > nextY[1] then
		table.insert(nextDir, 1, "up")
	elseif e:GetTransform().y < nextY[1] then
		table.insert(nextDir, 1, "down")
	end

	if nextDir[1] == "up" then
		xvel = 0
		yvel = -speed
	elseif nextDir[1] == "down" then
		xvel = 0
		yvel = speed
	elseif nextDir[1] == "left" then
		xvel = -speed
		yvel = 0
	elseif nextDir[1] == "right" then
		xvel = speed
		yvel = 0
	end

	count = count + 1
end

update = function(e)
	e:GetTransform().x = e:GetTransform().x + xvel
	e:GetTransform().y = e:GetTransform().y + yvel

	if e:GetEntity(parent):GetCC():GetType() == "" then
		die(e)
	end

	other = e:GetCC():CollidingName("all")
	if other ~= "" and alive then
		if e:GetEntity(other):GetCC():GetType() == "Player1" or e:GetEntity(other):GetCC():GetType() == "Tail1" then
			e:Message(other, color)
		end
	end

	if count > 0 and e:GetTransform() then
		if e:GetTransform().x == nextX[1] and e:GetTransform().y == nextY[1] then
			if nextDir[1] == "up" then
				xvel = 0
				yvel = -speed
			elseif nextDir[1] == "down" then
				xvel = 0
				yvel = speed
			elseif nextDir[1] == "left" then
				xvel = -speed
				yvel = 0
			elseif nextDir[1] == "right" then
				xvel = speed
				yvel = 0
			end

			if tailed ~= "" then
				e:Message(tailed, nextDir[1])
			end

			table.remove(nextX, 1)
			table.remove(nextY, 1)
			table.remove(nextDir, 1)
			count = count - 1
		end
	end
end

display = function(e)
	if graphic and alive == true then
		graphic:Play(color)
		graphic:Display(e:GetTransform().x, e:GetTransform().y)
	end
end

onKeyPress = function(e,k)
	if k == "r" then
		sound:SetVolume(200)
		sound:Play()
	end
end

recieveSignal = function(e, signal)
	if signal == "2red" then
		color = "red" 
	end
	if signal == "2blue" then
		color = "blue" 
	end
	if signal == "2yellow" then
		color = "yellow" 
	end

	if signal == "FlipT" then
		flipped = true
	elseif signal == "FlipF" then
		flipped = false
	end
end

recieveMessage = function(e, message)
	if message == "Reset" then
		reset(e)
		if tailed ~= "" then
			e:Message(tailed, "Reset")
		end
	end
	if message == "Eat" then
		x = 0
		y = 0

		if xvel > 0 then
			x = e:GetTransform().x - 20
			y = e:GetTransform().y
		elseif xvel < 0 then
			x = e:GetTransform().x + 20
			y = e:GetTransform().y
		else
			x = e:GetTransform().x
		end

		if yvel < 0 then
			y = e:GetTransform().y + 20
			x = e:GetTransform().x
		elseif yvel > 0 then
			y = e:GetTransform().y - 20
			x = e:GetTransform().x
		else
			y = e:GetTransform().y
		end

		if alive == false then
			graphic:Show(true)
			alive = true
			collider:SetType("Tail2")
		elseif tailed ~= "" then
			e:Message( tailed, message)
		else
			t = e:CreateEntity( x, y, "Tail2", e:GetName() )
			tailed = t
		end
	end
	if message == "blue" then
		if flipped == false then
			if color == "yellow" then
				sound:Play()
				die(e)
			end
		elseif flipped == true then
			if color == "red" then
				sound:Play()
				die(e)
			end
		end
	elseif message == "red" then
		if flipped == false then
			if color == "blue" then
				sound:Play()
				die(e)
			end
		elseif flipped == true then
			if color == "yellow" then
				sound:Play()
				die(e)
			end
		end
	elseif message == "yellow" then
		if flipped == false then
			if color == "red" then
				sound:Play()
				die(e)
			end
		elseif flipped == true then
			if color == "blue" then
				sound:Play()
				die(e)
			end
		end
	end
	if message == "up" or message == "down" or message == "left" or message == "right" then
		table.insert(nextX, e:GetEntity(parent):GetTransform().x)
		table.insert(nextY, e:GetEntity(parent):GetTransform().y)
		table.insert(nextDir, message)

		count = count + 1
	end
end

die = function(e)
	if alive then
		alive = false
		collider:SetType("")
		e:Sleep(.25)
		screen:ScreenShake(.25,-3)
	end
end

reset = function(e)

	nextX = {}
	nextY = {}
	nextDir = {}

	x = 0
	y = 0

	if xvel > 0 then
		x = e:GetEntity(parent):GetTransform().x - 20
		y = e:GetEntity(parent):GetTransform().y
	elseif xvel < 0 then
		x = e:GetEntity(parent):GetTransform().x + 20
		y = e:GetEntity(parent):GetTransform().y
	else
		x = e:GetEntity(parent):GetTransform().x
	end

	if yvel < 0 then
		y = e:GetEntity(parent):GetTransform().y + 20
		x = e:GetEntity(parent):GetTransform().x
	elseif yvel > 0 then
		y = e:GetEntity(parent):GetTransform().y - 20
		x = e:GetEntity(parent):GetTransform().x
	else
		y = e:GetEntity(parent):GetTransform().y
	end

	e:GetTransform().x = x
	e:GetTransform().y = y
end