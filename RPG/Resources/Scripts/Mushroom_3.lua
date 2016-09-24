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
	graphic:Play("Off")
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
	dialogue:PushMessage("WHY WHY WHY WHY WHY\n WHY WHY WHY WHY WHY WHYWHY WHY WHY WHY WHY\n why why why why WHY\n WHY WHY WHY WHY Y Y Y\n Y Y Y Y Y Y Y YYYYY")
	print("3")
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

	if e:GetCC():CollidingType("all") == "player" then
		transform:Display(true)
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
			graphic:Play("Off")
			dialogue:Clear()
			e:Signal("Kill")
			dialogue:PushMessage("WHY WHY WHY WHY WHY\n WHY WHY WHY WHY WHY WHYWHY WHY WHY WHY WHY\n why why why why WHY\n WHY WHY WHY WHY Y Y Y\n Y Y Y Y Y Y Y YYYYY")
		elseif alive == false then
			alive = true
			graphic:Play("On")
			dialogue:Clear()
			dialogue:PushMessage("Did you know that we\n are all one organism?")
			dialogue:PushMessage("We mushrooms, that is.")
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