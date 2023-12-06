local _G, select, setmetatable                        = _G, select, setmetatable

local TMW                                             = _G.TMW 

local A                                             = _G.Action

local CONST                                            = A.Const
local toNum                                         = A.toNum
local Print                                            = A.Print
local GetSpellInfo                                    = A.GetSpellInfo
local GetToggle                                        = A.GetToggle
local GetLatency                                    = A.GetLatency
local InterruptIsValid                                = A.InterruptIsValid
local Unit                                            = A.Unit 

local ACTION_CONST_WARRIOR_FURY                        = CONST.WARRIOR_FURY
local ACTION_CONST_WARRIOR_ARMS                         = CONST.WARRIOR_ARMS
local ACTION_CONST_WARRIOR_PROTECTION                     = CONST.WARRIOR_PROTECTION

local S                                                = {
    FireElemental                                        = (GetSpellInfo(198067)),
    EarthElemental                                        = (GetSpellInfo(198103)),
    FeralSpirits                                        = (GetSpellInfo(51533)),
    Ascendance                                        = (GetSpellInfo(114051)),
    Bloodlust                                        = (GetSpellInfo(2825)),
    VictoryRush                                        = (GetSpellInfo(34428)),
    EnragedRegeneration                                        = (GetSpellInfo(184364)),
    IgnorePain                                        = (GetSpellInfo(190456)),
    SlowTotem                                        = (GetSpellInfo(2484)),
    AstralShift                                        = (GetSpellInfo(108271)),
    Stormkeeper                                        = (GetSpellInfo(191634)),
}

local L                                             = {}
L.AUTO                                                = {
    enUS = "Auto",
    ruRU = "Авто ",
}
L.OFF                                                = {
    enUS = "Off",
    ruRU = "Выкл.",
}
L.PVP                                                 = {
    ANY = "PvP",
}
L.MOUSEOVER                                            = {
    enUS = "Use\n@mouseover", 
    ruRU = "Использовать\n@mouseover", 
}
L.MOUSEOVERTT                                        = {
    enUS = "Will unlock use actions for @mouseover units\nExample: Resuscitate, Healing\n\nRight click: Create macro", 
    ruRU = "Разблокирует использование действий для @mouseover юнитов\nНапример: Воскрешение, Хилинг\n\nПравая кнопка мышки: Создать макрос", 
}
L.AOE                                                = {
    enUS = "Use\nAoE", 
    ruRU = "Использовать\nAoE", 
}
L.AOETT                                                = {
    enUS = "Enable multiunits rotation\n\nRight click: Create macro", 
    ruRU = "Включает ротацию для нескольких целей\n\nПравая кнопка мышки: Создать макрос", 
}
L.CDS                                            = {
    enUS = "Cooldowns",
    ruRU = "Своя Оборона",
}
L.Totems                                            = {
    enUS = "Totems",
}
L.selfDefence                                            = {
    enUS = "Self Defence",
}
L.stackManagement                                            = {
    enUS = "stack Management",
}
L.ROTATION                                            = {
    enUS = "Rotation",
    ruRU = "Ротация",
}
L.CATCHINVISIBLE                                    = {
    enUS = "Catch Invisible (arena)",
    ruRU = "Поймать Невидимок (арена)",
}
L.CATCHINVISIBLETT                                    = {
    enUS = "Cast when combat around has been begin and enemy team still has unit in invisible\nDoesn't work if you're mounted or in combat!\n\nRight click: Create macro",
    ruRU = "Применять когда бой поблизости начат и команда противника до сих пор имеет юнита в невидимости\nНе работает, когда вы на транспорте или в бою!\n\nПравая кнопка мышки: Создать макрос",
}
L.IgnorePain                                        = {
    enUS = S.IgnorePain .. "\nHealth Percent (Self)",
    ruRU = S.IgnorePain .. "\nЗдоровье Процент (Свое)",
}
L.VictoryRush = {
    enUS = S.VictoryRush .. "\nHealth Percent (Self)",
    ruRU = S.VictoryRush .. "\nЗдоровье Процент (Свое)",
}
L.EnragedRegeneration = {
    enUS = S.EnragedRegeneration .. "\nHealth Percent (Self)",
    ruRU = S.EnragedRegeneration .. "\nЗдоровье Процент (Свое)",
}
L.AstralShift = {
    enUS = S.AstralShift .. "\nHealth Percent (Self)",
    ruRU = S.AstralShift .. "\nЗдоровье Процент (Свое)",
}
L.TRINKETDEFENSIVE                                    = {
    enUS = "Protection Trinkets\nHealth Percent (Self)",
    ruRU = "Аксессуары Защиты\nЗдоровье Процент (Свое)",
}
L.EarthElemental                                            = {
    enUS = S.EarthElemental .. "\nUse on bosses only\n",
}
L.FireElemental                                            = {
    enUS = S.FireElemental .. "\nUse on bosses only\n",
}
L.Stormkeeper                                            = {
    enUS = S.Stormkeeper .. "\nUse on bosses only\n",
}
L.FeralSpirits                                            = {
    enUS = S.FeralSpirits .. "\nUse on bosses only\n",
}
L.Bloodlust                                            = {
    enUS = S.Bloodlust .. "\nUse on bosses only\n",
}

