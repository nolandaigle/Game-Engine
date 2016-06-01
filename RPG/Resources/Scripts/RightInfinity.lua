bang = function(e)
	e:AddComponent("TransformComponent")

	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("ScreenComponent")

	e:AddComponent("MapComponent")
	map = e:GetMap()

	--Player entry
	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Game.save")
	enterSide = file:GetVariable("Player-exit")
	y = tonumber(file:GetVariable("Player-y"))

	if enterSide == "Right-up" or enterSide == "Right-down" then
		e:CreateEntity( 0, y, "Player", "" )
		player = e:GetEntity("Player")
		player:GetGC():Play("WalkRight")
		if enterSide == "Right-up" then
			e:GetScreen():Zoom(1.25)
		end
		if enterSide == "Right-down" then
			e:GetScreen():Zoom(.75)
		end
	end
end

update = function(e)

	--Player Exit
	if player:GetTransform().x < 0 then
		file:OpenFile("Game.save")
		if player:GetTransform().y < 200 then
			file:SetVariable("Player-exit", "Left-up")
		elseif player:GetTransform().y > 200 then
			file:SetVariable("Player-exit", "Left-down")
		end
		file:SetVariable("Player-x", e:GetEntity("Player"):GetTransform().x)
		file:SetVariable("Player-y", e:GetEntity("Player"):GetTransform().y)
		file:WriteFile()
		e:Message("Map", "LeftInfinity.json")
	end
end

display = function(e)
end

onKeyPress = function(e,k)
end

onKeyRelease = function(e,k)
end