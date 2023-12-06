local _G, setmetatable                           = _G, setmetatable
local  UnitAura,     UnitStagger,     UnitGUID = _G.UnitAura, _G.UnitStagger, _G.UnitGUID
local ACTION                                    = _G.Action
local Covenant                                    = _G.LibStub("Covenant")
local TMW                                     = _G.TMW 
local huge 									= math.huge

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
local IsSpellLearned                        = Action.IsSpellLearned
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

local ACTION_CONST_MONK_BREWMASTER           = CONST.MONK_BREWMASTER
local ACTION_CONST_AUTOTARGET                = CONST.AUTOTARGET
local ACTION_CONST_SPELLID_FREEZING_TRAP    = CONST.SPELLID_FREEZING_TRAP

local  GetTotemInfo,     IsIndoors,       UnitIsUnit = 
_G.GetTotemInfo, _G.IsIndoors, _G.UnitIsUnit



--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

Action[ACTION_CONST_MONK_BREWMASTER] = {
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
    BlackoutKick                    = Action.Create({ Type = "Spell", ID = 205523    }),
    CracklingJadeLightning          = Action.Create({ Type = "Spell", ID = 117952    }),    
    Detox                             = Action.Create({ Type = "Spell", ID = 218164    }),    
    ExpelHarm                        = Action.Create({ Type = "Spell", ID = 322101    }),
    FortifyingBrew                  = Action.Create({ Type = "Spell", ID = 115203    }),    
    LegSweep                        = Action.Create({ Type = "Spell", ID = 119381    }), 
    MysticTouch                       = Action.Create({ Type = "Spell", ID = 8647         }),
    Paralysis                        = Action.Create({ Type = "Spell", ID = 115078    }),
    Provoke                            = Action.Create({ Type = "Spell", ID = 115546    }),
    Resuscitate                        = Action.Create({ Type = "Spell", ID = 115178    }),    
    Roll                            = Action.Create({ Type = "Spell", ID = 109132    }),    
    SpinningCraneKick               = Action.Create({ Type = "Spell", ID = 322729    }),
    TigerPalm                        = Action.Create({ Type = "Spell", ID = 100780    }),
    RushingTigerPalm                = Action.Create({ Type = "Spell", ID = 337341    }),
    TouchofDeath                       = Action.Create({ Type = "Spell", ID = 322109    }),
    Transcendence                   = Action.Create({ Type = "Spell", ID = 101649    }),
    TranscendenceTransfer           = Action.Create({ Type = "Spell", ID = 119996    }),
    Vivify                           = Action.Create({ Type = "Spell", ID = 116670    }),
    ZenFlight                       = Action.Create({ Type = "Spell", ID = 125883    }),
    ZenPilgrimage                      = Action.Create({ Type = "Spell", ID = 126892    }),
    
    -- Brewmaster Specific
    BreathofFire                     = Action.Create({ Type = "Spell", ID = 115181    }),
    CelestialBrew                       = Action.Create({ Type = "Spell", ID = 322507    }),
    Clash                           = Action.Create({ Type = "Spell", ID = 324312    }),
    InvokeNiuzao                       = Action.Create({ Type = "Spell", ID = 132578    }), 
    KegSmash                      = Action.Create({ Type = "Spell", ID = 121253    }),
    PurifyingBrew                   = Action.Create({ Type = "Spell", ID = 119582    }),
    SpearHandStrike                   = Action.Create({ Type = "Spell", ID = 116705    }),
    ZenMeditation                       = Action.Create({ Type = "Spell", ID = 115176           }), 
    BrewmastersBalance                     = Action.Create({ Type = "Spell", ID = 245013, Hidden = true            }), 
    CelestialFortune                       = Action.Create({ Type = "Spell", ID = 216519, Hidden = true      }),
    GiftoftheOx                           = Action.Create({ Type = "Spell", ID = 124502, Hidden = true      }),
    ElusiveBrawler                        = Action.Create({ Type = "Spell", ID = 117906, Hidden = true         }),
    ElusiveBrawlerBuffBuff              = Action.Create({ Type = "Spell", ID = 195630, Hidden = true         }),
    Shuffle                             = Action.Create({ Type = "Spell", ID = 322120, Hidden = true        }),
    Stagger                        = Action.Create({ Type = "Spell", ID = 115069, Hidden = true        }),
    
    --Other
    StopCast                        = Action.Create({ Type = "Spell", ID = 61721, Hidden = true           }),
    
    --Hidden
    
    -- Normal Talents
    EyeoftheTiger                   = Action.Create({ Type = "Spell", ID = 196607, Hidden = true    }),
    ChiWave                            = Action.Create({ Type = "Spell", ID = 115098    }),
    ChiBurst                        = Action.Create({ Type = "Spell", ID = 123986    }),
    Celerity                           = Action.Create({ Type = "Spell", ID = 115173, Hidden = true    }),
    ChiTorpedo                      = Action.Create({ Type = "Spell", ID = 115008    }),
    TigersLust                        = Action.Create({ Type = "Spell", ID = 116841    }),
    LightBrewing                        = Action.Create({ Type = "Spell", ID = 325093, Hidden = true    }),
    Spitfire                         = Action.Create({ Type = "Spell", ID = 242580    }),
    BlackOxBrew                        = Action.Create({ Type = "Spell", ID = 115399    }),
    TigerTailSweep                  = Action.Create({ Type = "Spell", ID = 264348, Hidden = true    }),
    SummonOxStatue                  = Action.Create({ Type = "Spell", ID = 115315   }),
    ProvokeSummonBlackOxStatue      = Action.Create({ Type = "Spell", ID = 115546, Color = "PINK", Texture = 115315                                         }),
    RingofPeace                        = Action.Create({ Type = "Spell", ID = 116844    }),
    BobandWeave                       = Action.Create({ Type = "Spell", ID = 280515, Hidden = true    }),
    HealingElixir                    = Action.Create({ Type = "Spell", ID = 122281    }),
    DampenHarm                      = Action.Create({ Type = "Spell", ID = 122278    }),
    SpecialDelivery                 = Action.Create({ Type = "Spell", ID = 196730, Hidden = true    }),    
    RushingJadeWind                 = Action.Create({ Type = "Spell", ID = 116847    }),
    ExplodingKeg                    = Action.Create({ Type = "Spell", ID = 325153  }),
    HighTolerance                  = Action.Create({ Type = "Spell", ID = 196737, Hidden = true    }),
    CelestialFlames                 = Action.Create({ Type = "Spell", ID = 325177, Hidden = true      }),
    BlackoutCombo                        = Action.Create({ Type = "Spell", ID = 196736, Hidden = true      }),
    BlackoutComboBuff                = Action.Create({ Type = "Spell", ID = 228563, Hidden = true      }),
    
    
    -- PvP Talents
    Microbrew                        = Action.Create({ Type = "Spell", ID = 202107, Hidden = true      }),
    HotTrub                            = Action.Create({ Type = "Spell", ID = 202126, Hidden = true      }),
    --    GuidedMeditaiton                = Action.Create({ Type = "Spell", ID = 202200, Hidden = true      }),
    AvertHarm                        = Action.Create({ Type = "Spell", ID = 202162,      }),
    CraftNimbleBrew                    = Action.Create({ Type = "Spell", ID = 213658,      }),
    IncendiaryBreath                = Action.Create({ Type = "Spell", ID = 202272, Hidden = true      }),
    DoubleBarrel                    = Action.Create({ Type = "Spell", ID = 202335,      }),
    Admonishment                    = Action.Create({ Type = "Spell", ID = 207025,      }),
    NiuzaosEssence                    = Action.Create({ Type = "Spell", ID = 232876, Hidden = true      }),
    MightyOxKick                    = Action.Create({ Type = "Spell", ID = 202370,      }),
    EerieFermentation                = Action.Create({ Type = "Spell", ID = 205147, Hidden = true      }),
    
    -- Covenant Abilities
    SummonSteward                    = Action.Create({ Type = "Spell", ID = 324739    }),
    DoorofShadows                    = Action.Create({ Type = "Spell", ID = 300728    }),
    Fleshcraft                        = Action.Create({ Type = "Spell", ID = 321687    }),
    Fleshcraftshield                  = Action.Create({ Type = "Spell", ID = 324867    }),
    Soulshape                        = Action.Create({ Type = "Spell", ID = 310143    }),
    WeaponsofOrder                = Action.Create({ Type = "Spell", ID = 310454    }),
    WeaponsofOrderWW                =Action.Create({ Type = "Spell", ID = 311054    }),
    BonedustBrew                    = Action.Create({ Type = "Spell", ID = 325216    }),
    DeathsDue                        = Action.Create({ Type = "Spell", ID = 324128    }),  
    FaelineStomp                        = Action.Create({ Type = "Spell", ID = 327104    }),
    FallenOrder                        = Action.Create({ Type = "Spell", ID = 326860    }),       
    
    
    -- Conduits
    CoordinatedOffensive            = Action.Create({ Type = "Spell", ID = 336598, Hidden = true    }),
    
    
    -- Legendaries
    -- General Legendaries    
    
    --Brew Master Legendaries
    CharredPassions                    = Action.Create({ Type = "Spell", ID = 338138, Hidden = true    }),
    CharredPassionsBuff                 = Action.Create({ Type = "Spell", ID = 338140, Hidden = true    }),
    LastKeg                             = Action.Create({ Type = "Spell", ID = 337288, Hidden = true    }),
    
    
    
    --Anima Powers - to add later...
    
    
    -- Trinkets
    DreadFireVessel            = Create({ Type = "Trinket", ID = 6805 }),   
    
    
    -- Potions
    PotionofUnbridledFury            = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }),     
    SuperiorPotionofUnbridledFury    = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }),
    PotionofSpectralStrength        = Action.Create({ Type = "Potion", ID = 171275, QueueForbidden = true }),
    PotionofSpectralAgility          = Action.Create({ Type = "Potion", ID = 171270, QueueForbidden = true }),
    PotionofSpectralStamina            = Action.Create({ Type = "Potion", ID = 171274, QueueForbidden = true }),
    PotionofEmpoweredExorcisms        = Action.Create({ Type = "Potion", ID = 171352, QueueForbidden = true }),
    PotionofHardenedShadows            = Action.Create({ Type = "Potion", ID = 171271, QueueForbidden = true }),
    PotionofPhantomFire                = Action.Create({ Type = "Potion", ID = 171349, QueueForbidden = true }),
    PotionofDeathlyFixation            = Action.Create({ Type = "Potion", ID = 171351, QueueForbidden = true }),
    SpiritualHealingPotion            = Action.Create({ Type = "Potion", ID = 171267, QueueForbidden = true }),      
    
    -- Misc
    Channeling                      = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),    -- Show an icon during channeling
    TargetEnemy                     = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),    -- Change Target (Tab button)
    StopCast                        = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),        -- spell_magic_polymorphrabbit
    PoolResource                    = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),
    Quake                           = Action.Create({ Type = "Spell", ID = 240447, Hidden = true     }), -- Quake (Mythic Plus Affix)
    GCD                          = Action.Create({ Type = "Spell", ID = 61304, Hidden = true     }),   
    StaggerGreen                     = Action.Create({ Type = "Spell", ID = 124275, Hidden = true     }),   
    StaggerYellow                    = Action.Create({ Type = "Spell", ID = 124274, Hidden = true     }),
    StaggerRed                    = Action.Create({ Type = "Spell", ID = 124273, Hidden = true     }),
}


