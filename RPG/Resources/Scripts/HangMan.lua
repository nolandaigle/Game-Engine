color = "White"
alive = true
health = 5
conversation = 0
music = false

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("HangMan.png")
	graphic:SetFrameSize(64,64)
	graphic:AddFrame("Standing", 0, 0)
	graphic:AddFrame("Standing", 0, 1)
	graphic:AddFrame("Standing", 0, 2)
	graphic:AddFrame("Standing", 0, 3)
	graphic:AddFrame("Standing", 0, 4)
	graphic:AddFrame("Standing", 0, 5)
	graphic:AddFrame("Standing", 0, 6)
	graphic:Play("Standing")
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(64, 64)
	e:AddComponent("CollisionComponent")
	e:GetCC():SetType("hangman")

	e:AddComponent("FileComponent")
	file = e:GetFC()

	--DIALOGUE stuff
	e:AddComponent("DialogComponent")
	dialogue = e:GetDC()
	dialogue:ShowGraphic(false)
	dialogue:PushMessage("I've been so sad\n my whole life.")
	dialogue:PushMessage("I wanted to die...")
	dialogue:PushMessage("Then they all came\n and tied me to this tree.")
	dialogue:PushMessage("I guess I can't say\n I wasn't asking for it.")
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
end

onKeyPress = function(e,k)
end

onKeyRelease = function(e,k)
end

recieveMessage = function(e, message)
	if message == "Dialogue" then
		if e:GetDC() then
			dialogue:OpenDialogue()
			if conversation == 0 then
				e:Message("Music", "Resources/Music/Untitled.wav")
				e:Message("Music", "Play")
			end
			if conversation == 3 then
				e:Message("Music", "Stop")
			end

			conversation = conversation + 1
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
		color = "White"
	elseif signal == "Blue" then
		color = "Blue"
	end
end