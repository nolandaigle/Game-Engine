conversation = 0
color = "White"
alive = true
tdisplay = false

bang = function(e)
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Arcade.png")
	graphic:SetFrameSize(16,20)
	graphic:AddFrame("Stand", 0, 0)
	graphic:Play("Stand")
	graphic:Stop()
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(16, 20)
	e:AddComponent("CollisionComponent")
	e:GetCC():SetType("Arcade")

	--DIALOGUE stuff
	e:AddComponent("DialogComponent")
	dialogue = e:GetDC()
	dialogue:ShowGraphic(false)
	dialogue:PushMessage("Loading ArcadeGame.json...\nLoading Angels 15.wav...\nInitiating GODHEAD...\nInitializing Ram...\nsorry\nREADY")

    e:AddComponent("FileComponent")
    file = e:GetFC()
    file:OpenFile("Game.save")
    enterWarp = file:GetVariable("Warp")
end

update = function(e)
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

			if tdisplay == true then
			transform:Display(true)
			tdisplay = false
		end
		end
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
			conversation = conversation + 1
			dialogue:OpenDialogue()
			if conversation == 2 then
				e:Message("Map", "ArcadeGame.json")
				e:Message("Music", "Stop")
			end
		end
	end
end

recieveSignal = function(e, signal)
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