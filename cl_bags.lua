print("bags loaded")
local ped, vehicle

-- config
local adjustrate = 1 -- time to adjust in ms
local bagrate = 0.008 -- higher value = faster height change
local bagspl = 83 -- bags plus key
local bagsms = 84 -- bags minus key

Citizen.CreateThread( function()
	while true do
		Wait(1)
		ped = PlayerPedId()

		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped, false)
			if (GetPedInVehicleSeat(vehicle, -1) == ped) then  
               if IsControlPressed(0, bagspl) then -- bags plus
                    -- print("plus")
                    Wait(adjustrate)
                    local curllimit = GetVehicleSuspensionHeight(vehicle) --GetVehicleHandlingFloat(vehicle, "CHandlingData", "fSuspensionRaise")
                    -- SetVehicleHandlingVector(vehicle, "CHandlingData", 'fSuspensionRaise', curllimit + 0.05)
                    if curllimit < -0.2 then
                         --print("bag limit reached")
                    else
                         SetVehicleSuspensionHeight(vehicle, curllimit - bagrate)
                         Wait(adjustrate)
                         -- print(curllimit)
                    end
               elseif IsControlPressed(0, bagsms) then -- bags minus
                    --print('minus')
                    Wait(adjustrate)
                    local curllimit = GetVehicleSuspensionHeight(vehicle) --GetVehicleHandlingFloat(vehicle, "CHandlingData", "fSuspensionRaise")
                    if curllimit > 0.2 then
                         --print("bag limit reached")
                    else
                    -- SetVehicleHandlingVector(vehicle, "CHandlingData", 'fSuspensionRaise', curllimit - 0.05)
                    SetVehicleSuspensionHeight(vehicle, curllimit + bagrate)
                    Wait(adjustrate)
                    -- print(curllimit)
                    end
            end
            end
		end

          if IsPedInAnyVehicle(ped, false) then
               if GetIsTaskActive(ped,2) then
				voertuig = GetVehiclePedIsUsing(ped)
				angle = GetVehicleSteeringAngle(voertuig)
				Citizen.Wait(100)
				SetVehicleSteeringAngle(voertuig, angle)
			end
          end
	end
end)