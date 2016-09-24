color = "White"
alive = false
health = 0
timer = 0

x = 0.0
y = 0.0
startx = 0
starty = 0
targetx = 0
targety = 0

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Skeleton.png")
	graphic:SetFrameSize(8,16)
	graphic:AddFrame("WalkRight", 0, 1)
	graphic:AddFrame("WalkRight", 1, 1)
	graphic:AddFrame("WalkLeft", 0, 0)
	graphic:AddFrame("WalkLeft", 1, 0)
	graphic:AddFrame("Stand", 0, 2)
	graphic:AddFrame("Stand", 1, 2)
	graphic:Play("WalkRight")
	graphic:Stop()
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(8, 16)
	e:AddComponent("CollisionComponent")
	e:GetCC():SetType("skeleton")

	--DIALOGUE stuff
	e:AddComponent("DialogComponent")
	dialogue = e:GetDC()
	dialogue:ShowGraphic(false)
	dialogue:SetVoice("uh.wav")
	dialogue:PushMessage("I was just minding my\n business...")
	dialogue:PushMessage("Damn monster.")
	dialogue:PushMessage("Swallowed me whole.")

	startx = transform.x
	starty = transform.y
	x = transform.x
	y = transform.y
	targetx = startx + 16
	targety = starty + 16
end

update = function(e)
	timer = timer + e:GetDeltaTime()
	if timer > 8 and e:GetCC():CollidingType("all") == "" then
		targetx = startx + math.random(- 32, 32)
		targety = startx + math.random(- 32, 32)
		if targetx > x then
			graphic:Play("WalkRight")
		elseif targetx < x then
			graphic:Play("WalkLeft")
		end
		timer = 0
	elseif e:GetCC():CollidingType("all") ~= "" then
		targetx = x
		targety = y
	end

	x = x + e:Lerp(x, targetx, 0.01)
	y = y + e:Lerp(y, targety, 0.01)

	transform.x = x
	transform.y = y

	if math.abs(x - targetx) < 2 and math.abs(y - targety) < 2 then
		graphic:Play("Stand")
	end

	if health < 1 then
		alive = false
	end
end

display = function(e)
	if graphic then
		if color == "Blue" then
			graphic:SetColor(50,50,255)

			graphic:Display(transform.x, transform.y)
		end
		if color == "White" and alive == true then
			graphic:SetColor(255,255,255)
			graphic:Display(transform.x, transform.y)
		end
		if color == "Red" and alive == true then
			graphic:SetColor(255,50,50)
			graphic:Display(transform.x, transform.y)
		end
	end

	if e:GetCC():CollidingType("all") == "player" then
		transform:Display(true)
	end
end

onKeyPress = function(e,k)
end

onKeyRelease = function(e,k)
end

recieveMessage = function(e, message)
	if message == "Dialogue" then
		if e:GetDC() then
			dialogue:OpenDialogue()
		end
	end
	if message == "bullet" then
		health = health - 1
	end
end

recieveSignal = function(e, signal)
	charMove = signal
	if signal == "BreakConv" then
		if e:GetDC() then
			dialogue:HideBox()
		end
	end
	if signal == "White" then
		color = "White"
	elseif signal == "Blue" then
		color = "Blue"
	elseif signal == "Red" then
		color = "Red"
	end
end