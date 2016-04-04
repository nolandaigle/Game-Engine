bang = function(e)
	--Add components
	e:AddComponent("ScreenComponent")
	e:AddComponent("SoundComponent")
	--Load allen watts clip and play alan watts clip
	e:GetSC():Load("Resources/Sound/watts.wav")
	e:GetSC():Play()
	e:GetSC():SetLoop(true)
	--Is the character finished with the trippy part?
	finished = false

	c = e:GetEntity("Character")
end

update = function(e)
	--If the character has passed 7229, stop applying the shader
	if finished == true then
		e:GetScreen():SetPixelate( false, 0, .01)
	end

	--If the character has not finished the trippy part
	if finished == false then
		e:GetScreen():SetPixelate( true, (e:GetEntity("Character"):GetTransform().x/8192)*.25, .0001)

		--If the character has passed 7229, TRIPPY PART OVER
		if c:GetTransform().x > 7229 then
			e:GetSC():Stop()
			e:GetSC():Load("Resources/Sound/Dreamman.wav")
			e:GetSC():Play()
			finished = true;
		end
	end

	--If the character is outside the map, jump to next scene
	if c:GetTransform().x > 8200 or c:GetTransform().x < 0 or c:GetTransform().y > 128 or c:GetTransform().y < 0 then
			e:Message("Map", "InterMissionTwo.json")
	end
end

display = function(e)
end