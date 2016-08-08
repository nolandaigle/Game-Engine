

bang = function(e)
	e:AddComponent("ScreenComponent")
	e:GetScreen():Reset()
	e:GetScreen():Zoom(.25)
end

update = function(e)
end

display = function(e)
end

onKeyPress = function(e,k)
end

onKeyRelease = function(e,k)
end

recieveSignal = function(e, signal)
	if signal == "Meditated" then
			e:Message("Map", "GODHEAD.json")
	end
end