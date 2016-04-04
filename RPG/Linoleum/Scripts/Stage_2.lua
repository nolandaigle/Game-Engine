bang = function(e)
	--Add components
	e:AddComponent("GraphicComponent")
	e:AddComponent("SoundComponent")
	e:AddComponent("ScreenComponent")
	--Load music
	e:GetSC():Load("Resources/Sound/Stage_2.wav")
	e:GetSC():Play()
	e:GetSC():SetLoop(true)
	--Set shader
	e:GetScreen():SetPixelate( true, .1, .00001)
	--initialize variables
	timer = 0.0
	spawnTimer = 0.0
	timeCap = 15.0
	enabled = true
end

update = function(e)
	--add the time between each frame to timer
	timer = timer + e:GetDeltaTime()
	spawnTimer = spawnTimer + e:GetDeltaTime()

	--if timer is > the cap then the pixelate shader increased intensity
	if timer > 5  and enabled == false then
		e:GetScreen():SetPixelate( true, .5, .0001)
		enabled = true
	end

	--Spawn an entity at the starting locatino every 2.5 seconds
	if spawnTimer > 2.5 and e:GetEntity("Character"):GetTransform().y < 256 then
		e:CreateEntity( 256,380, "Person" )
		spawnTimer = 0
	end
end

display = function(e)
end

onKeyPress = function(e,k)
	--If a key is pressed, set shader and timer to 0
	if enabled == true then
		e:GetScreen():SetPixelate( false, 0, .01)
		enabled = false
	end
	timer = 0
end