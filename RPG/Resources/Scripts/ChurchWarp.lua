color = "White"
alive = false
health = 0
timer = 0

x = 0.0
y = 0.0
startx = 0
starty = 0
targetx = 0
targety = 0

boned = false

conversation = 0

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )
	e:AddComponent("GraphicComponent")
	graphic = e:GetGC()
	

	e:AddComponent("TransformComponent")
	transform = e:GetTransform()
	transform:SetSize(32, 16)
	e:AddComponent("CollisionComponent")
	e:GetCC():SetType("ChurchWarp")

	e:AddComponent("FileComponent")
	file = e:GetFC()
end

update = function(e)
	if e:GetCC():CollidingType("all") == "player" then
		e:Message("Map", "Church.json")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "1")
		file:WriteFile()
	end
end

display = function(e)
end

onKeyPress = function(e,k)
end

onKeyRelease = function(e,k)
end