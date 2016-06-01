bang = function(e)


	e:AddComponent("MapComponent")
	

	e:AddComponent("ScreenComponent")
	e:GetScreen():Reset()
	e:GetScreen():Zoom(.25)
end
