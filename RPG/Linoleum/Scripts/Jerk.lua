bang = function(e)
	e:AddComponent("GraphicComponent")
	e:AddComponent("SoundComponent")
	e:GetSC():Load("Resources/Sound/DreamReverse.wav")
	e:GetSC():Play()
	e:GetSC():SetLoop(true)
	e:AddComponent("TransformComponent")
	e:AddComponent("CollisionComponent")
	e:AddComponent("DialogComponent")
	e:AddComponent("ScreenComponent")
	e:GetGC():SetImage("Man1.png")
	e:GetGC():AddFrame("WalkRight", 0, 0)
	e:GetGC():AddFrame("WalkRight", 1, 0)
	e:GetGC():AddFrame("WalkLeft", 0, 1)
	e:GetGC():AddFrame("WalkLeft", 1, 1)
	e:GetGC():Play("WalkRight")
	e:GetGC():SetAnimation("WalkRight")
	e:GetGC():SetFPS(5)
	walking = "right"
	e:GetGC():Stop()
	e:SetLayer(1)
	e:GetCC():SetType("Jerk")
	e:GetDC():SetGraphic("Resources/Graphic/Man1Talk.png")
	e:GetDC():PushMessage("No he doesn't.")
	e:GetDC():PushMessage("Not anymore.")
	e2 = e:GetEntity("Character")

	timer = 0

	e:GetScreen():SetPixelate( true, .5, .1)

	enabled = true
end

update = function(e)
	timer = timer + e:GetDeltaTime()

	if timer > 1 then
		e:GetScreen():SetPixelate( true, 0, .00001)
	end

	if timer > 200 then
		e:Message("Map", "Outro.json")
	end
end

display = function(e)
	gComp = e:GetGC()

	transform = e:GetTransform()

	if gComp then
		if transform then
	        gComp:Display(transform.x, transform.y)
	    end
	end 
end


onKeyPress = function(e,k)
	timer = 0
	if k == "e" then
		timer = 15
	end
end

recieveMessage = function(e, message)
	if message == "Dialogue" then
		if e:GetDC() then
		e:GetDC():OpenDialogue()
		end
	end
end

recieveSignal = function(e, signal)
	if signal == "BreakConv" then
		if e:GetDC() then
			e:GetDC():HideBox()
		end
	end
end