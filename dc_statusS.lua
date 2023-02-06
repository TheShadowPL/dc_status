ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

jobs_count = {
    ems = 0,
    lspd = 0,
    mecano = 0
}
playercount = 0

Citizen.CreateThread(function()
    while true do
        Wait(30000)
        jobs_count = {
            ems = 0,
            lspd = 0,
            mecano = 0
        }
        playercount = 0
        for i, playerid in pairs(ESX.GetPlayers()) do
            playercount = playercount + 1
            local xPlayer = ESX.GetPlayerFromId(playerid)
            if xPlayer ~= nil then
                local job = xPlayer.getJob().name
                if job == 'mecano' or job == 'mechanic' then jobs_count.mecano = jobs_count.mecano + 1 end
                if job == 'ambulance' or job == 'fire' then jobs_count.ems = jobs_count.ems + 1 end
                if job == 'police' then jobs_count.lspd = jobs_count.lspd + 1 end
            end
        end
    end
end)

ESX.RegisterServerCallback('dc_status:getJobs', function(argument, cb)
    local data = {
        jobs = jobs_count,
        players = playercount
    }
    cb(data)
end)