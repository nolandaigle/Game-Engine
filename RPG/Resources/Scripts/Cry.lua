zoom  = 1.0
timer =  0

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

	timer =  0
end

update = function(e)

	timer = timer + e:GetDeltaTime()
	if timer > 10 then
		if zoom < 2 then
			e:GetScreen():Zoom(1.001)
			zoom = zoom * 1.001
		end
	end
end

recieveSignal = function(e, signal)
	if signal == "Left" then
		e:Message("Map", "caveNetwork.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "2")
		file:WriteFile()
	end
	if signal == "Right" then
		e:Message("Map", "Graveyard.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "1")
		file:WriteFile()
	end
end