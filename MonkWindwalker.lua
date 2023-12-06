local _G, setmetatable                           = _G, setmetatable
local ACTION                                    = _G.Action
local Covenant                                    = _G.LibStub("Covenant")
local TMW                                     = _G.TMW 
local Action                                 = _G.Action
local CONST                                 = Action.Const
local Listener                                 = Action.Listener
local Create                                 = Action.Create
local GetToggle                                = Action.GetToggle
local SetToggle                                = Action.SetToggle
local GetLatency                            = Action.GetLatency
local GetGCD                                = Action.GetGCD
local GetCurrentGCD                            = Action.GetCurrentGCD
local ShouldStop                            = Action.ShouldStop
local BurstIsON                                = Action.BurstIsON
local AuraIsValid                            = Action.AuraIsValid
local AuraIsValidByPhialofSerenity            = Action.AuraIsValidByPhialofSerenity
local InterruptIsValid                        = Action.InterruptIsValid
local FrameHasSpell                            = Action.FrameHasSpell
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
local ActiveUnitPlates                          = MultiUnits:GetActiveUnitPlates()
local IsIndoors, UnitIsUnit, UnitIsPlayer       = IsIndoors, UnitIsUnit, UnitIsPlayer
local pairs                                     = pairs
local GrappleWeaponIsReady                    = Action.GrappleWeaponIsReady

local ACTION_CONST_MONK_WINDWALKER            = CONST.MONK_WINDWALKER
local ACTION_CONST_AUTOTARGET                = CONST.AUTOTARGET
local ACTION_CONST_SPELLID_FREEZING_TRAP    = CONST.SPELLID_FREEZING_TRAP

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

