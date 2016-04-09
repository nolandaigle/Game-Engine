xvel = 0
yvel = 0
medTimer = 0

bang = function(e)
	e:AddComponent("TransformComponent")

	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("ScreenComponent")

	medTimer = 0.0
	teleportTime = 5

	e:AddComponent("MapComponent")
	map = e:GetMap()

	--Player entry
	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("playerexit.save")
	enterSide = file:GetLine()
	y = file:GetLine()
	file:CloseFile()

	if enterSide == "rightup" or enterSide == "rightdown" then
		e:CreateEntity( 0, tonumber(y), "Player", "" )
		player = e:GetEntity("Player")
		player:GetGC():Play("WalkRight")
		if enterSide == "rightup" then
			e:GetScreen():Zoom(2)
		end
		if enterSide == "rightdown" then
			e:GetScreen():Zoom(.5)
		end
	end
end

update = function(e)

	if e:KeyPressed("up") == true or e:KeyPressed("down") == true or e:KeyPressed("left") == true or e:KeyPressed("right") == true then
		medTimer = 0.0
	end

	--Player Exit
	if player:GetTransform().x < 0 then
		if player:GetTransform().y < 200 then
			file = io.open("playerexit.save", "w")
			file:write("rightup\n")
			file:write(player:GetTransform().y)
			file:close()
			e:Message("Map", "LeftInfinity.json")
		elseif player:GetTransform().y > 200 then
			file = io.open("playerexit.save", "w")
			file:write("rightdown\n")
			file:write(player:GetTransform().y)
			file:close()
			e:Message("Map", "LeftInfinity.json")
		end
	end

	--Meditation Timer
	medTimer = medTimer + e:GetDeltaTime()

	if medTimer > teleportTime then
		e:GetScreen():SetPixelate( true, .5, .0001)
		if medTimer > teleportTime + 10 then 
			e:Message("Map", "Clones.json")
			medTimer = 0
		end
	end
end

display = function(e)
end

onKeyPress = function(e,k)
	
	medTimer = 0
	e:GetScreen():SetPixelate( false, 0, .01)
end

onKeyRelease = function(e,k)
	medTimer = 0
	e:GetScreen():SetPixelate( false, 0, .01)
end