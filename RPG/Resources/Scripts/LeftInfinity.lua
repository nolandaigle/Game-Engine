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

	if enterSide == "Ray" then
		e:CreateEntity( 960, 150, "Player", "" )
		player = e:GetEntity("Player")
		player:GetGC():Play("WalkRight")
		e:GetScreen():Reset()
		e:GetScreen():Zoom(.5)
	elseif enterSide == "Left-up" or enterSide == "Left-down" then
		e:CreateEntity( 960, y, "Player", "" )
		player = e:GetEntity("Player")
		player:GetGC():Play("WalkLeft")
		if enterSide == "Left-up" then
			e:GetScreen():Zoom(.5)
		end
		if enterSide == "Left-down" then
			e:GetScreen():Zoom(1.75)
		end
	end
end

update = function(e)

	--Player Exit
	if player:GetTransform().x > map:GetWidth() then
		if player:GetTransform().y < 200 then

			if e:GetScreen():GetWidth() >= 900 then
				e:Message("Map", "Ray.json")
				file:OpenFile("Game.save")
				file:SetVariable("Warp", "1")
				file:WriteFile()
			else
				file:OpenFile("Game.save")
				file:SetVariable("Player-exit", "Right-up")
				file:SetVariable("Player-x", e:GetEntity("Player"):GetTransform().x)
				file:SetVariable("Player-y", e:GetEntity("Player"):GetTransform().y)
				file:WriteFile()
				e:Message("Map", "RightInfinity.json")
			end
		elseif player:GetTransform().y > 200 then
			file:OpenFile("Game.save")
				file:SetVariable("Player-exit", "Right-down")
				file:SetVariable("Player-x", e:GetEntity("Player"):GetTransform().x)
				file:SetVariable("Player-y", e:GetEntity("Player"):GetTransform().y)
				file:WriteFile()
			e:Message("Map", "RightInfinity.json")
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