Action[ACTION_CONST_MONK_WINDWALKER] = {
    -- Racial
    ArcaneTorrent                    = Action.Create({ Type = "Spell", ID = 50613    }),
    BloodFury                        = Action.Create({ Type = "Spell", ID = 20572    }),
    Fireblood                        = Action.Create({ Type = "Spell", ID = 265221   }),
    AncestralCall                    = Action.Create({ Type = "Spell", ID = 274738   }),
    Berserking                        = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                        = Action.Create({ Type = "Spell", ID = 260364   }),
    QuakingPalm                        = Action.Create({ Type = "Spell", ID = 107079   }),
    Haymaker                        = Action.Create({ Type = "Spell", ID = 287712   }), 
    WarStomp                        = Action.Create({ Type = "Spell", ID = 20549    }),
    BullRush                        = Action.Create({ Type = "Spell", ID = 255654   }),  
    GiftofNaaru                        = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                        = Action.Create({ Type = "Spell", ID = 58984    }), 
    Stoneform                        = Action.Create({ Type = "Spell", ID = 20594    }), 
    BagofTricks                        = Action.Create({ Type = "Spell", ID = 312411    }),
    WilloftheForsaken                = Action.Create({ Type = "Spell", ID = 7744        }),   
    EscapeArtist                    = Action.Create({ Type = "Spell", ID = 20589    }), 
    EveryManforHimself                = Action.Create({ Type = "Spell", ID = 59752    }), 
    LightsJudgment                    = Action.Create({ Type = "Spell", ID = 255647    }),
    RocketJump                        = Action.Create({ Type = "Spell", ID = 69070    }),
    DarkFlight                        = Action.Create({ Type = "Spell", ID = 68992    }),
    
    -- Monk General
    BlackoutKick                    = Action.Create({ Type = "Spell", ID = 100784    }),
    CracklingJadeLightning          = Action.Create({ Type = "Spell", ID = 117952    }),    
    Detox                             = Action.Create({ Type = "Spell", ID = 218164    }),    
    ExpelHarm                        = Action.Create({ Type = "Spell", ID = 322101    }),
    FortifyingBrew                  = Action.Create({ Type = "Spell", ID = 243435    }),    
    LegSweep                        = Action.Create({ Type = "Spell", ID = 119381    }),
    MarkoftheCrane                  = Action.Create({ Type = "Spell", ID = 228287    }),    
    MysticTouch                       = Action.Create({ Type = "Spell", ID = 8647, Hidden = true         }),
    Paralysis                        = Action.Create({ Type = "Spell", ID = 344359    }),
    Provoke                            = Action.Create({ Type = "Spell", ID = 115546    }),
    Resuscitate                        = Action.Create({ Type = "Spell", ID = 115178    }),    
    Roll                            = Action.Create({ Type = "Spell", ID = 109132    }),    
    SpinningCraneKick               = Action.Create({ Type = "Spell", ID = 101546    }),
    TigerPalm                        = Action.Create({ Type = "Spell", ID = 100780    }),
    RushingTigerPalm                = Action.Create({ Type = "Spell", ID = 337341    }),
    TouchofDeath                       = Action.Create({ Type = "Spell", ID = 325215    }),
    Transcendence                   = Action.Create({ Type = "Spell", ID = 101649    }),
    TranscendenceTransfer           = Action.Create({ Type = "Spell", ID = 119996    }),
    Vivify                           = Action.Create({ Type = "Spell", ID = 116670, predictName = "Vivify",    }),
    ZenFlight                       = Action.Create({ Type = "Spell", ID = 125883    }),
    ZenPilgrimage                      = Action.Create({ Type = "Spell", ID = 126892    }),
    
    -- WindWalker Specific
    Disable                           = Action.Create({ Type = "Spell", ID = 116095    }),
    FistsofFury                       = Action.Create({ Type = "Spell", ID = 113656    }),
    FlyingSerpentKick               = Action.Create({ Type = "Spell", ID = 101545    }),
    FlyingSerpentKickJump           = Action.Create({ Type = "Spell", ID = 115057    }), -- Action ID of FlyingSerpentKick
    InvokeXuen                       = Action.Create({ Type = "Spell", ID = 323999    }),
    RisingSunKick                   = Action.Create({ Type = "Spell", ID = 107428    }),
    SpearHandStrike                   = Action.Create({ Type = "Spell", ID = 116705    }),
    StormEarthAndFire               = Action.Create({ Type = "Spell", ID = 137639              }), 
    StormEarthAndFireFixate         = Action.Create({ Type = "Spell", ID = 221771           }), -- while StormEarthAndFire buff
    TouchofKarma                       = Action.Create({ Type = "Spell", ID = 122470    }),
    SpinningCraneKick               = Action.Create({ Type = "Spell", ID = 101546    }),
    Afterlife                        = Action.Create({ Type = "Spell", ID = 116092, Hidden = true        }),
    MasteryComboStrikes             = Action.Create({ Type = "Spell", ID = 115636, Hidden = true        }),
    Windwalking                        = Action.Create({ Type = "Spell", ID = 157411, Hidden = true        }),

    
    -- Normal Talents
    EyeoftheTiger                   = Action.Create({ Type = "Spell", ID = 196607, Hidden = true    }),
    ChiWave                            = Action.Create({ Type = "Spell", ID = 115098, predictName = "ChiWave",    }),
    ChiBurst                        = Action.Create({ Type = "Spell", ID = 123986, predictName = "ChiBurst",    }),
    Celerity                           = Action.Create({ Type = "Spell", ID = 115173, Hidden = true    }),
    ChiTorpedo                      = Action.Create({ Type = "Spell", ID = 115008    }),
    TigersLust                        = Action.Create({ Type = "Spell", ID = 116841    }),
    Ascension                        = Action.Create({ Type = "Spell", ID = 115396, Hidden = true    }),
    FistoftheWhiteTiger             = Action.Create({ Type = "Spell", ID = 261947    }),
    EnergizingElixir                = Action.Create({ Type = "Spell", ID = 115288    }),
    TigerTailSweep                  = Action.Create({ Type = "Spell", ID = 264348, Hidden = true    }),
    GoodKarma                        = Action.Create({ Type = "Spell", ID = 280195, Hidden = true    }),
    RingofPeace                        = Action.Create({ Type = "Spell", ID = 116844    }),
    InnerStrength                   = Action.Create({ Type = "Spell", ID = 261767, Hidden = true    }),
    DiffuseMagic                    = Action.Create({ Type = "Spell", ID = 122783    }),
    DampenHarm                      = Action.Create({ Type = "Spell", ID = 122278    }),
    HitCombo                        = Action.Create({ Type = "Spell", ID = 196740, Hidden = true    }),    
    RushingJadeWind                 = Action.Create({ Type = "Spell", ID = 116847    }),
    DanceofChiJi                    = Action.Create({ Type = "Spell", ID = 325201, Hidden = true    }),
    SpiritualFocus                  = Action.Create({ Type = "Spell", ID = 280197, Hidden = true    }),
    WhirlingDragonPunch             = Action.Create({ Type = "Spell", ID = 152175    }),
    Serenity                        = Action.Create({ Type = "Spell", ID = 152173    }),
    
}


local A = setmetatable(Action[ACTION_CONST_MONK_WINDWALKER], { __index = Action })

local player                                 = "player"
local PartyUnits
TMW:RegisterSelfDestructingCallback("TMW_ACTION_IS_INITIALIZED_PRE", function()
        PartyUnits = GetToggle(2, "PartyUnits", ACTION_CONST_MONK_WINDWALKER)
        return true -- Signal RegisterSelfDestructingCallback to unregister
end)

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end
local player = "player"

----------------------
-------- COMMON PREAPL -------
----------------------
local Temp = {
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
    IsSlotTrinketBlocked                    = {},
}; do     
    
    -- Push IsSlotTrinketBlocked
    for key, val in pairs(Action[ACTION_CONST_MONK_WINDWALKER]) do 
        if type(val) == "table" and val.Type == "Trinket" then 
            Temp.IsSlotTrinketBlocked[val.ID] = true
        end 
    end 
end 


local function IsSchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "NATURE") == 0
end 

local IsIndoors, UnitIsUnit, UnitName = IsIndoors, UnitIsUnit, UnitName




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