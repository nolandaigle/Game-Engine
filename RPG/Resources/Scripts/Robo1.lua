color = "White"
alive = true
health = 1
timer = 0

x = 0.0
y = 0.0

creator = "missing"


bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Robo1.png")
	graphic:SetFrameSize(8,16)
	graphic:AddFrame("Stand", 0, 0)
	graphic:AddFrame("WalkRight", 1, 0)
	graphic:AddFrame("WalkRight", 2, 0)
	graphic:AddFrame("WalkRight", 3, 0)
	graphic:AddFrame("WalkRight", 0, 1)
	graphic:AddFrame("WalkRight", 1, 1)
	graphic:AddFrame("WalkRight", 2, 1)
	graphic:AddFrame("WalkRight", 3, 1)
	graphic:AddFrame("WalkLeft", 0, 2)
	graphic:AddFrame("WalkLeft", 1, 2)
	graphic:AddFrame("WalkLeft", 2, 2)
	graphic:AddFrame("WalkLeft", 3, 2)
	graphic:AddFrame("WalkLeft", 0, 3)
	graphic:AddFrame("WalkLeft", 1, 3)
	graphic:AddFrame("WalkLeft", 2, 3)
	graphic:AddFrame("WalkLeft", 3, 3)
	graphic:AddFrame("WalkLeft", 0, 4)
	graphic:Play("WalkRight")
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(8, 16)
	e:AddComponent("CollisionComponent")
	e:GetCC():SetType("robot")

	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Quest.save")


	if file:GetVariable("Creator") ~= "" then
		creator = file:GetVariable("Creator")
	end

	--DIALOGUE stuff
	e:AddComponent("DialogComponent")
	dialogue = e:GetDC()
	dialogue:ShowGraphic(false)
	dialogue:SetVoice("uh.wav")

	if creator == "missing" then
		dialogue:PushMessage("Hi.")
		dialogue:PushMessage("Our creator has been gone\n for a long time.")
		dialogue:PushMessage("These arcade games are\n all that we have left of him.")
	elseif creator == "returned" then
		dialogue:PushMessage("He's back!")
		dialogue:PushMessage("Where has he been\n for all this time?")
		dialogue:PushMessage("I would visit him,\n but my gears are busted.")
		dialogue:PushMessage("If you see him,\n can you ask him a question for me?")
		dialogue:PushMessage("Just ask him...")
		dialogue:PushMessage("What is awareness?\n\nAnd...\n do I have it?")
	end

	startx = transform.x
	starty = transform.y
	targetx = startx + 16
	targety = starty + 16
end

update = function(e)
	timer = timer + e:GetDeltaTime()
	if timer > 8 and e:GetCC():CollidingType("all") == "" then
		targetx = startx + math.random(- 64, 64)
		targety = starty + math.random(- 64, 64)
		if targetx > transform.x then
			graphic:Play("WalkRight")
		elseif targetx < transform.x then
			graphic:Play("WalkLeft")
		end
		timer = 0
	elseif e:GetCC():CollidingType("all") ~= "" then
		graphic:Play("Stand")
		targetx = transform.x
		targety = transform.y
	end

	transform.x = transform.x + e:Lerp(transform.x, targetx, 0.01)
	transform.y = transform.y + e:Lerp(transform.y, targety, 0.01)

	if math.abs(x - targetx) < 2 and math.abs(y - targety) < 2 then
		graphic:Play("Stand")
	end

	if health < 1 and alive == true then
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
	end

	if e:GetCC():CollidingType("all") == "player" and color == "White" then
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
	end
end