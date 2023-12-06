local TMW                                            = TMW 
local CNDT                                            = TMW.CNDT
local Env                                            = CNDT.Env

local A                                                = Action
local GetToggle                                        = A.GetToggle
local InterruptIsValid                                = A.InterruptIsValid

local UnitCooldown                                    = A.UnitCooldown
local Unit                                            = A.Unit 
local Player                                        = A.Player 
local Pet                                            = A.Pet
local LoC                                            = A.LossOfControl
local MultiUnits                                    = A.MultiUnits
local EnemyTeam                                        = A.EnemyTeam
local FriendlyTeam                                    = A.FriendlyTeam
local TeamCache                                        = A.TeamCache
local InstanceInfo                                    = A.InstanceInfo
local _G, select, setmetatable                        = _G, select, setmetatable

local TMW                                             = _G.TMW 

local A                                             = _G.Action

local CONST                                            = A.Const
local toNum                                         = A.toNum
local Print                                            = A.Print
local GetSpellInfo                                    = A.GetSpellInfo
local GetLatency                                    = A.GetLatency
local ACTION_CONST_SHAMAN_ENCHANCEMENT                        = CONST.SHAMAN_ENCHANCEMENT
local ACTION_CONST_SHAMAN_ELEMENTAL             = CONST.SHAMAN_ELEMENTAL
local ACTION_CONST_SHAMAN_RESTORATION             = CONST.SHAMAN_RESTORATION

