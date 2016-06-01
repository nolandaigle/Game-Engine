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

	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Game.save")
	enterSide = file:GetVariable("Player-exit")

	if enterSide == "Right" then
		e:CreateEntity( 0, 200, "Player", "" )
		player = e:GetEntity("Player")
		player:GetGC():Play("WalkRight")
	end
	if enterSide == "Left" then
		e:CreateEntity( -16, 200, "Player", "" )
		player = e:GetEntity("Player")
		player:GetGC():Play("WalkLeft")
	end
	if enterSide == "Bottom" then
		e:CreateEntity( 200, 0, "Player", "" )
		player = e:GetEntity("Player")
		player:GetGC():Play("WalkLeft")
	end
	if enterSide == "Top" then
		e:CreateEntity( 200, -32, "Player", "" )
		player = e:GetEntity("Player")
		player:GetGC():Play("WalkRight")
	end
end

update = function(e)

	if e:KeyPressed("up") == true or e:KeyPressed("down") == true or e:KeyPressed("left") == true or e:KeyPressed("right") == true then
		medTimer = 0.0
	end
	
	if player:GetTransform().x < 0 then
		file:OpenFile("Game.save")
		file:SetVariable("Player-exit", "Field")
		file:SetVariable("Player-x", e:GetEntity("Player"):GetTransform().x)
		file:SetVariable("Player-y", 150)
		file:WriteFile()
		e:Message("Map", "LeftInfinity.json")
	elseif player:GetTransform().x > map:GetWidth() then
		player:GetTransform().x = 0
	end

	if player:GetTransform().y < -32 then
		player:GetTransform().y = map:GetHeight()
	elseif player:GetTransform().y > map:GetHeight() then
		player:GetTransform().y = -32
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