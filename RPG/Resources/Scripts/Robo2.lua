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
	graphic:SetImage("Robo2.png")
	graphic:SetFrameSize(8,16)
	graphic:SetFPS(12)
	graphic:AddFrame("Stand", 0, 0)
	graphic:AddFrame("WalkRight", 1, 0)
	graphic:AddFrame("WalkRight", 2, 0)
	graphic:AddFrame("WalkRight", 0, 1)
	graphic:AddFrame("WalkLeft", 1, 1)
	graphic:AddFrame("WalkLeft", 2, 1)
	graphic:AddFrame("WalkLeft", 0, 2)
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
		dialogue:PushMessage("Robots don't have souls.")
		dialogue:PushMessage("We carry the soul of our\n creator.")
	elseif creator == "returned" then
		dialogue:PushMessage("He's back!")
		dialogue:PushMessage("Now what am I waiting for?")
		dialogue:PushMessage("if file:GetVariable('Creator') == 'complete' then\n    dialogue:PushMessage('I am literally \na computer program')\n    dialogue:PushMessage('My brain...')\n    dialogue:PushMessage('My brain \nprocesses input too.'))")
	end
	dialogue:SetVoice("uh.wav")

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