local SliderMarginOptions = { margin = { top = 10 } }
local LayoutConfigOptions = { gutter = 4, padding = { left = 5, right = 5 } }
A.Data.ProfileEnabled[A.CurrentProfile]             = true
A.Data.ProfileUI                                     = {    
    DateTime = "v2.00 (20.2.2021)",
    [2] = {
        [ACTION_CONST_WARRIOR_FURY] = {             
            LayoutOptions = LayoutConfigOptions,
            {
                {
                    E                 = "Checkbox", 
                    DB                 = "mouseover",
                    DBV             = true,
                    L                 = L.MOUSEOVER, 
                    TT                 = L.MOUSEOVERTT, 
                    M                 = {},
                },
                {
                    E                 = "Checkbox", 
                    DB                 = "AoE",
                    DBV             = true,
                    L                 = L.AOE,
                    TT                 = L.AOETT,
                    M                 = {},
                },
            },
            { -- [2] Self Defensives 
                {
                    E                 = "Header",
                    L                 = L.selfDefence,
                },
            },
            {
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "VictoryRush",
                    DBV             = 80,
                    ONOFF             = true,
                    L                 = L.VictoryRush,                
                    M                 = {},
                },
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "EnragedRegeneration",
                    DBV             = 30,
                    ONOFF             = true,
                    L                 = L.EnragedRegeneration,                
                    M                 = {},
                },
            },
            {
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "IgnorePain",
                    DBV             = 60,
                    ONOFF             = true,
                    L                 = L.IgnorePain,                
                    M                 = {},
                },
            },
        },
        
        [ACTION_CONST_WARRIOR_ARMS] = {             
            LayoutOptions = LayoutConfigOptions,
            {
                {
                    E                 = "Checkbox", 
                    DB                 = "mouseover",
                    DBV             = true,
                    L                 = L.MOUSEOVER, 
                    TT                 = L.MOUSEOVERTT, 
                    M                 = {},
                },
                {
                    E                 = "Checkbox", 
                    DB                 = "AoE",
                    DBV             = true,
                    L                 = L.AOE,
                    TT                 = L.AOETT,
                    M                 = {},
                },
            },
            { -- [2] Self Defensives 
                {
                    E                 = "Header",
                    L                 = L.selfDefence,
                },
            },
            {
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "VictoryRush",
                    DBV             = 80,
                    ONOFF             = true,
                    L                 = L.VictoryRush,                
                    M                 = {},
                },
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "IgnorePain",
                    DBV             = 60,
                    ONOFF             = true,
                    L                 = L.IgnorePain,                
                    M                 = {},
                },
            },
        },
        [ACTION_CONST_WARRIOR_PROTECTION] = {             
            LayoutOptions = LayoutConfigOptions,
            {
                { -- Mouseover
                    E = "Checkbox", 
                    DB = "mouseover",
                    DBV = true,
                    L = { 
                        enUS = "Use @mouseover", 
                        ruRU = "Использовать @mouseover", 
                        frFR = "Utiliser les fonctions @mouseover",
                    }, 
                    TT = { 
                        enUS = "Will unlock use actions for @mouseover units\nExample: Resuscitate, Healing", 
                        ruRU = "Разблокирует использование действий для @mouseover юнитов\nНапример: Воскрешение, Хилинг", 
                        frFR = "Activera les actions via @mouseover\n Exemple: Ressusciter, Soigner",
                    }, 
                    M = {},
                },
                { -- AoE
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        enUS = "Use AoE", 
                        ruRU = "Использовать AoE", 
                        frFR = "Utiliser l'AoE",
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                        ruRU = "Включает действия для нескольких целей", 
                        frFR = "Activer les actions multi-unités",
                    }, 
                    M = {
                        Custom = "/run Action.AoEToggleMode()",
                        -- It does call func CraftMacro(L[CL], macro above, 1) -- 1 means perCharacter tab in MacroUI, if nil then will be used allCharacters tab in MacroUI
                        Value = value or nil, 
                        -- Very Very Optional, no idea why it will be need however.. 
                        TabN = '@number' or nil,                                
                        Print = '@string' or nil,
                    },
                },
                { -- Shield Block
                    E = "Checkbox", 
                    DB = "ShieldBlockDPS",
                    DBV = true,
                    L = { 
                        ANY = "Use ShieldBlock for DPS", 
                    }, 
                    TT = { 
                        ANY = "If enabled: Will use Shield Block to buff Shield Slam for DPS", 
                    }, 
                    M = {},
                },
            },
            { -- [1] Row 2
                {
                    E = "Checkbox", 
                    DB = "SnSInterruptList",
                    DBV = true,
                    L = { 
                        enUS = "Use Shadowlands Mythic+ & Raid\nsmart interrupt list", 
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will force a special interrupt list containing all the Shadowlands Mythic+ and Raid stuff WHEN YOU ARE IN MYTHIC+ OR RAID ZONE.\nYou can edit this list in the Interrupts tab\nand customize it as you want",
                    }, 
                    M = {},
                },                    
                {
                    E                 = "Checkbox", 
                    DB                 = "StormBoltInterrupt",
                    DBV             = true,
                    L = {
                        ANY = "StormBolt Interrupt",
                    },
                    TT = { 
                        ANY = "If Enabled : Will use StormBolt to Interrupt",
                    },
                    M                 = {},
                },
                {
                    E                 = "Checkbox", 
                    DB                 = "ShockwaveInterrupt",
                    DBV             = true,
                    L = {
                        ANY = "Shockwave Interrupt",
                    },
                    TT = { 
                        ANY = "If Enabled : Will use Shockwave to Interrupt",
                    },
                    M                 = {},
                },
            },
            { -- [2]
                {
                    E = "Header",
                    L = {
                        enUS = " -- Defensives -- ",
                    },
                },
            },
            { -- [2] 
                {  
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "ShieldBlockHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = GetSpellInfo(2565) .. " (%)",
                    }, 
                    M = {},
                },
            },
            {
                {
                    E = "Checkbox", 
                    DB = "LastStandCatchKillStrike",
                    DBV = true,
                    L = { 
                        ANY = GetSpellInfo(12975) .. " Catch Kill Strike", 
                    }, 
                    TT = { 
                        ANY = "If Enabled : Will attempt to catch a kill strike with Last Stand",
                    }, 
                    M = {},
                },
            },
            { -- [2] 
                {  
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "LastStandHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = GetSpellInfo(12975) .. " (%)",
                    }, 
                    M = {},
                },
                {  
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "LastStandTTD",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = GetSpellInfo(12975) .. " TTD",
                    }, 
                    M = {},
                },
            },
            {
                {
                    E = "Checkbox", 
                    DB = "ShieldWallCatchKillStrike",
                    DBV = true,
                    L = { 
                        ANY = GetSpellInfo(871) .. " Catch Kill Strike", 
                    }, 
                    TT = { 
                        ANY = "If Enabled : Will attempt to catch a kill strike with Shield Wall",
                    }, 
                    M = {},
                },
            },
            { -- [2] 
                {  
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "ShieldWallHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = GetSpellInfo(871) .. " (%)",
                    }, 
                    M = {},
                },
                {  
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "ShieldWallTTD",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = GetSpellInfo(871) .. " TTD",
                    }, 
                    M = {},
                },
            },
            { -- [2]     
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "SpiritualHealingPotion",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Spiritual Healing Potion (%)",
                    }, 
                    M = {},
                }, 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "RallyingCryHP",
                    DBV = 100, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = GetSpellInfo(97462) .. " (%)",
                    }, 
                    M = {},
                },
            },
        },
    },
}
-----------------------------------------
--                   PvP  
-----------------------------------------
local DisarmPvPunits     = setmetatable({}, { __index = function(t, v)
            t[v] = GetToggle(2, "DisarmPvPunits")
            return t[v]
end})
local ImunBuffsCC              = {"CCTotalImun", "DamagePhysImun", "TotalImun"}
local ImunBuffsInterrupt     = {"KickImun", "TotalImun", "DamagePhysImun"}

