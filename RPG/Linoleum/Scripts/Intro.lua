bang = function(e)
	e:AddComponent("SoundComponent")
	e:AddComponent("DialogComponent")
	e:AddComponent("GraphicComponent")

	e:GetSC():Load("Resources/Sound/Dreamman.wav")
	e:GetDC():SetGraphic("Resources/Graphic/GodTalk.png")
	e:GetDC():SetVoice("giggle.wav")
	e:GetDC():ShowGraphic(false)
	e:GetDC():PushMessage("That's me\n on the beachside,\n combing the sand.\n\nMetal meter in my\n hand,\nsporting a pocket\n full of change.")
	e:GetDC():PushMessage("That's me in the\n street with\n the violin\nunder my chin.\n\nPlayin with a grin,\nsingin gibberish.")
    e:GetDC():PushMessage("That's me\n at the back of the\n bus.")
    e:GetDC():PushMessage("That's me\n in that cell.")
    e:GetDC():PushMessage("That's me\n inside your head.")
    e:GetDC():PushMessage("That's me\n inside your head.")
    e:GetDC():PushMessage("-NOFX")

	e:GetGC():SetImage("Sprite.png")
	e:GetGC():AddFrame("Body", 0, 0)
	e:GetGC():SetAnimation("Body")
	e:GetGC():Play("Body")
	e:GetGC():SetScale(3,3)
	showing = false

	convo = 0
end

update = function(e)
end

display = function(e)
end

onKeyPress = function(e,k)

end

onKeyPress = function(e,k)
	if k == "j" then
		if e:GetDC() then
			convo = convo + 1
			if convo == 8 then
				e:Message("Map", "Stage_1.json")
			end
				e:GetDC():OpenDialogue()
		end
	end
end