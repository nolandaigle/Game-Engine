color = "White"
alive = false
health = 0
timer = 0

x = 0.0
y = 0.0

tripped = false

conversation = 0

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Priest.png")
	graphic:SetFrameSize(16,16)
	graphic:AddFrame("Stand", 0, 0)
	graphic:Play("Stand")
	graphic:Stop()
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(16, 16)
	e:AddComponent("CollisionComponent")
	e:GetCC():SetType("priest")

	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Quest.save")
	
	if file:GetVariable("Priest") == "tripped" then
		tripped = true
	else
		tripped = false
	end

	--DIALOGUE stuff
	e:AddComponent("DialogComponent")
	dialogue = e:GetDC()
	dialogue:ShowGraphic(false)
	dialogue:SetVoice("woo.wav")
	if tripped == false then
		dialogue:PushMessage("Let nothing trouble you,\n let nothing frighten you.\nAll things are passing;\n God never changes.\nPatience obtains all\n things.")
		dialogue:PushMessage("He who possesses God\n lacks  nothing:\nGod alone suffices.")
	elseif tripped == true then
		dialogue:PushMessage("Pretty trippy, huh.")
	end

	startx = transform.x
	starty = transform.y
	targetx = startx + 16
	targety = starty + 16
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

			if conversation == 2 and tripped == true then
				conversation = 0
			end

			if conversation == 3 then
				conversation = 0

				file:OpenFile("Quest.save")
				file:SetVariable("Priest", "tripped")
				file:WriteFile()

				e:Message("Map", "JesusLand.json")
				file:OpenFile("Game.save")
				file:SetVariable("Warp", "1")
				file:WriteFile()
				e:Message("Music", "Stop")
				e:Message("Music", "Resources/Music/Church.wav")
				e:Message("Music", "Play")

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
		color = "Blue"
	end
end