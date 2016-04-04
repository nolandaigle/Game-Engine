startingX = 0
startingY = 0
xvel = 0
yvel = 0
speed = 2
graphic = nil
tailed = ""
timer = 0.0
deathTimer = 0.0
deathTime = 1.0

size = 0
cap = 10

color = "red"

alive = true

flipped = false

gametype = "Full"

bang = function(e)
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Player.png")
	graphic:AddFrame("blue", 0, 0 )
	graphic:AddFrame("red", 0, 1)
	graphic:AddFrame("yellow", 0, 2)
	e:AddComponent("SoundComponent")
	sound = e:GetSC()
	sound:Load("Resources/Sound/Splash2.wav")
	e:AddComponent("TransformComponent")
	e:AddComponent("CollisionComponent")
	collider = e:GetCC()
	collider:SetType("Player2")
	e:AddComponent("ScreenComponent")
	screen = e:GetScreen()

	startingX = e:GetTransform().x
	startingY = e:GetTransform().y

	--READ FILE
	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("save.txt")
	cap = tonumber(file:GetLine())
	gametype = file:GetLine()
	file:CloseFile()
end

update = function(e)
	e:GetTransform().x = e:GetTransform().x + xvel
	e:GetTransform().y = e:GetTransform().y + yvel

	timer = timer + e:GetDeltaTime()

	if alive == false then
		deathTimer = deathTimer + e:GetDeltaTime()
	end

	if deathTimer > deathTime then
		deathTimer = 0
		graphic:Show(true)
		alive = true
		collider:SetType("Player2")
		e:GetTransform().x = startingX
		e:GetTransform().y = startingY
		xvel = 0
		yvel = 0
	end

	other = e:GetCC():CollidingName("all")
	if other ~= "" and alive == true then
		if e:GetEntity(other):GetCC():GetType() == "Powerpellet" or e:GetEntity(other):GetCC():GetType() == "FlipPellet" then
			eat(e)
			e:Message(other, "Eat")
		elseif e:GetEntity(other):GetCC():GetType() == "Player1" or e:GetEntity(other):GetCC():GetType() == "Tail1" then
			e:Message(other, color)
		end
	end
end

display = function(e)
	if graphic then
		if alive == true then
			graphic:Play(color)
			graphic:Display(e:GetTransform().x, e:GetTransform().y)
		else
			e:GetScreen():SlowMo(.016)
		end
	end
end

onKeyPress = function(e,k)
	
	if k == "t" then
		eat(e)
	end

	if k == "j" then
		color = "red"
		e:Signal("2" .. color)
	elseif k == "k" then
		color = "blue"
		e:Signal("2" .. color)
	elseif k == "l" then
		color = "yellow"
		e:Signal("2" .. color)
	end

	if timer > .001 and alive then
		timer = 0

		if k == "w" then
			xvel = 0
			yvel = -speed
			if ( tailed ~= "" ) then
				e:Message(tailed, "up")
			end
			sound:Load("Resources/Sound/Splash2.wav")
			sound:Play()
		elseif k == "s" then
			xvel = 0
			yvel = speed
			if ( tailed ~= "" ) then
				e:Message(tailed, "down")
			end
			sound:Load("Resources/Sound/Splash2.wav")
			sound:Play()
		elseif k == "a" then
			xvel = -speed
			yvel = 0
			if ( tailed ~= "" ) then
				e:Message(tailed, "left")
			end
			sound:Load("Resources/Sound/Splash2.wav")
			sound:Play()
		elseif k == "d" then
			xvel = speed
			yvel = 0
			if ( tailed ~= "" ) then
				e:Message(tailed, "right")
			end
			sound:Load("Resources/Sound/Splash2.wav")
			sound:Play()
		end
	end
end

recieveSignal = function(e, signal)
	if signal == "FlipT" then
		flipped = true
	elseif signal == "FlipF" then
		flipped = false
	end
end

recieveMessage = function(e, message)
	if message == "blue" then
		if flipped == false then
			if color == "yellow" then
				sound:Load("Resources/Sound/Death.wav")
				sound:Play()
				die(e)
			end
		elseif flipped == true then
			if color == "red" then
				sound:Load("Resources/Sound/Death.wav")
				sound:Play()
				die(e)
			end
		end
	elseif message == "red" then
		if flipped == false then
			if color == "blue" then
				sound:Load("Resources/Sound/Death.wav")
				sound:Play()
				die(e)
			end
		elseif flipped == true then
			if color == "yellow" then
				sound:Load("Resources/Sound/Death.wav")
				sound:Play()
				die(e)
			end
		end
	elseif message == "yellow" then
		if flipped == false then
			if color == "red" then
				sound:Load("Resources/Sound/Death.wav")
				sound:Play()
				die(e)
			end
		elseif flipped == true then
			if color == "blue" then
				sound:Load("Resources/Sound/Death.wav")
				sound:Play()
				die(e)
			end
		end
	end
end

eat = function(e)
	x = 0
		y = 0
		if xvel > 0 then
			x = e:GetTransform().x - 20
			y = e:GetTransform().y
		elseif xvel < 0 then
			x = e:GetTransform().x + 20
			y = e:GetTransform().y
		end
		if yvel < 0 then
			y = e:GetTransform().y + 20
			x = e:GetTransform().x
		elseif yvel > 0 then
			y = e:GetTransform().y - 20
			x = e:GetTransform().x
		end

	if tailed ~= "" then
		e:Message(tailed, "Eat")
	else
		t = e:CreateEntity( x, y, "Tail2", "Player2" )
		tailed = t
	end

	if size == 0 then
		reset(e)

		if xvel > 0 then
			e:Message(tailed, "right")
		elseif xvel < 0 then
			e:Message(tailed, "left")
		elseif yvel > 0 then
			e:Message(tailed, "down")
		elseif yvel < 0 then
			e:Message(tailed, "up")
		end

	end

	size = size + 1

	if size >= cap and gametype == "Full" then
		e:Signal("ChangeMap")
	end

	e:Signal("2" .. color)
end

die = function(e)
	sound:Play()
	alive = false
	collider:SetType("")
	e:Sleep(.5)
	nextDir = {}
	nextX = {}
	nextY = {}
	size = 0

	e:GetTransform().x = startingX
	e:GetTransform().y = startingY

	screen:ScreenShake(.5,-5)
end

reset = function(e)
	if tailed ~= "" then
		e:Message(tailed, "Reset")
	end
end