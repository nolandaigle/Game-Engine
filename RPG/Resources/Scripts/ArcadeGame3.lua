timer =  0
conversation = 0

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )

	e:AddComponent("ScreenComponent")
	e:GetScreen():Reset()
	e:GetScreen():Zoom(.5)

	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Game.save")
	enterWarp = file:GetVariable("Warp")

	if enterWarp == "1" then
		e:Message("1", "Create" )
	elseif enterWarp == "2" then
		e:Message("2", "Create" )
	elseif enterWarp == "3" then
		e:Message("3", "Create" )
	end

	e:Message("Music", "Stop")
	e:Message("Music", "Resources/Music/Angels 15.wav")
	e:Message("Music", "Play")

	e:AddComponent("FileComponent")
	file = e:GetFC()
	file:OpenFile("Quest.save")


	creator = file:GetVariable("Creator")

end

update = function(e)
	if creator == "returned" then
		timer = timer + e:GetDeltaTime()
	end

	if timer > 20 then
		e:Message("Music", "Stop")
		file:OpenFile("Game.save")
		file:SetVariable("Warp", "2")
		file:WriteFile()
		e:Message("Map", "DadsHouse2.json")
	end
end

display = function(e)
end

onKeyPress = function(e,k)
end