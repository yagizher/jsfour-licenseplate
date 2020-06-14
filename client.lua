local ESX, plate = nil

-- ESX
Citizen.CreateThread(function()
  SetNuiFocus(false, false)

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- Menu
RegisterNetEvent('jsfour-licenseplate')
AddEventHandler('jsfour-licenseplate', function()
  ESX.UI.Menu.CloseAll()
  ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'licenseplate_menu',
	{
		title    = 'Licenseplate menu',
    		align    = 'bottom-right',
		elements = {
			{label = 'Numarayı değiştir', value = 'change'},
			{label = 'Arabaya uygula', value = 'apply'},
		}
	},
	function(data, menu)
		local val = data.current.value

		if val == 'change' then
      SetNuiFocus(true, true)
      SendNUIMessage({
        action = "open"
      })
    else
      if plate ~= nil then
        local vehicle, distance = ESX.Game.GetClosestVehicle(coords)

        if distance ~= -1 and distance <= 3.0 then
          local oldplate = GetVehicleNumberPlateText(vehicle)

          ESX.TriggerServerCallback('jsfour-licenseplate:update', function( cb )
            if cb == 'found' then
              ESX.UI.Menu.CloseAll()
              SetVehicleNumberPlateText(vehicle, plate)
              plate = nil
            elseif cb == 'error' then
              ESX.ShowNotification('Plakayı yerleştiremedin.')
            end
          end, oldplate, plate)
        else
          ESX.ShowNotification('Yakında araç yok.')
        end
      else
        ESX.ShowNotification('Boş plakayı yerleştiremezsin.')
      end
		end
	end,
	function(data, menu)
		menu.close()
	end
)
end)

-- NUI Callback - close
RegisterNUICallback('escape', function(data, cb)
  	plate = data.number
	SetNuiFocus(false, false)
end)
