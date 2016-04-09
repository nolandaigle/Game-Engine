xvel = 0
yvel = 0

bang = function(e)
	e:AddComponent("TransformComponent")
	e:GetTransform():CenterView()

	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("ScreenComponent")

	medTimer = 0.0
	teleportTime = 5
end

update = function(e)

	if e:KeyPressed("up") == true or e:KeyPressed("down") == true or e:KeyPressed("left") == true or e:KeyPressed("right") == true then
		medTimer = 0.0
	end

	--Meditation Timer
	medTimer = medTimer + e:GetDeltaTime()

	if medTimer > teleportTime then
		e:GetScreen():SetPixelate( true, .5, .0001)
		if medTimer > teleportTime + 10 then 
			e:Message("Map", "Clones.json")
			medTimer = 0
		end
	end
end

display = function(e)
end

onKeyPress = function(e,k)
	
	medTimer = 0
	e:GetScreen():SetPixelate( false, 0, .01)

	if k == "q" then
		e:Message("Map", "Clones.json")
	end
end

onKeyRelease = function(e,k)
	medTimer = 0
	e:GetScreen():SetPixelate( false, 0, .01)
end