local _G, setmetatable, pairs, type, math    = _G, setmetatable, pairs, type, math
local huge                                     = math.huge

local TMW                                     = _G.TMW 

local Action                                 = _G.Action

local CONST                                 = Action.Const
local Listener                                 = Action.Listener
local Create                                 = Action.Create
local GetToggle                                = Action.GetToggle
local GetLatency                            = Action.GetLatency
local GetGCD                                = Action.GetGCD
local GetCurrentGCD                            = Action.GetCurrentGCD
local ShouldStop                            = Action.ShouldStop
local BurstIsON                                = Action.BurstIsON
local AuraIsValid                            = Action.AuraIsValid
local InterruptIsValid                        = Action.InterruptIsValid
local DetermineUsableObject                    = Action.DetermineUsableObject
local Pet                    = LibStub("PetLibrary")

local Utils                                    = Action.Utils
local BossMods                                = Action.BossMods
local TeamCache                                = Action.TeamCache
local EnemyTeam                                = Action.EnemyTeam
local FriendlyTeam                            = Action.FriendlyTeam
local LoC                                     = Action.LossOfControl
local Player                                = Action.Player 
local MultiUnits                            = Action.MultiUnits
local UnitCooldown                            = Action.UnitCooldown
local Unit                                    = Action.Unit 
local IsUnitEnemy                            = Action.IsUnitEnemy
local IsUnitFriendly                        = Action.IsUnitFriendly

local DisarmIsReady                            = Action.DisarmIsReady

local Azerite                                 = LibStub("AzeriteTraits")

local ACTION_CONST_SHAMAN_ELEMENTAL             = CONST.SHAMAN_ELEMENTAL
local ACTION_CONST_AUTOTARGET                = CONST.AUTOTARGET
local ACTION_CONST_SPELLID_FREEZING_TRAP    = CONST.SPELLID_FREEZING_TRAP

local IsIndoors, UnitIsUnit                    = _G.IsIndoors, _G.UnitIsUnit
local ActiveUnitPlates                          = MultiUnits:GetActiveUnitPlates()