local S                                                = {
    FireElemental                                        = (GetSpellInfo(198067)),
    EarthElemental                                        = (GetSpellInfo(198103)),
    FeralSpirits                                        = (GetSpellInfo(51533)),
    Ascendance                                        = (GetSpellInfo(114051)),
    Bloodlust                                        = (GetSpellInfo(2825)),
    HealingSurge                                        = (GetSpellInfo(8004)),
    HealingTotem                                        = (GetSpellInfo(5394)),
    StunTotem                                        = (GetSpellInfo(192058)),
    SlowTotem                                        = (GetSpellInfo(2484)),
    AstralShift                                        = (GetSpellInfo(108271)),
    Stormkeeper                                        = (GetSpellInfo(191634)),
    HealingTideTotem                                        = (GetSpellInfo(108280)),
    Riptide                                        = (GetSpellInfo(61295)),
    HealingRain                                        = (GetSpellInfo(73920)),
    Downpour                                        = (GetSpellInfo(207778)),
    Wellspring                                        = (GetSpellInfo(197995)),
    HealingWave                                        = (GetSpellInfo(77472)),
    ChainHeal                                        = (GetSpellInfo(1064)),
    UnleashLife                                        = (GetSpellInfo(73685)),
    CloudBurstTotem                                        = (GetSpellInfo(157153)),
    EarthWallTotem                                        = (GetSpellInfo(198838)),
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
L.DispellAndInterrupts                                            = {
    enUS = "Dispel and Interrupts",
}
L.PvPAndArena                                            = {
    enUS = "PvP and Arena",
}
L.Totems                                            = {
    enUS = "Totems",
}
L.selfDefence                                            = {
    enUS = "Self Defence",
}
L.selfHealing                                            = {
    enUS = "Self Healing",
}
L.partyHealing                                            = {
    enUS = "Party Healing",
}
L.AoEHealing                                            = {
    enUS = "AoE Healing",
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
L.Ascendance                                        = {
    enUS = S.Ascendance .. "\nUse on bosses only\n",
}
L.HealingSurge = {
    enUS = S.HealingSurge .. "\nHealth Percent (Self)",
    ruRU = S.HealingSurge .. "\nЗдоровье Процент (Свое)",
}
L.HealingTotem = {
    enUS = S.HealingTotem .. "\nHealth Percent (Self)",
    ruRU = S.HealingTotem .. "\nЗдоровье Процент (Свое)",
}
L.Riptide = {
    enUS = S.Riptide .. "\nHealth Percent (Self)",
    ruRU = S.Riptide .. "\nЗдоровье Процент (Свое)",
}
L.UnleashLife = {
    enUS = S.UnleashLife .. "\nHealth Percent (Self)",
    ruRU = S.UnleashLife .. "\nЗдоровье Процент (Свое)",
}
L.Wellspring = {
    enUS = S.Wellspring .. "\nHealth Percent (Self)",
    ruRU = S.Wellspring .. "\nЗдоровье Процент (Свое)",
}
L.WellspringCount = {
    enUS = S.Wellspring .. "\nUse if x players below % HP",
}
L.Downpour = {
    enUS = S.Downpour .. "\nHealth Percent (Self)",
    ruRU = S.Downpour .. "\nЗдоровье Процент (Свое)",
}
L.DownpourCount = {
    enUS = S.Downpour .. "\nUse if x players below % HP",
}
L.HealingRain = {
    enUS = S.HealingRain .. "\nHealth Percent (Self)",
    ruRU = S.HealingRain .. "\nЗдоровье Процент (Свое)",
}
L.HealingRainCount = {
    enUS = S.HealingRain .. "\nUse if x players below % HP",
}
L.HealingWave = {
    enUS = S.HealingWave .. "\nHealth Percent (Self)",
    ruRU = S.HealingWave .. "\nЗдоровье Процент (Свое)",
}
L.ChainHeal = {
    enUS = S.ChainHeal .. "\nHealth Percent (Self)",
    ruRU = S.ChainHeal .. "\nЗдоровье Процент (Свое)",
}
L.ChainHealCount = {
    enUS = S.ChainHeal .. "\nUse if x players below % HP",
}
L.HealingTideTotem = {
    enUS = S.HealingTideTotem .. "\nHealth Percent (Self)",
    ruRU = S.HealingTideTotem .. "\nЗдоровье Процент (Свое)",
}
L.HealingTideTotemCount = {
    enUS = S.HealingTideTotem .. "\nUse if x players below % HP",
}
L.CloudBurstTotem = {
    enUS = S.CloudBurstTotem .. "\nHealth Percent (Self)",
    ruRU = S.CloudBurstTotem .. "\nЗдоровье Процент (Свое)",
}
L.CloudBurstTotemCount = {
    enUS = S.CloudBurstTotem .. "\nUse if x players below % HP",
}
L.EarthWallTotem = {
    enUS = S.EarthWallTotem .. "\nHealth Percent (Self)",
    ruRU = S.EarthWallTotem .. "\nЗдоровье Процент (Свое)",
}
L.EarthWallTotemCount = {
    enUS = S.EarthWallTotem .. "\nUse if x players below % HP",
}
L.genericHealerSettings                                            = {
    enUS = "Generic healer settings",
}
L.AutoTargeting                                            = {
    enUS = "Auto targeting if no ally needs healing",
}
L.whenToDealDmg                                            = {
    enUS = "If everyone above % HP rotation should deal dmg instead of healing",
}
L.StunTotem = {
    enUS = S.StunTotem .. "\nuse on x enemies",
}
L.StunTotemSlider = {
    enUS = S.StunTotem .. "\nuse on x enemies slider",
}
L.SlowTotem = {
    enUS = S.SlowTotem .. "\nuse on x enemies",
}
L.SlowTotemSlider = {
    enUS = S.SlowTotem .. "\nuse on x enemies slider",
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

A.Data.ProfileEnabled[Action.CurrentProfile] = true
A.Data.ProfileUI = {    
    DateTime = "v5.0.1 (14.10.2020) BETA",
    -- Class settings
    [2] = {        
        [ACTION_CONST_SHAMAN_ENCHANCEMENT] = {             
            LayoutOptions = LayoutConfigOptions,
            {
                {
                    E = "Header",
                    L = {ANY = " -- Nothing here -- ",},
                },
            },
        },
        [ACTION_CONST_SHAMAN_ELEMENTAL] = {
            { -- [7]
                {
                    E = "Header",
                    L = {ANY = " -- Nothing here -- ",},
                },
            },        
        },
        [ACTION_CONST_SHAMAN_RESTORATION] = {
            LayoutOptions = { gutter = 5, padding = { left = 10, right = 10 } },    
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- General -- ",
                    },
                },
            },
            { -- [1]                             
                {
                    E = "Checkbox", 
                    DB = "mouseover",
                    DBV = true,
                    L = { 
                        enUS = "Use\n@mouseover", 
                        ruRU = "Использовать\n@mouseover", 
                    }, 
                    TT = { 
                        enUS = "Will unlock use actions for @mouseover units\nExample: Resuscitate, Healing", 
                        ruRU = "Разблокирует использование действий для @mouseover юнитов\nНапример: Воскрешение, Хилинг", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "targettarget",
                    DBV = true,
                    L = { 
                        enUS = "Use\n@targettarget", 
                        ruRU = "Использовать\n@targettarget", 
                    }, 
                    TT = { 
                        enUS = "Will unlock use actions\nfor enemy @targettarget units", 
                        ruRU = "Разблокирует использование\nдействий для вражеских @targettarget юнитов", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        enUS = "Use\nAoE", 
                        ruRU = "Использовать\nAoE", 
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                        ruRU = "Включает действия для нескольких целей", 
                    }, 
                    M = {},
                },  
                {
                    E = "Checkbox", 
                    DB = "TasteInterruptList",
                    DBV = true,
                    L = { 
                        enUS = "Use BFA Mythic+ & Raid\nsmart interrupt list", 
                        ruRU = "использование BFA Mythic+ & Raid\nумный список прерываний", 
                        frFR = "Liste d'interrupts intelligente\nBFA Mythic+ & Raid",
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will force a special interrupt list containing all the BFA Mythic+ and Raid stuff WHEN YOU ARE IN MYTHIC+ OR RAID ZONE.\nYou can edit this list in the Interrupts tab\nand customize it as you want",
                        ruRU = "Если включено : Запустит специальный список прерываний, содержащий все BFA Mythic+ и Raid stuff КОГДА ВЫ НАХОДИТЕСЬ В МИФИЧЕСКОЙ + ИЛИ ЗОНЕ RAID.\nВы можете редактировать этот список на вкладке Прерывания\nи настраивай как хочешь",
                        frFR = "Si activé : Force une liste d'interruption spéciale contenant tous les éléments BFA Mythic + et Raid QUAND VOUS ETES EN MYTHIC+ OU EN RAID.\nVous pouvez modifier cette liste dans l'onglet Interruptions\net la personnaliser comme vous le souhaitez", 
                    }, 
                    M = {},
                },    
                {
                    E = "Checkbox", 
                    DB = "UseRotationPassive",
                    DBV = true,
                    L = { 
                        enUS = "Use\nPassive\nRotation",
                        ruRU = "Включить\nПассивную\nРотацию" 
                    },
                    M = {},
                },                                  
            },     
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Healing Engine -- ",
                    },
                },
            },    
            { -- [7] 
                {
                    E = "Checkbox", 
                    DB = "ManaManagement",
                    DBV = true,
                    L = { 
                        enUS = "Boss Fight\nManaSave\n(PvE)", 
                        ruRU = "Бой с Боссом\nУправление Маной\n(PvE)",
                    }, 
                    TT = { 
                        enUS = "Enable to keep small mana save tricks during boss fight\nMana will keep going to save phase if Boss HP >= our Mana", 
                        ruRU = "Включает сохранение малого количества маны с помощью некоторых манипуляций в течении боя против Босса\nМана будет переходить в фазу сохранения если ХП Босса >= нашей Маны", 
                    }, 
                    M = {},
                },             
                {
                    E = "Checkbox", 
                    DB = "ManaPotion",
                    DBV = true,
                    L = { 
                        enUS = "Use\nMana Potion",
                        ruRU = "Использовать\nЗелье Маны",
                    },
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "StopCastOverHeal",
                    DBV = true,
                    L = { 
                        enUS = "Stop Cast\noverhealing",
                        ruRU = "Stop Cast\noverhealing",
                    },
                    TT = { 
                        enUS = "Enable this option to automatically stop the current cast to avoid overhealing.",
                        ruRU = "Enable this option to automatically stop the current cast to avoid overhealing.",
                    },
                    M = {},
                },         
            },
            {            
                {        
                    E = "Checkbox", 
                    DB = "StartByPreCast",
                    DBV = true,
                    L = { 
                        enUS = "Begin Combat\nBy PreCast",
                        ruRU = "Начинать Бой\nЗаранее произнося", 
                    },
                    TT = { 
                        enUS = "Will start rotation on enemy by available longer\ncasting spell depended on your spec",
                        ruRU = "Будет начинать ротация на противнике с доступной\nдлинной произносящейся способности в зависимости от спека",
                    },
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "SpellKick",
                    DBV = true,
                    L = { 
                        enUS = "Spell Kick",
                        ruRU = "Spell Kick",
                    },
                    TT = { 
                        enUS = "Enable this option to automatically use your kicking spells.",
                        ruRU = "Enable this option to automatically use your kicking spells.",
                    },
                    M = {},
                },
            },
            
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Racials -- ",
                    },
                },
            },    
            {
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "RacialBurstHealing",                    
                    DBV = 100,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetLocalization()["TAB"][1]["RACIAL"] .. "\n(Healing HP %)",                        
                    },                     
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "RacialBurstDamaging",                    
                    DBV = 100,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetLocalization()["TAB"][1]["RACIAL"] .. "\n(Damaging HP %)",                        
                    },                     
                    M = {},
                },
            },
            { -- Trinkets
                {
                    E = "Header",
                    L = {
                        ANY = " -- Trinkets -- ",
                    },
                },
            },    
            {                 
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Always", value = "Always" },
                        { text = "Burst Synchronized", value = "BurstSync" },                    
                    },
                    DB = "TrinketBurstSyncUP",
                    DBV = "Always",
                    L = { 
                        enUS = "Damager: How to use trinkets",
                        ruRU = "Урон: Как использовать аксессуары", 
                    },
                    TT = { 
                        enUS = "Always: On cooldown\nBurst Synchronized: By Burst Mode in 'General' tab",
                        ruRU = "Always: По доступности\nBurst Synchronized: От Режима Бурстов во вкладке 'Общее'", 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 100,                            
                    DB = "TrinketMana",
                    DBV = 85,
                    ONLYOFF = false,
                    L = { 
                        enUS = "Trinket: Mana(%)",
                        ruRU = "Trinket: Mana(%)",
                    },
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 5, 
                    MAX = 100,                            
                    DB = "TrinketBurstHealing",
                    DBV = 75,
                    ONLYOFF = false,
                    L = { 
                        enUS = "Healer: Target Health (%)",
                        ruRU = "Лекарь: Здоровье Цели (%)", 
                    },
                    M = {},
                },        
            },
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Essences -- ",
                    },
                },
            },    
            {
                RowOptions = { margin = { top = 10 } },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 100,                            
                    DB = "LucidDreamManaPercent",                    
                    DBV = 85,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(299374) .. "\nMana %",                        
                    },                     
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 10,                            
                    DB = "LifeBindersInvocationUnits",                    
                    DBV = 5,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(299944) .. "\nunits number",                        
                    },                     
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "LifeBindersInvocationHP",                    
                    DBV = 85,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(299944) .. "\n(%)",                        
                    },                     
                    M = {},
                },
            },
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Mythic + -- ",
                    },
                },
            },    
            {
                {
                    E = "Checkbox", 
                    DB = "MythicPlusLogic",
                    DBV = true,
                    L = { 
                        enUS = "Smart Mythic+",
                        ruRU = "Smart Mythic+",
                    },
                    TT = { 
                        enUS = "Enable this option to activate critical healing logic depending of the current dungeon.\nExample:Fulminating Zap in Junkyard",
                        ruRU = "Enable this option to activate critical healing logic depending of the current dungeon.\nExample:Fulminating Zap in Junkyard",
                    },
                    M = {},
                },    
                {
                    E = "Checkbox", 
                    DB = "GrievousWoundsLogic",
                    DBV = true,
                    L = { 
                        enUS = "Grievous Wounds\nlogic",
                        ruRU = "Grievous Wounds\nlogic",
                    },
                    TT = { 
                        enUS = "Enable this option to activate critical healing logic for friendly units that got Grievous Wounds debuff.",
                        ruRU = "Enable this option to activate critical healing logic for friendly units that got Grievous Wounds debuff.",
                    },
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 5,                            
                    DB = "GrievousWoundsMinStacks",                    
                    DBV = 2,
                    ONOFF = false,
                    L = { 
                        ANY = "Grievous Wounds\nmin stacks",                        
                    },   
                    TT = { 
                        enUS = "How many stacks of Grievous Wounds should be up on friendly unit before force targetting on this unit.\nExample: 2 means friendly unit will be urgently targetted if he got 2 stacks.", 
                        ruRU = "How many stacks of Grievous Wounds should be up on friendly unit before force targetting on this unit.\nExample: 2 means friendly unit will be urgently targetted if he got 2 stacks.", 
                    },                    
                    M = {},
                },                
                {
                    E = "Checkbox", 
                    DB = "StopCastQuake",
                    DBV = true,
                    L = { 
                        enUS = "Stop Cast\nquaking",
                        ruRU = "Stop Cast\nquaking",
                    },
                    TT = { 
                        enUS = "Enable this option to automatically stop your current cast before Quake.",
                        ruRU = "Enable this option to automatically stop your current cast before Quake.",
                    },
                    M = {},
                },    
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 3,                            
                    DB = "StopCastQuakeSec",                    
                    DBV = 1,
                    Precision = 1,
                    ONOFF = false,
                    L = { 
                        ANY = "Stop Cast\nquaking seconds",                      
                    },
                    TT = { 
                        enUS = "Define the value you want to stop your cast before next Quake hit.\nValue is in seconds.\nExample: 1 means you will stop cast at 1sec remaining on Quaking.",            
                        ruRU = "Define the value you want to stop your cast before next Quake hit.\nValue is in seconds.\nExample: 1 means you will stop cast at 1sec remaining on Quaking.",            
                    },                    
                    M = {},
                },
            },
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Utilities -- ",
                    },
                },
            },
            {
                {
                    E = "Checkbox", 
                    DB = "UseGhostWolf",
                    DBV = true,
                    L = { 
                        enUS = "Auto " .. A.GetSpellInfo(2645), 
                        ruRU = "Авто " .. A.GetSpellInfo(2645), 
                        frFR = "Auto " .. A.GetSpellInfo(2645), 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. A.GetSpellInfo(2645), 
                        ruRU = "Автоматически использовать " .. A.GetSpellInfo(2645), 
                        frFR = "Utiliser automatiquement " .. A.GetSpellInfo(2645), 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 7,                            
                    DB = "GhostWolfTime",
                    DBV = 3, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        enUS = A.GetSpellInfo(2645) .. " if moving for",
                        ruRU = A.GetSpellInfo(2645) .. " если переехать",
                        frFR = A.GetSpellInfo(2645) .. " si vous bougez pendant",
                    },
                    TT = { 
                        enUS = "If " .. A.GetSpellInfo(2645) .. " is talented and ready, will use it if moving for set value.", 
                        ruRU = "Если " .. A.GetSpellInfo(2645) .. " изучен и готов, будет использовать его при переходе на заданное значение.", 
                        frFR = "Si " .. A.GetSpellInfo(2645) .. " est prêt, l'utilisera s'il se déplace pour la valeur définie.", 
                    }, 
                    M = {},
                },    
            },            
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Defensives -- ",
                    },
                },
            },            
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "AstralShiftHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(108271) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "AbyssalHealingPotionHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(301308) .. " (%)",
                    }, 
                    M = {},
                },
            },
            { -- HealingTideTotem
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(108280) .. " -- ",
                    },
                }, 
            },
            {
                RowOptions = { margin = { top = -10 } },
                {
                    E = "Header",
                    L = {
                        ANY = " -- Raid -- ",
                    },
                },
                {
                    E = "Header",
                    L = {
                        ANY = " -- Dungeon -- ",
                    },
                },
            },
            -- HealingTideTotem
            { -- [3] 
                RowOptions = { margin = { top = 10 } },        
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "HealingTideTotemRaidUnits",
                    DBV = 5,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(108280) .. "\n(Total Units)",    
                    },                     
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "HealingTideTotemPartyUnits",
                    DBV = 3,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(108280) .. "\n(Total Units)",    
                    },                     
                    M = {},
                },
            },
            {
                RowOptions = { margin = { top = 10 } },
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "HealingTideTotemRaidHP",
                    DBV = 65,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(108280) .. "\n(Per UnitHealth %)",                        
                    },                     
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 100,                            
                    DB = "HealingTideTotemPartyHP",
                    DBV = 60,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(108280) .. "\n(Per UnitHealth %)",                        
                    },                     
                    M = {},
                },                
            },                            
            { -- EarthShield
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(974) .. " -- ",
                    },
                }, 
            },
            {
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Auto", value = "Auto" },    
                        { text = "Tanking Units", value = "Tanking Units" },                    
                        { text = "Mostly Inc. Damage", value = "Mostly Inc. Damage" },
                    },
                    DB = "EarthShieldWorkMode",
                    DBV = "Tanking Units",
                    L = { 
                        ANY = A.GetSpellInfo(974) .. "\nWork Mode",
                    }, 
                    TT = { 
                        enUS = "These conditions will be skiped if unit will dying in emergency (critical) situation", 
                        ruRU = "Эти условия будут пропущены если юнит будет умирать в чрезвычайной (критической) ситуациии", 
                    },                    
                    M = {},
                },
            },    
            { -- ChainHeal
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(1064) .. " -- ",
                    },
                }, 
            },
            {
                RowOptions = { margin = { top = -10 } },
                {
                    E = "Header",
                    L = {
                        ANY = " -- Raid -- ",
                    },
                },
                {
                    E = "Header",
                    L = {
                        ANY = " -- Dungeon -- ",
                    },
                },
            },
            -- ChainHeal
            { -- [3] 
                RowOptions = { margin = { top = 10 } },        
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "ChainHealRaidUnits",
                    DBV = 4,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(1064) .. "\n(Total Units)",    
                    },                     
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "ChainHealPartyUnits",
                    DBV = 3,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(1064) .. "\n(Total Units)",    
                    },                     
                    M = {},
                },
            },
            {
                RowOptions = { margin = { top = 10 } },
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "ChainHealRaidHP",
                    DBV = 92,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(1064) .. "\n(Per UnitHealth %)",                        
                    },                     
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 100,                            
                    DB = "ChainHealPartyHP",
                    DBV = 80,
                    ONLYON = true,
                    L = { 
                        ANY = A.GetSpellInfo(1064) .. "\n(Per UnitHealth %)",                        
                    },                     
                    M = {},
                },                
            },    
            { -- HealingStreamTotem
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(5394) .. " -- ",
                    },
                }, 
            },            
            {
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 100,                            
                    DB = "HealingStreamTotemHP",
                    DBV = 55,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(5394) .. "\n(%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 5,                            
                    DB = "HealingStreamTotemUnits",
                    DBV = 3,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(5394) .. "\nunits",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "HealingStreamTotemRefresh",
                    DBV = 3,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(5394) .. "\nrefresh(sec)",
                    }, 
                    M = {},
                },
            },
            { -- HealingRain
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(73920) .. " -- ",
                    },
                }, 
            },            
            {
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "HealingRainRefresh",
                    DBV = 3,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(73920) .. "\nrefresh(sec)",
                    }, 
                    M = {},
                },
            },
            { -- SpiritWalkersGrace
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. A.GetSpellInfo(79206) .. " -- ",
                    },
                }, 
            },            
            {
                {
                    E = "Checkbox", 
                    DB = "UseSpiritWalkersGrace",
                    DBV = true,
                    L = { 
                        enUS = "Auto\n" .. A.GetSpellInfo(79206),
                        ruRU = "Auto\n" .. A.GetSpellInfo(79206),
                    },
                    TT = { 
                        enUS = "Enable this option to automatically use " .. A.GetSpellInfo(79206),
                        ruRU = "Enable this option to automatically use " .. A.GetSpellInfo(79206),
                    },
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "SpiritWalkersGraceTime",
                    DBV = 3,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(79206) .. "\nif moving for",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "SpiritWalkersCatch",
                    DBV = 3,
                    ONOFF = false,
                    L = { 
                        ANY = A.GetSpellInfo(79206) .. "\nonly if rooted",
                    }, 
                    M = {},
                },                
            },                
            { -- [6]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Party -- ",
                    },
                },
            }, 
            { -- [7]
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "@party1", value = 1 },
                        { text = "@party2", value = 2 },
                    },
                    MULT = true,
                    DB = "PartyUnits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                    }, 
                    L = { 
                        ANY = "Party Units",
                    }, 
                    TT = { 
                        enUS = "Enable/Disable relative party passive rotation", 
                        ruRU = "Включить/Выключить относительно группы пассивную ротацию", 
                    }, 
                    M = {},
                },  
                {
                    E = "Checkbox", 
                    DB = "Dispel",
                    DBV = true,
                    L = { 
                        enUS = "Auto\n" .. A.GetSpellInfo(528),
                        ruRU = "Auto\n" .. A.GetSpellInfo(528),
                    },
                    TT = { 
                        enUS = "Enable this option to automatically use " .. A.GetSpellInfo(528),
                        ruRU = "Enable this option to automatically use " .. A.GetSpellInfo(528),
                    },
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "Purje",
                    DBV = true,
                    L = { 
                        enUS = "Auto\n" .. A.GetSpellInfo(527),
                        ruRU = "Auto\n" .. A.GetSpellInfo(527),
                    },
                    TT = { 
                        enUS = "Enable this option to automatically use " .. A.GetSpellInfo(527),
                        ruRU = "Enable this option to automatically use " .. A.GetSpellInfo(527),
                    },
                    M = {},
                },                
            },     
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Overlay -- ",
                    },
                },
            },
            { -- [2] 2nd Row
                {
                    E = "Checkbox", 
                    DB = "UseAnnouncer",
                    DBV = true,
                    L = { 
                        enUS = "Use Smart Announcer", 
                        ruRU = "Use Smart Announcer",  
                        frFR = "Use Smart Announcer", 
                    }, 
                    TT = { 
                        enUS = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                        ruRU = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                        frFR = "Will make the rotation to announce importants informations.\nUseful to get fast and clear status of what the rotation is doing and why it is doing.\nFor example :\n- Blind on enemy healer to interrupt an incoming heal.\n- Vanish to survive incoming damage.", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AnnouncerInCombatOnly",
                    DBV = true,
                    L = { 
                        enUS = "Only use in combat", 
                        ruRU = "Only use in combat", 
                        frFR = "Only use in combat",
                    }, 
                    TT = { 
                        enUS = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work with precombat actions if available.\nFor example : Sap out of combat, pre potion.", 
                        ruRU = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work out of combat if precombat actions are available.\nFor example : Sap out of combat, pre potion.",
                        frFR = "Will only use Smart Announcer while in combat.\nDisable it will make Smart Announcer work out of combat if precombat actions are available.\nFor example : Sap out of combat, pre potion.",  
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "AnnouncerDelay",
                    DBV = 2, -- 2sec
                    ONOFF = true,
                    L = { 
                        ANY = "Alerts delay (sec)",
                    },
                    TT = { 
                        enUS = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                        ruRU = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                        frFR = "Will force a specific delay before the alerts fade.\nDefault value : 2 seconds.", 
                    },                     
                    M = {},
                },                
            },    
            
        },
    },
    -- MSG Actions UI
    [7] = {
        [ACTION_CONST_SHAMAN_ENCHANCEMENT] = { 
            -- MSG Action Pet Dispell
            ["dispell"] = { Enabled = true, Key = "PetDispell", LUA = [[
                return     A.DispellMagic:IsReady(unit, true) and 
                        (
                            ( 
                                not Unit(thisunit):IsEnemy() and 
                                (
                                    (
                                        not InPvP() and 
                                        Env.Dispel(unit)
                                    ) or 
                                    (
                                        InPvP() and 
                                        EnemyTeam():PlayersInRange(1, 5)
                                    ) 
                                )
                            ) or 
                            ( 
                                Unit(thisunit):IsEnemy() and 
                                Unit(thisunit):GetRange() <= 5 and 
                                Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"TotalImun", "DeffBuffsMagic"}, true) 
                            )                
                        ) 
            ]] },
            -- MSG Action Pet Kick
            ["kick"] = { Enabled = true, Key = "Pet Kick", LUA = [[
                return  SpellInRange(thisunit, Action[PlayerSpec].SpellLock.ID) and 
                        select(2, CastTime(nil, thisunit)) > 0 and 
                        Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"KickImun", "TotalImun", "DeffBuffsMagic"}, true) 
            ]] },
            -- MSG Action Fear
            ["kick"] = { Enabled = true, Key = "Pet Kick", LUA = [[
                return  SpellInRange(thisunit, Action[PlayerSpec].SpellLock.ID) and 
                        select(2, CastTime(nil, thisunit)) > 0 and 
                        Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"KickImun", "TotalImun", "DeffBuffsMagic"}, true) 
            ]] },
        },
        [ACTION_CONST_SHAMAN_RESTORATION] = { 
            -- MSG Action Pet Dispell
            ["dispell"] = { Enabled = true, Key = "PetDispell", LUA = [[
                return     A.DispellMagic:IsReady(unit, true) and 
                        (
                            ( 
                                not Unit(thisunit):IsEnemy() and 
                                (
                                    (
                                        not InPvP() and 
                                        Env.Dispel(unit)
                                    ) or 
                                    (
                                        InPvP() and 
                                        EnemyTeam():PlayersInRange(1, 5)
                                    ) 
                                )
                            ) or 
                            ( 
                                Unit(thisunit):IsEnemy() and 
                                Unit(thisunit):GetRange() <= 5 and 
                                Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"TotalImun", "DeffBuffsMagic"}, true) 
                            )                
                        ) 
            ]] },
            -- MSG Action Pet Kick
            ["kick"] = { Enabled = true, Key = "Pet Kick", LUA = [[
                return  SpellInRange(thisunit, Action[PlayerSpec].SpellLock.ID) and 
                        select(2, CastTime(nil, thisunit)) > 0 and 
                        Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"KickImun", "TotalImun", "DeffBuffsMagic"}, true) 
            ]] },
            -- MSG Action Fear
            ["kick"] = { Enabled = true, Key = "Pet Kick", LUA = [[
                return  SpellInRange(thisunit, Action[PlayerSpec].SpellLock.ID) and 
                        select(2, CastTime(nil, thisunit)) > 0 and 
                        Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"KickImun", "TotalImun", "DeffBuffsMagic"}, true) 
            ]] },
        },
        [ACTION_CONST_SHAMAN_ELEMENTAL] = { 
            -- MSG Action Pet Dispell
            ["dispell"] = { Enabled = true, Key = "PetDispell", LUA = [[
                return     A.DispellMagic:IsReady(unit, true) and 
                        (
                            ( 
                                not Unit(thisunit):IsEnemy() and 
                                (
                                    (
                                        not InPvP() and 
                                        Env.Dispel(unit)
                                    ) or 
                                    (
                                        InPvP() and 
                                        EnemyTeam():PlayersInRange(1, 5)
                                    ) 
                                )
                            ) or 
                            ( 
                                Unit(thisunit):IsEnemy() and 
                                Unit(thisunit):GetRange() <= 5 and 
                                Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"TotalImun", "DeffBuffsMagic"}, true) 
                            )                
                        ) 
            ]] },
            -- MSG Action Pet Kick
            ["kick"] = { Enabled = true, Key = "Pet Kick", LUA = [[
                return  SpellInRange(thisunit, Action[PlayerSpec].SpellLock.ID) and 
                        select(2, CastTime(nil, thisunit)) > 0 and 
                        Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"KickImun", "TotalImun", "DeffBuffsMagic"}, true) 
            ]] },
            -- MSG Action Fear
            ["kick"] = { Enabled = true, Key = "Pet Kick", LUA = [[
                return  SpellInRange(thisunit, Action[PlayerSpec].SpellLock.ID) and 
                        select(2, CastTime(nil, thisunit)) > 0 and 
                        Action[PlayerSpec].SpellLock:AbsentImun(thisunit, {"KickImun", "TotalImun", "DeffBuffsMagic"}, true) 
            ]] },
        },
    },
}


