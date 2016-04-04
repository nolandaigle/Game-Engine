bang = function(e)
	e:AddComponent("GraphicComponent")
	e:AddComponent("TransformComponent")
	e:AddComponent("CollisionComponent")
	e:AddComponent("MapComponent")
	e:AddComponent("DialogComponent")
	e:GetGC():SetImage("Character.png")
	e:GetGC():AddFrame("WalkRight", 0, 0)
	e:GetGC():AddFrame("WalkRight", 1, 0)
	e:GetGC():AddFrame("WalkLeft", 0, 1)
	e:GetGC():AddFrame("WalkLeft", 1, 1)
	e:GetGC():Play("WalkRight")
	e:GetGC():SetAnimation("WalkRight")
	e:GetGC():SetFPS(5)
	e:SetLayer(1)
	walking = "right"
	e:GetGC():Stop()
	e:GetCC():SetType("Person")

	e:GetDC():SetGraphic("Resources/Graphic/Man1Talk.png")
	e:GetDC():SetVoice("uh.wav")
	e:GetDC():PushMessage("...")

	distance = 32
	time = 0

	nextX = e:GetTransform().x
	nextY = e:GetTransform().y

	charMove = "BreakConv"
end

update = function(e)
	char = e:GetEntity("Character")
	time = time + e:GetDeltaTime()
	collider = e:GetCC()

	if transform then
		while collider:CollidingType("left") == "Block" do
			transform.x = transform.x + 1;
		end
		while collider:CollidingType("right") == "Block" do
			transform.x = transform.x - 1;
		end
		while collider:CollidingType("top") == "Block" do
			transform.y = transform.y + 1;
		end
		while collider:CollidingType("bottom") == "Block" do
			transform.y = transform.y - 1;
		end
	end

	if nextX < e:GetTransform().x then
		e:GetTransform().x = e:GetTransform().x - 1
	elseif nextX > e:GetTransform().x then
		e:GetTransform().x = e:GetTransform().x + 1
	end
	if nextY < e:GetTransform().y then
		e:GetTransform().y = e:GetTransform().y - 1
	elseif nextY > e:GetTransform().y then
		e:GetTransform().y = e:GetTransform().y + 1
	end

	if e:GetTransform().x == nextX and e:GetTransform().y == nextY then
		e:GetGC():Stop()
	end

	if char:GetTransform().x - e:GetTransform().x > -distance and char:GetTransform().x - e:GetTransform().x < distance and char:GetTransform().y - e:GetTransform().y > -distance and char:GetTransform().y - e:GetTransform().y < distance then
		if char:GetTransform().x < e:GetTransform().x then
			if e:GetGC():Playing() == false then
				e:GetGC():Play("WalkRight")
			end
			nextX = e:GetTransform().x + 2
		end
		if char:GetTransform().x > e:GetTransform().x then
			if e:GetGC():Playing() == false then
				e:GetGC():Play("WalkLeft")
			end
			nextX = e:GetTransform().x - 2
		end
		if char:GetTransform().y < e:GetTransform().y then
			nextY = e:GetTransform().y + 2
		end
		if char:GetTransform().y > e:GetTransform().y then
			nextY = e:GetTransform().y - 2
		end
	else
		if time > 4 then
			time = 0
			
			nextX = math.random(e:GetTransform().x-32,e:GetTransform().x+32)
			nextY = math.random(e:GetTransform().y-32,e:GetTransform().y+32)

			if nextX < e:GetTransform().x then
					e:GetGC():Play("WalkLeft")
			elseif nextX > e:GetTransform().x then
				e:GetGC():Play("WalkRight")
			end
		end
	end
end

display = function(e)
	gComp = e:GetGC()

	transform = e:GetTransform()

	if gComp then
		if transform then
	        gComp:Display(transform.x, transform.y)
	    end
	end 
end

recieveMessage = function(e, message)
	if message == "Dialogue" then
		if e:GetDC() then
		e:GetDC():OpenDialogue()
		end
	end
end

recieveSignal = function(e, signal)
	charMove = signal
end