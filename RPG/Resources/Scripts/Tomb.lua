color = "White"
alive = true
health = 5
tdisplay = false

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Tomb.png")
	graphic:SetFrameSize(64,64)
	graphic:AddFrame("Meditate", 0, 0)
	graphic:Play("Meditate")
	graphic:Stop()
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(64, 64)
	e:AddComponent("CollisionComponent")
	e:GetCC():SetType("guru")

	--DIALOGUE stuff
	e:AddComponent("DialogComponent")
	dialogue = e:GetDC()
	dialogue:ShowGraphic(false)
	dialogue:PushMessage(" Here lies...\n\n\n  The only person around\nhere who matters.")
	dialogue:PushMessage(" Yes, it's true.\nI made my own\n\n tombstone.")

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
		end
		if color == "White" and alive == true then
			graphic:SetColor(255,255,255)
			graphic:Display(transform.x, transform.y)
		end
	end

		if tdisplay == true then
			transform:Display(true)
			tdisplay = false
		end
end

onKeyPress = function(e,k)
end

onKeyRelease = function(e,k)
end

recieveMessage = function(e, message)
	if message == "PlayerTouch" then
		tdisplay = true
	end
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