local A = setmetatable(Action[ACTION_CONST_MONK_BREWMASTER], { __index = Action })

local player                                 = "player"

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
    CastStartTime = {},
}; do     
end

local function BMUnitAura(unit, spellID, filter)   
        for i = 1, huge do
            local name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, id, canApplyAura, isBossDebuff, isCastByPlayer, nameplateShowAll, timeMod, arg16 = UnitAura(unit, i, filter)         
            if not name then
                return 0
            elseif spellID then
                return name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, nameplateShowPersonal, id, canApplyAura, isBossDebuff, isCastByPlayer, nameplateShowAll, timeMod, arg16
            end
        end
    end

    local staggerDebuffs = {
        [124273] = true,
        [124274] = true,
        [124275] = true,
    }
	
local function GetNextTick()
    return select(16, BMUnitAura("player", staggerDebuffs, "HARMFUL")) or 0
end
GetNextTick = Action.MakeFunctionCachedStatic(GetNextTick)

local function GetStaggerLevel(next_tick, next_health)
    local perc 
    if next_tick and next_health then 
        perc = next_tick / next_health
    else 
        perc = GetNextTick() / Unit("player"):HealthMax()
    end 
    
    if perc <= .015 then
        return 1
    elseif perc <= .03 then
        return 2
    elseif perc <= .05 then
        return 3
    elseif perc <= .1 then
        return 4
    else
        return 5
    end
