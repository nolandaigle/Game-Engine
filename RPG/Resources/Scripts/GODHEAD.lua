timer =  0
conversation = 0
x = 0
y = 0
going = false
played = false
d = -1

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )

	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:CenterView()

	e:AddComponent("SoundComponent")
	sound = e:GetSC()
	sound:Load("Resources/Sound/impact.wav", "Door")

	e:AddComponent("ScreenComponent")
	e:GetScreen():Reset()
	e:GetScreen():Zoom(.005)

	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("GODHEAD.png")
	graphic:SetFrameSize(1056,1056)

	e:AddComponent("FileComponent")
	file = e:GetFC()

	math.randomseed(os.time())
	d = math.random(0, 5)

	if d == 0 then
		transform.x = transform.x-499
		transform.y = transform.y-400
		e:Message("Music", "Unloop")
		e:Message("Music", "Resources/Music/Hello.wav")
		e:Message("Music", "Stop")
	elseif d == 1 then
		transform.x = transform.x-355
		transform.y = transform.y-400
		e:Message("Music", "Unloop")
		e:Message("Music", "Resources/Music/It's been a long time.wav")
		e:Message("Music", "Stop")
	elseif d == 2 then
		transform.x = transform.x-355
		transform.y = transform.y-400
		e:Message("Music", "Unloop")
		e:Message("Music", "Resources/Music/Schmuckforalifetime.wav")
		e:Message("Music", "Stop")
	elseif d == 3 then
		transform.x = transform.x-355
		transform.y = transform.y-400
		e:Message("Music", "Unloop")
		e:Message("Music", "Resources/Music/titlescreen.wav")
		e:Message("Music", "Stop")
	elseif d == 4 then
		transform.x = transform.x-499
		transform.y = transform.y-400
		e:Message("Music", "Unloop")
		e:Message("Music", "Resources/Music/An introduction.wav")
		e:Message("Music", "Stop")
	elseif d == 5 then
		transform.x = transform.x-355
		transform.y = transform.y-400
		e:Message("Music", "Unloop")
		e:Message("Music", "Resources/Music/giantrobots.wav")
		e:Message("Music", "Stop")
	end

	file:OpenFile("Quest.save")
	file:SetVariable("Bone", "not")
	file:SetVariable("Creator", "missing")
	file:SetVariable("Mom", "not")
	file:SetVariable("Priest", "not")
	file:SetVariable("SharkBelly", "not")
	file:WriteFile()
end

update = function(e)
	timer = timer + e:GetDeltaTime()

	if timer > .5 and played == false then
		sound:Play("Door")
		played = true
		print(played)
	end

	if timer > 5 then
		e:GetScreen():Zoom(1.00075)
		if going == false then
			e:Message("Music", "Play")
			going = true
		end
	end

	if d == 0 and timer > 104 then
		sound:Play("Door")
		e:Message("Map", "Box.json")
	end
	if d == 1 and timer > 104 then
		sound:Play("Door")
		e:Message("Map", "Box.json")
	end
	if d == 2 and timer > 148 then
		sound:Play("Door")
		e:Message("Map", "Box.json")
	end
	if d == 3 and timer > 104 then
		sound:Play("Door")
		e:Message("Map", "Box.json")
	end
	if d == 4 and timer > 101 then
		sound:Play("Door")
		e:Message("Map", "Box.json")
	end
	if d == 5 and timer > 83 then
		sound:Play("Door")
		e:Message("Map", "Box.json")
	end
end

display = function(e)
	graphic:Display(transform.x, transform.y)
end

onKeyPress = function(e,k)
	file:OpenFile("Quest.save")
	file:SetVariable("Time", tostring(timer))
	file:WriteFile()
	sound:Play("Door")
end