Action[ACTION_CONST_SHAMAN_ELEMENTAL] = {
    -- Racial
    ArcaneTorrent                             = Create({ Type = "Spell", ID = 50613                                                                             }),
    BloodFury                                 = Create({ Type = "Spell", ID = 20572                                                                              }),
    Fireblood                                   = Create({ Type = "Spell", ID = 265221                                                                             }),
    AncestralCall                              = Create({ Type = "Spell", ID = 274738                                                                             }),
    Berserking                                = Create({ Type = "Spell", ID = 26297                                                                            }),
    ArcanePulse                                  = Create({ Type = "Spell", ID = 260364                                                                            }),
    QuakingPalm                                  = Create({ Type = "Spell", ID = 107079                                                                             }),
    Haymaker                                  = Create({ Type = "Spell", ID = 287712                                                                             }), 
    WarStomp                                  = Create({ Type = "Spell", ID = 20549                                                                             }),
    BullRush                                  = Create({ Type = "Spell", ID = 255654                                                                             }),    
    BagofTricks                               = Create({ Type = "Spell", ID = 312411                                                                             }),    
    GiftofNaaru                               = Create({ Type = "Spell", ID = 59544                                                                            }),
    LightsJudgment                               = Create({ Type = "Spell", ID = 255647                                                                            }),
    Shadowmeld                                  = Create({ Type = "Spell", ID = 58984                                                                            }), -- usable in Action Core 
    Stoneform                                  = Create({ Type = "Spell", ID = 20594                                                                            }), 
    WilloftheForsaken                          = Create({ Type = "Spell", ID = 7744                                                                            }), -- usable in Action Core 
    EscapeArtist                              = Create({ Type = "Spell", ID = 20589                                                                            }), -- usable in Action Core 
    EveryManforHimself                          = Create({ Type = "Spell", ID = 59752                                                                            }), -- usable in Action Core  
    Regeneratin                                  = Create({ Type = "Spell", ID = 291944                                                                            }), -- not usable in APL but user can Queue it
    -- Defensives
    AstralShift                                = Create({ Type = "Spell", ID = 108271                                               }),
    LightningShield                                = Create({ Type = "Spell", ID = 192106                                               }),
    EarthShield                                = Create({ Type = "Spell", ID = 974                                               }),
    -- Healing
    HealingSurge                                = Create({ Type = "Spell", ID = 8004                                               }),
    -- CDS

    -- Rotation       
    Stormstrike                                = Create({ Type = "Spell", ID = 17364                                               }),
    Windstrike                                = Create({ Type = "Spell", ID = 115356                                               }),
    Primalstrike                                = Create({ Type = "Spell", ID = 73899                                               }),
    LavaLash                                = Create({ Type = "Spell", ID = 60103                                               }),
    LavaBurst                                = Create({ Type = "Spell", ID = 51505                                               }),
    EarthShock                                = Create({ Type = "Spell", ID = 8042                                               }),
    FrostShock                                = Create({ Type = "Spell", ID = 196840                                               }),
    FlameShock                                = Create({ Type = "Spell", ID = 188389                                               }),
    EchoingShock                                = Create({ Type = "Spell", ID = 320125                                               }),
    LightningBolt                                = Create({ Type = "Spell", ID = 188196                                               }),
    ChainLightning                                = Create({ Type = "Spell", ID = 188443                                               }),
    CrashLightning                                = Create({ Type = "Spell", ID = 187874                                               }),
    ElementalBlast                                = Create({ Type = "Spell", ID = 117014                                               }),
    IceStrike                                = Create({ Type = "Spell", ID = 342240                                               }),
    FireNova                                = Create({ Type = "Spell", ID = 333974                                               }),
    EarthenSpike                                = Create({ Type = "Spell", ID = 188089                                               }),
    FeralLunge                                = Create({ Type = "Spell", ID = 196884                                               }),
    Icefury                                = Create({ Type = "Spell", ID = 210714                                               }),
    IcefuryBuff                            = Create({ Type = "Spell", ID = 210714, Hidden = true     }),
    StaticDischarge                                = Create({ Type = "Spell", ID = 342243                                               }),
    LiquidMagmaTotem                       = Create({ Type = "Spell", ID = 192222 }),
    AncestralGuidance                      = Create({ Type = "Spell", ID = 108281 }), 
    FlameShockDebuff                       = Create({ Type = "Spell", ID = 188389, Hidden = true }),
    WindGustBuff                           = Create({ Type = "Spell", ID = 263806, Hidden = true     }),
    MasteroftheElements                    = Create({ Type = "Spell", ID = 16166 }),
    MasteroftheElementsBuff                = Create({ Type = "Spell", ID = 260734 , Hidden = true     }),
    LavaSurgeBuff                          = Create({ Type = "Spell", ID = 77762 , Hidden = true     }),
    AscendanceBuff                         = Create({ Type = "Spell", ID = 114050 , Hidden = true     }),
    LavaBeam                               = Create({ Type = "Spell", ID = 114074 }),
    IgneousPotential                       = Create({ Type = "Spell", ID = 279829 }),
    SurgeofPowerBuff                       = Create({ Type = "Spell", ID = 285514 , Hidden = true     }),
    NaturalHarmony                         = Create({ Type = "Spell", ID = 278697 }),
    SurgeofPower                           = Create({ Type = "Spell", ID = 262303 }),
    LavaShock                              = Create({ Type = "Spell", ID = 273448 }),
    LavaShockBuff                          = Create({ Type = "Spell", ID = 273453 , Hidden = true     }),
    CalltheThunder                         = Create({ Type = "Spell", ID = 260897 }),
    EchooftheElementals                    = Create({ Type = "Spell", ID = 275381 }),
    EchooftheElements                      = Create({ Type = "Spell", ID = 108283 }),
    ResonanceTotemBuff                     = Create({ Type = "Spell", ID = 202192 , Hidden = true     }),
    TectonicThunder                        = Create({ Type = "Spell", ID = 286949 }),
    TectonicThunderBuff                    = Create({ Type = "Spell", ID = 286949 , Hidden = true     }),
    UnlimitedPower                         = Create({ Type = "Spell", ID = 260895}),
    CallLightning                          = Create({ Type = "Spell", ID = 157348 , Hidden = true     }),
    ChainHarvest                                = Create({ Type = "Spell", ID = 320674                                               }),

}

Action:CreateEssencesFor(ACTION_CONST_SHAMAN_ELEMENTAL)
local A = setmetatable(Action[ACTION_CONST_SHAMAN_ELEMENTAL], { __index = Action })

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end

local player                                 = "player"
local Temp                                     = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndCC                              = {"TotalImun", "CCTotalImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
    TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
    DisablePhys                             = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                              = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
    BerserkerRageLoC                        = {"FEAR", "INCAPACITATE"},
    IsSlotTrinketBlocked                    = {},
}; do        
    -- Push IsSlotTrinketBlocked
    for key, val in pairs(Action[ACTION_CONST_SHAMAN_ELEMENTAL]) do 
        if type(val) == "table" and val.Type == "Trinket" then 
            Temp.IsSlotTrinketBlocked[val.ID] = true
        end 
    end 
end 

local IsIndoors, UnitIsUnit, UnitName = IsIndoors, UnitIsUnit, UnitName

local function IsSchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 


--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)



    
    -- Mouseover
    if A.IsUnitEnemy("mouseover") then
        unit = "mouseover"
        if MouseoverRotation(unit) then 
            return true 
        end 
    end 
    
    -- Target  
    if A.IsUnitEnemy("target") then 
        unit = "target"
        if EnemyRotation(unit) then 
            return true
        end 
        
    end

end

A[1] = nil
A[2] = nil
A[4] = nil
A[5] = nil
A[6] = nil
A[7] = nil
A[8] = nil