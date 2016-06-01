xvel = 0
yvel = 0
medTimer = 0.0

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("ScreenComponent")
	e:AddComponent("MapComponent")

	medTimer = 0.0
	teleportTime = 5

	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(0, 0)
	e:GetTransform():CenterView()

	e:GetScreen():Reset()
	e:GetScreen():Zoom( .1 )
	e:GetScreen():SetPixelate( true, .5, .01)

	e:Message("Music", "Resources/Music/The God Head.wav")
	e:Message("Music", "Play")
	e:Message("Music", "Unloop")

	e:AddComponent("FileComponent")
	file = e:GetFC()
end

update = function(e)
	e:Signal("Stuck")

	--Meditation Timer
	medTimer = medTimer + e:GetDeltaTime()
	if medTimer > 1 then
		e:GetScreen():SetPixelate( false, 0, .01)
	end
	if ( e:GetScreen():GetWidth() <= e:GetMap():GetWidth() ) then
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
		e:Message("Map", "Ray.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "1")
		file:WriteFile()
	end
	if signal == "Left" then
		e:Message("Map", "Sokoban1.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "1")
		file:WriteFile()
	end
	if signal == "Bottom" then
		e:Message("Map", "SideLoop.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "1")
		file:WriteFile()
	end
	if signal == "Top" then
		e:Message("Map", "Mirror.json")
		file:OpenFile("Game.save")
		file:SetVariable("Player-exit", "Top")
		file:SetVariable("Player-x", e:GetEntity("Player"):GetTransform().x)
		file:SetVariable("Player-y", e:GetEntity("Player"):GetTransform().y)
		file:WriteFile()
	end
end