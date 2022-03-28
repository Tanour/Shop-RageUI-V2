ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("shoptanour:BuyPain")
AddEventHandler("shoptanour:BuyPain", function(name, label, price) 
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= price then
	    xPlayer.removeMoney(price)
    	xPlayer.addInventoryItem(name, 1) 
        TriggerClientEvent('esx:showNotification', source, "Vous avez bien acheté ~b~1x "..label.."~s~ pour ~g~"..price.."$~s~ !")
     else 
        TriggerClientEvent('esx:showNotification', source, "Pas assez ~r~d'argent sur vous")    
    end
end)
