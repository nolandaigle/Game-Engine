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
end

update = function(e)
end

recieveSignal = function(e, signal)
	if signal == "Top" then
		e:Message("Map", "Fountain.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "1")
		file:WriteFile()
	end
	if signal == "Left" then
		e:Message("Map", "TreePath.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "1")
		file:WriteFile()
	end
	if signal == "Right" then
		e:Message("Map", "Disorder.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "3")
		file:WriteFile()
	end
end