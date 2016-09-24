color = "White"
alive = true
health = 1
timer = 0

x = 0.0
y = 0.0

boned = "not"

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Cloak.png")
	graphic:SetFrameSize(16,16)
	graphic:AddFrame("Walk", 0, 0)
	graphic:AddFrame("Walk", 1, 0)
	graphic:AddFrame("Walk", 2, 0)
	graphic:AddFrame("Walk", 3, 0)
	graphic:Play("Walk")
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(16, 16)
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
	dialogue:PushMessage("I was born here.")
	dialogue:PushMessage("I've never even left this room!")
	dialogue:PushMessage("Do you know my parents?")


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
			graphic:Play("Walk")
		elseif targetx < transform.x then
			graphic:Play("Walk")
		end
		timer = 0
	elseif e:GetCC():CollidingType("all") ~= "" then
	end

	transform.x = transform.x + e:Lerp(transform.x, targetx, 0.01)
	transform.y = transform.y + e:Lerp(transform.y, targety, 0.01)

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
		dialogue:Clear()
		dialogue:PushMessage("I was born here.")
		dialogue:PushMessage("I've never even left this room!")
		dialogue:PushMessage("Do you know my parents?")
	elseif signal == "Blue" then
		color = "Blue"
		dialogue:Clear()
		dialogue:PushMessage("She doesn't notice you.")
					
	end
end