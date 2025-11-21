Config = {}

-- Framework Settings
Config.Framework = 'esx' -- 'esx' or 'qb'

-- Language Settings
Config.Locale = 'en' -- Available: cs, de, fr, en, es

-- Display Settings
Config.ShowInfo = {
    name = true,           -- Show character name
    dateOfBirth = true,    -- Show date of birth
    playerId = true,       -- Show player ID
    job = true,            -- Show current job
    bankMoney = true,      -- Show bank money
    cashMoney = true,      -- Show cash money
    phoneNumber = true,    -- Show phone number
    citizenId = true,      -- Show citizen ID (QB only)
    gang = true,           -- Show gang (QB only)
    stress = true,         -- Show stress level (QB only)
    hunger = true,         -- Show hunger level
    thirst = true          -- Show thirst level
}

-- Webhook Settings
Config.Webhook = {
    enabled = true,
    url = '', -- Your Discord webhook URL
    botName = 'Identity Script',
    color = 3447003, -- Blue color
    title = 'Player ID Command Used'
}

-- Command Settings
Config.Command = 'id'

-- Notification Settings
Config.Notification = {
    position = 'top-right', -- ox_lib notification position
    duration = 8000,        -- Duration in milliseconds
    type = 'info'          -- Notification type
}
