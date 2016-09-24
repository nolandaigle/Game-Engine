color = "White"
alive = true
health = 3

direction = "right"
going = "down"
targety = 0
speed = .5

bang = function(e)

	e:AddComponent("FileComponent")
	file = e:GetFC()

	e:AddComponent("SoundComponent")
	sound = e:GetSC()
	sound:Load("Resources/Sound/pop.wav", "Pop")

	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Ghost.png")
	graphic:SetFrameSize(8,16)
	graphic:AddFrame("WalkRight", 0, 1)
	graphic:AddFrame("WalkRight", 1, 1)
	graphic:AddFrame("WalkLeft", 0, 0)
	graphic:AddFrame("WalkLeft", 1, 0)
	graphic:AddFrame("Stand", 0, 2)
	graphic:AddFrame("Stand", 1, 2)
	graphic:Play("WalkRight")
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(8, 16)
	e:AddComponent("CollisionComponent")
	e:GetCC():SetType("alien")

	e:AddComponent("MapComponent")
	map = e:GetMap()

end

update = function(e)
	speed = speed + .001

	if transform.y > map:GetHeight() - 200 then
		going = "up"
		graphic:SetImage("Mushroom.png")
		graphic:Play("WalkRight")
	elseif transform.y < 0 then
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "3")
		file:WriteFile()
		e:Message("Map", "Arcade.json")
	end

	if going == "down" then
		if transform.y < targety then
			transform.y = transform.y + 1
		end
	elseif going == "up" then
		if transform.y > targety then
			transform.y = transform.y - 1
		end
	end

	if direction == "right" then
		transform.x = transform.x + speed
		if transform.x > map:GetWidth() then
			if going == "down" then
				targety = targety + 64
			else
				targety = targety - 64
			end
			direction = "left"
			graphic:Play("WalkLeft")
		end
	elseif direction == "left" then
		transform.x = transform.x - speed
		if transform.x < 0 then
			if going == "down" then
				targety = targety + 64
			else
				targety = targety - 64
			end
			direction = "right"
			graphic:Play("WalkRight")
		end
	end

	if health < 1 and alive == true then
		alive = false
		e:GetCC():SetType("")
		e:Signal("Killed")
	end
end

display = function(e)
	if graphic then
		if color == "White" and alive == true then
			graphic:SetColor(255,255,255)
			graphic:Display(transform.x, transform.y)
		end
	end
end

onKeyPress = function(e,k)
end

onKeyRelease = function(e,k)
end

recieveMessage = function(e, message)
	if message == "bullet" then
		health = health - 1
		sound:Play("Pop")
	end
end

recieveSignal = function(e, signal)
	charMove = signal
	if signal == "BreakConv" then
		if e:GetDC() then
			dialogue:HideBox()
		end
	end
	if signal == "White" then
		color = "White"
	end
end