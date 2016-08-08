timer =  0
conversation = 0

bang = function(e)
	e:SetScreenColor( 0, 0, 0 )

	e:AddComponent("TransformComponent")
	e:AddComponent("ScreenComponent")
	e:GetScreen():Reset()
	e:GetTransform():CenterView()
	e:GetScreen():Zoom(.75)

	e:AddComponent("FileComponent")
	file = e:GetFC()

	e:Message("Music", "Stop")
	e:Message("Music", "Resources/Music/Angels 3 (FSTR).wav")
	e:Message("Music", "Play")

end

update = function(e)
end

display = function(e)
end

onKeyPress = function(e,k)
end