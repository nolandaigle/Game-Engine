timer =  0
conversation = 0

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("SoundComponent")
	sound = e:GetSC()
	sound:Load("Resources/Music/Note To Self.wav", "NTS")

	e:AddComponent("ScreenComponent")
	e:GetScreen():Reset()
	e:GetScreen():Zoom(.5)

	--DIALOGUE stuff
	e:AddComponent("DialogComponent")
	dialogue = e:GetDC()
	dialogue:ShowGraphic(false)
	dialogue:SetVoice("pop.wav")
	dialogue:PushMessage("And wherever we go,\n and whatever we do,\n and whatever we see,\n and whoever we be...")
	dialogue:PushMessage("It don't matter.\n\nI don't mind cause you don't matter.\n I don't mind cause I don't matter.\n and don't shit matter.\n\nYou'll see in the end.")
	dialogue:PushMessage("I've got a feeling that there's something more.\n Something that holds us together.")
	dialogue:PushMessage("The strangest feeling but I can't be sure.\n Something that's old as forever.")
	dialogue:PushMessage("\n\n\n\n\n\n\n\n\n\n\n-J Cole")

	e:AddComponent("FileComponent")
	file = e:GetFC()

end

update = function(e)
end

display = function(e)
end

onKeyPress = function(e,k)
	conversation = conversation + 1
	dialogue:OpenDialogue()

	if conversation == 3 then
		sound:Play("NTS")
	end
	if conversation == 5 then
		sound:Stop("NTS")
	end
	if conversation == 6 then
		e:Message("Map", "Box.json")
	end
	if k == "q" then
		e:Message("Map", "Ray2.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "1")
		file:WriteFile()
	end
end