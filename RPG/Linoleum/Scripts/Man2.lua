bang = function(e)
	e:AddComponent("GraphicComponent")
	e:AddComponent("TransformComponent")
	e:AddComponent("CollisionComponent")
	e:AddComponent("DialogComponent")
	e:GetGC():SetImage("Man1.png")
	e:GetGC():AddFrame("WalkRight", 0, 0)
	e:GetGC():AddFrame("WalkRight", 1, 0)
	e:GetGC():AddFrame("WalkLeft", 0, 1)
	e:GetGC():AddFrame("WalkLeft", 1, 1)
	e:GetGC():Play("WalkRight")
	e:GetGC():SetAnimation("WalkRight")
	e:GetGC():SetFPS(5)
	e:SetLayer(1)
	walking = "right"
	e:GetGC():Stop()
	e:GetCC():SetType("Man2")
e:GetDC():SetGraphic("Resources/Graphic/Man1Talk.png")
e:GetDC():SetVoice("uh.wav")
e:GetDC():PushMessage("Hey there!")
e:GetDC():PushMessage("Kinda fucky here\n\nAin't it?")
e:GetDC():PushMessage("I don't know man \n I'm still trying to\nfigure it out\n\nTOO")
e:GetDC():PushMessage("When you're in a\n dream, \nIf you spin, \n you won't even \nWAKE UP")
e:GetDC():PushMessage("Yeah!")
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
end