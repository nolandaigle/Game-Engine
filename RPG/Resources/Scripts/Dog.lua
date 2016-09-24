color = "White"
alive = true
health = 2
timer = 0
tdisplay = false

x = 0.0
y = 0.0
startx = 0
starty = 0
targetx = 0
targety = 0

boned = false

conversation = 0

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Dog.png")
	graphic:SetFrameSize(8,8)
	graphic:AddFrame("WalkRight", 0, 0)
	graphic:AddFrame("WalkRight", 1, 0)
	graphic:AddFrame("WalkRight", 2, 0)
	graphic:AddFrame("WalkRight", 3, 0)
	graphic:AddFrame("WalkRight", 4, 0)
	graphic:AddFrame("WalkLeft", 0, 1)
	graphic:AddFrame("WalkLeft", 1, 1)
	graphic:AddFrame("WalkLeft", 2, 1)
	graphic:AddFrame("WalkLeft", 3, 1)
	graphic:AddFrame("WalkLeft", 4, 1)
	graphic:Play("WalkRight")
	graphic:Stop()
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(8, 8)
	e:AddComponent("CollisionComponent")
	e:GetCC():SetType("dog")
	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Quest.save")

	if file:GetVariable("Bone") == "done" then
		boned = true
	else
		boned = false
	end

	--DIALOGUE stuff
	e:AddComponent("DialogComponent")
	dialogue = e:GetDC()
	dialogue:ShowGraphic(false)
	dialogue:SetVoice("woo.wav")
	dialogue:PushMessage("The dog looks at you as if to say,\n\n    'You know what to do'")

	startx = transform.x
	starty = transform.y
	x = transform.x
	y = transform.y
	targetx = startx + 16
	targety = starty + 16
end

update = function(e)
	timer = timer + e:GetDeltaTime()
	if timer > 8 and e:GetCC():CollidingType("all") == "" then
		targetx = startx + math.random(- 32, 32)
		targety = startx + math.random(- 32, 32)
		if targetx > x then
			graphic:Play("WalkRight")
		elseif targetx < x then
			graphic:Play("WalkLeft")
		end
		timer = 0
	elseif e:GetCC():CollidingType("all") ~= "" then
		targetx = x
		targety = y
	end

	x = x + e:Lerp(x, targetx, 0.01)
	y = y + e:Lerp(y, targety, 0.01)

	transform.x = x
	transform.y = y

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

			if boned == false and color == "White" then

				conversation = conversation + 1

				if conversation == 1 then
					dialogue:Clear()
					dialogue:PushMessage("A dog,\n with a small bone\n in its mouth...\n\nYou take the bone.")
					dialogue:PushMessage("The dog, mouth now \nfree of the bone, \nbegins to speak,\n\n  'Hello...")
					dialogue:PushMessage("My name is spot.\nMy only friend in the world \nis a human... \nWhere is he now?\n Where is his scent?")
					dialogue:PushMessage("I've been a staunch \nagnostic my entire life. \nBut now... \nI want to explore the void.\nI want to see the\n universe where he lives. ")
					dialogue:PushMessage("I want to see the colors.\n I want to smell what I \ncannot smell.\nI want to exist where I do \nnot exist. \n ... ")
					dialogue:PushMessage("Where is my friend?'")
					file:OpenFile("Quest.save")
					file:SetVariable("Bone", "collected")
					file:WriteFile()
				end
				if conversation == 2 then
					e:Message("Music", "Resources/Music/GoodJob.wav")
					e:Message("Music", "Play")
					e:Message("Music", "Loop")
				end

				dialogue:OpenDialogue()

				if conversation > 6 then
					e:Message("Music", "Stop")
					dialogue:Clear()
					dialogue:PushMessage("The dog looks at you as if\n to say,\n\n    'You know what to do'")
					dialogue:HideBox()
					boned = true
					conversation = 0
				end
			else
				if color == "Blue" then
					conversation = conversation + 1
					if conversation == 1 then
						dialogue:Clear()
						dialogue:PushMessage("The dog doesn't\n seem to notice your\n presence.")
					end
					if conversation == 2 then
						conversation = 0
						dialogue:HideBox()
					end
				end

				dialogue:OpenDialogue()
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
		end
	end
	if signal == "White" then
		color = "White"
	elseif signal == "Blue" then
		color = "Blue"
	elseif signal == "Red" then
		color = "Red"
	end
end