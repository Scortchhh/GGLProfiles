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

local ACTION_CONST_DRUID_FERAL                        = CONST.DRUID_FERAL
local ACTION_CONST_DRUID_GUARDIAN             = CONST.DRUID_GUARDIAN
local ACTION_CONST_DRUID_RESTORATION             = CONST.DRUID_RESTORATION

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
    Rejuvenation                                        = (GetSpellInfo(774)),
    Regrowth                                        = (GetSpellInfo(8936)),
    CenarionWard                                        = (GetSpellInfo(102351)),
    Swiftmend                                        = (GetSpellInfo(18562)),
    WildGrowth                                        = (GetSpellInfo(48438)),
    Lifebloom                                        = (GetSpellInfo(33763)),
    Renewal                                        = (GetSpellInfo(108238)),
    Barkskin                                        = (GetSpellInfo(22812)),
    Ironbark                                        = (GetSpellInfo(102342)),
    Efflorescence                                        = (GetSpellInfo(145205)),
    Tranquility                                        = (GetSpellInfo(740)),
    NaturesSwiftness                                        = (GetSpellInfo(132158)),
    ConvokeTheSpirits                                        = (GetSpellInfo(337433)),
    Innervate                                        = (GetSpellInfo(29166)),
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
L.selfHealing                                            = {
    enUS = "Self Healing",
}
L.partyHealing                                            = {
    enUS = "Party Healing",
}
L.AoEHealing                                            = {
    enUS = "AoE Healing",
}
L.genericHealerSettings                                            = {
    enUS = "Generic healer settings",
}
L.whenToDealDmg                                            = {
    enUS = "If everyone above % HP rotation should deal dmg instead of healing",
}
L.AutoTargeting                                            = {
    enUS = "Use auto targetting to swap between mobs for dots",
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
L.Rejuvenation = {
    enUS = S.Rejuvenation .. "\nHealth Percent (Self)",
    ruRU = S.Rejuvenation .. "\nЗдоровье Процент (Свое)",
}
L.Regrowth = {
    enUS = S.Regrowth .. "\nHealth Percent (Self)",
    ruRU = S.Regrowth .. "\nЗдоровье Процент (Свое)",
}
L.CenarionWard = {
    enUS = S.CenarionWard .. "\nHealth Percent (Self)",
    ruRU = S.CenarionWard .. "\nЗдоровье Процент (Свое)",
}
L.WildGrowth = {
    enUS = S.WildGrowth .. "\nHealth Percent (Self)",
    ruRU = S.WildGrowth .. "\nЗдоровье Процент (Свое)",
}
L.WildGrowthCount = {
    enUS = S.WildGrowth .. "\nUse if x players below % HP",
}
L.Efflorescence = {
    enUS = S.Efflorescence .. "\nHealth Percent (Self)",
    ruRU = S.Efflorescence .. "\nЗдоровье Процент (Свое)",
}
L.EfflorescenceCount = {
    enUS = S.Efflorescence .. "\nUse if x players below % HP",
}
L.ConvokeTheSpirits = {
    enUS = S.ConvokeTheSpirits .. "\nHealth Percent (Self)",
    ruRU = S.ConvokeTheSpirits .. "\nЗдоровье Процент (Свое)",
}
L.ConvokeTheSpiritsCount = {
    enUS = S.ConvokeTheSpirits .. "\nUse if x players below % HP",
}
L.Innervate = {
    enUS = S.Innervate .. "\nMana Percent (Self)",
}
L.Tranquility = {
    enUS = S.Tranquility .. "\nHealth Percent (Self)",
    ruRU = S.Tranquility .. "\nЗдоровье Процент (Свое)",
}
L.TranquilityCount = {
    enUS = S.Tranquility .. "\nUse if x players below % HP",
}
L.Lifebloom = {
    enUS = S.Lifebloom .. "\nHealth Percent (Self)",
    ruRU = S.Lifebloom .. "\nЗдоровье Процент (Свое)",
}
L.NaturesSwiftness = {
    enUS = S.NaturesSwiftness .. "\nHealth Percent (Self)",
    ruRU = S.NaturesSwiftness .. "\nЗдоровье Процент (Свое)",
}
L.Swiftmend = {
    enUS = S.Swiftmend .. "\nHealth Percent (Self)",
    ruRU = S.Swiftmend .. "\nЗдоровье Процент (Свое)",
}
L.Renewal = {
    enUS = S.Renewal .. "\nHealth Percent (Self)",
    ruRU = S.Renewal .. "\nЗдоровье Процент (Свое)",
}
L.Ironbark = {
    enUS = S.Ironbark .. "\nHealth Percent (Self)",
    ruRU = S.Ironbark .. "\nЗдоровье Процент (Свое)",
}
L.Barkskin = {
    enUS = S.Barkskin .. "\nHealth Percent (Self)",
    ruRU = S.Barkskin .. "\nЗдоровье Процент (Свое)",
}
L.HealingTotem = {
    enUS = S.HealingTotem .. "\nHealth Percent (Self)",
    ruRU = S.HealingTotem .. "\nЗдоровье Процент (Свое)",
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

local SliderMarginOptions = { margin = { top = 10 } }
local LayoutConfigOptions = { gutter = 4, padding = { left = 5, right = 5 } }
A.Data.ProfileEnabled[A.CurrentProfile]             = true
A.Data.ProfileUI                                     = {    
    DateTime = "v2.00 (25.02.2021)",
    [2] = {
        [ACTION_CONST_DRUID_FERAL] = {             
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
                    DB                 = "HealingSurge",
                    DBV             = 60,
                    ONOFF             = true,
                    L                 = L.HealingSurge,                
                    M                 = {},
                },
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "HealingTotem",
                    DBV             = 75,
                    ONOFF             = true,
                    L                 = L.HealingTotem,                
                    M                 = {},
                },
            },
            {
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "AstralShift",
                    DBV             = 60,
                    ONOFF             = true,
                    L                 = L.AstralShift,                
                    M                 = {},
                },
            },
            { -- [2] Self Defensives 
                {
                    E                 = "Header",
                    L                 = L.CDS,
                },
            },
            {
                {
                    E                 = "Checkbox", 
                    DB                 = "Ascendance",
                    DBV             = true,
                    L                 = L.Ascendance,
                    M                 = {},
                },
                {
                    E                 = "Checkbox", 
                    DB                 = "Bloodlust",
                    DBV             = true,
                    L                 = L.Bloodlust,
                    M                 = {},
                },
            },  
            {
                {
                    E                 = "Checkbox", 
                    DB                 = "Feral Spirits",
                    DBV             = true,
                    L                 = L.FeralSpirits,
                    M                 = {},
                },
                {
                    E                 = "Checkbox", 
                    DB                 = "Earth Elemental",
                    DBV             = true,
                    L                 = L.EarthElemental,
                    M                 = {},
                },
            }, 


            { -- [2] Self Defensives 
                {
                    E                 = "Header",
                    L                 = L.Totems,
                },
            },
            {
                {
                    E                 = "Checkbox", 
                    DB                 = "Stun Totem",
                    DBV             = true,
                    L                 = L.StunTotem,
                    M                 = {},
                },
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 10,                            
                    DB                 = "Stun Totem Value",
                    DBV             = 3,
                    ONOFF             = true,
                    L                 = L.StunTotemSlider,                
                    M                 = {},
                },
            },  
            {
                {
                    E                 = "Checkbox", 
                    DB                 = "Slow Totem",
                    DBV             = true,
                    L                 = L.SlowTotem,
                    M                 = {},
                },
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 10,                            
                    DB                 = "Slow Totem Value",
                    DBV             = 3,
                    ONOFF             = true,
                    L                 = L.SlowTotemSlider,                
                    M                 = {},
                },
            },
        },

        [ACTION_CONST_DRUID_RESTORATION] = {             
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
                {
                    E                 = "Checkbox", 
                    DB                 = "AutoTargeting",
                    DBV             = false,
                    L                 = L.AutoTargeting,
                    M                 = {},
                },
            },
            {
                {
                    E                 = "Checkbox", 
                    DB                 = "RootEnraged",
                    DBV             = false,
                    L = { 
                        enUS = "Root mobs that is enraged", 
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will root mobs when sooth is on cooldown that are enrage",
                    }, 
                    M                 = {},
                },
                {
                    E                 = "Checkbox", 
                    DB                 = "UseMoonkinForm",
                    DBV             = false,
                    L = { 
                        enUS = "Use Moonkin form DPS Spells", 
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will cast Starsurge and Starfire, that require Moonkin Form and talent Balance Affinity",
                    }, 
                    M                 = {},
                },
                {
                    E                 = "Checkbox", 
                    DB                 = "UseCatForm",
                    DBV             = false,
                    L = { 
                        enUS = "Use Cat form too DPS", 
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will use Cat form and cat form abilitys to do DPS, require you to stand in melee range of target and talent Feral Affinity",
                    }, 
                    M                 = {},
                },

            },
            {
                {
                    E                 = "Checkbox", 
                    DB                 = "RebirthInGroups",
                    DBV             = false,
                    L = { 
                        enUS = "Combat Ress in Group", 
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will use combat ress in Groups",
                    }, 
                    M                 = {},
                },
            },
            {
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "DPSAboveManaPvE",
                    DBV             = 55,
                    ONOFF             = true,
                    L = { 
                        enUS = "DPS only if mana is above or equal to %", 
                    }, 
                    TT = { 
                        enUS = "Move slider to what procent your mana should be equal to or above to DPS",
                    }, 
                    M                 = {},
                },
            },
            { -- General -- Header
                {
                    E = "Header",
                    L = {
                        ANY = " PvP Profile Options ",
                    },
                },
            },		
            {
                {
                    M                 = {},   
                    E                = "Checkbox",                                                                               
                    DB                 = "DPSinPvP",
                    DBV             = false,
                    L = { 
                        enUS = "DPS in PvP", 
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will use DPS spell in PvP",
                    },
                },
                {
                    E                 = "Checkbox", 
                    DB                 = "UseMoonkinFormPvP",
                    DBV             = false,
                    L = { 
                        enUS = "Use Moonkin form DPS Spells in PvP", 
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will cast Starsurge and Starfire in PvP, that require Moonkin Form",
                    }, 
                    M                 = {},
                },
                {
                    E                 = "Checkbox", 
                    DB                 = "AutoTargetingPvP",
                    DBV             = false,
                    L = { 
                        enUS = "Use auto targetting to swap between players for dot in PvP", 
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will auto targetting to swap between players for dot applying",
                    }, 
                    M                 = {},
                },
            },
            {
                {
                    M                 = {},   
                    E                = "Checkbox",                                                                               
                    DB                 = "UseCycloneInPvP",
                    DBV             = true,
                    L = { 
                        enUS = "Use Cyclone in PvP", 
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will use Cyclone in PvP, will try and focus healers when healing if in range and/or Convoke",
                    },
                    M                 = {},
                },
            },
            {
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "DPSAboveManaPvP",
                    DBV             = 65,
                    ONOFF             = true,
                    L = { 
                        enUS = "DPS only if mana is above or equal to % in PvP", 
                    }, 
                    TT = { 
                        enUS = "Move slider to what procent your mana should be equal to or above to DPS",
                    }, 
                    M                 = {},
                },
            },
            { -- General -- Header
                {
                    E = "Header",
                    L = {
                        ANY = " Raid Profile Options ",
                    },
                },
            },		
            {
                {
                    E                 = "Checkbox", 
                    DB                 = "AutoTargetingRaid",
                    DBV             = false,
                    L = { 
                        enUS = "Use auto targetting to swap and DPS in raid", 
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will auto targetting to swap between enemies to ",
                    }, 
                    M                 = {},
                },
                {
                    E                 = "Checkbox", 
                    DB                 = "DPSinRaid",
                    DBV             = false,
                    L = { 
                        enUS = "DPS In Raids", 
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will use DPS spells in Raid",
                    }, 
                    M                 = {},
                },
                {
                    E                 = "Checkbox", 
                    DB                 = "UseCatFormInRaid",
                    DBV             = false,
                    L = { 
                        enUS = "Use Cat form DPS in Raid", 
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will use Cat form and cat form abilitys to do DPS, require you to stand in melee range of target and talent Feral Affinity",
                    }, 
                    M                 = {},
                },
            },
            {
                {
                    M                 = {},   
                    E                = "Checkbox",                                                                               
                    DB                 = "UseMoonkinFormInRaid",
                    DBV             = false,
                    L = { 
                        enUS = "Use Moonkin DPS Spells in Raid", 
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will cast Starsurge and Starfire, that require Moonkin Form and talent Balance Affinity",
                    }, 
                    M                 = {},
                },
                {
                    M                 = {},   
                    E                = "Checkbox",                                                                               
                    DB                 = "HealRippedSoul",
                    DBV             = false,
                    L = { 
                        enUS = "Heal Ripped Soul in CN", 
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will Heal Ripped Soul in Castle Nathria if your target is Ripped Soul\nThis will prevent from auto swapping away from Ripped Soul",
                    }, 
                    M                 = {},
                },
                {
                    M                 = {},   
                    E                = "Checkbox",                                                                               
                    DB                 = "HealSunKing",
                    DBV             = false,
                    L = { 
                        enUS = "Heal SunKing in CN", 
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will Heal SunKing in Castle Nathria if your target is SunKing\nThis will prevent from auto swapping away from SunKing",
                    }, 
                    M                 = {},
                },
            },
            {
                {
                    M                 = {},   
                    E                = "Checkbox",                                                                               
                    DB                 = "RebirthInRaid",
                    DBV             = false,
                    L = { 
                        enUS = "Combat ress in Raid", 
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will use combat ress in Raids",
                    },
                },
            },
            {
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "DPSAboveManaRaid",
                    DBV             = 35,
                    ONOFF             = true,
                    L = { 
                        enUS = "DPS only if mana is above or equal to % in Raid", 
                    }, 
                    TT = { 
                        enUS = "Move slider to what procent your mana should be equal to or above to DPS",
                    }, 
                    M                 = {},
                },
            },
            { -- [2] Self Defensives 
                {
                    E                 = "Header",
                    L                 = L.genericHealerSettings,
                },
            },
            {
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "whenToDealDamage",
                    DBV             = 85,
                    ONOFF             = true,
                    L                 = L.whenToDealDmg,                
                    M                 = {},
                },
            },
            { -- [2] Self Defensives 
                {
                    E                 = "Header",
                    L                 = L.selfHealing,
                },
            },
            {
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "RejuvenationSelf",
                    DBV             = 90,
                    ONOFF             = true,
                    L                 = L.Rejuvenation,                
                    M                 = {},
                },
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "RegrowthSelf",
                    DBV             = 70,
                    ONOFF             = true,
                    L                 = L.Regrowth,                
                    M                 = {},
                },
            },
            {
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "RenewalSelf",
                    DBV             = 65,
                    ONOFF             = true,
                    L                 = L.Renewal,                
                    M                 = {},
                },
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "BarkSkinSelf",
                    DBV             = 65,
                    ONOFF             = true,
                    L                 = L.Barkskin,                
                    M                 = {},
                },
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "IronBarkSelf",
                    DBV             = 65,
                    ONOFF             = true,
                    L                 = L.Ironbark,                
                    M                 = {},
                },
            },
            { -- [2] Self Defensives 
                {
                    E                 = "Header",
                    L                 = L.partyHealing,
                },
            },
            {
                {
                    M                 = {},   
                    E                = "Checkbox",                                                                               
                    DB                 = "PrioGrievousWoundPartyMember",
                    DBV             = false,
                    L = { 
                        enUS = "M+ Affix - Regrowth Grievous Wound prio", 
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will Prio Grievous Wound party members and cast regrowth on them to remove Grievous Wound stacks",
                    },
                },  
                {
                    M                 = {},   
                    E                = "Checkbox",                                                                               
                    DB                 = "BurstAffixSpreadRejParty",
                    DBV             = false,
                    L = { 
                        enUS = "M+ Affix - Burst Rejuvenation all", 
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will Prio Rejuvenation party members to handle Burst M+ Affix",
                    },
                },  
            },
            {
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "RejuvenationParty",
                    DBV             = 95,
                    ONOFF             = true,
                    L                 = L.Rejuvenation,                
                    M                 = {},
                },
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "SwiftmendParty",
                    DBV             = 55,
                    ONOFF             = true,
                    L                 = L.Swiftmend,                
                    M                 = {},
                },
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "RegrowthParty",
                    DBV             = 75,
                    ONOFF             = true,
                    L                 = L.Regrowth,                
                    M                 = {},
                },
            },

            {
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "CenarionWardParty",
                    DBV             = 90,
                    ONOFF             = true,
                    L                 = L.CenarionWard,                
                    M                 = {},
                },
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "LifebloomParty",
                    DBV             = 85,
                    ONOFF             = true,
                    L                 = L.Lifebloom,                
                    M                 = {},
                },
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "IronBarkParty",
                    DBV             = 85,
                    ONOFF             = true,
                    L                 = L.Ironbark,                
                    M                 = {},
                },
            },
            { -- [2] Self Defensives 
                {
                    E                 = "Header",
                    L                 = L.AoEHealing,
                },
            },
            {
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "WildGrowthParty",
                    DBV             = 80,
                    ONOFF             = true,
                    L                 = L.WildGrowth,                
                    M                 = {},
                },
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 5,                            
                    DB                 = "WildGrowthPartyCount",
                    DBV             = 3,
                    ONOFF             = true,
                    L                 = L.WildGrowthCount,                
                    M                 = {},
                },
            },
            {
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "EfflorescenceParty",
                    DBV             = 70,
                    ONOFF             = true,
                    L                 = L.Efflorescence,                
                    M                 = {},
                },
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 5,                            
                    DB                 = "EfflorescencePartyCount",
                    DBV             = 3,
                    ONOFF             = true,
                    L                 = L.EfflorescenceCount,                
                    M                 = {},
                },
            },
            {
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "TranquilityParty",
                    DBV             = 60,
                    ONOFF             = true,
                    L                 = L.Tranquility,                
                    M                 = {},
                },
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 5,                            
                    DB                 = "TranquilityPartyCount",
                    DBV             = 3,
                    ONOFF             = true,
                    L                 = L.TranquilityCount,                
                    M                 = {},
                },
            },
            { -- [2] Self Defensives 
                {
                    E                 = "Header",
                    L                 = L.CDS,
                },
            },
            {
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "NaturesSwiftness",
                    DBV             = 50,
                    ONOFF             = true,
                    L                 = L.NaturesSwiftness,                
                    M                 = {},
                },
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "ConvokeTheSpiritsParty",
                    DBV             = 50,
                    ONOFF             = true,
                    L                 = L.ConvokeTheSpirits,                
                    M                 = {},
                },
            },
            {
                {
                },
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 5,                            
                    DB                 = "ConvokeTheSpiritsPartyCount",
                    DBV             = 3,
                    ONOFF             = true,
                    L                 = L.ConvokeTheSpirits,                
                    M                 = {},
                },
            },
            {
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "InnervateSelf",
                    DBV             = 40,
                    ONOFF             = true,
                    L                 = L.Innervate,                
                    M                 = {},
                },
            },
        },

        [ACTION_CONST_DRUID_GUARDIAN] = {             
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
                    DB                 = "HealingSurge",
                    DBV             = 60,
                    ONOFF             = true,
                    L                 = L.HealingSurge,                
                    M                 = {},
                },
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "HealingTotem",
                    DBV             = 75,
                    ONOFF             = true,
                    L                 = L.HealingTotem,                
                    M                 = {},
                },
            },
            {
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "AstralShift",
                    DBV             = 60,
                    ONOFF             = true,
                    L                 = L.AstralShift,                
                    M                 = {},
                },
            },
            { -- [2] Self Defensives 
                {
                    E                 = "Header",
                    L                 = L.CDS,
                },
            },
            {
                {
                    E                 = "Checkbox", 
                    DB                 = "Ascendance",
                    DBV             = true,
                    L                 = L.Ascendance,
                    M                 = {},
                },
                {
                    E                 = "Checkbox", 
                    DB                 = "Bloodlust",
                    DBV             = true,
                    L                 = L.Bloodlust,
                    M                 = {},
                },
                {
                    E                 = "Checkbox", 
                    DB                 = "Stormkeeper",
                    DBV             = true,
                    L                 = L.Stormkeeper,
                    M                 = {},
                },
            },  
            {
                {
                    E                 = "Checkbox", 
                    DB                 = "Fire Elemental",
                    DBV             = true,
                    L                 = L.FireElemental,
                    M                 = {},
                },
                {
                    E                 = "Checkbox", 
                    DB                 = "Earth Elemental",
                    DBV             = true,
                    L                 = L.EarthElemental,
                    M                 = {},
                },
            }, 
            
            { -- [2] Self Defensives 
                {
                    E                 = "Header",
                    L                 = L.Totems,
                },
            },
            {
                {
                    E                 = "Checkbox", 
                    DB                 = "Stun Totem",
                    DBV             = true,
                    L                 = L.StunTotem,
                    M                 = {},
                },
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 10,                            
                    DB                 = "Stun Totem Value",
                    DBV             = 3,
                    ONOFF             = true,
                    L                 = L.StunTotemSlider,                
                    M                 = {},
                },
            },  
        },
    }
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

