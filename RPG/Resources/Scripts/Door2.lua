open = true

switchNum = 1
switched = 0

bang = function(e)
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Door.png")
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	e:AddComponent("CollisionComponent")
	collision = e:GetCC()
	collision:SetType("Open")
	e:AddComponent("SoundComponent")
	sound = e:GetSC()
	sound:Load("Resources/Sound/Door.wav", "Door")

	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Sokoban.save")
	switchNum = tonumber(file:GetVariable("Switch-number"))
end

update = function(e)
end

display = function(e)
	if graphic and open == false then
		if color == "Blue" then
			graphic:SetColor(50,50,255)
			graphic:Display(transform.x, transform.y)
		end
		if color == "White" and alive == true then
			graphic:SetColor(255,255,255)
			graphic:Display(transform.x, transform.y)
		end
		if color == "Red" and alive == true then
			graphic:SetColor(255,50,50)
			graphic:Display(transform.x, transform.y)
		end
	end
end

recieveSignal = function(e, signal)

	if signal == "White" then
		color = "White"
	elseif signal == "Blue" then
		color = "Blue"
	elseif signal == "Red" then
		color = "Red"
	end

	if signal == "reset" then
		file:OpenFile("Sokoban.save")
		switchNum = tonumber(file:GetVariable("Switch-number"))
		switched = switched + 1
		if switched >= switchNum then
			if open == true then
				open = false
				collision:SetType("Block")
			else
				open = true
				collision:SetType("Open")
			end
		end
	elseif signal == "unlocked" then
		if open == false then
			sound:Play("Door")
		end
		open = false
		collision:SetType("Block")
	end
end