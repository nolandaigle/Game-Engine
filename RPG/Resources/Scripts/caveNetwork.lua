color = "White"

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
	elseif enterWarp == "4" then
		e:Message("4", "Create" )
	end

	e:AddComponent("ScreenComponent")
	e:GetScreen():Reset()
	e:GetScreen():Zoom(.25)
end

update = function(e)
end

recieveSignal = function(e, signal)
	if signal == "Right" then
		e:Message("Map", "Cry.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "1")
		file:WriteFile()
	end
	if signal == "Left" then
		e:Message("Map", "Ray2.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "1")
		file:WriteFile()
	end
	if signal == "Bottom" then
		e:Message("Map", "Mirror.json")
		file:OpenFile("Game.save")
		file:SetVariable("Player-exit", "Bottom")
		file:WriteFile()
	end
	if signal == "Top" then
		e:Message("Map", "Mirror.json")
		file:OpenFile("Game.save")
		file:SetVariable("Player-exit", "Top")
		file:SetVariable("Player-x", e:GetEntity("Player"):GetTransform().x)
		file:SetVariable("Player-y", e:GetEntity("Player"):GetTransform().y)
		file:WriteFile()
	end
	if signal == "Blue" and color ~= "Blue" then
		color = signal
	end
	if signal == "White" then
		color = signal
	end
end