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
	e:GetCC():SetType("dad")

	e:AddComponent("FileComponent")
	file = e:GetFC()

	--DIALOGUE stuff
	e:AddComponent("DialogComponent")
	dialogue = e:GetDC()
	dialogue:ShowGraphic(false)

	file:OpenFile("Quest.save")

	dialogue:PushMessage("It's you...")
	dialogue:PushMessage("I succeeded!\n\n I...")
	dialogue:PushMessage("Ah. I feel\n strange.")
	dialogue:PushMessage("I see you've found my games.")
	dialogue:PushMessage("I'm spread so \n\n   t hin")
	dialogue:PushMessage("You've grown into\n something beautiful.")
	dialogue:PushMessage("Ahhhh... hh.")
	dialogue:PushMessage("I don't know what to say.\n\n Would you like to see\n what I've been working on?")
	dialogue:PushMessage("I spent so many years building s o\n much.")
	dialogue:PushMessage("These robots...\n  my games,\n\n \n\n\n t he t o y s...")
	dialogue:PushMessage("My child...")
	dialogue:PushMessage("That's what you are,\n right ?")
	dialogue:PushMessage("Sometimes I think\n I am sterile.")
	dialogue:PushMessage("I 've been trying\n to build a machine\n that can \n    travel\nthrough\n      time.")
	dialogue:PushMessage("But I accidentally created something...\n\nsomething greater.")
	dialogue:PushMessage("I wanted to\n control time,\n reverse it,\n change the past,\n know the future,\n\n but...")
	dialogue:PushMessage("What I ignored...")
	dialogue:PushMessage("I didn't realize\n it until I\n played these games,\n spoke with the robots...\n\n What do I have\n that they do not?")
	dialogue:PushMessage("I succeeded!\n\n I...")
	dialogue:PushMessage("I created something\n magnificent.")
	dialogue:PushMessage("And I can see that\n one day I will create\n you.")
	dialogue:PushMessage("Ahh...\n\n Follow me\n to the machine\n in my basement.")
	dialogue:PushMessage("I gave it the name,\n\n F A T B O Y")

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
			conversation = conversation + 1
			dialogue:OpenDialogue()
			if conversation == 2 then
				e:Message("Music", "Loop")
				e:Message("Music", "Resources/Music/Mushroom.wav")
				e:Message("Music", "Play")
			elseif conversation == 11 then
				e:Message("Music", "Stop")
			elseif conversation == 15 then
				e:Message("Music", "Resources/Music/Angels 18.wav")
				e:Message("Music", "Play")
			elseif conversation == 24 then
				e:Message("Music", "Stop")
				e:Message("Map", "GODHEAD.json")
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