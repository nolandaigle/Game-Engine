color = "White"
alive = false

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Mushroom.png")
	graphic:SetFrameSize(16,16)
	graphic:AddFrame("Off", 0, 0)
	graphic:AddFrame("On", 0, 1)
	graphic:Play("On")
	graphic:Stop()
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(16, 16)
	e:AddComponent("CollisionComponent")
	e:GetCC():SetType("mushroom")

	--DIALOGUE stuff
	e:AddComponent("DialogComponent")
	dialogue = e:GetDC()
	dialogue:ShowGraphic(false)
	dialogue:PushMessage("Kill me.\n\n Please!")
	print("2")
end

update = function(e)
end

display = function(e)
	if graphic then
		if color == "Blue" then
			graphic:SetColor(50,50,255)
			graphic:Display(transform.x, transform.y)
		end
		if color == "White" then
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
	if message == "bullet" then
		if alive == true then
			alive = false
			graphic:Play("On")
			dialogue:Clear()
			dialogue:PushMessage("Kill me.\n\n Please!")
			e:Signal("Kill")
		elseif alive == false then
			alive = true
			graphic:Play("Off")
			dialogue:Clear()
			dialogue:PushMessage("Oh...\n that's good.")
			e:Signal("Mushroom")
		end
	end

	if message == "Dialogue" then
		if e:GetDC() then
			dialogue:OpenDialogue()
		end
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