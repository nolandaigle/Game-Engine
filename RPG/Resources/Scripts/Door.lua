open = false

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
	collision:SetType("Block")
	e:AddComponent("SoundComponent")
	sound = e:GetSC()
	sound:Load("Resources/Sound/Door.wav", "Door")

	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Sokoban.save")
	switchNum = tonumber(file:GetVariable("Switch-number"))
	print(switchNum)
end

update = function(e)
end

display = function(e)
	if graphic and open == false then
		graphic:Display(transform.x, transform.y)
	end
end

recieveSignal = function(e, signal)
	if signal == "White" then
		color = "White"
	elseif signal == "Blue" then
		color = "Blue"
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
		open = true
		collision:SetType("Open")
	end
end