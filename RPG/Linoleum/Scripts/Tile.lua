bang = function(e, i)
	--Add components
	e:AddComponent("GraphicComponent")
	e:AddComponent("TransformComponent")

	--Set graphic to city tileset by default
	graphic = e:GetGC()
	graphic:SetImage("CityTileset.png")

	--the width of the tileset, in tiles
	width = 128/16

	--set the graphic to the correct tile inside the tileset
	if i then
		bx = tonumber(i)-1
		by = 0

		while bx >= width do
			bx = bx - width
			by = by + 1
		end
		graphic:SetFrameSize(16,16)
		graphic:AddFrame("Tile", bx, by)
		graphic:Play("Tile")
	end

	--if tile layer is equal to 1, it is an obstacle
	if e:GetLayer() == 1 then
		e:AddComponent("CollisionComponent")
		collider = e:GetCC()
		collider:SetTransform(e:GetTransform())
		collider:SetType("Block")
	end

	--varibales for the TRIPPYNESS
	mult = 1.0
	rand = (math.random(70,130))
	increment = .0001

	--update and draw tile even if it is offscreen
	e:GetGC():BypassCulling(true)

		--create shortcuts for transform and graphic components
	transform = e:GetTransform()
	gComp = e:GetGC()
end

display = function(e)

	--ALL THE TRIPPYNESS SHITTTTT
	mult = mult + increment*(rand*.005)

	if mult > 1.0 then
		increment = increment*1.02
	end

    if mult > 500 or e:GetDeltaTime() > .25 then
		e:Message("Map", "InterMissionOne.json")
	end

	if gComp then
		--MORE TRIPPYNESSSSS
		if rand > 124 or rand < 86 then
			gComp:SetRotation(math.floor(mult*2))
		else
			gComp:SetRotation(-math.floor(mult*2))
		end

		gComp:SetScale(mult*mult, mult*mult)

		--draw tile
        gComp:Display(math.floor(e:GetTransform().x*mult*1.01) - math.floor(mult), math.floor(e:GetTransform().y*mult*1.01) - math.floor(mult) )
	end 
end