RegisterNetEvent("RedEM:client:PlaySound")
AddEventHandler("RedEM:client:PlaySound", function(sound)
    if sound == 1 then
        PlaySoundFrontend("MONEY", "HUD_DOMINOS_SOUNDSET", 1)
    elseif sound == 2 then
        PlaySoundFrontend("UNAFFORDABLE", "Ledger_Sounds", 1)
    elseif sound == 3 then
        PlaySoundFrontend("MAIL", "HUD_MAIL_SOUNDSET", 1)
    elseif sound == 4 then
        PlaySoundFrontend("Witness_Wanted", "HUD_Wanted_Sounds", 1)
    end
end)