-----------------------------------------
--                   PvP  
-----------------------------------------

function A.Main_CastBars(unit, list)
    if not A.IsInitialized or A.IamHealer or (A.Zone ~= "arena" and A.Zone ~= "pvp") then 
        return false 
    end 
    
    if A[A.PlayerSpec] and A[A.PlayerSpec].SpearHandStrike and A[A.PlayerSpec].SpearHandStrike:IsReadyP(unit, nil, true) and A[A.PlayerSpec].SpearHandStrike:AbsentImun(unit, {"KickImun", "TotalImun", "DamagePhysImun"}, true) and A.InterruptIsValid(unit, list) then 
        return true         
    end 
end 

function A.Second_CastBars(unit)
    if not A.IsInitialized or (A.Zone ~= "arena" and A.Zone ~= "pvp") then 
        return false 
    end 
    
    local Toggle = A.GetToggle(2, "ParalysisPvP")    
    if Toggle and Toggle ~= "OFF" and A[A.PlayerSpec] and A[A.PlayerSpec].Paralysis and A[A.PlayerSpec].Paralysis:IsReadyP(unit, nil, true) and A[A.PlayerSpec].Paralysis:AbsentImun(unit, {"CCTotalImun", "TotalImun", "DamagePhysImun"}, true) and Unit(unit):IsControlAble("incapacitate", 0) then 
        if Toggle == "BOTH" then 
            return select(2, A.InterruptIsValid(unit, "Heal", true)) or select(2, A.InterruptIsValid(unit, "PvP", true)) 
        else
            return select(2, A.InterruptIsValid(unit, Toggle, true))         
        end 
    end 
end 

