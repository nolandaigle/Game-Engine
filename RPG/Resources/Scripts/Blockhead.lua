color = "White"
alive = true
health = 2
timer = 0

x = 0.0
y = 0.0

boned = "not"

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("blockhead.png")
	graphic:SetFrameSize(16,16)
	graphic:AddFrame("WalkRight", 3, 0)
	graphic:AddFrame("WalkRight", 4, 0)
	graphic:AddFrame("WalkRight", 5, 0)
	graphic:AddFrame("WalkLeft", 0, 0)
	graphic:AddFrame("WalkLeft", 1, 0)
	graphic:AddFrame("WalkLeft", 2, 0)
	graphic:Play("WalkRight")
	graphic:Stop()
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(8, 16)
	e:AddComponent("CollisionComponent")
	e:GetCC():SetType("skeleton")

	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Quest.save")
	
	boned =  file:GetVariable("Bone")

	--DIALOGUE stuff
	e:AddComponent("DialogComponent")
	dialogue = e:GetDC()
	dialogue:ShowGraphic(false)
	dialogue:SetVoice("uh.wav")
	dialogue:PushMessage("...my friend\n doesn't talk anymore.")
	dialogue:PushMessage("When we explored the ruins,\n there were three of us.")
	dialogue:PushMessage("Out there...\n You have to find your own\n God.")
	dialogue:PushMessage("...")
	dialogue:PushMessage("Yes, I mean the Ruins\n to the NORTH.")
	dialogue:PushMessage("It's scary out there.")


	startx = transform.x
	starty = transform.y
	targetx = startx + 16
	targety = starty + 16
end

update = function(e)
	timer = timer + e:GetDeltaTime()
	if timer > 8 and e:GetCC():CollidingType("all") == "" then
		targetx = startx + math.random(- 16, 16)
		targety = starty + math.random(- 16, 16)
		if targetx > transform.x then
			graphic:Play("WalkRight")
		elseif targetx < transform.x then
			graphic:Play("WalkLeft")
		end
		timer = 0
	elseif e:GetCC():CollidingType("all") ~= "" then
		graphic:Stop()
	end

	transform.x = transform.x + math.floor(e:Lerp(transform.x, targetx, 0.01))
	transform.y = transform.y + math.floor(e:Lerp(transform.y, targety, 0.01))

	if math.abs(x - targetx) < 2 and math.abs(y - targety) < 2 then
		graphic:Stop()
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
	end
end