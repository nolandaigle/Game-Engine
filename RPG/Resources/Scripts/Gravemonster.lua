color = "White"
alive = false
health = 0
timer = 0

x = 0.0
y = 0.0
startx = 0
starty = 0
targetx = 0
targety = 0

boned = false

conversation = 0
eaten = false

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("GraveMonster.png")
	graphic:SetFrameSize(48,48)
	graphic:AddFrame("Standing", 0, 0)
	graphic:AddFrame("Standing", 1, 0)
	graphic:AddFrame("Standing", 2, 0)
	graphic:AddFrame("Standing", 3, 0)
	graphic:AddFrame("Standing", 0, 1)
	graphic:AddFrame("Standing", 1, 1)
	graphic:AddFrame("Standing", 2, 1)
	graphic:AddFrame("Standing", 3, 1)
	graphic:AddFrame("Standing", 0, 2)
	graphic:AddFrame("Standing", 1, 2)
	graphic:AddFrame("Standing", 2, 2)
	graphic:AddFrame("Standing", 3, 2)
	graphic:AddFrame("Standing", 0, 3)
	graphic:AddFrame("Standing", 1, 3)
	graphic:AddFrame("Eating", 2, 3)
	graphic:AddFrame("Eating", 3, 3)
	graphic:AddFrame("Eating", 0, 4)
	graphic:AddFrame("Eating", 1, 4)
	graphic:AddFrame("Eating", 2, 4)
	graphic:AddFrame("Eating", 3, 4)
	graphic:AddFrame("Eating", 0, 5)
	graphic:AddFrame("Eating", 1, 5)

	graphic:Play("Standing")
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(48, 48)
	e:AddComponent("CollisionComponent")
	e:GetCC():SetType("gravemonster")
	e:AddComponent("FileComponent")
	file = e:GetFC()

	--DIALOGUE stuff
	e:AddComponent("DialogComponent")
	dialogue = e:GetDC()
	dialogue:ShowGraphic(false)
	dialogue:SetVoice("uh.wav")
	dialogue:PushMessage("I\n\n  EAT\n\n    SOULS!!!!!!!!!!!!!")

	startx = transform.x
	starty = transform.y
	x = transform.x
	y = transform.y
	targetx = startx + 16
	targety = starty + 16
end

update = function(e)
	if eaten == true then
		timer = timer + e:GetDeltaTime()
	else
		timer = 0
	end

	if timer > 1 then
		e:Message("Music", "Stop")
		e:Message("Music", "Resources/Music/In The Belly of a Shark.wav")
		e:Message("Music", "Play")
		e:Message("Map", "Stomach.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "3")
		file:WriteFile()
		file:OpenFile("Quest.save")
		file:SetVariable("SharkBelly", "eaten")
		file:WriteFile()
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
		if e:GetDC() and conversation < 1 then
			conversation = conversation + 1
			dialogue:OpenDialogue()
			e:Signal("Eat Player")
		else
			e:Signal("BreakConv")
		end
	end
	if message == "bullet" then
		health = health - 1
	end
end

recieveSignal = function(e, signal)
	charMove = signal
	if signal == "BreakConv" then
		if e:GetDC() and conversation == 1 then
			conversation = 0
			dialogue:HideBox()
			graphic:Play("Eating")
			timer = 0.0
			eaten = true
		end
	end
	if signal == "White" then
		color = "White"
	elseif signal == "Blue" then
		color = "Blue"
	end
end