end

local function GetNormalStagger()
	Normalized = GetNextTick() / Unit("player"):HealthMax()
	
	return Normalized
end

local function GetStaggerProgress(next_stagger, next_normalized)
    local progress 
    if next_stagger and next_normalized then 
        progress = next_stagger / next_normalized * 100
    else 
        progress = UnitStagger("player") / GetNormalStagger() * 100
    end 
    
    return progress
end 

local function GetStaggerHPLosePerTick(next_tick, next_health)
    local PercentLose  
    if next_tick and next_health then 
        PercentLose = ("%.1f"):format(100 * next_tick / next_health)
    else 
        PercentLose = ("%.1f"):format(100 * GetNextTick() / Unit("player"):HealthMax())
    end 
    
    return PercentLose
end 

local function GetStaggerPercent()
    return UnitStagger("player") * 100 / Unit("player"):HealthMax()
end 

local function IsSchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "NATURE") == 0
end 

local IsIndoors, UnitIsUnit, UnitName = IsIndoors, UnitIsUnit, UnitName


function Player:AreaTTD(range)
    local ttdtotal = 0
    local totalunits = 0
    local r = range
    
    for _, unitID in pairs(ActiveUnitPlates) do 
        if Unit(unitID):GetRange() <= r then 
            local ttd = Unit(unitID):TimeToDie()
            totalunits = totalunits + 1
            ttdtotal = ttd + ttdtotal
        end
    end
    
    if totalunits == 0 then
        return 0
    end
    
    return ttdtotal / totalunits
end    

local function InMelee(unit)
    -- @return boolean 
    return A.TigerPalm:IsInRange(unit)
end 

local function ReturnSpellChargesMax(spellID) -- Fix until Action API (GetSpellChargesMax) is corrected
    -- @return number
    local _, max_charges = GetSpellCharges(spellID)
    if not max_charges then 
        max_charges = 0
    end 
    
    return max_charges    
end

local function ReturnSpellChargesFrac(spellID) -- Fix until Action API (GetSpellChargesFrac) is corrected
    -- @return number    
    local charges, maxCharges, start, duration = GetSpellCharges(spellID)
    if not maxCharges then 
        return 0
    end 
    
    if charges == maxCharges then 
        return maxCharges
    end
    
    return charges + ((GetTime() - start) / duration)  
end

local function ReturnSpellChargesFullRechargeTime(spellID) -- Fix until Action API (GetSpellChargesFullRechargeTime) is corrected
    -- @return number
    local _, _, _, duration = GetSpellCharges(spellID)
    if duration then 
        return (ReturnSpellChargesMax(spellID) - ReturnSpellChargesFrac(spellID)) * duration
    else 
        return 0
    end 
end 

local function GetByRange(count, range, isCheckEqual, isCheckCombat)
    -- @return boolean 
    local c = 0 
    for unit in pairs(ActiveUnitPlates) do 
        if (not isCheckEqual or not UnitIsUnit("target", unit)) and (not isCheckCombat or Unit(unit):CombatTime() > 0) then 
            if InMelee(unit) then 
                c = c + 1
            elseif range then 
                local r = Unit(unit):GetRange()
                if r > 0 and r <= range then 
                    c = c + 1
                end 
            end 
            
            if c >= count then 
                return true 
            end 
        end 
    end
end 
GetByRange = A.MakeFunctionCachedDynamic(GetByRange)

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.LegSweep:IsReadyByPassCastGCD(unit) or not A.LegSweep:AbsentImun(unit, Temp.TotalAndPhysKick, true) then 
        return true 
    end 
end 

--Work around fix for AoE off breaking
if UseAoE == true
then AoETargets = Action.GetToggle(2,"AoETargets")
else AoETargets = 10
end

-----------------------------------------
--                 ROTATION  
-----------------------------------------
local unitID



local function AutoPurify()
    -- Using by Dynamic bar also
        local lvl = GetStaggerLevel()
        if (lvl > 1 and lvl < 3 and GetStaggerProgress() > 80) or (lvl == 3 and GetStaggerProgress() > 70) or (lvl == 4 and GetStaggerProgress() > 50) or lvl > 4 then 
            return true, lvl
        end 
    return false, -1
end 
Action.AutoPurify = AutoPurify

local function ShouldPurify()
    local Toggle = GetToggle(2, "ShouldPurify")
    local Purify, PurifyLVL = AutoPurify()
    return Purify and (Toggle == 0 or Toggle == PurifyLVL)
end 

