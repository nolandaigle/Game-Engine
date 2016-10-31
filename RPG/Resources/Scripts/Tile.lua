color = "White"

bang = function(e, i)
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()

	if e:GetLayer() == 1 then
		if i then
			e:AddComponent("CollisionComponent")
			collider = e:GetCC()
			collider:SetTransform(e:GetTransform())
			collider:SetType("Block")
		end
	end

	e:SetUpdate(false)
	e:SetDisplay(false)


end

recieveSignal = function(e, signal)
end