xvel = 0
yvel = 0
medTimer = 0

bang = function(e)
	e:AddComponent("TransformComponent")
	e:AddComponent("DialogComponent")
	e:GetDC():OpenDialogue()
	e:GetDC():HideBox()

	e:AddComponent("MapComponent")
	map = e:GetMap()

	e:AddComponent("ScreenComponent")
	e:GetScreen():Reset()
	e:GetScreen():Zoom(.4)

	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Game.save")
	enterSide = file:GetVariable("Player-exit")
	enterWarp = file:GetVariable("Warp")

	if enterWarp == "1" then
		e:Message("1", "Create" )
	elseif enterWarp == "2" then
		e:Message("2", "Create" )
	end
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
	if signal == "Right" then
		e:Message("Map", "Field.json")
		file:OpenFile("Game.save")
		file:SetVariable("Player-exit", "Right")
		file:WriteFile()
	end
	if signal == "Left" then
		e:Message("Map", "Sokoban1.json")
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
		e:Message("Map", "caveNetwork.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "1")
		file:WriteFile()
	end	
end