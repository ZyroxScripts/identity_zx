# Identity Script for FiveM

Player identity script for ESX and QB-Core frameworks.

## Features
- Multi-framework support (ESX/QB-Core)
- Configurable display options
- Multi-language support (cs, de, fr, en, es)
- Discord webhook integration
- ox_lib notifications

## Installation
1. Place in `resources` folder
2. Add `ensure identity_zx` to `server.cfg`
3. Configure `config.lua`

## Dependencies
- ox_lib
- ESX or QB-Core

## Configuration
```lua
Config.Framework = 'esx' -- or 'qb'
Config.Locale = 'cs'
Config.ShowInfo = {
    name = true,
    dateOfBirth = true,
    playerId = true,
    job = true,
    bankMoney = true,
    -- ... more options
}
```

## Usage
Use `/id` command to display character information.

## Languages
Czech, English, German, French, Spanish
