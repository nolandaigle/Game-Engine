bang = function(e)
	e:AddComponent("GraphicComponent")
	e:AddComponent("TransformComponent")
	e:AddComponent("CollisionComponent")
	e:AddComponent("DialogComponent")
	e:GetGC():SetImage("Jesus.png")
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
	e:GetCC():SetType("Jesus")
	e:GetDC():SetGraphic("Resources/Graphic/Woman1Talk.png")
	e:GetDC():SetVoice("yell.wav")
	e:GetDC():PushMessage("My son!")
	e:GetDC():PushMessage("Why did you kill me?")
	e:GetDC():PushMessage("...?")
	e2 = e:GetEntity("Character")
end

update = function(e)
	collider = e:GetCC()

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