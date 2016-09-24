color = "White"
alive = true
health = 5
tdisplay = false

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Jesus.png")
	graphic:SetFrameSize(32,32)
	graphic:AddFrame("Meditate", 0, 0)
	graphic:Play("Meditate")
	graphic:Stop()
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(32, 32)
	e:AddComponent("CollisionComponent")
	e:GetCC():SetType("guru")

	--DIALOGUE stuff
	e:AddComponent("DialogComponent")
	dialogue = e:GetDC()
	dialogue:ShowGraphic(false)

	d = math.random(0, 1)

	if d == 0 then
		dialogue:PushMessage("Does anybody feel bad\n for Bill Cosby?")
	elseif d == 1 then
		dialogue:PushMessage("Real life?\n ...what does it feel like?")
		dialogue:PushMessage("I ask you tonight...\n I ask you tonight\n to live a real life.")
		dialogue:PushMessage("I just want to be a real boy.")
		dialogue:PushMessage("Pinochio story is,\n I just want to be a real boy.\nPinochio story is\n to be a real boy.")
	end


end

update = function(e)
	if health < 1 then
		alive = false
		e:Signal("Killed")
	end
end

display = function(e)
	if graphic then
		if color == "Blue" then
			graphic:SetColor(50,50,255)
			graphic:Display(transform.x, transform.y)

			if tdisplay == true then
			transform:Display(true)
			tdisplay = false
			end
		end
		if color == "White" and alive == true then
			graphic:SetColor(255,255,255)
			graphic:Display(transform.x, transform.y)

			if tdisplay == true then
			transform:Display(true)
			tdisplay = false
		end
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
	if message == "PlayerTouch" then
		tdisplay = true
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