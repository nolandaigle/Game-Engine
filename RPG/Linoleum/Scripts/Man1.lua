bang = function(e)
	e:AddComponent("GraphicComponent")
	e:AddComponent("TransformComponent")
	e:AddComponent("CollisionComponent")
	e:AddComponent("DialogComponent")
	e:AddComponent("MapComponent")
	e:GetGC():SetImage("Man1.png")
	e:GetGC():AddFrame("WalkRight", 0, 0)
	e:GetGC():AddFrame("WalkRight", 1, 0)
	e:GetGC():AddFrame("WalkLeft", 0, 1)
	e:GetGC():AddFrame("WalkLeft", 1, 1)
	e:GetGC():Play("WalkRight")
	e:GetGC():SetAnimation("WalkRight")
	e:GetGC():SetFPS(5)
	walking = "right"
	e:GetGC():Stop()
	e:GetCC():SetType("Man1")
	e:GetDC():SetGraphic("Resources/Graphic/Man1Talk.png")
	e:GetDC():PushMessage("My pockets are full \n  of lint and holes\nwhere everything\n  IMPORTANT to me")
	e:GetDC():PushMessage("Just seems to fall \n right down my leg \n and onto the floor.\n\n My closest friend,\n Linoleum.")
	e:GetDC():PushMessage("Linoleum supports \n my head. \n\nGives me something to\n BELIEVE.")

	distance = 32
	time = 0

	nextX = e:GetTransform().x
	nextY = e:GetTransform().y

	charMove = "BreakConv"

	collider = e:GetCC()
end

update = function(e)
	char = e:GetEntity("Character")

	time = time + e:GetDeltaTime()

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

	if charMove == "BreakConv" and char:GetTransform().x - e:GetTransform().x > -distance and char:GetTransform().x - e:GetTransform().x < distance and char:GetTransform().y - e:GetTransform().y > -distance and char:GetTransform().y - e:GetTransform().y < distance then
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
		if time > 25 then
			
			time = 0
				nextX = char:GetTransform().x
				nextY= char:GetTransform().y - 10

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
	if signal == "BreakConv" then
		if e:GetDC() then
			e:GetDC():HideBox()
		end
	end
end