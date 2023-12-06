--#########################################
--##### TEAM SCORTCH PRIEST PROFILEUI #####
--#########################################


local TMW											= TMW 
local CNDT											= TMW.CNDT
local Env											= CNDT.Env

local A												= Action
local GetToggle										= A.GetToggle
local InterruptIsValid								= A.InterruptIsValid

local UnitCooldown									= A.UnitCooldown
local Unit											= A.Unit 
local Player										= A.Player 
local Pet											= A.Pet
local LoC											= A.LossOfControl
local MultiUnits									= A.MultiUnits
local EnemyTeam										= A.EnemyTeam
local FriendlyTeam									= A.FriendlyTeam
local TeamCache										= A.TeamCache
local InstanceInfo									= A.InstanceInfo
local select, setmetatable							= select, setmetatable


A.Data.ProfileEnabled[Action.CurrentProfile] = true
A.Data.ProfileUI = {    
    DateTime = "v1.0.0 (23 Feb 2021)",
    -- Class settings
    [2] = {        
        [ACTION_CONST_PRIEST_SHADOW] = {  
            { -- General -- Header
                {
                    E = "Header",
                    L = {
                        ANY = " --> GENERAL <-- ",
                    },
                },
            },		
            { -- General -- Content
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
				{ -- Mouseover
                    E = "Checkbox", 
                    DB = "MultiDoTCheck",
                    DBV = true,
                    L = { 
                        ANY = "Auto MultiDoT"
                    }, 
                    TT = { 
                        ANY = "If enabled : Will automatically swap targets to spread DoTs"
                    }, 
                    M = {},
                },
			},
			{
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
                    E = "Checkbox", 
                    DB = "HorrorInterrupt",
                    DBV = true,
                    L = { 
                        ANY = "Psychic Horror Interrupt"
                    }, 
                    TT = { 
                        ANY = "If enabled : Will use Psychic Horror to interrupt"
                    }, 
                    M = {},
                },
				{
                    E = "Checkbox", 
                    DB = "ScreamInterrupt",
                    DBV = false,
                    L = { 
                        ANY = "Psychic Scream Interrupt"
                    }, 
                    TT = { 
                        ANY = "If enabled : Will use Psychic Scream to interrupt"
                    }, 
                    M = {},
                },
			},
			{
				{
						E = "Slider",                                                     
						MIN = 2, 
						MAX = 10,                            
						DB = "VTmaxTargets",
						DBV = 7, 
						ONOFF = false,
						L = { 
							ANY = "Targets to spread VT",
						}, 
						M = {},
				}, 
				{
						E = "Slider",                                                     
						MIN = 2, 
						MAX = 10,                            
						DB = "SWPmaxTargets",
						DBV = 11, 
						ONOFF = true,
						L = { 
							ANY = "Targets to spread SW:P",
						}, 
						M = {},
				},
			},
			{
                {
                    E 		= "Slider", 													
					MIN 	= 10, 
					MAX 	= 40,							
					DB 		= "MultiDotDistance",
					DBV 	= 25,
					ONLYOFF = true,
					L 		= { 
                        enUS = "Multidots Range", 
                    }, 
					TT		= { 
                        enUS = "Choose the range where you want to automatically multidots units.", 
                    }, 
					M 		= {},
                },					 
				{
						E = "Slider",                                                     
						MIN = 0, 
						MAX = 5,                            
						DB = "PWSTime",
						DBV = -1, 
						ONOFF = true,
						L = { 
							ANY = "PW:S Delay",
						}, 
						M = {},
				},
			},
			{
				{
                    E 		= "Slider", 													
					MIN 	= 0, 
					MAX 	= 100,							
					DB 		= "TargetSwapDelay",
					DBV 	= 0,
					ONLYOFF = true,
					L 		= { 
                        enUS = "Target Swap Delay (ms)", 
                    }, 
					TT		= { 
                        enUS = "Set a delay when swapping targets.", 
                    }, 
					M 		= {},
                },
				{
                    E 		= "Slider", 													
					MIN 	= 0, 
					MAX 	= 100,							
					DB 		= "VTCastDelay",
					DBV 	= 20,
					ONLYOFF = true,
					L 		= { 
                        enUS = "Vamperic Touch Delay (ms)", 
                    }, 
					TT		= { 
                        enUS = "Set a delay to prevent VT from double casting", 
                    }, 
					M 		= {},
                },
			},
            { -- Spacer

                {
                    E = "LayoutSpace",                                                                        
                },
            },
            { -- Spacer
                {
                    E = "LayoutSpace",                                                                         
                },
            },			
			{ -- Defensives -- Header
                {
                    E = "Header",
                    L = {
                        ANY = " --> DEFENSIVES <-- ",
                    },
                },
            },			
            { -- Defensives
                { -- Desperate Prayer
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "DesperatePrayer",
                    DBV = 100, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(19236) .. " HP (%)",
                    }, 
                    M = {},
                },
			},
			{-- Defensives Cont.
				{ -- Vamperic Emprace
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "VampiricEmbrace",
                    DBV = 100, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(15286) .. " HP (%)",
                    }, 
                    M = {},
                },
				{ -- Dispersion
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "Dispersion",
                    DBV = 100, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(47585) .. " HP (%)",
                    }, 
                    M = {},
                },
            },
            { -- Spacer

                {
                    E = "LayoutSpace",                                                                         
                },
            },
        },

    },
    -- MSG Actions UI
    [7] = {
        [ACTION_CONST_PRIEST_SHADOW] = { 
            ["dispel"] = { Enabled = true, Key = "SingeMagic", LUAVER = 5, LUA = [[
                return     DispelIsReady(thisunit, true, true)
            ]] },
            ["reflect"] = { Enabled = true, Key = "NetherWard", LUAVER = 5, LUA = [[
                return     ReflectIsReady(thisunit, true, true)
            ]] },
        },
        [ACTION_CONST_PRIEST_HOLY] = { 
            ["dispel"] = { Enabled = true, Key = "SingeMagic", LUAVER = 5, LUA = [[
                return     DispelIsReady(thisunit, true, true)
            ]] },
            ["reflect"] = { Enabled = true, Key = "NetherWard", LUAVER = 5, LUA = [[
                return     ReflectIsReady(thisunit, true, true)
            ]] },

        },
 
    },
}


