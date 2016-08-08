xvel = 0
yvel = 0
solved = false
shroom = 0

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
	file:OpenFile("Game.save")
	enterWarp = file:GetVariable("Warp")

	if enterWarp == "1" then
		e:Message("1", "Create" )
	elseif enterWarp == "2" then
		e:Message("2", "Create" )
	elseif enterWarp == "3" then
		e:Message("3", "Create" )
	end
end

update = function(e)
	
	player = e:GetEntity("Player")

	if player:GetTransform().x < 0 then
		player:GetTransform().x = map:GetWidth() - 16
	elseif player:GetTransform().x > map:GetWidth() then
		if solved == true then
			e:Message("Map", "ForkDog.json")
			file:OpenFile("Game.save")
			file:SetVariable("Warp", "1")
			file:WriteFile()
		else
			player:GetTransform().x = 0
		end
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
	if signal == "Kill" then
		shroom = shroom - 1
	end
	if signal == "Mushroom" then
		shroom = shroom + 1
		if shroom == 4 then
			solved = true
		end
	end
end