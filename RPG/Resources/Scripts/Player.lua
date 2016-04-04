bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	graphic:SetImage("Player.png")
	graphic:SetFrameSize(8,16)
	graphic:AddFrame("WalkRight", 0, 0)
	graphic:AddFrame("WalkRight", 1, 0)
	graphic:AddFrame("WalkLeft", 0, 1)
	graphic:AddFrame("WalkLeft", 1, 1)
	graphic:AddFrame("Meditate", 0, 2)
	graphic:AddFrame("Meditate", 1, 2)
	graphic:Play("Meditate")
	graphic:Stop()
	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	e:AddComponent("CollisionComponent")

	e:GetTransform():CenterView()
end

update = function(e)
end

display = function(e)
	if graphic then
		graphic:Display(transform.x, transform.y)
	end
end