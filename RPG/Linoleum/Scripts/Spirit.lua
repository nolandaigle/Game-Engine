bang = function(e)
	e:AddComponent("GraphicComponent")
	e:AddComponent("TransformComponent")
	e:AddComponent("CollisionComponent")
	e:AddComponent("MapComponent")
	e:GetGC():SetImage("Thing.png")
	e:GetGC():AddFrame("WalkRight", 0, 0)
	e:GetGC():AddFrame("WalkRight", 1, 0)
	e:GetGC():AddFrame("WalkLeft", 0, 1)
	e:GetGC():AddFrame("WalkLeft", 1, 1)
	e:GetGC():Play("WalkRight")
	e:GetGC():SetAnimation("WalkRight")
	e:GetGC():SetFPS(5)
	walking = "right"
	e:GetGC():Stop()
	e:GetCC():SetType("Person")

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

	--Get collision with tiles
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

	--Move NPC toward his next position
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
	--if NPC has reached position, stop
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
		if time > 8 then
			time = 0
			
			nextX = math.random(e:GetTransform().x-128,e:GetTransform().x+128)
			nextY = math.random(e:GetTransform().y-128,e:GetTransform().y+128)

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
end

recieveSignal = function(e, signal)
	charMove = signal
end