bang = function(e)
	e:AddComponent("GraphicComponent")
	e:AddComponent("TransformComponent")
	e:AddComponent("CollisionComponent")
	e:AddComponent("DialogComponent")
	e:AddComponent("MapComponent")

	e:GetDC():SetGraphic("Resources/Graphic/Man1Talk.png")
	personType = 4
	personType = math.random(0,2)

    moveTime = math.random(5,15)

	if personType == 0 then
		e:GetGC():SetImage("Monster.png")
	elseif personType == 1 then
		e:GetGC():SetImage("Monster2.png")
	elseif personType == 2 then
		e:GetGC():SetImage("Monster3.png")
	elseif personType == 3 then
		e:GetGC():SetImage("Monster4.png")
	elseif personType == 4 then
		e:GetGC():SetImage("Monster5.png")
	end

	e:GetDC():PushMessage("...")
	e:GetDC():PushMessage("(what is 'K'?)")

	e:GetGC():AddFrame("WalkRight", 0, 0)
	e:GetGC():AddFrame("WalkRight", 1, 0)
	e:GetGC():AddFrame("WalkLeft", 0, 1)
	e:GetGC():AddFrame("WalkLeft", 1, 1)
	e:GetGC():Play("WalkRight")
	e:GetGC():SetAnimation("WalkRight")
	e:GetGC():SetFPS(5)
	walking = "right"
	e:SetLayer(2)
	e:GetGC():Stop()
	e:GetCC():SetType("Random")


	xvel = 0.0

	distance = 32
	time = 0

	nextX = e:GetTransform().x
	nextY = e:GetTransform().y

	charMove = "BreakConv"

	open = false
end

update = function(e)
	char = e:GetEntity("Character")
	time = time + e:GetDeltaTime()
	collider = e:GetCC()

	if xvel > 0 then
		xvel = xvel - .1
	elseif xvel < 0 then
		xvel = xvel + .1
	end


	e:GetTransform().x = e:GetTransform().x + math.floor(xvel)

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

	if open == false then
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

	
		if time > moveTime then
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
	if message == "Dialogue" then
		if e:GetDC() then
			open = true
			xvel = 0
			nextX = e:GetTransform().x
			nextY = e:GetTransform().y
			e:GetDC():OpenDialogue()
		end
	end
	if message == "Hurt" then
		if collider:CollidingType("left") == "Character" then
			xvel = 5.0
		elseif collider:CollidingType("right") == "Character" then
			xvel = -5.0
		end
	end
end

recieveSignal = function(e, signal)
	charMove = signal
	if signal == "BreakConv" then
		if e:GetDC() then
			open = false
			e:GetDC():HideBox()
		end
	end
end