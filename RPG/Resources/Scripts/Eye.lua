color = "White"
alive = true
health = 1
timer = 0
otimer = 0

showing = true

x = 0.0
y = 0.0

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Eye.png")
	graphic:SetFrameSize(65,64)
	graphic:AddFrame("Close", 0, 0)
	graphic:AddFrame("Close", 1, 0)
	graphic:AddFrame("Close", 2, 0)
	graphic:AddFrame("Close", 3, 0)
	graphic:AddFrame("Close", 4, 0)
	graphic:AddFrame("Close", 5, 0)
	graphic:AddFrame("Close", 6, 0)
	graphic:AddFrame("Open", 6, 0)
	graphic:AddFrame("Open", 5, 0)
	graphic:AddFrame("Open", 4, 0)
	graphic:AddFrame("Open", 3, 0)
	graphic:AddFrame("Open", 2, 0)
	graphic:AddFrame("Open", 1, 0)
	graphic:AddFrame("Open", 0, 0)
	graphic:Play("Open")
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(64, 64)
	e:AddComponent("CollisionComponent")
	e:GetCC():SetType("skeleton")

	--DIALOGUE stuff
	e:AddComponent("DialogComponent")
	dialogue = e:GetDC()
	dialogue:ShowGraphic(false)
	dialogue:SetVoice("uh.wav")
	dialogue:PushMessage("...")


	startx = transform.x
	starty = transform.y
	targetx = startx + 16
	targety = starty + 16
end

update = function(e)
	timer = timer + e:GetDeltaTime()

	if timer > 1.75 and timer < 2.00 then
		graphic:Play("Close")
		argetx = startx + math.random(- 32, 32)
		targety = startx + math.random(- 32, 32)
	elseif timer > 3.5 and timer < 10 then
		if otimer == 0 then
			otimer = 1
			showing = false
		end
		graphic:Play("Open")
	elseif timer > 10 then
		timer = 0
		graphic:Play("Open")
		if otimer == 1 then
			otimer = 0
			showing = true
		end
	end

	transform.x = transform.x + e:Lerp(transform.x, targetx, 0.01)
	transform.y = transform.y + e:Lerp(transform.y, targety, 0.01)

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
		if color == "White" and alive == true and showing == true then
			graphic:SetColor(255,255,255)
			graphic:Display(transform.x, transform.y)
		end
	end

	if e:GetCC():CollidingType("all") == "player" then
		transform:Display(true)
	end
end

onKeyPress = function(e,k)
	if k == "f" then
		graphic:Play("Close")
	elseif k == "g" then
		graphic:Play("Open")
	end
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