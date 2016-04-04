bang = function(e)
	e:AddComponent("TransformComponent")
	e:AddComponent("CollisionComponent")
	e:AddComponent("ScreenComponent")


	collider = e:GetCC()
	collider:SetTransform(e:GetTransform())
	collider:SetType("Tunnel")
end

update = function(e)
end

display = function(e)
end