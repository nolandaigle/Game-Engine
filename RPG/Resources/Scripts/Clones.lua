xvel = 0
yvel = 0
medTimer = 0.0

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("ScreenComponent")

	medTimer = 0.0
	teleportTime = 5

	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(0, 0)
	e:GetTransform():CenterView()

	e:GetScreen():Zoom( .1 )
	e:GetScreen():SetPixelate( true, .5, .01)

	e:Message("Music", "Resources/Music/The God Head.wav")
	e:Message("Music", "Play")
end

update = function(e)

	--Meditation Timer
	medTimer = medTimer + e:GetDeltaTime()
	if medTimer > 1 then
		e:GetScreen():SetPixelate( false, 0, .01)
	end
	if medTimer < 25 then
		e:GetScreen():Zoom( 1 + ((medTimer/9000)) )
	end
end

display = function(e)
end

onKeyPress = function(e,k)
end

onKeyRelease = function(e,k)
end

recieveSignal = function(e, signal)
	if signal == "Right" then
		e:Message("Map", "Field.json")
		file = io.open("playerexit.save", "w")
		file:write(signal)
		file:close()
	end
	if signal == "Left" then
		e:Message("Map", "Field.json")
		file = io.open("playerexit.save", "w")
		file:write(signal)
		file:close()
	end
	if signal == "Bottom" then
		e:Message("Map", "Field.json")
		file = io.open("playerexit.save", "w")
		file:write(signal)
		file:close()
	end
	if signal == "Top" then
		e:Message("Map", "Mirror.json")
		file = io.open("playerexit.save", "w")
		file:write(signal)
		file:close()
	end
end