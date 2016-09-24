color = "White"
alive = true
health = 1
timer = 0

x = 0.0
y = 0.0
tdisplay = false


bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("protestor2.png")
	graphic:SetFrameSize(48,32)
	graphic:AddFrame("WalkRight", 0, 0)
	graphic:AddFrame("WalkRight", 1, 0)
	graphic:AddFrame("WalkRight", 2, 0)
	graphic:AddFrame("WalkLeft", 3, 0)
	graphic:AddFrame("WalkLeft", 4, 0)
	graphic:AddFrame("WalkLeft", 5, 0)
	graphic:Play("WalkRight")
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(48, 32)
	e:AddComponent("CollisionComponent")
	e:GetCC():SetType("protestor")

	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Quest.save")

	--DIALOGUE stuff
	e:AddComponent("DialogComponent")
	dialogue = e:GetDC()
	dialogue:ShowGraphic(false)
	dialogue:SetVoice("uh.wav")

	dialogue:PushMessage("!!!")

	startx = transform.x
	starty = transform.y
	targetx = startx + 16
	targety = starty + 16
end

update = function(e)
	timer = timer + e:GetDeltaTime()
	if e:GetCC():CollidingType("all") == "" then
		
		if targetx > transform.x then
			graphic:Play("WalkRight")
		elseif targetx < transform.x then
			graphic:Play("WalkLeft")
		end
	elseif e:GetCC():CollidingType("all") ~= "" then
		graphic:Stop()
	end

	targetx = e:GetEntity("Player"):GetTransform().x + math.random(-16, 16)
	targety = e:GetEntity("Player"):GetTransform().y + math.random(-16, 16)

	if math.abs(transform.x - targetx) < 128 and math.abs(transform.y - targety) < 128 then
		graphic:Stop()
		targetx = transform.x
		targety = transform.y
	else
		transform.x = transform.x + e:Lerp(transform.x, targetx, 0.001)
		transform.y = transform.y + e:Lerp(transform.y, targety, 0.001)
	end

	if health < 1 and alive == true then
		dialogue:Clear()
		dialogue:PushMessage("Hundred Points!")
		dialogue:OpenDialogue()
		alive = false
	end

	--Tile Collision detection and resolution
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
end

display = function(e)
	if graphic then
		if color == "Blue" then
			graphic:SetColor(50,50,255)
			graphic:Display(transform.x, transform.y)
		end
		if color == "White" and alive == true then
			graphic:SetColor(255,255,255)
			graphic:Display(transform.x, transform.y)
		end
	end

	if tdisplay == true then
			transform:Display(true)
			tdisplay = false
		end
end

onKeyPress = function(e,k)
end

onKeyRelease = function(e,k)
end

recieveMessage = function(e, message)
if message == "PlayerTouch" then
		tdisplay = true
	end
	if message == "Dialogue" then
		if e:GetDC() then
			dialogue:OpenDialogue()
		end
	end
	if message == "bullet" then
		health = health - 1
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
	elseif signal == "Blue" then
		color = "Blue"
	end
end