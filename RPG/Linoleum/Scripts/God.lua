bang = function(e)
	e:AddComponent("SoundComponent")
	e:AddComponent("DialogComponent")
	e:AddComponent("TransformComponent")
	e:AddComponent("GraphicComponent")
	e:GetGC():SetImage("homelessman.png")
	e:SetLayer(2)
	e:GetGC():SetImage("homelessman.png")
	e:GetGC():AddFrame("Body", 0, 0)
	e:GetGC():SetAnimation("Body")
	e:GetGC():Play("Body")
	e:GetGC():SetFrameSize(199,173)
	showing = false
	e:GetGC():BypassCulling(true)

	e:GetSC():Load("Resources/Sound/Dreamman.wav")
	e:GetDC():SetGraphic("Resources/Graphic/GodTalk.png")
	e:GetDC():SetVoice("giggle.wav")
	e:GetDC():ShowGraphic(false)
	e:GetDC():PushMessage("...")
	e:GetDC():PushMessage("Oh")
	e:GetDC():PushMessage("Hi Austin.")
	e:GetDC():PushMessage("Wanna see a f*ked up \nbody?")
	e:GetDC():PushMessage("")
	e:GetDC():PushMessage("HA \n \n    HA \n...what?")

	e:GetTransform():CenterView()

	convo = 0
end

update = function(e)
end

display = function(e)
	if showing == true then
		if e:GetGC() then
    	    e:GetGC():Display(20, 40)
		end 
	end
end

onKeyPress = function(e,k)

end

onKeyPress = function(e,k)
	if k == "j" then
		if e:GetDC() then
			convo = convo + 1
			if convo == 2 then
				e:GetDC():ShowGraphic(true)
				e:GetSC():Play()
			elseif convo == 4 then
				e:GetSC():Stop()
			end
			if convo == 5 then
				showing = true
				e:PrintMessage("Hey")
			elseif convo == 6 then
				showing = false
				e:GetSC():Play()
			elseif convo == 7 then
				e:Message("Map", "Stage_2.json")
			end
				e:GetDC():OpenDialogue()
		end
	end
end