open = true

switchNum = 1
switched = 0

bang = function(e)
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Sokobox.png")
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
		graphic:Display(transform.x, transform.y)
	end
end

recieveSignal = function(e, signal)
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