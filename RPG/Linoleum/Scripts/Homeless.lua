bang = function(e)
	e:AddComponent("GraphicComponent")
	e:AddComponent("TransformComponent")
	e:GetGC():SetImage("homelessman.png")
	e:SetLayer(2)
	e:GetGC():SetImage("homelessman.png")
	e:GetGC():AddFrame("Body", 0, 0)
	e:GetGC():SetAnimation("Body")
	e:GetGC():Play("Body")
	e:GetGC():SetFrameSize(199,173)
	showing = false
	e:GetGC():BypassCulling(true)
end

update = function(e)
end

display = function(e)
	transform = e:GetTransform()

	gComp = e:GetGC()

	if showing == true then
		if gComp then
    	    gComp:Display(e:GetTransform().x, e:GetTransform().y)
		end 
	end
end

recieveMessage = function(e, message)
	if message == "Show" then
		showing = true
	end
	if message == "StopShow" then
		showing = false
	end
end