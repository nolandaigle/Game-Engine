bang = function(e)
	e:AddComponent("SoundComponent")
	e:AddComponent("DialogComponent")
	e:AddComponent("GraphicComponent")

	e:GetSC():Load("Resources/Sound/Dreamman.wav")
	e:GetDC():SetGraphic("Resources/Graphic/GodTalk.png")
	e:GetDC():SetVoice("giggle.wav")
	e:GetDC():ShowGraphic(false)
	e:GetDC():PushMessage("My closest friend,\n Linoleum...\n\nLinoleum supports\n my head.\n\nGives me \n something to\n believe.'")

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
			if convo == 2 then
				e:Message("Map", "Intro.json")
			end
				e:GetDC():OpenDialogue()
		end
	end
end