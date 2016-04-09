xvel = 0
yvel = 0
medTimer = 0

bang = function(e)
	e:AddComponent("TransformComponent")

	e:AddComponent("MapComponent")
	map = e:GetMap()

	e:AddComponent("ScreenComponent")
	e:GetScreen():Reset()
	e:GetScreen():Zoom(.35)

	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("playerexit.save")
	enterSide = file:GetLine()
	file:CloseFile()

	if enterSide == "Bottom" then
		e:CreateEntity( 206, 0, "Player", "" )
		player = e:GetEntity("Player")
		e:CreateEntity( 40, 480, "ReversePlayer", "" )
		revplayer = e:GetEntity("ReversePlayer")
	end
	if enterSide == "Top" then
		e:CreateEntity( 40, 480, "Player", "" )
		player = e:GetEntity("Player")
		e:CreateEntity( 430, 480-32, "Player", "" )
		e:CreateEntity( 206, 0, "ReversePlayer", "" )
		revplayer = e:GetEntity("ReversePlayer")
	end
end

update = function(e)
	if e:KeyPressed("up") == true or e:KeyPressed("down") == true or e:KeyPressed("left") == true or e:KeyPressed("right") == true then
		medTimer = 0.0
	end
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
		file = io.open("playerexit.save", "w")
		file:write(signal)
		file:close()
	end
	if signal == "Left" then
		e:Message("Map", "LeftInfinity.json")
		file = io.open("playerexit.save", "w")
		file:write("Field")
		file:close()
	end
	if signal == "Bottom" then
		e:Message("Map", "Mirror.json")
		file = io.open("playerexit.save", "w")
		file:write(signal)
		file:close()
	end
	if signal == "Top" then
		e:Message("Map", "Field.json")
		file = io.open("playerexit.save", "w")
		file:write(signal)
		file:close()
	end	
end