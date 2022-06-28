function LoadModel(hash)
    if IsModelValid(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end
        return true
    else

        return false
    end
end

function LoadTexture(hash)
    if not HasStreamedTextureDictLoaded(texture) then
        RequestStreamedTextureDict(hash, true)
        while not HasStreamedTextureDictLoaded(hash) do
            Wait(1)
        end
        return true
    else
        return false
    end
end


function bigInt(text)
    local string1 = DataView.ArrayBuffer(16)
    string1:SetInt64(0, text)
    return string1:GetInt64(0)
end

local lastSoundSetName = ""
local lastSoundSetRef = ""

function PlayFrontendSound(frontend_soundset_ref, frontend_soundset_name, forcePlay)
    if forcePlay and lastSoundSetName ~= 0 then
        PlaySoundFrontend(lastSoundSetName, lastSoundSetRef) -- stop audio
    end

    if frontend_soundset_ref ~= 0 then
        Citizen.InvokeNative(0x0F2A2175734926D8, frontend_soundset_name, frontend_soundset_ref) -- load sound frontend
    end
    PlaySoundFrontend(frontend_soundset_name, frontend_soundset_ref, true, 0) -- play sound frontend

    lastSoundSetName = frontend_soundset_name
    lastSoundSetRef = frontend_soundset_ref
end

function DrawText(text, font, x, y, fontscale, fontsize, r, g, b, alpha, textcentred, shadow)
    local str = CreateVarString(10, "LITERAL_STRING", text)
    SetTextScale(fontscale, fontsize)
    SetTextColor(r, g, b, alpha)
    SetTextCentre(textcentred)
    if shadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    SetTextFontForCurrentCommand(font)
    DisplayText(str, x, y)
end

function TeleportToCoords(x, y, z, heading)
    local playerPedId = PlayerPedId()
    SetEntityCoords(playerPedId, x, y, z, true, true, true, false)
    if heading ~= nil then SetEntityHeading(playerPedId, heading) end
end
