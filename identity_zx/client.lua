local CurrentLocale = {}

-- Load localization
Citizen.CreateThread(function()
    Wait(100) -- Wait for locales to load
    if Locales and Locales[Config.Locale] then
        CurrentLocale = Locales[Config.Locale]
    elseif Locales and Locales['en'] then
        CurrentLocale = Locales['en'] -- Fallback to English
    else
        print('[Identity Script] Error: No localization found!')
    end
end)

-- Function to get localized text
function _U(str, ...)
    if CurrentLocale[str] then
        return string.format(CurrentLocale[str], ...)
    else
        return 'Translation [' .. str .. '] does not exist'
    end
end

-- Function to format money
local function formatMoney(amount)
    if not amount then return '0 $' end
    local formatted = tostring(amount):reverse():gsub("(%d%d%d)", "%1,"):reverse()
    if formatted:sub(1, 1) == "," then
        formatted = formatted:sub(2)
    end
    return formatted .. ' $'
end

-- Function to format percentage
local function formatPercentage(value)
    if not value then return '0%' end
    return math.floor(value) .. '%'
end

-- Register the /id command
RegisterCommand(Config.Command, function(source, args, rawCommand)
    TriggerServerEvent('identity:getPlayerInfo')
end, false)

-- Handle player info response
RegisterNetEvent('identity:showPlayerInfo', function(playerData)
    if not playerData then 
        print('[Identity Script] Error: No player data received')
        return 
    end
    
    local infoLines = {}
    
    -- Build information lines based on config
    if Config.ShowInfo.name then
        local name = playerData.name or _U('unknown')
        table.insert(infoLines, _U('character_name') .. ': ' .. name)
    end
    
    if Config.ShowInfo.dateOfBirth then
        local dob = playerData.dateOfBirth or _U('unknown')
        table.insert(infoLines, _U('date_of_birth') .. ': ' .. dob)
    end
    
    if Config.ShowInfo.playerId then
        local pid = playerData.playerId or _U('unknown')
        table.insert(infoLines, _U('player_id') .. ': ' .. pid)
    end
    
    if Config.ShowInfo.job then
        if playerData.job then
            local jobText = playerData.job.label or playerData.job.name or _U('unemployed')
            if playerData.job.grade_label or playerData.job.grade then
                jobText = jobText .. ' - ' .. (playerData.job.grade_label or ('Grade ' .. playerData.job.grade))
            end
            table.insert(infoLines, _U('current_job') .. ': ' .. jobText)
        else
            table.insert(infoLines, _U('current_job') .. ': ' .. _U('unemployed'))
        end
    end
    
    if Config.ShowInfo.bankMoney then
        local bank = playerData.bankMoney or 0
        table.insert(infoLines, _U('bank_money') .. ': ' .. formatMoney(bank))
    end
    
    if Config.ShowInfo.cashMoney then
        local cash = playerData.cashMoney or 0
        table.insert(infoLines, _U('cash_money') .. ': ' .. formatMoney(cash))
    end
    
    if Config.ShowInfo.phoneNumber then
        local phone = playerData.phoneNumber or _U('unknown')
        table.insert(infoLines, _U('phone_number') .. ': ' .. phone)
    end
    
    if Config.ShowInfo.citizenId and playerData.citizenId then
        table.insert(infoLines, _U('citizen_id') .. ': ' .. playerData.citizenId)
    end
    
    if Config.ShowInfo.gang and playerData.gang then
        local gangText = playerData.gang.label or playerData.gang.name or _U('no_gang')
        if playerData.gang.grade and playerData.gang.grade.name then
            gangText = gangText .. ' - ' .. playerData.gang.grade.name
        end
        table.insert(infoLines, _U('gang') .. ': ' .. gangText)
    end
    
    if Config.ShowInfo.stress then
        local stress = playerData.stress or 0
        table.insert(infoLines, _U('stress_level') .. ': ' .. formatPercentage(stress))
    end
    
    if Config.ShowInfo.hunger then
        local hunger = playerData.hunger or 0
        table.insert(infoLines, _U('hunger_level') .. ': ' .. formatPercentage(hunger))
    end
    
    if Config.ShowInfo.thirst then
        local thirst = playerData.thirst or 0
        table.insert(infoLines, _U('thirst_level') .. ': ' .. formatPercentage(thirst))
    end
    
    -- Show each information as separate notification
    if #infoLines > 0 then
        -- Show each info line as separate notification with delay
        for i, line in ipairs(infoLines) do
            SetTimeout(i * 200, function() -- 200ms delay between notifications
                lib.notify({
                    id = 'player_identity_' .. i,
                    title = '',
                    description = line,
                    type = Config.Notification.type,
                    position = Config.Notification.position,
                    duration = Config.Notification.duration
                })
            end)
        end
    else
        print('[Identity Script] Error: No info lines to display')
    end
end)
