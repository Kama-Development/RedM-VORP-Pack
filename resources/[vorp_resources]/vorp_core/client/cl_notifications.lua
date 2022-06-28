RegisterNetEvent('vorp:NotifyLeft')
AddEventHandler('vorp:NotifyLeft', function(firsttext, secondtext, dict, icon, duration, color)
    local _dict = dict
    local _icon = icon
    LoadTexture(_dict)

    exports.vorp_core:DisplayLeftNotification(tostring(firsttext), tostring(secondtext), tostring(_dict), tostring(_icon), tonumber(duration), tostring(color))
end)


RegisterNetEvent('vorp:Tip')
AddEventHandler('vorp:Tip', function(text, duration)
    exports.vorp_core:DisplayTip(tostring(text), tonumber(duration))
end)

RegisterNetEvent('vorp:NotifyTop')
AddEventHandler('vorp:NotifyTop', function(text, location, duration)
    exports.vorp_core:DisplayTopCenterNotification(tostring(text), tostring(location), tonumber(duration))
end)

RegisterNetEvent('vorp:TipRight')
AddEventHandler('vorp:TipRight', function(text, duration)
    exports.vorp_core:DisplayRightTip(tostring(text), tonumber(duration))
end)

RegisterNetEvent('vorp:TipBottom')
AddEventHandler('vorp:TipBottom', function(text, duration)
    exports.vorp_core:DisplayObjective(tostring(text), tonumber(duration))
end)

--new
RegisterNetEvent('vorp:ShowTopNotification')
AddEventHandler('vorp:ShowTopNotification', function(tittle, subtitle, duration)
    exports.vorp_core:ShowTopNotification(tostring(tittle), tostring(subtitle), tonumber(duration))
end)
--new
RegisterNetEvent('vorp:ShowAdvancedRightNotification')
AddEventHandler('vorp:ShowAdvancedRightNotification', function(text, dict, icon, text_color, duration)
    local _dict = dict
    local _icon = icon
    if not LoadTexture(_dict) then
        _dict = "generic_textures"
        LoadTexture(_dict)
        _icon = "tick"
    end
    exports.vorp_core:ShowAdvancedRightNotification(tostring(text), tostring(_dict), tostring(_icon), tostring(text_color), tonumber(duration))
end)
--new
RegisterNetEvent('vorp:ShowBasicTopNotification')
AddEventHandler('vorp:ShowBasicTopNotification', function(text, duration)
    exports.vorp_core:ShowBasicTopNotification(tostring(text), tonumber(duration))
end)
--new
RegisterNetEvent('vorp:ShowSimpleCenterText')
AddEventHandler('vorp:ShowSimpleCenterText', function(text, duration)
    exports.vorp_core:ShowSimpleCenterText(tostring(text), tonumber(duration))
end)

--new
RegisterNetEvent('vorp:ShowBottomRight')
AddEventHandler('vorp:ShowBottomRight', function(text, duration)
    exports.vorp_core:showBottomRight(tostring(text), tonumber(duration))
end)

--new

RegisterNetEvent('vorp:failmissioNotifY')
AddEventHandler('vorp:failmissioNotifY', function(title, subtitle, duration)
    exports.vorp_core:failmissioNotifY(tostring(title), tostring(subtitle), tonumber(duration))
end)

--new
RegisterNetEvent('vorp:deadplayerNotifY')
AddEventHandler('vorp:deadplayerNotifY', function(title, audioRef, audioName, duration)
    exports.vorp_core:deadplayerNotifY(tostring(title), tostring(audioRef), tostring(audioName), tonumber(duration))
end)

--new
RegisterNetEvent('vorp:updatemissioNotify')
AddEventHandler('vorp:updatemissioNotify', function(notifid, utitle, umsg, duration)
    exports.vorp_core:updatemissioNotify(notifid, tostring(utitle), tostring(umsg), tonumber(duration))
end)

--new
RegisterNetEvent('vorp:warningNotify')
AddEventHandler('vorp:warningNotify', function(title, msg, audioRef, audioName, duration)
    exports.vorp_core:warningNotify(tostring(title), tostring(msg), tostring(audioRef), tostring(audioName), tonumber(duration))
end)


-------- play a sound -------------
RegisterNetEvent('vorp:PlaySoundFrontEnd')
AddEventHandler('vorp:PlaySoundFrontEnd', function(category, name)
    PlayFrontendSound(category, name)
end)


-- how to use
--
-- TriggerEvent('vorp:NotifyLeft', "first text", "second text", "generic_textures", "tick", 4000, "COLOR_WHITE")
-- TriggerEvent('vorp:Tip', "your text", 4000)
-- TriggerEvent('vorp:NotifyTop', "your text", "TOWN_ARMADILLO", 4000)
-- TriggerEvent('vorp:TipRight', "your text",  4000)
-- TriggerEvent('vorp:TipBottom', "your text", 4000)
-- TriggerEvent('vorp:ShowTopNotification', "your text", "your text", 4000)
-- TriggerEvent('vorp:ShowAdvancedRightNotification', "your text", "generic_textures" , "tick" , "COLOR_PURE_WHITE", 4000)
-- TriggerEvent('vorp:ShowBasicTopNotification', "your text", 4000)
-- TriggerEvent('vorp:ShowSimpleCenterText', "your text", 4000)
-- TriggerEvent('vorp:ShowSimpleCenterText', "your text", 4000)
-- TriggerEvent('vorp:ShowNotification', "your text", 4000)
--TriggerEvent('vorp:ShowBottomRight', "your text", 4000)
--TriggerEvent('vorp:failmissioNotifY', "your text", "msg", 4000)
--TriggerEvent('vorp:deadplayerNotifY', title, audioRef, audioName, duration)
--TriggerEvent('vorp:updatemissioNotify', notifid, "title ", "msg , duration) notifid leave it like that.
--TriggerEvent('vorp:warningNotify', title, msg, audioRef, audioName, duration)