local IronskinDuration = 7
local function SelfDeffensives()
    local BrewMaxCharge = 3 + (A.LightBrewing:IsSpellLearned() and 1 or 0)
	local HoldNiuzao = Action.GetToggle(2, "NiuzaoHoldBrew")
    
    -- PurifyingBrew
    if A.PurifyingBrew:IsReady(player) and ShouldPurify() and ((not HoldNiuzao) or (HoldNiuzao and A.InvokeNiuzao:GetCooldown() > 0) or (not A.BurstIsON("target"))) then 
        return A.PurifyingBrew
    end 
    
    
    -- HealingElixir
    local HealingElixir = GetToggle(2, "HealingElixir")
    if     HealingElixir >= 0 and A.HealingElixir:IsReady(player) and IsSchoolFree() and
    (
        (     -- Auto 
            HealingElixir >= 85 and 
            (
                Unit(player):HealthPercent() <= 20 or
                (                        
                    Unit(player):HealthPercent() < 70 and 
                    ReturnSpellChargesFrac(A.HealingElixir.ID) > 1.1
                ) or 
                (
                    Unit(player):HealthPercent() < 40 and 
                    Unit(player):IsTanking("target", 8)
                ) 
            )
        ) or 
        (    -- Custom
            HealingElixir < 85 and 
            Unit(player):HealthPercent() <= HealingElixir
        )
    ) 
    then 
        return A.HealingElixir
    end 
    
    -- ZenMeditation
    local ZenMeditation = GetToggle(2, "ZenMeditation")
    if     ZenMeditation >= 0 and A.ZenMeditation:IsReady(player) and Player:IsStayingTime() > 0.8 and IsSchoolFree() and 
    (
        (     -- Auto 
            ZenMeditation >= 100 and 
            (    -- Trying to catch kill strike by CLEU from latest hits
                Unit(player):GetDMG() >= Unit(player):Health() or 
                Unit(player):GetRealTimeDMG() >= Unit(player):Health() 
            )
        ) or 
        (    -- Custom
            -- Note: User should configure own cast bars through LUA in 'Actions' tab with own HP preset for advanced logic to catch boss's critical casting strikes
            ZenMeditation < 100 and 
            Unit(player):HealthPercent() <= ZenMeditation
        )
    ) 
    then 
        return A.ZenMeditation
    end 
    
    -- AvertHarm
    if A.AvertHarm:IsReady(player) and Unit(player):TimeToDie() > 15 and (FriendlyTeam(nil, 2):GetTTD(2, 18, 20) or FriendlyTeam(nil, 2):HealerIsFocused(true, true, 20)) then 
        return A.AvertHarm
    end 
    
    -- CelestialBrew
    local CelestialBrew = GetToggle(2, "CelestialBrew") 
    if     CelestialBrew >= 0 and A.CelestialBrew:IsReady(player) and
    (
        (     -- Auto 
            CelestialBrew >= 100 and A.PurifyingBrew:GetSpellCharges() ~= 2 and
            UnitStagger(player) >= A.CelestialBrew:GetSpellDescription()[1]
        ) or 
        (    -- Custom
            CelestialBrew < 100 and 
            GetStaggerPercent() >= CelestialBrew
        )
    ) 
    then 
        return A.CelestialBrew
    end 
    
    -- DampenHarm
    local DampenHarm = GetToggle(2, "DampenHarm")
    if     DampenHarm >= 0 and A.DampenHarm:IsReady(player) and Unit(player):IsTanking("target", 8) and 
    (
        (     -- Auto 
            DampenHarm >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 20 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused(nil, true) 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            DampenHarm < 100 and 
            Unit(player):HealthPercent() <= DampenHarm
        )
    ) 
    then 
        return A.DampenHarm
    end 

	--HealPot
	local SpiritualHealingPotionHP = GetToggle(2, "SpiritualHealingPotionHP")
    if SpiritualHealingPotionHP > 0 and A.SpiritualHealingPotion:IsReady(player) and Unit(player):HealthPercent() <= SpiritualHealingPotionHP then
        return A.SpiritualHealingPotion
	end
				
    -- FortifyingBrew
    local FortifyingBrew = GetToggle(2, "FortifyingBrew")
    if     FortifyingBrew >= 0 and A.FortifyingBrew:IsReady(player) and Unit(player):IsTanking("target", 8) and 
    (
        (     -- Auto 
            FortifyingBrew >= 100 and 
            (
                (
                    not A.IsInPvP and 
                    Unit(player):HealthPercent() < 40 and 
                    Unit(player):TimeToDieX(15) < 5 
                ) or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused(nil, true)                                 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            FortifyingBrew < 100 and 
            Unit(player):HealthPercent() <= FortifyingBrew
        )
    ) 
    then 
        return A.FortifyingBrew
    end 
    
    -- Stoneform
    local Stoneform = GetToggle(2, "Stoneform")
    if     Stoneform >= 0 and A.Stoneform:IsRacialReadyP(player) and Unit(player):IsTanking("target", 8) and 
    (
        (     -- Auto 
            Stoneform >= 100 and 
            (
                (
                    not A.IsInPvP and                         
                    Unit(player):TimeToDieX(65) < 3 
                ) or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused(nil, true)                                 
                        )
                    )
                )
            ) 
        ) or 
        (    -- Custom
            Stoneform < 100 and 
            Unit(player):HealthPercent() <= Stoneform
        )
    ) 
    then 
        return A.Stoneform
    end 
    
    -- Stoneform (PvE Self Dispel)
    if A.Stoneform:AutoRacial(player) and not A.IsInPvP and AuraIsValid(player, "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
    
end 

local function BlackOxStatue()
    for i = 1, MAX_TOTEMS do 
        local have, name, start, duration = GetTotemInfo(i)
        if duration and duration == 900 then 
            return duration - (TMW.time - start)
        end 
    end 
    return 0
end

--[[
local function Niuzao()
    for i = 1, MAX_TOTEMS do 
        local have, name, start, duration = GetTotemInfo(i)
        if duration and duration == 45 then 
            return duration - (TMW.time - start)
        end 
    end 
    return 0
end
]]

local function ShouldTaunt(unit)
    if A.Zone ~= "none" then 
        
        -- Provoke
        if A.Provoke:IsReady(unit) and (not A.IsInPvP or not A.Admonishment:IsSpellLearned() and not Unit(unit):IsPlayer() and not Unit(unit):IsTotem()) and Unit(unit):CombatTime() > 0 and not Unit(unit .. "target"):IsTank() then 
            return A.Provoke
        end         
    end 
    
    -- Admonishment
    if A.Admonishment:IsReady(unit) and Unit(unit):IsPlayer() and Unit(unit):HasDeBuffs(206891) == 0 and A.Admonishment:AbsentImun(unit, Temp.TotalAndPhys) then 
        return A.Admonishment
    end     
end 

            
	local function Interrupts(unit)
		isInterrupt = select(9,UnitCastingInfo("target"));
		local LegSweepInterrupt = Action.GetToggle(2, "LegSweepInterrupt")
		local ParalysisInterrupt = Action.GetToggle(2, "ParalysisInterrupt")
		
		if A.GetToggle(2, "SnSInterruptList") and (IsInRaid() or A.InstanceInfo.KeyStone > 1) then
			useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, "SnS_ShadowlandsContent", true, countInterruptGCD(unit))
		else
			useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, nil, nil, countInterruptGCD(unit))
		end
		
		if castRemainsTime >= A.GetLatency() then
			-- Spear Hand Strike
			if useKick and not notInterruptable and A.SpearHandStrike:IsReady(unit) and A.SpearHandStrike:AbsentImun(unit, Temp.TotalAndPhysKick, true) then 
				return A.SpearHandStrike
			end
			
			-- Paralysis
			if A.Paralysis:IsReady(unit) and A.Paralysis:AbsentImun(unit, Temp.TotalAndCC, true) and ParalysisInterrupt and A.SpearHandStrike:GetCooldown() > 1 and useCC then 
				return A.Paralysis
			end 
			
			-- LegSweep
			if A.LegSweep:IsReady(unit) and A.LegSweep:AbsentImun(unit, Temp.TotalAndCC, true) and LegSweepInterrupt and A.SpearHandStrike:GetCooldown() > 1 and useCC then 
				return A.LegSweep
			end 
			
			if useRacial and A.QuakingPalm:AutoRacial(unit) then 
				return A.QuakingPalm
			end 
			
			if useRacial and A.Haymaker:AutoRacial(unit) then 
				return A.Haymaker
			end 
			
			if useRacial and A.WarStomp:AutoRacial(unit) then 
				return A.WarStomp
			end 
			
			if useRacial and A.BullRush:AutoRacial(unit) then 
				return A.BullRush
			end 
		end
	end  

