bang = function(e)
	e:AddComponent("MapComponent")
	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Game.save")
	enterWarp = file:GetVariable("Warp")

	if enterWarp == "1" then
		e:Message("1", "Create" )
	end

	e:AddComponent("ScreenComponent")
	e:GetScreen():Reset()
	e:GetScreen():Zoom(.3)
end

update = function(e)
end

display = function(e)
end

onKeyPress = function(e,k)
end

onKeyRelease = function(e,k)
end

recieveSignal = function(e, signal)
	if signal == "Left" then
		e:Message("Map", "LeftInfinity.json")
		file:OpenFile("Game.save")
		file:SetVariable("Player-exit", "Ray")
		file:SetVariable("Player-y", 150)
		file:WriteFile()
	elseif signal == "Right" then
		e:GetEntity("Player"):GetTransform().x = 0
	end
end