function A.DisarmIsReady(unitID, skipShouldStop, isMsg)
    if A.IsInPvP then 
        local isArena = unitID:match("arena")
        if     (
            (unitID == "arena1" and DisarmPvPunits[A.PlayerSpec][1]) or 
            (unitID == "arena2" and DisarmPvPunits[A.PlayerSpec][2]) or
            (unitID == "arena3" and DisarmPvPunits[A.PlayerSpec][3]) or
            (not isArena and DisarmPvPunits[A.PlayerSpec][4]) 
        ) 
        then 
            if (not isArena and Unit(unitID):IsEnemy() and Unit(unitID):IsPlayer()) or (isArena and not Unit(unitID):InLOS() and (A.Zone == "arena" or A.Zone == "pvp")) then 
                local Disarm = A[A.PlayerSpec].Disarm
                if  Disarm and 
                (
                    (
                        not isMsg and GetToggle(2, "DisarmPvP") ~= "OFF" and ((not isArena and Disarm:IsReady(unitID, nil, nil, skipShouldStop)) or (isArena and Disarm:IsReadyByPassCastGCD(unitID))) and                                 
                        Unit(unitID):IsMelee() and (GetToggle(2, "DisarmPvP") == "ON COOLDOWN" or Unit(unitID):HasBuffs("DamageBuffs") > 8)
                    ) or 
                    (
                        isMsg and Disarm:IsReadyM(unitID)
                    )
                ) and 
                Disarm:AbsentImun(unitID, ImunBuffsCC, true) and 
                Unit(unitID):IsControlAble("disarm") and 
                Unit(unitID):InCC() == 0 and 
                Unit(unitID):HasDeBuffs("Disarmed") == 0
                then 
                    return true 
                end 
            end 
        end 
    end 