--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)
    ----------
    --- ROTATION VAR ---
    ----------
    local EnemyRotation, FriendlyRotation
    local isSchoolFree = IsSchoolFree()
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime()        -- @number 
    local combatTime = Unit("player"):CombatTime()
    local inDisarm  = LoC:Get("DISARM") > 0
    local Energy = Player:Energy()
    local Chi = Player:Chi()
    local inMelee             = false 
    
    --    local PotionTTD = Unit("target"):TimeToDie() > Action.GetToggle(2, "PotionTTD")
    local AutoPotionSelect = Action.GetToggle(2, "AutoPotionSelect")
    local PotionTrue = Action.GetToggle(1, "Potion")    
    local Racial = Action.GetToggle(1, "Racial")
    local UseAoE = Action.GetToggle(2, "AoE")
    local AoETargets = Action.GetToggle(2, "AoETargets")
    local currentTargets = MultiUnits:GetByRange(7)    
    local MouseoverTarget = UnitName("mouseover")
    local isSchoolFree         = IsSchoolFree()
    local HoldNiuzao = Action.GetToggle(2, "NiuzaoHoldBrew")
	local AutoPotionSelect = Action.GetToggle(2, "AutoPotionSelect")
    
    --------------------------------------
    -------- ENEMY UNIT ROTATION ---------
    --------------------------------------
    
    -- Return 
    if Unit("player"):HasBuffs(A.ZenMeditation.ID, true) > 0 then 
        return 
    end 
    
    -- Defensive
    if inCombat > 0 then 
        local Deffensive = SelfDeffensives(inCombat)
        if Deffensive then 
            return Deffensive:Show(icon)
        end 
    end 
    
    -- Defensive Trinkets
    if inCombat > 0 and (Unit(player):HealthPercent() < 30 or Unit(player):TimeToDie() < 5) then 
        if A.Trinket1:IsReady(player) and A.Trinket1:GetItemCategory() ~= "DPS" then 
            return A.Trinket1:Show(icon)
        end 
        
        if A.Trinket2:IsReady(player) and A.Trinket2:GetItemCategory() ~= "DPS" then 
            return A.Trinket2:Show(icon)
        end
    end    

    --Def Pot
    if AutoPotionSelect == "HardenedShadowsPot" and A.PotionofHardenedShadows:IsReady(unit) and PotionTrue and Unit(player):HasBuffs(A.InvokeNiuzao.ID, true) == 0 and
    (               
        -- HP lose per sec >= 40
        Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 45 
        or 
        Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.40 
        or 
        -- TTD 
        Unit("player"):TimeToDieX(15) < 5 
    ) then
		 return A.PotionofHardenedShadows:Show(icon)
	elseif AutoPotionSelect == "SpectralStaminaPot" and A.SpectralStaminaPot:IsReady(unit) and PotionTrue and Unit(player):HasBuffs(A.InvokeNiuzao.ID, true) == 0 and
    (               
        -- HP lose per sec >= 40
        Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 45 
        or 
        Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.40 
        or 
        -- TTD 
        Unit("player"):TimeToDieX(15) < 5 
    ) then
		return A.SpectralStaminaPot:Show(icon)
    end
    
    --Rotations
    function EnemyRotation(unit)
        
        --RushingJade Prepull
        if A.RushingJadeWind:IsReady("player") and Unit("target"):IsEnemy() and Unit("target"):GetRange() <= 15 and Unit("player"):CombatTime() == 0 then
            return A.RushingJadeWind:Show(icon)
        end
        
        --Explosive Rotation        
        local function ExplosiveRotation()
            if Unit("target"):IsExplosives() and ChannelCheckplayer == 113656 then
                return A.StopCast:Show(icon)
            end
            if A.TigerPalm:IsReady("target") then
                return A.TigerPalm:Show(icon)
            end
            if A.BlackoutKick:IsReady("target") then
                return A.BlackoutKick:Show(icon)
            end
            if A.KegSmash:IsReady("target") then
                return A.KegSmash:Show(icon)
            end
        end
        
        if Unit("target"):IsExplosives() and ExplosiveRotation() then
            return true
        end
        
        -- ArcaneTorrent
        if A.ArcaneTorrent:AutoRacial("target") then 
            return A.ArcaneTorrent:Show(icon)
        end         
        
        -- [[ Friendly Rotation ]]
        if IsUnitFriendly("target") then 
            unit = "target"
            
            -- Resuscitate
            if isSchoolFree and inCombat == 0 and Unit(unit):IsDead() and Unit(unit):IsPlayer() and Player:IsStaying() and A.Resuscitate:IsReady(unit) then 
                return A.Resuscitate:Show(icon)
            end 
            
            -- Detox
            if isSchoolFree and A.Detox:IsReady(unit) and AuraIsValid(unit, "UseDispel", "Dispel") and A.Detox:AbsentImun(unit) then 
                return A.Detox:Show(icon)
            end 
            
            -- TigersLust
            if isSchoolFree and A.TigersLust:IsReady(unit) and Unit(unit):HasDeBuffs("Rooted") > GetGCD() and A.TigersLust:AbsentImun(unit) and no then 
                return A.TigersLust:Show(icon)
            end 
            
            -- GiftofNaaru
            if A.GiftofNaaru:AutoRacial(unit) then 
                return A.GiftofNaaru:Show(icon)
            end 
            
            -- Vivify
            --      if isSchoolFree and Player:IsStaying() and A.Vivify:IsReady(unit) and (UnitIsUnit(unit, player) or (A.Vivify:PredictHeal(unit) and A.Vivify:AbsentImun(unit))) then 
            --          return A.Vivify:Show(icon)
            --      end         
            
            -- TigersLust
            if isSchoolFree and A.TigersLust:IsReady(unit) and not Player:IsMounted() then 
                local cMoving = Unit(unit):GetCurrentSpeed()
                if cMoving > 0 and cMoving < 64 and A.TigersLust:AbsentImun(unit) then 
                    return A.TigersLust:Show(icon)
                end 
            end 
            
            -- ChiBurst
            if inAoE and isSchoolFree and A.ChiBurst:IsReady(unit, true) and Unit(unit):GetRange() <= 40 and Player:IsStaying() and A.ChiBurst:AbsentImun(unit) and (not A.IsInPvP or not EnemyTeam("HEALER"):IsBreakAble(40)) then 
                return A.ChiBurst:Show(icon)
            end 
            
            -- ChiWave
            if inAoE and isSchoolFree and A.ChiWave:IsReady(unit, true) and Unit(unit):GetRange() <= 25 and A.ChiWave:AbsentImun(unit) and (not A.IsInPvP or not EnemyTeam("HEALER"):IsBreakAble(25)) then 
                return A.ChiWave:Show(icon)
            end 
            
            -- Vivify
            -- Force cast 
            if A.IsInPvP and isSchoolFree and inCombat > 0 and Player:IsStaying() and A.Vivify:IsReady(unit) and (UnitIsUnit(unit, player) or A.Vivify:AbsentImun(unit)) and Unit(unit):GetRealTimeDMG() > 0 then 
                return A.Vivify:Show(icon)
            end 
        end 
        
        if IsUnitEnemy("target") then 
              unit = "target"
            local inMelee = A.TigerPalm:IsInRange(unit)
            
            -- Out of combat / Precombat
            if inCombat == 0 then         
                local Pull = BossMods:GetPullTimer()
                
                if Pull > 0 and PotionTrue then 
                    -- BattlePotionOfAgility
                    if Pull < 2 and LoC:IsMissed("DISARM") then 
                        if A.PotionofSpectralAgility:IsReady(unit) and AutoPotionSelect == "SpectralAgilityPot" then 
                            return A.PotionofSpectralAgility:Show(icon)
                        elseif A.PotionofEmpoweredExorcisms:IsReady(unit) and AutoPotionSelect == "EmpoweredExorcismsPot" then 
                            return A.PotionofEmpoweredExorcisms:Show(icon)
                        elseif A.PotionofPhantomFire:IsReady(unit) and AutoPotionSelect == "PhantomFirePot" then 
                            return A.PotionofPhantomFire:Show(icon)
						elseif A.PotionofDeathlyFixation:IsReady(unit) and AutoPotionSelect == "DeathlyFixationPot" then 
                            return A.PotionofDeathlyFixation:Show(icon)
						end
                    end
                end
            end
            
            --actions=auto_attack
            --actions+=/spear_hand_strike,if=target.debuff.casting.react
        local Interrupt = Interrupts(unit)
        if Interrupt then 
            return Interrupt:Show(icon)
        end   
            --actions+=/gift_of_the_ox,if=health<health.max*0.65
            --actions+=/dampen_harm,if=incoming_damage_1500ms&buff.fortifying_brew.down
            --actions+=/fortifying_brew,if=incoming_damage_1500ms&(buff.dampen_harm.down|buff.diffuse_magic.down)
            --actions+=/use_item,name=dreadfire_vessel
            -- Defensive Trinkets
            
            --actions+=/potion
            
            --actions+=/rushing_jade_wind,if=buff.rushing_jade_wind.down
            if A.RushingJadeWind:IsReady("player") and Unit("player"):HasBuffs(A.RushingJadeWind.ID, true) == 0 and Unit("target"):GetRange() <= 15 then
                return A.RushingJadeWind:Show(icon)
            end    
            
            local function Cooldowns()
                --actions+=/blood_fury
                if A.BloodFury:IsReady("player") then 
                    return A.BloodFury:Show(icon)
                end
                
                --actions+=/berserking
                if A.Berserking:IsReady("player") then 
                    return A.Berserking:Show(icon)
                end
                
                --actions+=/lights_judgment
                if A.LightsJudgment:IsReady("player") then 
                    return A.LightsJudgment:Show(icon)
                end
                
                --actions+=/fireblood
                if A.Fireblood:IsReady("player") then 
                    return A.Fireblood:Show(icon)
                end
                
                --actions+=/ancestral_call
                if A.AncestralCall:IsReady("player") then 
                    return A.AncestralCall:Show(icon)
                end
                
                --actions+=/bag_of_tricks
                if A.BagofTricks:IsReady("player") then 
                    return A.BagofTricks:Show(icon)
                end
                
                --actions+=/invoke_niuzao_the_black_ox,if=target.time_to_die>25
                if A.InvokeNiuzao:IsReady(unit) and ((Unit("target"):TimeToDie() > 25 and Unit("target"):GetRange() <= 5 and not HoldNiuzao) or ((Unit("target"):TimeToDie() > 25 and Unit("target"):GetRange() <= 5 and HoldNiuzao and Unit("player"):HasDeBuffs(A.StaggerRed.ID, true) > 0))) then
                    return A.InvokeNiuzao:Show(icon)
                end
                
                --actions+=/touch_of_death,if=target.health.pct<=15
                if A.TouchofDeath:IsReady(unit) then
                    return A.TouchofDeath:Show(icon)
                end
                
                --KegSmash before reset
                if ((A.KegSmash:IsReady(unit) and not A.LastKeg:HasLegendaryCraftingPower()) or (A.LastKeg:HasLegendaryCraftingPower() and A.KegSmash:GetSpellCharges() > 0)) and A.WeaponsofOrder:IsReady("player") then
                    return A.KegSmash:Show(icon)
                end
                
                --actions+=/weapons_of_order
                if A.WeaponsofOrder:IsReady(unit) then
                    return A.WeaponsofOrder:Show(icon)
                end
                
                --actions+=/fallen_order
                if A.FallenOrder:IsReady(unit) then
                    return A.FallenOrder:Show(icon)
                end
                
                --actions+=/bonedust_brew
                if A.BonedustBrew:IsReady(unit) then
                    return A.BonedustBrew:Show(icon)
                end
                
                --actions+=/black_ox_brew,if=(energy+(energy.regen*cooldown.keg_smash.remains))<40&buff.blackout_combo.down&cooldown.keg_smash.up
                if A.BlackOxBrew:IsReady("player") and ((Player:Energy() + (Player:EnergyRegen() * A.KegSmash:GetCooldown())) < 40 and (Unit("player"):HasBuffs(A.BlackoutComboBuff.ID, true) > 0 or not A.BlackoutCombo:IsTalentLearned()) and A.KegSmash:GetCooldown() > 0) then
                    return A.BlackOxBrew:Show(icon)
                end
                
            end
            
            if A.BurstIsON(unit) and Cooldowns() then
                return true
            end
            --actions+=/purifying_brew
            if A.PurifyingBrew:IsReady("player") 
            and A.PurifyingBrew:GetSpellCharges() == 2 
            and 
            (
                (
                    (
                        not HoldNiuzao 
                        or 
                        not A.BurstIsON(unit)
                    ) 
                    and 
                    (
                        Unit("player"):HasDeBuffs(A.StaggerGreen.ID, true) > 0 
                        or 
                        Unit("player"):HasDeBuffs(A.StaggerYellow.ID, true) > 0 
                        or 
                        Unit("player"):HasDeBuffs(A.StaggerRed.ID, true) > 0
                    )
                ) 
			    or 
                (
                    HoldNiuzao and A.BurstIsON(unit) 
                    and A.InvokeNiuzao:GetCooldown() > 0 
                    and 
                    (
                        Unit("player"):HasDeBuffs(A.StaggerGreen.ID, true) > 0 
                        or 
                        Unit("player"):HasDeBuffs(A.StaggerYellow.ID, true) > 0 
                        or 
                        Unit("player"):HasDeBuffs(A.StaggerRed.ID, true) > 0
                    )
                )
            ) 
            then
                return A.PurifyingBrew:Show(icon)
            end
            
            if A.PurifyingBrew:IsReady("player")
            and ReturnSpellChargesFullRechargeTime(A.PurifyingBrew.ID) < 5 
            and 
            (
                not A.BurstIsON(unit) 
                or 
                (
                    HoldNiuzao and A.InvokeNiuzao:GetCooldown() > 0
                ) 
                or 
                not HoldNiuzao
            ) 
            and 
            (
                Unit("player"):HasDeBuffs(A.StaggerGreen.ID, true) > 0 
                or 
                Unit("player"):HasDeBuffs(A.StaggerYellow.ID, true) > 0 
                or 
                Unit("player"):HasDeBuffs(A.StaggerRed.ID, true) > 0
            ) 
            then
                return A.PurifyingBrew:Show(icon)
            end
            --Black Ox Brew is currently used to either replenish brews based on less than half a brew charge available, or low energy to enable Keg Smash
            --actions+=/black_ox_brew,if=cooldown.purifying_brew.charges_fractional<0.5
            if A.BlackOxBrew:IsReady("player") and ReturnSpellChargesFrac(A.PurifyingBrew.ID) < 0.5 then
                return A.BlackOxBrew:Show(icon)
            end
            
            --Offensively, prioritizes KS on cleave, BoS else, with energy spenders and cds sorted below
            --actions+=/keg_smash,if=spell_targets>=2
            if A.KegSmash:IsReady(unit) and MultiUnits:GetByRange(10, 3) >= 2 then
                return A.KegSmash:Show(icon)
            end
            
            --actions+=/faeline_stomp,if=spell_targets>=2
            if A.FaelineStomp:IsReady(unit) and MultiUnits:GetByRange(10, 3) >= 2 then
                return A.FaelineStomp:Show(icon)
            end
            
            --cast KS at top prio during WoO buff
            --actions+=/keg_smash,if=buff.weapons_of_order.up
            if A.KegSmash:IsReady(unit) and Unit("player"):HasBuffs(A.WeaponsofOrder.ID, true) > 0 then
                return A.KegSmash:Show(icon)
            end
            
            --Celestial Brew priority whenever it took significant damage (adjust the health.max coefficient according to intensity of damage taken), and to dump excess charges before BoB.
            --actions+=/celestial_brew,if=buff.blackout_combo.down&incoming_damage_1999ms>(health.max*0.1+stagger.last_tick_damage_4)&buff.elusive_brawler.stack<2
            if A.CelestialBrew:IsReady("player") and (Unit("player"):HasBuffs(A.BlackoutComboBuff.ID, true) > 0 or not A.BlackoutCombo:IsTalentLearned()) and Unit("player"):GetRealTimeDMG(2) > ((Unit("player"):HealthMax() * 0.1) + GetStaggerLevel(next_tick)) and Unit("player"):HasBuffsStacks(A.ElusiveBrawlerBuff.ID, true) < 2 then
                return A.CelestialBrew:Show(icon)
            end
            
            --actions+=/tiger_palm,if=talent.rushing_jade_wind.enabled&buff.blackout_combo.up&buff.rushing_jade_wind.up
            if A.TigerPalm:IsReady(unit) and A.RushingJadeWind:IsTalentLearned() and Unit("player"):HasBuffs(A.BlackoutComboBuff.ID, true) > 0 and Unit("player"):HasBuffs(A.RushingJadeWind.ID, true) > 0 then    
                return A.TigerPalm:Show(icon)
            end
            
            --actions+=/breath_of_fire,if=buff.charred_passions.down&runeforge.charred_passions.equipped
            if A.BreathofFire:IsReady(unit) and Unit("target"):GetRange() < 8 and Unit("player"):HasBuffs(A.CharredPassionsBuff.ID, true) == 0 and A.CharredPassions:HasLegendaryCraftingPower() then
                return A.BreathofFire:Show(icon)
            end
            
            --actions+=/blackout_kick
            if A.BlackoutKick:IsReady(unit) then
                return A.BlackoutKick:Show(icon)
            end
            
            --actions+=/keg_smash
            if ((A.KegSmash:IsReady(unit) and not A.LastKeg:HasLegendaryCraftingPower()) or (A.LastKeg:HasLegendaryCraftingPower() and A.KegSmash:GetSpellCharges() > 0)) then
                return A.KegSmash:Show(icon)
            end
            
            --actions+=/faeline_stomp
            if A.FaelineStomp:IsReady(unit) then
                return A.FaelineStomp:Show(icon)
            end
            
            --actions+=/expel_harm,if=buff.gift_of_the_ox.stack>=3
            if A.ExpelHarm:IsReady("player") and GetSpellCount(322101) >= 2 then
                return A.ExpelHarm:Show(icon)
            end
            
            --actions+=/spinning_crane_kick,if=buff.charred_passions.up
            if A.SpinningCraneKick:IsReady("player") and Unit("player"):HasBuffs(A.CharredPassionsBuff.ID, true) > 0 then
                return A.SpinningCraneKick:Show(icon)
            end
            
            --actions+=/breath_of_fire,if=buff.blackout_combo.down&(buff.bloodlust.down|(buff.bloodlust.up&dot.breath_of_fire_dot.refreshable))
            if A.BreathofFire:IsReady(unit) and Unit("target"):GetRange() < 8 and Unit("player"):HasBuffs(A.BlackoutComboBuff.ID, true) == 0 then
                return A.BreathofFire:Show(icon)
            end
            
            --actions+=/chi_burst
            if A.ChiBurst:IsReady(unit) then
                return A.ChiBurst:Show(icon)
            end
            
            --actions+=/chi_wave
            if A.ChiWave:IsReady(unit) then
                return A.ChiWave:Show(icon)
            end
            
            --actions+=/spinning_crane_kick,if=active_enemies>=3&cooldown.keg_smash.remains>gcd&(energy+(energy.regen*(cooldown.keg_smash.remains+execute_time)))>=65&(!talent.spitfire.enabled|!runeforge.charred_passions.equipped)
            if A.SpinningCraneKick:IsReady("player") and Action.GetToggle(2, "FillerPriority") == 2 and MultiUnits:GetByRange(10, 4) >= 3 and A.KegSmash:GetCooldown() > GetGCD() and (Player:Energy() + (Player:EnergyRegen() * (A.KegSmash:GetCooldown() + Unit("target"):TimeToDieX(15)))) >= 65 and (not A.Spitfire:IsTalentLearned() or not A.CharredPassions:HasLegendaryCraftingPower()) then
                return A.SpinningCraneKick:Show(icon)
            end         
            
            --actions+=/tiger_palm,if=!talent.blackout_combo&cooldown.keg_smash.remains>gcd&(energy+(energy.regen*(cooldown.keg_smash.remains+gcd)))>=65
            if A.TigerPalm:IsReady(unit) and not A.BlackoutCombo:IsTalentLearned() and A.KegSmash:GetCooldown() > GetGCD() and (Player:Energy() + (Player:EnergyRegen() * (A.KegSmash:GetCooldown() + GetGCD()))) >= 65 then
                return A.TigerPalm:Show(icon)
            end
            
            --actions+=/spinning_crane_kick,if=active_enemies>=3&cooldown.keg_smash.remains>gcd&(energy+(energy.regen*(cooldown.keg_smash.remains+execute_time)))>=65&(!talent.spitfire.enabled|!runeforge.charred_passions.equipped)
            if A.SpinningCraneKick:IsReady("player") and Action.GetToggle(2, "FillerPriority") == 1 and MultiUnits:GetByRange(10, 4) >= 3 and A.KegSmash:GetCooldown() > GetGCD() and (Player:Energy() + (Player:EnergyRegen() * (A.KegSmash:GetCooldown() + Unit("target"):TimeToDieX(15)))) >= 65 and (not A.Spitfire:IsTalentLearned() or not A.CharredPassions:HasLegendaryCraftingPower()) then
                return A.SpinningCraneKick:Show(icon)
            end     
            
            --actions+=/arcane_torrent,if=energy<31
            if A.ArcaneTorrent:IsReady("player") and Player:Energy() < 31 then
                return A.ArcaneTorrent:Show(icon)
            end
            
            --actions+=/rushing_jade_wind
            if A.RushingJadeWind:IsReady("player") and Unit("target"):GetRange() <= 15 then
                return A.RushingJadeWind:Show(icon)
            end    
            
        end        
    end
    
    local function FriendlyRotation(unit)
        -- Resuscitate
        if isSchoolFree and Unit(player):CombatTime() == 0 and Unit(unit):IsDead() and Player:IsStaying() and A.Resuscitate:IsReady(unit) then 
            return A.Resuscitate:Show(icon)
        end 
        
        -- Detox
        if isSchoolFree and A.Detox:IsReady(unit) and AuraIsValid(unit, "UseDispel", "Dispel") and A.Detox:AbsentImun(unit) then 
            return A.Detox:Show(icon)
        end 
        
        -- TigersLust
        if isSchoolFree and A.TigersLust:IsReady(unit) and Unit(unit):HasDeBuffs("Rooted") > GetGCD() and A.TigersLust:AbsentImun(unit) then 
            return A.TigersLust:Show(icon)
        end 
        
        -- GiftofNaaru
        if A.GiftofNaaru:AutoRacial(unit) then 
            return A.GiftofNaaru:Show(icon)
        end 
        
        -- Vivify
        if isSchoolFree and A.Vivify:IsReady(unit) and Player:IsStaying() and A.Vivify:AbsentImun(unit) and Unit(unit):HealthPercent() < 90 then 
            return A.Vivify:Show(icon)
        end         
        
        -- TigersLust
        if isSchoolFree and A.TigersLust:IsReady(unit) and not Player:IsMounted() then 
            local cMoving = Unit(unit):GetCurrentSpeed()
            if cMoving > 0 and cMoving <= 70 and A.TigersLust:AbsentImun(unit) then 
                return A.TigersLust:Show(icon)
            end 
        end 
        
        -- ChiBurst
        if inAoE and isSchoolFree and A.ChiBurst:IsReady(unit, true) and Unit(unit):GetRange() <= 40 and Player:IsStaying() and A.ChiBurst:AbsentImun(unit) and (not A.IsInPvP or not EnemyTeam("HEALER"):IsBreakAble(40)) then 
            return A.ChiBurst:Show(icon)
        end 
        
        -- ChiWave
        if inAoE and isSchoolFree and A.ChiWave:IsReady(unit, true) and Unit(unit):GetRange() <= 25 and A.ChiWave:AbsentImun(unit) and (not A.IsInPvP or not EnemyTeam("HEALER"):IsBreakAble(25)) then 
            return A.ChiWave:Show(icon)
        end 
    end 
    
    -- Mouseover    
    if IsUnitFriendly("mouseover") and FriendlyRotation("mouseover") then 
        return true             
    end     
    
    -- Target     
    if IsUnitEnemy("target") and EnemyRotation("target") then 
        return true 
    end    
    
    if IsUnitFriendly("target") and FriendlyRotation("target") then 
        return true 
    end 
end
--Finished

