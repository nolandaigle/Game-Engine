color = "White"
alive = true
health = 5
conversation = 0

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Dad.png")
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

	file:OpenFile("Quest.save")

	if file:GetVariable("Mom") == "reconciled" or file:GetVariable("Mom") == "done" then
		dialogue:PushMessage("We both love you very much.")
	else
		dialogue:PushMessage("Hello my child...\n I have been watching you\n for a long time.")
		dialogue:PushMessage("I wish your mother\n could bear to see you\n grow.")
		dialogue:PushMessage("Tell her...\n I am always with\n both of you.")
		dialogue:PushMessage("Forever.")
		dialogue:PushMessage("I know everything you do...\n\n It's strange.")
		dialogue:PushMessage("I am learning now,\n how to be a God.\n\n It's easy.")
		dialogue:PushMessage("I love you both\n with everything I have.")
	end
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
		--	graphic:SetColor(255,255,255)
		--	graphic:Display(transform.x, transform.y)
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
			conversation = conversation + 1
			dialogue:OpenDialogue()
			if conversation == 8 then
				file:OpenFile("Quest.save")
				file:SetVariable("Mom", "reconciled")
				file:SetVariable("Creator", "returned")
				file:WriteFile()
				dialogue:Clear()
				dialogue:PushMessage("We both love you\n very much.")
				conversation = 0
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
		conversation = 0
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