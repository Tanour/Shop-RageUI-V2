
---------- Tanour ----------


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)      
		Citizen.Wait(5000)
	end
end)


--- MENU ---

local open = false 
local MainMenu = RageUI.CreateMenu('Shop', 'interaction') 
local subMenu = RageUI.CreateSubMenu(MainMenu, "Shop", "interaction")
local subMenu2 = RageUI.CreateSubMenu(MainMenu, "Shop", "interaction")
local subMenu3 = RageUI.CreateSubMenu(MainMenu, "Shop", "interaction")
MainMenu.Display.Header = true 
MainMenu.Closed = function()
  open = false
end

--- FUNCTION OPENMENU ---

function shopTanour()
	if open then 
		open = false
		RageUI.Visible(MainMenu, false)
		return
	else
		open = true 
		RageUI.Visible(MainMenu, true)
		CreateThread(function()
		while open do 
		   RageUI.IsVisible(MainMenu,function() 


			RageUI.Button("Nourritures", nil, {RightLabel = "→→"}, true , {
				onSelected = function() 
        end

		}, subMenu)

			RageUI.Button("Boissons", nil, {RightLabel = "→→"}, true , { 
				onSelected = function() 
				end
			}, subMenu2) 

        RageUI.Button("Divers", nil, {RightLabel = "→→"}, true , { 
            onSelected = function() 
            end
        }, subMenu3) 



    end) 

       

			RageUI.IsVisible(subMenu,function()

                RageUI.Separator("↓ Liste des Nourritures ↓")

                for k, v in pairs(Config.Categories.Nourriture) do 
               RageUI.Button(v.label, nil, {RightLabel = "~g~"..ESX.Math.GroupDigits(v.price).."$"}, true , {
					onSelected = function()
					   TriggerServerEvent('shoptanour:BuyPain',v.name, v.label, v.price)
                    end,
				})
            end
   
        end)
        
        RageUI.IsVisible(subMenu2,function()
            RageUI.Separator("↓ Liste des Boissons ↓")

            for k, v in pairs(Config.Categories.Boissons) do 
                RageUI.Button(v.label, nil, {RightLabel = "~g~"..ESX.Math.GroupDigits(v.price).."$"}, true , {
                     onSelected = function()
                        TriggerServerEvent('shoptanour:BuyPain',v.name, v.label, v.price)
	
                    end,
				})
            end	
        end)

        RageUI.IsVisible(subMenu3,function()

            RageUI.Separator("↓ Liste des Objets Divers ↓")

            for k, v in pairs(Config.Categories.Divers) do 
           RageUI.Button(v.label, nil, {RightLabel = "~g~"..ESX.Math.GroupDigits(v.price).."$"}, true , {
                onSelected = function()
                   TriggerServerEvent('shoptanour:BuyPain',v.name, v.label, v.price)
                end,
            })
        end
    end)

		Wait(5)
	end
 end)
end
end 




---- Position Menu ----
Citizen.CreateThread(function()  
    while Config == nil do 
        Wait(5000)
    end 
    for k, v in pairs(Config.Shops) do 
        -- Blips
        local blips = AddBlipForCoord(v.pos)
        SetBlipSprite(blips, 59)
        SetBlipColour(blips, 2)
        SetBlipScale(blips, 0.8)
        SetBlipDisplay(blips, 4)
        SetBlipAsShortRange(blips, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Boutique")
        EndTextCommandSetBlipName(blips)
    while true do 
        local myCoords = GetEntityCoords(PlayerPedId())
        local nofps = false

        if not openedMenu then 
            for k, v in pairs(Config.Shops) do 
                if #(myCoords - v.pos) < 1.0 then 
                    nofps = true
                    Visual.Subtitle("Appuyer sur ~b~[E]~s~ pour parler au ~b~vendeur", 1) 
                    if IsControlJustPressed(0, 38) then 
                        lastPos = GetEntityCoords(PlayerPedId())                 
                        shopTanour()
                    end 
                elseif #(myCoords - v.pos) < 5.0 then 
                    nofps = true 
                    DrawMarker(22, v.pos, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 0, 0 , 255, true, true, p19, true)     
                end 
            end 
        end
        if nofps then 
            Wait(1)
        else 
            Wait(1500)
        end 
    end
end)

---------- Tanour ----------
