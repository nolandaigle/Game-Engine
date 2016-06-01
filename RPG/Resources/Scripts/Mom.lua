color = "White"
alive = true
health = 5
conversation = 0
music = false

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Mom.png")
	graphic:SetFrameSize(8,16)
	graphic:AddFrame("Standing", 0, 0)
	graphic:Play("Standing")
	graphic:Stop()
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(8, 16)
	e:AddComponent("CollisionComponent")
	e:GetCC():SetType("mom")

	e:AddComponent("FileComponent")
	file = e:GetFC()

	--DIALOGUE stuff
	e:AddComponent("DialogComponent")
	dialogue = e:GetDC()
	dialogue:ShowGraphic(false)
	dialogue:PushMessage("Oh...")
	dialogue:PushMessage("...You've grown so much.\n\n I wish your father\n could see you.")
	dialogue:PushMessage("I've stuck myself here\n in this moment in\n T. I. M. E. so\n that I could be with you...")
	dialogue:PushMessage("Forever.")
	dialogue:PushMessage("Why move on?\n\nYour father is lost forever.\n You will one day be lost\n\n forever...")
	dialogue:PushMessage("Oh no,\n I am going to cry.")
	dialogue:PushMessage("Why move on?")
end

update = function(e)
	if health < 1 then
		alive = false
	end
end

display = function(e)
	if graphic then
		if color == "Blue" and alive == false then
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
			conversation = conversation + 1

			if conversation == 1 then
				file:OpenFile("Quest.save")

				if file:GetVariable("Mom") == "reconciled" then
					dialogue:Clear()
					dialogue:PushMessage("Oh lord...\n\n I just don't know.")
					alive = false
					health = 0
					file:OpenFile("Quest.save")
					file:SetVariable("Mom", "done")
					file:WriteFile()
				elseif file:GetVariable("Mom") == "done" then
					dialogue:Clear()
					dialogue:PushMessage("We both love you\n very much.")
				end
			end

			if conversation == 3 and music == false then
				e:Message("Music", "Resources/Music/Love.wav")
				e:Message("Music", "Play")
				e:Message("Music", "Loop")
				music = true
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
		color = "White"
	elseif signal == "Blue" then
		dialogue:Clear()
		color = "Blue"
	end
end