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
	end

	e:AddComponent("MapComponent")
	map = e:GetMap()

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
		e:GetEntity("Player"):GetTransform().x = map:GetWidth()
	elseif signal == "Right" then
		e:Message("Map", "HippieFlip.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "1")
		file:WriteFile()
	end
end
