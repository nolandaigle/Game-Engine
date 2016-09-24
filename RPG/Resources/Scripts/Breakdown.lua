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
	e:GetScreen():Zoom(.25)

	e:Message("Music", "Stop")
end

update = function(e)
end

recieveSignal = function(e, signal)
	if signal == "Top" then
		e:Message("Map", "Scatter.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "1")
		file:WriteFile()
	end
	if signal == "Bottom" then
		e:Message("Map", "Graveyard.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "5")
		file:WriteFile()
	end
end