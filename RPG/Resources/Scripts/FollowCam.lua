debug = false

bang = function(e)
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	e:GetTransform():CenterView()

	e:AddComponent("GraphicComponent")
	e:AddComponent("ScreenComponent")
	e:AddComponent("MapComponent")
	map = e:GetMap()
end

update = function(e)
	player = e:GetEntity("Player"):GetTransform()
	if player then
		transform.x = (transform.x + e:Lerp(transform.x, player.x, .1 ))
		transform.y = (transform.y + e:Lerp(transform.y, player.y, .1 ))
	end

	if (transform.x < e:GetScreen():GetWidth()/2) then
		transform.x = e:GetScreen():GetWidth()/2
	end
	if (transform.x > map:GetWidth() - e:GetScreen():GetWidth()/2)  then
		transform.x = map:GetWidth() - e:GetScreen():GetWidth()/2
	end
	
	if (transform.y < e:GetScreen():GetHeight()/2) then
		transform.y = e:GetScreen():GetHeight()/2
	end
	if (transform.y > map:GetHeight() - e:GetScreen():GetHeight()/2) then
		transform.y = map:GetHeight() - e:GetScreen():GetHeight()/2
	end

	e:GetTransform():CenterView()
end

display = function(e)
	if debug == true then
		e:GetGC():Display(transform.x, transform.y)
	end
end

onKeyPress = function(e,k)
end

onKeyRelease = function(e,k)
end