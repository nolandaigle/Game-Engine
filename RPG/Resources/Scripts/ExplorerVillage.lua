bang = function(e)
	e:AddComponent("MapComponent")
	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Game.save")
	enterWarp = file:GetVariable("Warp")

	if enterWarp == "1" then
		e:Message("1", "Create" )
	elseif enterWarp == "2" then
		e:Message("2", "Create" )
	elseif enterWarp == "3" then
		e:Message("3", "Create" )
	end

	e:AddComponent("ScreenComponent")
	e:GetScreen():Reset()
	e:GetScreen():Zoom(.35)

	e:Message("Music", "Resources/Music/Welcome To My Head.wav")
	e:Message("Music", "Loop")
	e:Message("Music", "Play")


end

update = function(e)
end

recieveSignal = function(e, signal)
	if signal == "Bottom" then
		e:Message("Map", "Disorder.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "2")
		file:WriteFile()
		e:Message("Music", "Stop")

	end
end