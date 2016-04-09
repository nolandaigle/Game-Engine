xvel = 0
yvel = 0
medTimer = 0

bang = function(e)
	e:AddComponent("TransformComponent")
	e:GetTransform():CenterView()

	e:AddComponent("MapComponent")
	map = e:GetMap()

	e:AddComponent("ScreenComponent")
	e:GetScreen():Reset()
	e:GetScreen():Zoom(.25)

	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("playerexit.save")
	enterSide = file:GetLine()
	file:CloseFile()

	if enterSide == "Bottom" then
		e:CreateEntity( 206, 0, "Player", "" )
		player = e:GetEntity("Player")
		e:CreateEntity( 40, 320, "ReversePlayer", "" )
		revplayer = e:GetEntity("ReversePlayer")
	end
	if enterSide == "Top" then
		e:CreateEntity( 40, 472, "Player", "" )
		player = e:GetEntity("Player")
		e:CreateEntity( 206, 0, "ReversePlayer", "" )
		revplayer = e:GetEntity("ReversePlayer")
	end
end

update = function(e)

	if e:KeyPressed("up") == true or e:KeyPressed("down") == true or e:KeyPressed("left") == true or e:KeyPressed("right") == true then
		medTimer = 0.0
	end

	if player:GetTransform().y < -16 then
		if player:GetTransform().x > 112 then
			player:GetTransform().y = map:GetHeight()
		else
			file = io.open("playerexit.save", "w")
			file:write("Top\n")
			file:close()
			e:Message("Map", "ThreesCompany.json")
		end
	elseif player:GetTransform().y > map:GetHeight() then
		if player:GetTransform().x > 112 then
			file = io.open("playerexit.save", "w")
			file:write("Top\n")
			file:close()
			e:Message("Map", "Field.json")
		else
			player:GetTransform().y = -16
		end
	end

	if revplayer:GetTransform().y < -16 then
		revplayer:GetTransform().y = map:GetHeight()
	elseif revplayer:GetTransform().y > map:GetHeight() then
		revplayer:GetTransform().y = -16
	end
end

display = function(e)
end

onKeyPress = function(e,k)
end

onKeyRelease = function(e,k)
end

recieveSignal = function(e, signal)
end