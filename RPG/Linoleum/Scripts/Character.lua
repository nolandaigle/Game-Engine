
bang = function(e)
	e:AddComponent("GraphicComponent")
	e:AddComponent("TransformComponent")
	e:AddComponent("CollisionComponent")
	e:AddComponent("MapComponent")
	e:AddComponent("SoundComponent")
	e:GetSC():Load("Resources/Sound/Hit.wav")
	e:GetGC():SetImage("Character.png")
	e:GetGC():AddFrame("WalkRight", 0, 0)
	e:GetGC():AddFrame("WalkRight", 1, 0)
	e:GetGC():AddFrame("WalkLeft", 0, 1)
	e:GetGC():AddFrame("WalkLeft", 1, 1)
	e:GetGC():AddFrame("Meditate", 0, 2)
	e:GetGC():AddFrame("Meditate", 1, 2)
	e:GetGC():AddFrame("HitLeft", 1, 3)
	e:GetGC():AddFrame("HitRight", 0, 3)
	e:GetGC():Play("WalkRight")
	e:GetGC():SetAnimation("WalkRight")
	e:GetGC():SetFPS(5)
	e:SetLayer(1)
	e:GetCC():SetType("Character")

	e:GetTransform():CenterView()

	timer = 0.0
	timeCap = 15.0
end

update = function(e)
	transform = e:GetTransform()
	map = e:GetMap()

	timer = timer + e:GetDeltaTime()

	while e:GetCC():CollidingType("left") == "Block" do
		transform.x = transform.x + 1;
	end
	while e:GetCC():CollidingType("right") == "Block" do
		transform.x = transform.x - 1;
	end
	while e:GetCC():CollidingType("top") == "Block" do
		transform.y = transform.y + 1;
	end
	while e:GetCC():CollidingType("bottom") == "Block" do
		transform.y = transform.y - 1;
	end

	if e:GetCC():CollidingType("all") == "Tunnel" then
		e:Message("Map", "Tunnel.json")
	end

	pressed = false

	if e:KeyPressed("w") == true then
		transform.y = transform.y - 1
		pressed = true
	end
	if e:KeyPressed("a") == true then
		transform.x = transform.x - 1
		pressed = true
	end
	if e:KeyPressed("s") == true then
		transform.y = transform.y + 1
		pressed = true
	end
	if e:KeyPressed("d") == true then
		transform.x = transform.x + 1
		pressed = true
	end

	if pressed == true then
		e:Signal("BreakConv")
		timer = 0
	else
		e:Signal("Chill")
	end
	if pressed == false then
		e:GetGC():Stop()
	end

	if timer > 10 then
		e:GetGC():Play("Meditate")
	end
end

display = function(e)

	transform = e:GetTransform()

	gComp = e:GetGC()

	transform:CenterView()

	if gComp then
        gComp:Display(e:GetTransform().x, e:GetTransform().y)
	end 
end


onKeyRelease = function(e,k)
end

onKeyPress = function(e,k)
	if k == "d" then
		e:GetGC():Play("WalkRight")
	elseif k == "a" then
		e:GetGC():Play("WalkLeft")
	end

	npc = ""
	if k == "j" then
		npc = e:GetCC():CollidingName("all")
		if npc ~= "" then
			e:Message(npc, "Dialogue")
		end
	end
	if k == "k" then
		npc = e:GetCC():CollidingName("all")
		e:GetSC():Play()
		if e:GetGC():GetCurrentAnimation() == "WalkLeft" then
			e:GetGC():Play("HitLeft")
		elseif e:GetGC():GetCurrentAnimation() == "WalkRight" then
			e:GetGC():Play("HitRight")
		end
		if npc ~= "" then
			e:Message(npc, "Hurt")
		end
	end
end