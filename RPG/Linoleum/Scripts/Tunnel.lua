bang = function(e)
	--add components
	e:AddComponent("TransformComponent")
	e:AddComponent("CollisionComponent")

	--set collider type
	e:GetCC():SetType("Tunnel")
end

update = function(e)
end

display = function(e)
end