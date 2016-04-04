bang = function(e)
	--Add components
	e:AddComponent("GraphicComponent")
	e:AddComponent("TransformComponent")
	e:AddComponent("CollisionComponent")
	e:AddComponent("DialogComponent")
	--Set the graphic component image to woman1.png
	e:GetGC():SetImage("Woman1.png")
	--Create animations
	e:GetGC():AddFrame("WalkRight", 0, 0)
	e:GetGC():AddFrame("WalkRight", 1, 0)
	e:GetGC():AddFrame("WalkLeft", 0, 1)
	e:GetGC():AddFrame("WalkLeft", 1, 1)
	--Play animation upon scene start
	e:GetGC():SetAnimation("WalkRight")
	e:GetGC():SetFPS(5)
	walking = "right"
	e:GetGC():Stop()
	--Set collider type to "Woman1"
	e:GetCC():SetType("Woman1")
	--Set dialogue
	e:GetDC():SetGraphic("Resources/Graphic/Woman1Talk.png")
	e:GetDC():SetVoice("giggle.wav")
	e:GetDC():PushMessage("Oh...")
	e:GetDC():PushMessage("Hi Austin.")
	e:GetDC():PushMessage("...")
end

update = function(e)

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