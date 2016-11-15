debug = false

updating = true

created = false

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
end

lateUpdate = function(e)
	player = e:GetEntity("Player"):GetTransform()

	
		if player then

			if created == false then
				transform.x = player.x
				transform.y = player.y
				created = true
			end

			transform.x = (transform.x + e:Lerp(transform.x, player.x, .05 ))
			transform.y = (transform.y + e:Lerp(transform.y, player.y, .05 ))

		end

		if (transform.x < e:GetScreen():GetWidth()/2) then
			transform.x = e:Round(e:GetScreen():GetWidth()/2)
		end
		if (transform.x > map:GetWidth() - e:GetScreen():GetWidth()/2)  then
			transform.x = e:Round(map:GetWidth() - e:GetScreen():GetWidth()/2)
		end
		
		if (transform.y < e:GetScreen():GetHeight()/2) then
			transform.y = e:Round(e:GetScreen():GetHeight()/2)
		end
		if (transform.y > map:GetHeight() - e:GetScreen():GetHeight()/2) then
			transform.y = e:Round(map:GetHeight() - e:GetScreen():GetHeight()/2)
		end

	if updating == true then
		transform.x = e:Round(transform.x)
		transform.y = e:Round(transform.y)
		e:GetTransform():CenterView()
	end
end

display = function(e)
	if debug == true then
		e:GetGC():Display(transform.x, transform.y)
	end
end

onKeyPress = function(e,k)
	if k == "o" then
		if updating == true then
			debug = true
			updating = false
		elseif updating == false then
			debug = false
			updating = true
		end 
	end
end