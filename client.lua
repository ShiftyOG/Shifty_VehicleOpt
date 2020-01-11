local windowFront = 1
local windowRear = 1

-- Commands
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
--
		if NetworkIsSessionStarted() then
			TriggerEvent("chat:addSuggestion", "/extra", "/extra Extra#:all true:false")
			TriggerEvent("chat:addSuggestion", "/livery", "/livery livery#")
      			TriggerEvent("chat:addSuggestion", "/engine", "/engine (Toggles Engine)")
			TriggerEvent("chat:addSuggestion", "/trunk", "/trunk (Toggles Trunk)")
			TriggerEvent("chat:addSuggestion", "/hood", "/hood (Toggles hood)")
			TriggerEvent("chat:addSuggestion", "/fwindow", "/fwindow (Toggles Front Windows)")
			TriggerEvent("chat:addSuggestion", "/rwindow", "/rwindow (Toggles Rear Windows)")
			return
		end
	end
end)

RegisterCommand('extra', function(source, args)
    local Veh = Citizen.InvokeNative(0x9A9112A0FE9A4713, GetPlayerPed(-1), false)
    local args1 = args[1]
    local args2 = args[2]

    Citizen.InvokeNative(0x5F3A3574, Veh, true)
    if DoesEntityExist(Veh) then
        if ((args1=="all")and(args2=="true")) then
            for i=0,20 do
                if (DoesExtraExist(Veh, i)==1) then
                    Citizen.InvokeNative(0x7EE3A3C5E4A40CC9, Veh, i, false)
                end
            end
        elseif ((args1=="all")and(args2=="false")) then
            for i=0,20 do
                if (DoesExtraExist(Veh, i)==1) then
                    Citizen.InvokeNative(0x7EE3A3C5E4A40CC9, Veh, i, true)
                end
            end
        else
            local extra = tonumber(args1)
            if (DoesExtraExist(Veh, extra)==1) then
                if (Citizen.InvokeNative(0xD2E6822DBFD6C8BD, Veh, extra) == 1) then 
                    Citizen.InvokeNative(0x7EE3A3C5E4A40CC9, Veh, extra, true)
                else
                    Citizen.InvokeNative(0x7EE3A3C5E4A40CC9, Veh, extra, false)
                end
            end
        end
    end
end, false)

RegisterCommand('livery', function(source, args)
    local Veh = Citizen.InvokeNative(0x9A9112A0FE9A4713, GetPlayerPed(-1), false)
    local args1 = tonumber(args[1])

    if DoesEntityExist(Veh) then
        Citizen.InvokeNative(0x60BF608F1B8CD1B6, Veh, args1)
    end
end, false)

RegisterCommand('engine', function(source, args)
    local Veh = Citizen.InvokeNative(0x9A9112A0FE9A4713, GetPlayerPed(-1), false)
    if DoesEntityExist(Veh) then
        Citizen.InvokeNative(0x2497C4717C8B881E, Veh, (not Citizen.InvokeNative(0xAE31E7DF9B5B132E, Veh)), false, true)
    end
end, false)

RegisterCommand('hood', function(source, args)
    local Veh = Citizen.InvokeNative(0x9A9112A0FE9A4713, GetPlayerPed(-1), false)
    local isopen = GetVehicleDoorAngleRatio(Veh,4)
    if (isopen == 0) then
		Citizen.InvokeNative(0x7C65DAC73C35C862, Veh,4,0,0)
	else
		Citizen.InvokeNative(0x93D9BD300D7789E5, Veh,4,0)
	end
end)

RegisterCommand('trunk', function(source, args)
    local Veh = Citizen.InvokeNative(0x9A9112A0FE9A4713, GetPlayerPed(-1), false)
    local isopen = GetVehicleDoorAngleRatio(Veh,5)
    if (isopen == 0) then
		Citizen.InvokeNative(0x7C65DAC73C35C862, Veh,5,0,0)
	else
		Citizen.InvokeNative(0x93D9BD300D7789E5, Veh,5,0)
	end
end)

RegisterCommand('fwindow', function(source, args, rawCommand)
    local playerPed = GetPlayerPed(-1)
    local playerVeh = Citizen.InvokeNative(0x9A9112A0FE9A4713, playerPed, false)
    if ( Citizen.InvokeNative(0x826AA586EDB9FEF8, playerPed ) ) and windowFront == 0 then
      Citizen.InvokeNative(0x602E548F46E24D59, playerVeh, 1)
      Citizen.InvokeNative(0x602E548F46E24D59, playerVeh, 0)
      windowFront = 1
    else
        Citizen.InvokeNative(0x7AD9E6CE657D69E3, playerVeh, 1)
        Citizen.InvokeNative(0x7AD9E6CE657D69E3, playerVeh, 0)
        windowFront = 0
    end
end)

RegisterCommand('rwindow', function(source, args, rawCommand)
    local playerPed = GetPlayerPed(-1)
    local playerVeh = Citizen.InvokeNative(0x9A9112A0FE9A4713, playerPed, false)
    if ( Citizen.InvokeNative(0x826AA586EDB9FEF8, playerPed ) ) and windowRear == 0 then
      Citizen.InvokeNative(0x602E548F46E24D59, playerVeh, 2)
      Citizen.InvokeNative(0x602E548F46E24D59, playerVeh, 3)
      windowRear = 1
    else
        Citizen.InvokeNative(0x7AD9E6CE657D69E3, playerVeh, 2)
        Citizen.InvokeNative(0x7AD9E6CE657D69E3, playerVeh, 3)
        windowRear = 0
    end
end)
