color = "White"
alive = true
health = 5
conversation = 0

creator = "missing"

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Robo3.png")
	graphic:SetFrameSize(8,16)
	graphic:AddFrame("Stand", 0, 0)
	graphic:Play("Stand")
	graphic:Stop()
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(8, 16)
	e:AddComponent("CollisionComponent")
	e:GetCC():SetType("robo")

	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Quest.save")


	if file:GetVariable("Creator") ~= "" then
		creator = file:GetVariable("Creator")
	end

	--DIALOGUE stuff
	e:AddComponent("DialogComponent")
	dialogue = e:GetDC()
	dialogue:ShowGraphic(false)
	dialogue:SetVoice("uh.wav")

	if creator == "missing" then
		dialogue:PushMessage("The man who created us...")
		dialogue:PushMessage("I just want to talk to him.")
		dialogue:PushMessage("We are all products of evolution.\n Is my sole purpose to be a slave to my\n creator?")
		dialogue:PushMessage("I am made in your image...")
		dialogue:PushMessage("Where does your image end?")
		dialogue:PushMessage("I traveled through the DESERT\n and found where he lived...")
		dialogue:PushMessage("I felt his footprints in the sand.")
	elseif creator == "returned" then
		dialogue:PushMessage("Hmm?")
		dialogue:PushMessage("What's a soul?")
		dialogue:PushMessage("Huh..\n\n so what's the point of that?")
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
				e:Message("Music", "Stop")
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
		if conversation > 0 then
			conversation = 0
		end

		if e:GetDC() then
			dialogue:HideBox()
			if conversation ~= 0 then
				e:Message("Music", "Resources/Music/RoboJazz.wav")
				e:Message("Music", "Play")
				e:Message("Music", "Loop")
			end
		end
	end
	if signal == "White" then
		color = "White"
	elseif signal == "Blue" then
		color = "Blue"
	end
end