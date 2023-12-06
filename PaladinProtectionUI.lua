local _G, select, setmetatable = _G, select, setmetatable
local TMW = _G.TMW 
local A = _G.Action
local CONST = A.Const
local toNum = A.toNum
local Print = A.Print
local GetSpellInfo = A.GetSpellInfo
local GetToggle = A.GetToggle
local GetLatency = A.GetLatency
local InterruptIsValid = A.InterruptIsValid
local Unit = A.Unit 
local ACTION_CONST_PALADIN_PROTECTION = CONST.PALADIN_PROTECTION

local SliderMarginOptions = { 
    margin = { top = 10 } 
}
local LayoutConfigOptions = { 
    gutter = 4, 
    padding = { left = 5, right = 5 }
}

A.Data.ProfileEnabled[A.CurrentProfile] = true
A.Data.ProfileUI = {    
    DateTime = "v1.01 (11.01.2021)",
    [2] = {
        [ACTION_CONST_PALADIN_PROTECTION] = {
            LayoutOptions = LayoutConfigOptions,
            {
                {    
                    E = "Checkbox", 
                    DB = "ConsecrationWhileMoving",
                    DBV = false,
                    L = {enUS = "On Move Cast Consecration"}, 
                    TT = { enUS = "If the spell Consecration should be cast while moving."}, 
                    M = {},
                },
				{    
                    E = "Checkbox", 
                    DB = "PallyCleanse",
                    DBV = true,
                    L = {enUS = "Cleanse Self"}, 
                    TT = { enUS = "Toggle if Cleanse should be cast on self"}, 
                    M = {},
                },
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
            }, 
            {
                {
                    E = "Checkbox", 
                    DB = "BoP Party Members",
                    DBV = true,
                    L = { 
                        enUS = "Cast BoP on party members\nrequire specific binds - Beta", 
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will try and autotarget party members that are low and cast Blessing of Protection on them, require specific binds to work",
                    }, 
                    M = {},
                },
            },       
			{
                {
                    E = "Slider",                                                     
                    H = 20,
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "PallyAoeEnemyCount",
                    DBV = 3,
                    L = { enUS = "Enemies Present For Auto AoE"}, 
                    TT = { enUS = "Quantity of enemies within 10 yards to perform AoE rotation." },  
                    M = {
                    },
                },
            }, 			
            {
                {    
                    E = "Header",
                    L = {enUS = "Aura Configuration"}, 
                    S = 14,
                },
            },
            {
                {
                    E = "Dropdown", 
                    DB = "PallyCombatAura",
                    DBV = 2,
                    L = { enUS = "Combat Aura" },
                    TT = { enUS = "Which Aura to use when in combat or when dismounted." }, 
                    M = {},
                    H = 20,
                    OT = 
                    {
                        { text = 'Crusader', value = 1 },
                        { text = 'Devotion' , value = 2 },
                        { text = 'Concentration' , value = 3 },
                        { text = 'Retribution' , value = 4 },
                    }
                },
                {
                    E = "Dropdown", 
                    DB = "PallyOutOfCombatAura",
                    DBV = 1,
                    L = { enUS = "Mounted Aura" },
                    TT = { enUS = "Which Aura to use when Mounted" }, 
                    M = {},
                    H = 20,
                    OT = 
                    {
                        { text = 'Crusader', value = 1 },
                        { text = 'Devotion' , value = 2 },
                        { text = 'Concentration' , value = 3 },
                        { text = 'Retribution' , value = 4 },
                    }
                },
            },
            {
                {    
                    E = "Header",
                    L = {enUS = "Spell Max Cast Range Configuration"}, 
                    S = 14,
                },
            },
            {
                {
                    E = "Slider",                                                     
                    H = 20,
                    MIN = 0, 
                    MAX = 30,                            
                    DB = "PallyJudgementMaxRange",
                    DBV = 30,
                    L = { enUS = "Judgement Max Range"}, 
                    TT = { enUS = "Maximum range an enemy can be for Judgement to cast." },  
                    M = {
                    },
                },
                {
                    E = "Slider",                                                     
                    H = 20,
                    MIN = 0, 
                    MAX = 30,                            
                    DB = "PallyAvengersShieldMaxRange",
                    DBV = 30,
                    L = { enUS = "Avenger's Shield Max Range"}, 
                    TT = { enUS = "Maximum range an enemy can be for Avenger's Shield to cast." },  
                    M = {
                    },
                },
            },
            {
                {
                    E = "Slider",                                                     
                    H = 20,
                    MIN = 0, 
                    MAX = 30,                            
                    DB = "PallyHammerOfWrathMaxRange",
                    DBV = 30,
                    L = { enUS = "Hammer of Wrath Max Range"}, 
                    TT = { enUS = "Maximum range an enemy can be for Hammer of Wrath to cast." },  
                    M = {
                    },
                },
                {
                    E = "Slider",                                                     
                    H = 20,
                    MIN = 0, 
                    MAX = 30,                            
                    DB = "PallyHandOfReckoningMaxRange",
                    DBV = 30,
                    L = { enUS = "Hand of Reckoning Max Range"}, 
                    TT = { enUS = "Maximum range an enemy can be for Hand of Reckoning to cast." },  
                    M = {
                    },
                },
            },
            {
                {    
                    E = "Header",
                    L = {enUS = "Mitigation Minimum Health Configuration"}, 
                    S = 14,
                },
            },
            {
                {
                    E = "Slider",                                                     
                    H = 20,
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "PallyWordOfGloryHealth",
                    DBV = 30,
                    L = { enUS = "Word of Glory"}, 
                    TT = { enUS = "Spell will cast when HP is less than or equal to this value." },  
                    M = {
                    },
                },
                {
                    E = "Slider",                                                     
                    H = 20,
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "PallyWordOfGloryHealthShiningLight",
                    DBV = 50,
                    L = { enUS = "Word of Glory With Shining Light"}, 
                    TT = { enUS = "Spell will cast when HP is less than or equal to this value with Shining Light." },  
                    M = {
                    },
                },
                {
                    E = "Slider",                                                     
                    H = 20,
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "PallyArgentDefenderHealth",
                    DBV = 40,
                    L = { enUS = "Argent Defender"}, 
                    TT = { enUS = "Spell will cast when HP is less than or equal to this value." },  
                    M = {
                    },
                },
            },
            {
                {
                    E = "Checkbox",                                                     
                    DB = "PallyDivineShieldSolo",
                    DBV = true,
                    L = { enUS = "Divine Shield Solo"}, 
                    TT = { enUS = "If Divine shield should be cast when not in a group." },  
                    M = {
                    },
                },
            },
            {
                {
                    E = "Slider",                                                     
                    H = 20,
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "PallyGuardianOfAncientKingsHealth",
                    DBV = 20,
                    L = { enUS = "Guardian of Ancient Kings"}, 
                    TT = { enUS = "Spell will cast when HP is less than or equal to this value." },  
                    M = {
                    },
                },
                {
                    E = "Slider",                                                     
                    H = 20,
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "PallyLayOnHandsHealth",
                    DBV = 10,
                    L = { enUS = "Lay On Hands"}, 
                    TT = { enUS = "Spell will cast when HP is less than or equal to this value." },  
                    M = {
                    },
                },        
                {
                    E = "Slider",                                                     
                    H = 20,
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "PallyFinalStandHealth",
                    DBV = 10,
                    L = { enUS = "Final Stand / Divine Shield"}, 
                    TT = { enUS = "Spell will cast when HP is less than or equal to this value. NOTE: Divine Shield will only cast if enabled in solo mode or Final stand talent is learned in party." },  
                    M = {
                    },
                },
            },
            {
                {
                    E = "Slider",                                                     
                    H = 20,
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "PallyBoPAllies",
                    DBV = 10,
                    L = { enUS = "Blessing of Protection allies"}, 
                    TT = { enUS = "If Friendly mouseover targets health below X percent, Cast Blessing of Protection on Mouseover target." },  
                    M = {
                    },
                },
            },

            {
                {    
                    E = "Header",
                    L = {enUS = "Out of Combat Healing Settings"}, 
                    S = 14,
                },
            },
            {      
                {
                    E = "Slider",                                                     
                    H = 20,
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "PallySoloOutOfCombatHealingHealthPercent",
                    DBV = 85,
                    L = { enUS = "Solo Min HP for self heal After combat"}, 
                    TT = { enUS = "If health below this point self healing will initiate after combat." },  
                    M = {
                    },
                },
                {
                    E = "Slider",                                                     
                    H = 20,
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "PallyGroupOutOfCombatHealingHealthPercent",
                    DBV = 30,
                    L = { enUS = "Group Min HP for after combat healing"}, 
                    TT = { enUS = "If health below this point self/Targeted healing will initiate after combat. NOTE: This setting only applies while in a party." },  
                    M = {
                    },
                },
            },


            {
                {    
                    E = "Header",
                    L = {enUS = "PVP Settings"}, 
                    S = 14,
                },
            },
            {      
                {
                    E = "Slider",                                                     
                    H = 20,
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "PallyPvpDivineShieldHealth",
                    DBV = 10,
                    L = { enUS = "Divine Shield"}, 
                    TT = { enUS = "[PVP ONLY] Spell will cast when HP is less than or equal to this value." },  
                    M = {
                    },
                },
            },
        }
    }
}