-----------------------------------------
--                   PvP  
-----------------------------------------
-- SingeMagic
function A.DispelIsReady(unit, isMsg, skipShouldStop)
	if Unit(unit):IsPlayer() then 
        if not isMsg then		
            return not Unit(unit):IsEnemy() and not Unit(unit):InLOS() and A[A.PlayerSpec].SingeMagic:IsReady(unit, nil, nil, true) and A.AuraIsValid(unit, "UseDispel", "Dispel")
		else
		    -- Notification			
			-- Mate in raid need to create a macro with their Index by doing this in game : /script print(UnitInRaid("player"))	
            -- 	
            A.SendNotification("Dispel requested by : " .. UnitName(unit), 119905)
		    return A[A.PlayerSpec].SingeMagic:IsReadyM(unit) 
		end
    end 
end 

-- NetherWard spell Reflect
function A.ReflectIsReady(unit, isMsg, skipShouldStop)
    if A[A.PlayerSpec].NetherWard then 
        local unitID = A.GetToggle(2, "ReflectPvPunits")
        return     (
            (unit == "arena1" and unitID[1]) or 
            (unit == "arena2" and unitID[2]) or
            (unit == "arena3" and unitID[3]) or
            (not unit:match("arena") and unitID[4]) 
        ) and 
        A.IsInPvP and
        Unit(unit):IsEnemy() and  
        (
            (
                not isMsg and 
                A.GetToggle(2, "ReflectPvP") ~= "OFF" and 
                A[A.PlayerSpec].NetherWard:IsReady(unit, nil, nil, skipShouldStop) and
                (
                    A.GetToggle(2, "ReflectPvP") == "ON COOLDOWN" or 
                    (A.GetToggle(2, "ReflectPvP") == "DANGEROUS CAST" and EnemyTeam():IsCastingBreakAble(0.25))
                )
            ) or 
            (
                isMsg and 
                A[A.PlayerSpec].NetherWard:IsReadyM(unit)                     
            )
        ) and 
        Unit(unit):IsPlayer()
    end 
end 

function A.Main_CastBars(unit, list)
    if not A.IsInitialized or A.IamHealer or (A.Zone ~= "arena" and A.Zone ~= "pvp") then 
        return false 
    end 
    
    if A[A.PlayerSpec] and A[A.PlayerSpec].PetKick and A[A.PlayerSpec].PetKick:IsReadyP(unit, nil, true) and A[A.PlayerSpec].PetKick:AbsentImun(unit, {"KickImun", "TotalImun", "TotalAndMag"}, true) and A.InterruptIsValid(unit, list) then 
        return true         
    end 
end 

function A.Second_CastBars(unit)
    if not A.IsInitialized or (A.Zone ~= "arena" and A.Zone ~= "pvp")  then 
        return false 
    end 
    
    local Toggle = A.GetToggle(2, "FearPvP")    
    if Toggle and Toggle ~= "OFF" and A[A.PlayerSpec] and A[A.PlayerSpec].Fear and A[A.PlayerSpec].Fear:IsReadyP(unit, nil, true) and A[A.PlayerSpec].Fear:AbsentImun(unit, {"CCTotalImun", "TotalImun", "TotalAndMag"}, true) and Unit(unit):IsControlAble("disorient", 0) then 
        if Toggle == "BOTH" then 
            return select(2, A.InterruptIsValid(unit, "Heal", true)) or select(2, A.InterruptIsValid(unit, "PvP", true)) 
        else
            return select(2, A.InterruptIsValid(unit, Toggle, true))         
        end 
    end 
end 