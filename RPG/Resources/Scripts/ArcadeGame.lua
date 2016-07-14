timer = 0

bang = function(e)
	e:AddComponent("MapComponent")

	e:AddComponent("ScreenComponent")
	e:GetScreen():Reset()
	e:GetScreen():Zoom(.35)

	e:AddComponent("FileComponent")
	file = e:GetFC()

	e:Message("Music", "Resources/Music/Mystic Cowboy.wav")
	e:Message("Music", "Play")
	e:Message("Music", "Unloop")
end

update = function(e)
	timer = timer + e:GetDeltaTime()
	if timer > 120 then
		e:Message("Map", "Arcade.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "2")
		file:WriteFile()
	end
end

onKeyPress = function(e,k)
end

recieveSignal = function(e, signal)
end