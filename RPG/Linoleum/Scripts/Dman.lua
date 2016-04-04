bang = function(e)
	e:AddComponent("GraphicComponent")
	e:AddComponent("TransformComponent")
	e:AddComponent("CollisionComponent")
	e:AddComponent("DialogComponent")
	e:AddComponent("MapComponent")
    e:AddComponent("SoundComponent")
    e:GetSC():Load("Resources/Sound/turkishtrainstation.wav")
    e:GetSC():Play()
    e:GetSC():SetLoop(true)

	e:GetDC():SetGraphic("Resources/Graphic/DmanTalk.png")
	personType = 4
	personType = math.random(0,2)

	e:GetGC():SetImage("Dman.png")

	e:GetDC():PushMessage("FUCK YOU")
	e:GetDC():PushMessage("FUCKin loser!\n\n")

	e:PrintMessage(personType)

	e:GetGC():AddFrame("WalkRight", 0, 0)
	e:GetGC():AddFrame("WalkRight", 1, 0)
	e:GetGC():AddFrame("WalkLeft", 0, 1)
	e:GetGC():AddFrame("WalkLeft", 1, 1)
	e:GetGC():AddFrame("Dead", 0, 2)
	e:GetGC():Play("WalkRight")
	e:GetGC():SetAnimation("WalkRight")
	e:GetGC():SetFPS(5)
	walking = "right"
	e:SetLayer(3)
	e:GetGC():Stop()
	e:GetCC():SetType("Dman")

	dead = false


	xvel = 0.0

	distance = 32
	time = 0

	nextX = e:GetTransform().x
	nextY = e:GetTransform().y

	charMove = "BreakConv"

	open = false

	size = 1.0

	time = 0.0

    e:GetGC():BypassCulling(true)
end

update = function(e)
	
	time = time + e:GetDeltaTime()

	if xvel > 0 then
		xvel = xvel - .1
	elseif xvel < 0 then
		xvel = xvel + .1
	end

	e:GetTransform().x = e:GetTransform().x + math.floor(xvel)

	if dead == false then
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

		
			if time > 22 then
				time = 0
				
				nextX = e:GetEntity("Character"):GetTransform().x
				nextY = e:GetEntity("Character"):GetTransform().y

				if nextX < e:GetTransform().x then
						e:GetGC():Play("WalkLeft")
				elseif nextX > e:GetTransform().x then
					e:GetGC():Play("WalkRight")
				end
			end
		end
	elseif dead == true then
		if time > 5 then
			xvel = 0
		end

		if time > 120 then
			e:Message("Map", "God.json")
		end
		size = size + .001
		e:GetGC():SetScale(size,size)
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
			dead = true
			e:GetGC():Play("Dead")
            e:GetSC():Stop()
			time = 0.0
			xvel = 5.0
		elseif collider:CollidingType("right") == "Character" then
            dead = true
            e:GetGC():Play("Dead")
            e:GetSC():Stop()
            time = 0.0
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