color = "White"
alive = true
health = 5
conversation = 0
tdisplay = false

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Mushroom.png")
	graphic:SetFrameSize(16,16)
	graphic:AddFrame("Meditate", 0, 0)
	graphic:Play("Meditate")
	graphic:Stop()
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(16, 16)
	e:AddComponent("CollisionComponent")
	e:GetCC():SetType("guru")

	--DIALOGUE stuff
	e:AddComponent("DialogComponent")
	dialogue = e:GetDC()
	dialogue:ShowGraphic(false)

	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Quest.save")
	
	boned =  file:GetVariable("Bone")
	mom =  file:GetVariable("Mom")
	creator =  file:GetVariable("Creator")
	priest = file:GetVariable("Priest")
	killed = file:GetVariable("Killed")

	if priest == "tripped" then
		dialogue:PushMessage(" Have you been here\n    before?\nWhat a long, strange trip.")
	end

	if boned == "met" then
		dialogue:PushMessage(" You met a skeleton\nwith a missing bone who\nfelt all alone.")
	elseif boned == "collected" then
		dialogue:PushMessage(" You met a skeleton\nwith a missing bone who\nfelt all alone.")
		dialogue:PushMessage(" A dog who yearns to\nkiss the stone, licks the \nbone inside his home.")
	elseif boned == "done" then
		dialogue:PushMessage(" You met a skeleton\nwith a missing bone who\nfelt all alone.")
		dialogue:PushMessage(" A dog who yearns to\nkiss the stone, licks the \nbone inside his home.")
		dialogue:PushMessage(" You connected the souls,\nworlds apart.\n A single step\nis a giant start.")
	end

	if mom == "reconciled" or  mom == "done" then
		dialogue:PushMessage(" You met a woman who\nyou seemed to know that\nloved too much and\nrefused to grow.")
	end

	if creator == "returned" then
		dialogue:PushMessage(" You met a man\nwith infinite grip, the\ncaptain of a sinking ship.")
	end

	if killed == "true" then
		dialogue:PushMessage(" Your face is ugly,\nand your souls is too.")
	end

	dialogue:PushMessage(" The ship has sailed,\nand so have you...\n\n Yet here you are.\nWhat's left to do?")


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
	if message == "Dialogue" then
		if e:GetDC() then
			dialogue:OpenDialogue()
			conversation = conversation + 1

			if conversation == 1 then
				e:Message("Music", "Resources/Music/Fuck.wav")
				e:Message("Music", "Play")
				e:Message("Music", "Loop")
			end
		end
	end
	if message == "bullet" then
		health = health - 1
	end
	if message == "PlayerTouch" then
		tdisplay = true
	end
end

recieveSignal = function(e, signal)
	charMove = signal
	if signal == "BreakConv" then
		if e:GetDC() then
			dialogue:HideBox()
			e:Message("Music", "Stop")
		end
	end
	if signal == "White" then
		color = "White"
	elseif signal == "Blue" then
		color = "Blue"
	end
end