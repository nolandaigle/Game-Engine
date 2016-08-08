color = "White"
alive = true
health = 1

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Crib.png")
	graphic:SetFrameSize(16,8)
	graphic:AddFrame("Standing", 0, 0)
	graphic:Play("Standing")
	graphic:Stop()
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(16, 8)
	e:AddComponent("CollisionComponent")
	e:GetCC():SetType("mom")

	--DIALOGUE stuff
	e:AddComponent("DialogComponent")
	dialogue = e:GetDC()
	dialogue:ShowGraphic(false)
	dialogue:PushMessage("...")
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
		--	graphic:SetColor(50,50,255)

		--	graphic:Display(transform.x, transform.y)
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
	if message == "bullet" then
		health = health - 1

		if health == 0 then
			e:Message("Player", "Die")
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