end

function A:CanInterruptPassive(unitID, countGCD)
    if A.IsInPvP and (A.Zone == "arena" or A.Zone == "pvp") then         
        if self.isPummel then 
            local useKick, _, _, notInterruptable = InterruptIsValid(unitID, "Heal", nil, countGCD)
            if not useKick then 
                useKick, _, _, notInterruptable = InterruptIsValid(unitID, "PvP", nil, countGCD)
            end 
            if useKick and not notInterruptable and self:IsReadyByPassCastGCD(unitID) and self:AbsentImun(unitID, ImunBuffsInterrupt, true) then 
                return true 
            end 
        end 
        
        if self.isStormBolt then 
            local StormBoltPvP = GetToggle(2, "StormBoltPvP")
            if StormBoltPvP and StormBoltPvP ~= "OFF" and self:IsReadyByPassCastGCD(unitID) then 
                local _, useCC, castRemainsTime 
                if Toggle == "BOTH" then 
                    useCC, _, _, castRemainsTime = select(2, InterruptIsValid(unitID, "Heal", nil, countGCD))
                    if not useCC then 
                        useCC, _, _, castRemainsTime = select(2, InterruptIsValid(unitID, "PvP", nil, countGCD))
                    end 
                else 
                    useCC, _, _, castRemainsTime = select(2, InterruptIsValid(unitID, Toggle, nil, countGCD))
                end 
                if useCC and castRemainsTime >= GetLatency() and Unit(unitID):IsControlAble("stun") and not Unit(unitID):InLOS() and self:AbsentImun(unitID, ImunBuffsCC, true) then 
                    return true 
                end 
            end 
        end                     
    end 
end

