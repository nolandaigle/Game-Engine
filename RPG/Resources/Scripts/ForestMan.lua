color = "White"
alive = true
health = 5
td = false

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
	e:GetCC():SetType("guru")

	--DIALOGUE stuff
	e:AddComponent("DialogComponent")
	dialogue = e:GetDC()
	dialogue:ShowGraphic(false)
	dialogue:PushMessage("The lonely man\n walks a lonely path.")
	dialogue:PushMessage("The trees branch\n ...or not.")
end

update = function(e)
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

	if td then
		transform:Display(true)
	end
	td = false
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
		td = true
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