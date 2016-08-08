speed = 5
dead = 0

bang = function(e)
	e:AddComponent("FileComponent")
	file = e:GetFC()

	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()

	graphic:SetImage("jesus.png")
	graphic:SetFrameSize(32, 32)


	graphic:AddFrame("Stand", 0, 0)
	graphic:Play("Stand")

	e:AddComponent("TransformComponent")
	transform = e:GetTransform()

	startX = transform.x
	startY = transform.y

	e:AddComponent("MapComponent")
	map = e:GetMap()
end

update = function(e)
	if map then
		if transform.x > map:GetWidth() then
			transform.x = 0
		end
		if transform.x < 0 then
			transform.x = map:GetWidth()
		end
	end

	if e:KeyPressed("left") == true then
		transform.x = transform.x - speed
	elseif e:KeyPressed("right") == true then
		transform.x = transform.x + speed
	end
end

display = function(e)
	if graphic then
		graphic:Display(transform.x, transform.y)
	end
end

onKeyPress = function(e,k)
	if k == "z" then
		e:CreateEntity( transform.x + 15, transform.y - 4, "Bullet", 0 )
	end 
end

onKeyRelease = function(e,k)
end

recieveSignal = function(e, signal)
	if signal == "Killed" then
		dead = dead + 1
		if dead >= 8 then
			file:OpenFile("Game.save")
			file:SetVariable("Warp", "3")
			file:WriteFile()
			e:Message("Map", "Arcade.json")
		end
	end
end