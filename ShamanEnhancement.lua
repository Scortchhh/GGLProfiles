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
local Combat                        = Action.Combat

local DisarmIsReady                            = Action.DisarmIsReady

local ACTION_CONST_SHAMAN_ENCHANCEMENT             = CONST.SHAMAN_ENCHANCEMENT
local ACTION_CONST_AUTOTARGET                = CONST.AUTOTARGET
local ACTION_CONST_SPELLID_FREEZING_TRAP    = CONST.SPELLID_FREEZING_TRAP

local IsIndoors, UnitIsUnit                    = _G.IsIndoors, _G.UnitIsUnit
local ActiveUnitPlates                          = MultiUnits:GetActiveUnitPlates()

Action[ACTION_CONST_SHAMAN_ENCHANCEMENT] = {
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

    -- Healing
    HealingSurge                                = Create({ Type = "Spell", ID = 8004                                               }),
    -- CDS
    FeralSpirits                                = Create({ Type = "Spell", ID = 51533                                               }),
    EarthElemental                                = Create({ Type = "Spell", ID = 198103                                               }),
    Ascendance                                = Create({ Type = "Spell", ID = 114051                                               }),
    Heroism                                = Create({ Type = "Spell", ID = 32182                                               }),
    BloodlustPvP                                = Create({ Type = "Spell", ID = 204361                                               }),
    Bloodlust                                = Create({ Type = "Spell", ID = 2825                                               }),
    Sundering                                = Create({ Type = "Spell", ID = 197214                                               }),
    Stormkeeper                                = Create({ Type = "Spell", ID = 191634                                               }),
    Shamanism                              = Create({ Type = "Spell", ID = 193876, Hidden = true     }),
    --totems
    HealingTotem                                = Create({ Type = "Spell", ID = 5394                                               }),
    StunTotem                                = Create({ Type = "Spell", ID = 192058                                               }),
    StunTotemGreen                        = Create({ Type = "SpellSingleColor", ID = 192058, Color = "GREEN", Desc = "[1] CC", QueueForbidden = true    }),
    SlowTotem                                = Create({ Type = "Spell", ID = 2484                                               }),
    WindFuryTotem                                = Create({ Type = "Spell", ID = 8512                                               }),
    TremorTotem                                = Create({ Type = "Spell", ID = 8143                                               }),
    CounterStrikeTotem                                = Create({ Type = "Spell", ID = 204331                                               }),
    GroundingTotem                                = Create({ Type = "Spell", ID = 204336                                               }),
    Skyfury                                = Create({ Type = "Spell", ID = 204330                                               }),
    -- Rotation       
    Stormstrike                                = Create({ Type = "Spell", ID = 17364                                               }),
    Windstrike                                = Create({ Type = "Spell", ID = 115356                                               }),
    LavaLash                                = Create({ Type = "Spell", ID = 60103                                               }),
    FrostShock                                = Create({ Type = "Spell", ID = 196840                                               }),
    FlameShock                                = Create({ Type = "Spell", ID = 188389                                               }),
    LightningBolt                                = Create({ Type = "Spell", ID = 188196                                               }),
    ChainLightning                                = Create({ Type = "Spell", ID = 188443                                               }),
    CrashLightning                                = Create({ Type = "Spell", ID = 187874                                               }),
    ElementalBlast                                = Create({ Type = "Spell", ID = 117014                                               }),
    IceStrike                                = Create({ Type = "Spell", ID = 342240                                               }),
    FireNova                                = Create({ Type = "Spell", ID = 333974                                               }),
    EarthenSpike                                = Create({ Type = "Spell", ID = 188089                                               }),
    FeralLunge                                = Create({ Type = "Spell", ID = 196884                                               }),


}

Action:CreateEssencesFor(ACTION_CONST_SHAMAN_ENCHANCEMENT)
local A = setmetatable(Action[ACTION_CONST_SHAMAN_ENCHANCEMENT], { __index = Action })
local player                                 = "player"
local Temp                                     = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                        = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                 = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMagPhys                            = {"TotalImun", "DamageMagicImun", "DamagePhysImun"},
    DisablePhys                                = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    BerserkerRageLoC                        = {"FEAR", "INCAPACITATE"},
    IsSlotTrinketBlocked                    = {},
}; do        
    -- Push IsSlotTrinketBlocked
    for key, val in pairs(Action[ACTION_CONST_SHAMAN_ENCHANCEMENT]) do 
        if type(val) == "table" and val.Type == "Trinket" then 
            Temp.IsSlotTrinketBlocked[val.ID] = true
        end 
    end 
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