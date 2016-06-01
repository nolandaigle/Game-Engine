bang = function(e)
	e:AddComponent("TransformComponent")
end

update = function(e)
end

display = function(e)
end

onKeyPress = function(e,k)
end

onKeyRelease = function(e,k)
end

recieveMessage = function(e, message)
	if message == "Create" then
		e:CreateEntity( e:GetTransform().x, e:GetTransform().y, "Player", "")
	end
end