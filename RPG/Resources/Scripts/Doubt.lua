color = "White"
alive = true
health = 5

conversation = 0

bang = function(e)
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
	e:GetCC():SetType("Bachelor")

	--DIALOGUE stuff
	e:AddComponent("DialogComponent")
	dialogue = e:GetDC()
	dialogue:ShowGraphic(false)
	dialogue:SetVoice("pop.wav")
	dialogue:PushMessage("No he doesn't.")
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
		if color == "Red" then
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
			conversation = conversation + 1
			if color == "Red" and conversation == 2 then
				e:Message("Map", "GODHEAD.json")
--				e:Message("Map", "RedBox.json")
				dialogue:HideBox()
			end
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
			conversation = 0
		end
	end
	if signal == "White" then
		dialogue:Clear()
		dialogue:PushMessage("No she doesn't.")
		color = "White"
	elseif signal == "Blue" then
		color = "Blue"
		dialogue:Clear()
		dialogue:PushMessage("No I don't.")
	elseif signal == "Red" then
		color = "Red"
		dialogue:Clear()
		
		dialogue:PushMessage("")

		graphic:SetImage("Rainbow.png")
		graphic:SetFrameSize(16,16)
		graphic:AddFrame("Warp", 0, 0)
		graphic:AddFrame("Warp", 1, 0)
		graphic:AddFrame("Warp", 2, 0)
		graphic:AddFrame("Warp", 3, 0)
		graphic:AddFrame("Warp", 0, 1)
		graphic:AddFrame("Warp", 1, 1)
		graphic:AddFrame("Warp", 2, 1)
		graphic:AddFrame("Warp", 1, 1)
		graphic:AddFrame("Warp", 0, 1)
		graphic:AddFrame("Warp", 3, 0)
		graphic:AddFrame("Warp", 2, 0)
		graphic:AddFrame("Warp", 1, 0)
		graphic:SetFPS(20)
		graphic:Play("Warp")
	end
end