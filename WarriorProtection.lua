local _G, setmetatable                           = _G, setmetatable
local huge                                        = math.huge
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

local DisarmIsReady                            = Action.DisarmIsReady


local ACTION_CONST_WARRIOR_PROTECTION             = CONST.WARRIOR_PROTECTION
local ACTION_CONST_AUTOTARGET                = CONST.AUTOTARGET
local ACTION_CONST_SPELLID_FREEZING_TRAP    = CONST.SPELLID_FREEZING_TRAP


Action[ACTION_CONST_WARRIOR_PROTECTION] = {
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
    BattleShout                                = Create({ Type = "Spell", ID = 6673                                               }),
    -- Healing
    HealingSurge                                = Create({ Type = "Spell", ID = 8004                                               }),
    -- CDS
    Avatar                                = Create({ Type = "Spell", ID = 107574                                               }),
    DemoralizingShout                                = Create({ Type = "Spell", ID = 1160                                               }),
    Ravager                                = Create({ Type = "Spell", ID = 228920                                               }),
    DragonRoar                                = Create({ Type = "Spell", ID = 118000                                               }),
    Shockwave                                = Create({ Type = "Spell", ID = 46968                                               }),
    Stormbolt                              = Action.Create({ Type = "Spell", ID = 107570     }),
    IntimidatingShout                        = Create({ Type = "Spell", ID = 5246                                               }),
    AncientAftershock                        = Create({ Type = "Spell", ID = 325886                                               }),
    SpearOfBastion                            = Create({ Type = "Spell", ID = 307865                                               }),
    ConquerorsBanner                        = Create({ Type = "Spell", ID = 324143                                               }),
    --kick                        
    Pummel                                = Create({ Type = "Spell", ID = 6552                                               }),
    --Passives
    BoomingVoice                                = Create({ Type = "Spell", ID = 202743                                               }),
    Devastator                                = Create({ Type = "Spell", ID = 236279                                               }),
    --taunt
    Taunt                                = Create({ Type = "Spell", ID = 355                                               }),
    -- Rotation       
    ShieldSlam                                = Create({ Type = "Spell", ID = 23922                                               }), 
    ShieldBlock                                = Create({ Type = "Spell", ID = 2565                                               }), 
    ShieldBlockBuff                            = Create({ Type = "Spell", ID = 132404                                               }),
    ShieldWall                                = Create({ Type = "Spell", ID = 871                                               }), 
    IgnorePain                                = Create({ Type = "Spell", ID = 190456                                               }), 
    LastStand                                = Create({ Type = "Spell", ID = 12975                                               }), 
    LastStandBuff                          = Create({ Type = "Spell", ID = 12975, Hidden = true     }),
    ThunderClap                                = Create({ Type = "Spell", ID = 6343                                               }),
    Execute                                = Create({ Type = "Spell", ID = 163201                                               }),
    Devastate                                = Create({ Type = "Spell", ID = 20243                                               }), 
    Revenge                                = Create({ Type = "Spell", ID = 6572                                               }), 
    Charge                                = Create({ Type = "Spell", ID = 100                                               }),
    VictoryRush                                = Create({ Type = "Spell", ID = 34428                                               }),
    BerserkerRage                                = Create({ Type = "Spell", ID = 18499                                               }),
    UnstoppableForce                        = Create({ Type = "Spell", ID = 275336, Hidden = true                                   }),
    RallyingCry                                = Create({ Type = "Spell", ID = 97462                                                  }),
    
    -- Items
    PotionofUnbridledFury                     = Create({ Type = "Potion",  ID = 169299                                                                         }), 
    GalecallersBoon                          = Create({ Type = "Trinket", ID = 159614                                                                         }),    
    LustrousGoldenPlumage                    = Create({ Type = "Trinket", ID = 159617                                                                         }),    
    PocketsizedComputationDevice             = Create({ Type = "Trinket", ID = 167555                                                                         }),    
    AshvanesRazorCoral                       = Create({ Type = "Trinket", ID = 169311                                                                         }),    
    AzsharasFontofPower                      = Create({ Type = "Trinket", ID = 169314                                                                         }),    
    RemoteGuidanceDevice                     = Create({ Type = "Trinket", ID = 169769                                                                         }),    
    WrithingSegmentofDrestagath              = Create({ Type = "Trinket", ID = 173946                                                                         }),    
    DribblingInkpod                          = Create({ Type = "Trinket", ID = 169319                                                                         }),    
    -- Gladiator Badges/Medallions
    DreadGladiatorsMedallion                 = Create({ Type = "Trinket", ID = 161674                                                                         }),    
    DreadCombatantsInsignia                  = Create({ Type = "Trinket", ID = 161676                                                                         }),    
    DreadCombatantsMedallion                 = Create({ Type = "Trinket", ID = 161811, Hidden = true                                                         }),    -- Game has something incorrect with displaying this
    DreadGladiatorsBadge                     = Create({ Type = "Trinket", ID = 161902                                                                         }),    
    DreadAspirantsMedallion                  = Create({ Type = "Trinket", ID = 162897                                                                         }),    
    DreadAspirantsBadge                      = Create({ Type = "Trinket", ID = 162966                                                                         }),    
    SinisterGladiatorsMedallion              = Create({ Type = "Trinket", ID = 165055                                                                         }),    
    SinisterGladiatorsBadge                  = Create({ Type = "Trinket", ID = 165058                                                                         }),    
    SinisterAspirantsMedallion               = Create({ Type = "Trinket", ID = 165220                                                                         }),    
    SinisterAspirantsBadge                   = Create({ Type = "Trinket", ID = 165223                                                                         }),    
    NotoriousGladiatorsMedallion             = Create({ Type = "Trinket", ID = 167377                                                                         }),    
    NotoriousGladiatorsBadge                 = Create({ Type = "Trinket", ID = 167380                                                                         }),    
    NotoriousAspirantsMedallion              = Create({ Type = "Trinket", ID = 167525                                                                         }),    
    NotoriousAspirantsBadge                  = Create({ Type = "Trinket", ID = 167528                                                                         }), 
    -- Potions
    PotionofUnbridledFury            = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }),     
    SuperiorPotionofUnbridledFury    = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }),
    PotionofSpectralStrength        = Action.Create({ Type = "Potion", ID = 171275, QueueForbidden = true }),
    PotionofSpectralAgility      = Action.Create({ Type = "Potion", ID = 171270, QueueForbidden = true }),
    PotionofSpectralStamina            = Action.Create({ Type = "Potion", ID = 171274, QueueForbidden = true }),
    PotionofEmpoweredExorcisms        = Action.Create({ Type = "Potion", ID = 171352, QueueForbidden = true }),
    PotionofHardenedShadows            = Action.Create({ Type = "Potion", ID = 171271, QueueForbidden = true }),
    PotionofPhantomFire                = Action.Create({ Type = "Potion", ID = 171349, QueueForbidden = true }),
    PotionofDeathlyFixation            = Action.Create({ Type = "Potion", ID = 171351, QueueForbidden = true }),
    SpiritualHealingPotion            = Action.Create({ Type = "Potion", ID = 171267, QueueForbidden = true }),     
    PhialofSerenity                   = Action.Create({ Type = "Item", ID= 177278 }),     
}

Action:CreateEssencesFor(ACTION_CONST_WARRIOR_PROTECTION)
local A = setmetatable(Action[ACTION_CONST_WARRIOR_PROTECTION], { __index = Action })

local player                                 = "player"
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
    BigDeff                                 = {A.ShieldWall.ID},
};     


local IsIndoors, UnitIsUnit, UnitName = IsIndoors, UnitIsUnit, UnitName
local player = "player"

local function IsSchoolFree()
    return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 

local function isCurrentlyTanking()
    -- is player currently tanking any enemies within 16 yard radius
    local IsTanking = Unit(player):IsTankingAoE(16) or Unit(player):IsTanking("target", 16);
    return IsTanking;
end

local function shouldCastIp()
    if Unit(player):HasBuffs(A.IgnorePain.ID, true) > 0 then 
        local castIP = tonumber((GetSpellDescription(190456):match("%d+%S+%d"):gsub("%D","")))
        local IPCap = math.floor(castIP * 1.3);
        local currentIp = Unit(player):HasBuffs(A.IgnorePain.ID, true)
        
        -- Dont cast IP if we are currently at 20% of IP Cap remaining
        if currentIp  < (0.2 * IPCap) then
            return true
        else
            return false
        end
    else
        -- No IP buff currently
        return true
    end
end


-- [1] CC AntiFake Rotation
local function AntiFakeStun(unitID) 
    return 
    IsUnitEnemy(unitID) and  
    Unit(unitID):GetRange() <= 20 and 
    Unit(unitID):IsControlAble("stun") and 
    A.StormBoltGreen:AbsentImun(unitID, Temp.TotalAndPhysAndCCAndStun, true)          
end 
A[1] = function(icon)    
    -- if     A.StormBoltGreen:IsReady(nil, true, nil, true) and AntiFakeStun("target")
    -- then 
    --     return A.StormBoltGreen:Show(icon)         
    -- end                                                                     
end

-- [2] Kick AntiFake Rotation
A[2] = function(icon)        
    local unitID
    if IsUnitEnemy("mouseover") then 
        unitID = "mouseover"
    elseif IsUnitEnemy("target") then 
        unitID = "target"
    end 
    
    if unitID then         
        local castLeft, _, _, _, notKickAble = Unit(unitID):IsCastingRemains()
        if castLeft > 0 then             
            if not notKickAble and A.Pummel:IsReady(unitID, nil, nil, true) and A.Pummel:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then
                return A.Pummel:Show(icon)                                                  
            end                   
        end 
    end                                                                                 
end

-- SelfDefensives
local function SelfDefensives()
    local HPLoosePerSecond = math.max((Unit(player):GetDMG() * 100 / Unit(player):HealthMax()) - (Unit(player):GetHEAL() * 100 / Unit(player):HealthMax()), 0)
    local istanking = isCurrentlyTanking()
    
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    -- VictoryRush
    if Unit(player):HealthPercent() <= 90 and A.VictoryRush:IsReady("target") then 
        return A.VictoryRush
    end 
    
    -- ShieldBlock
    local ShieldBlockHP = GetToggle(2, "ShieldBlockHP")
    if Player:Rage() >= A.ShieldBlock:GetSpellPowerCost() and 
    A.ShieldBlock:IsReady(player) and 
    Unit(player):HasBuffs(A.ShieldBlockBuff.ID, true) == 0 and 
    --Unit(player):HasBuffs(A.LastStandBuff.ID, true) == 0 and 
    --Unit(player):GetRealTimeDMG(3) > 0 and
    istanking and
    not A.LastPlayerCastID == A.ShieldBlock.ID
    then 
        return A.ShieldBlock
    end 
    
    --LastStand
    if A.LastStand:IsReadyByPassCastGCD(player) and (not A.GetToggle(2, "LastStandIgnoreBigDeff") or Unit(player):HasBuffs(Temp.BigDeff) == 0) then 
        local LS_HP                 = A.GetToggle(2, "LastStandHP")
        local LS_TTD                = A.GetToggle(2, "LastStandTTD")
        if LS_HP >= 100 then LS_HP = 40 end
        if LS_TTD >= 100 then LS_TTD = 5 end
        if  (    
            ( LS_HP     >= 0     or LS_TTD                              >= 0                                        ) and 
            ( LS_HP     <= 0     or Unit(player):HealthPercent()     <= LS_HP                                    ) and 
            ( LS_TTD     <= 0     or (Unit(player):TimeToDie()         <= LS_TTD and Unit(player):HealthPercent() <= 20)) 
        ) 
        or 
        (
            A.GetToggle(2, "LastStandCatchKillStrike") and 
            (
                ( Unit(player):GetDMG()         >= Unit(player):Health() and Unit(player):HealthPercent() <= 20 ) or 
                Unit(player):GetRealTimeDMG() >= Unit(player):Health() or 
                (Unit(player):TimeToDie()         <= A.GetGCD() and Unit(player):HealthPercent() <= 20)
            )
        )                
        then                
            return A.LastStand
        end 
    end
    
    
    -- ShieldWall
    if A.ShieldWall:IsReadyByPassCastGCD(player) then 
        local SW_HP                 = A.GetToggle(2, "ShieldWallHP")
        local SW_TTD                = A.GetToggle(2, "ShieldWallTTD")
        
        if SW_HP >= 100 then SW_HP = 40 end
        if SW_TTD >= 100 then SW_HP = 5 end
        if  (    
            ( SW_HP     >= 0     or SW_TTD                              >= 0                                        ) and 
            ( SW_HP     <= 0     or Unit(player):HealthPercent()     <= SW_HP                                    ) and 
            ( SW_TTD     <= 0     or Unit(player):TimeToDie()         <= SW_TTD and Unit(player):HealthPercent() <= 20      )  
        ) 
        or 
        (
            A.GetToggle(2, "ShieldWallCatchKillStrike") and 
            (
                ( Unit(player):GetDMG()         >= Unit(player):Health() and Unit(player):HealthPercent() <= 20 ) or 
                Unit(player):GetRealTimeDMG() >= Unit(player):Health() or 
                (Unit(player):TimeToDie()         <= A.GetGCD() + A.GetCurrentGCD() and Unit(player):HealthPercent() <= 20)
            )
        )                
        then
            -- ShieldBlock
            if A.ShieldBlock:IsReadyByPassCastGCD(player) and Player:Rage() >= A.ShieldBlock:GetSpellPowerCostCache() and Unit(player):HasBuffs(A.ShieldBlockBuff.ID, true) == 0 and Unit(player):HasBuffs(A.LastStandBuff.ID, true) == 0 then  
                return A.ShieldBlock        -- #4
            end 
            
            -- ShieldWall
            return A.ShieldWall         -- #3                  
            
        end 
    end
    
    -- RallyingCry 
    local RallyingCry = A.GetToggle(2, "RallyingCryHP")
    if    RallyingCry >= 0 and A.RallyingCry:IsReady(player) and 
    (
        (     -- Auto 
            RallyingCry >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 10 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.10 or 
                -- TTD 
                Unit(player):TimeToDieX(20) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) 
        or 
        (    -- Custom
            RallyingCry < 100 and 
            Unit(player):HealthPercent() <= RallyingCry
        )
    ) 
    then 
        return A.RallyingCry
    end      
    
    -- HealingPotion
    local SpiritualHealingPotion = A.GetToggle(2, "SpiritualHealingPotion")
    if     SpiritualHealingPotion >= 0 and A.SpiritualHealingPotion:IsReady(player) and 
    (
        (     -- Auto 
            SpiritualHealingPotion >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 10 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.10 or 
                -- TTD 
                Unit(player):TimeToDieX(20) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            SpiritualHealingPotion < 100 and 
            Unit(player):HealthPercent() <= SpiritualHealingPotion
        )
    ) 
    then 
        return A.SpiritualHealingPotion
    end             
    
end 
SelfDefensives = A.MakeFunctionCachedDynamic(SelfDefensives)

local function countInterruptGCD(unitID)
    if not A.Pummel:IsReadyByPassCastGCD(unitID) or not A.Pummel:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then 
        return true 
    end 
end 

local function Interrupts(unit)
    isInterrupt = select(9,UnitCastingInfo("target"));
    local StormBoltInterrupt   = GetToggle(2, "StormBoltInterrupt")    
    local ShockwaveInterrupt   = GetToggle(2, "ShockwaveInterrupt")    
    
    if A.GetToggle(2, "SnSInterruptList") and (IsInRaid() or A.InstanceInfo.KeyStone > 1) then
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, "SnS_ShadowlandsContent", true, countInterruptGCD(unit))
    else
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, nil, nil, countInterruptGCD(unit))
    end
    
    if castRemainsTime >= A.GetLatency() then
        -- Pummel
        if useKick and not notInterruptable and A.Pummel:IsReady(unit) and A.Pummel:AbsentImun(unit, Temp.TotalAndPhysKick, true) then 
            return A.Pummel
        end
        
        -- Shockwave
        if A.Shockwave:IsReady(unit) and A.Shockwave:AbsentImun(unit, Temp.TotalAndCC, true) and ShockwaveInterrupt and A.Pummel:GetCooldown() > 1 and useCC and Unit(unit):GetRange() <= 8 then 
            return A.Shockwave
        end 
        
        -- Shockwave
        if A.Stormbolt:GetCooldown() == 0 and A.Stormbolt:IsInRange(unit) and A.Shockwave:AbsentImun(unit, Temp.TotalAndCC, true) and StormBoltInterrupt and A.Pummel:GetCooldown() > 1 and useCC then 
            return A.Stormbolt
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

local function ThunderClapRange()
    return A.UnstoppableForce:IsSpellLearned() and 12 or 8
end

local hasGoneInMelee = false
-- [3] Single Rotation
A[3] = function(icon)
    --local EnemyRotation, FriendlyRotation
    local isMoving             = Player:IsMoving()                    -- @boolean 
    local inCombat             = Unit(player):CombatTime()            -- @number 
    local inAoE                = GetToggle(2, "AoE")                -- @boolean 
    local inDisarm             = LoC:Get("DISARM") > 0                -- @boolean 
    local inMelee              = false                                -- @boolean 
    inMelee                    = A.ShieldSlam:IsInRange("target")    
    local Pull                    = Action.BossMods:GetPullTimer()    
    local isCurrentlyTanking   = isCurrentlyTanking()
    ThunderClapRange()
    local Potion                = GetToggle(1, "Potion")
    local UseAoE                = Action.GetToggle(2, "AoE")
    local ShieldBlockDPS          = GetToggle(2, "ShieldBlockDPS")
    
    -- Rotations 
    function EnemyRotation(unit)  
        
        -- Defensive
        if inCombat then
            local SelfDefensive = SelfDefensives()
            if SelfDefensive then 
                return SelfDefensive:Show(icon)
            end 
        end
        
        local Interrupt = Interrupts(unit)
        if Interrupt then 
            return Interrupt:Show(icon)
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
        
        -- [[ Single Target ]]
        local function ST()
            -- actions.generic=ravager
            if A.Ravager:IsReady("player") and Unit("target"):GetRange() <= 8 and A.BurstIsON(unit) then
                return A.Ravager:Show(icon)
            end
            
            -- actions.generic+=/dragon_roar
            if A.DragonRoar:IsReady("player") then
                return A.DragonRoar:Show(icon)
            end
            
            -- actions.generic+=/shield_slam,if=buff.shield_block.up
            if A.ShieldSlam:IsReady(unit) and Unit("player"):HasBuffs(A.ShieldBlock.ID, true) > 0 then
                return A.ShieldSlam:Show(icon)
            end
            
            -- actions.generic+=/thunder_clap,if=(spell_targets.thunder_clap>1|cooldown.shield_slam.remains)&talent.unstoppable_force.enabled&buff.avatar.up
            if A.ThunderClap:IsReady("player") and Unit("target"):GetRange() <= ThunderClapRange() and (A.ThunderClap:GetSpellCharges() > 1 or A.ShieldSlam:GetCooldown() > 0) and A.UnstoppableForce:IsTalentLearned() and Unit("player"):HasBuffs(A.Avatar.ID, true) > 0 then
                return A.ThunderClap:Show(icon)
            end
            
            -- actions.generic+=/shield_slam
            if A.ShieldSlam:IsReady(unit) then
                return A.ShieldSlam:Show(icon)
            end
            
            -- actions.generic+=/execute
            if A.Execute:IsReady(unit) then
                return A.Execute:Show(icon)
            end
            
            -- actions.generic+=/revenge,if=rage>=70
            if A.Revenge:IsReady("player") and Player:Rage() >= 70 then
                return A.Revenge:Show(icon)
            end
            
            -- actions.generic+=/thunder_clap
            if A.ThunderClap:IsReady("player") and Unit("target"):GetRange() <= ThunderClapRange() then
                return A.ThunderClap:Show(icon)
            end
            
            -- actions.generic+=/revenge
            if A.Revenge:IsReady("player") and not A.Execute:IsReady(unit) then
                return A.Revenge:Show(icon)
            end
            
            -- actions.generic+=/devastate
            if A.Devastate:IsReady(unit) then
                return A.Devastate:Show(icon)
            end
        end
        
        -- [[ AoE ]]
        local function AoERotation()
            -- actions.aoe=ravager
            if A.Ravager:IsReady("player") and A.BurstIsON(unit) and Unit("target"):GetRange() <= 8 then
                return A.Ravager:Show(icon)
            end
            
            -- actions.aoe+=/dragon_roar
            if A.DragonRoar:IsReady("player") and Unit("target"):GetRange() <= 8 then
                return A.DragonRoar:Show(icon)
            end            
            
            -- actions.aoe+=/thunder_clap
            if A.ThunderClap:IsReady("player") and Unit("target"):GetRange() <= ThunderClapRange() then
                return A.ThunderClap:Show(icon)
            end    
            
            -- actions.aoe+=/revenge
            if A.Revenge:IsReady("player") and not A.Execute:IsReady(unit) then
                return A.Revenge:Show(icon)
            end    
            
            -- actions.aoe+=/shield_slam
            if A.ShieldSlam:IsReady(unit) then
                return A.ShieldSlam:Show(icon)
            end    
            
        end
        
        
        
        if A.BattleShout:IsReady(unitID, true) and Unit(player):HasBuffs(A.BattleShout.ID) == 0 then
            return A.BattleShout:Show(icon)
        end
        
        --Prepull Potion
        if A.PotionofSpectralStrength:IsReady(unit) and Action.GetToggle(1, "Potion") and (Pull > 0 and Pull <= 2) then
            return A.PotionofSpectralStrength:Show(icon)
        end
        if A.PotionofPhantomFire:IsReady(unit) and Action.GetToggle(1, "Potion") and (Pull > 0 and Pull <= 2) then
            return A.PotionofPhantomFire:Show(icon)
        end
        --potion #2
        if A.PotionofSpectralStrength:IsReady(unit) and Action.GetToggle(1, "Potion") and (Pull > 0 and Pull <= 2) then
            return A.PotionofSpectralStrength:Show(icon)
        end
        if A.PotionofPhantomFire:IsReady(unit) and Action.GetToggle(1, "Potion") and (Pull > 0 and Pull <= 2) then
            return A.PotionofPhantomFire:Show(icon)
        end
        -- actions=auto_attack
        -- actions+=/charge,if=time=0
        -- actions+=/use_items,if=cooldown.avatar.remains<=gcd|buff.avatar.up
        -- Trinket 1
        if A.Trinket1:IsReady(unit) and Unit(unit):GetRange() <= 7 and A.Trinket1:GetItemCategory() == "DPS" and A.BurstIsON(unit) and (A.Avatar:GetCooldown() > 0 or Unit("player"):HasBuffs(A.Avatar.ID, true) > 0) then
            return A.Trinket1:Show(icon)    
        end
        
        -- Trinket 2
        if A.Trinket2:IsReady(unit) and Unit(unit):GetRange() <= 7 and A.Trinket2:GetItemCategory() == "DPS" and A.BurstIsON(unit) and (A.Avatar:GetCooldown() > 0 or Unit("player"):HasBuffs(A.Avatar.ID, true) > 0) then
            return A.Trinket2:Show(icon)    
        end  
        
        -- actions+=/blood_fury
        if A.BloodFury:IsReady("player") and A.BurstIsON(unit) then
            return A.BloodFury:Show(icon)
        end
        
        -- actions+=/berserking
        if A.Berserking:IsReady("player") and A.BurstIsON(unit) then
            return A.Berserking:Show(icon)
        end
        
        -- actions+=/arcane_torrent
        if A.ArcaneTorrent:IsReady("player") and A.BurstIsON(unit) then
            return A.ArcaneTorrent:Show(icon)
        end
        
        -- actions+=/lights_judgment
        if A.LightsJudgment:IsReady("player") and A.BurstIsON(unit) then
            return A.LightsJudgment:Show(icon)
        end
        
        -- actions+=/fireblood
        if A.Fireblood:IsReady("player") and A.BurstIsON(unit) then
            return A.Fireblood:Show(icon)
        end
        
        -- actions+=/ancestral_call
        if A.AncestralCall:IsReady("player") and A.BurstIsON(unit) then
            return A.AncestralCall:Show(icon)
        end
        
        -- actions+=/bag_of_tricks
        if A.BagofTricks:IsReady("player") and A.BurstIsON(unit) then
            return A.BagofTricks:Show(icon)
        end
        
        -- actions+=/potion,if=buff.avatar.up|target.time_to_die<25
        if A.PotionofSpectralStrength:IsReady(unit) and Action.GetToggle(1, "Potion") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.Avatar.ID, true) > 0 or Unit("target"):TimeToDie() < 25) then
            return A.PotionofSpectralStrength:Show(icon)
        end
        if A.PotionofPhantomFire:IsReady(unit) and Action.GetToggle(1, "Potion") and A.BurstIsON(unit) and (Unit("player"):HasBuffs(A.Avatar.ID, true) > 0 or Unit("target"):TimeToDie() < 25) then
            return A.PotionofPhantomFire:Show(icon)
        end
        
        -- actions+=/ignore_pain,if=buff.ignore_pain.down&rage>50
        if A.IgnorePain:IsReady("player") and Unit("player"):HasBuffs(A.IgnorePain.ID, true) == 0 and Player:Rage() > 50 and shouldCastIp() then
            return A.IgnorePain:Show(icon)
        end
        
        -- actions+=/demoralizing_shout,if=talent.booming_voice.enabled
        if A.DemoralizingShout:IsReady("player") and A.BoomingVoice:IsTalentLearned() and Unit("target"):GetRange() <= 8 then
            return A.DemoralizingShout:Show(icon)
        end
        
        -- actions+=/avatar
        if A.Avatar:IsReady("player") and A.BurstIsON(unit) and Unit("target"):GetRange() <= 8 then
            return A.Avatar:Show(icon)
        end
        
        -- actions+=/ancient_aftershock
        if A.AncientAftershock:IsReady("player") and A.BurstIsON(unit) then
            return A.AncientAftershock:Show(icon)
        end
        
        -- actions+=/spear_of_bastion
        if A.SpearOfBastion:IsReady("player") and A.BurstIsON(unit) and Unit("target"):GetRange() <= 8 then
            return A.SpearOfBastion:Show(icon)
        end
        
        -- actions+=/conquerors_banner
        if A.ConquerorsBanner:IsReady("player") and A.BurstIsON(unit) and Unit("target"):GetRange() <= 8 then
            return A.ConquerorsBanner:Show(icon)
        end
        
        -- actions+=/shield_block,if=buff.shield_block.down
        if A.ShieldBlock:IsReady("player") and Unit("player"):HasBuffs(A.ShieldBlockBuff.ID, true) == 0 and A.ShieldSlam:GetCooldown() < 1 and ShieldBlockDPS then
            return A.ShieldBlock:Show(icon)
        end
        
        -- actions+=/run_action_list,name=aoe,if=spell_targets.thunder_clap>=3
        if MultiUnits:GetByRange(8, 3) >= 3 and UseAoE and AoERotation() then
            return AoERotation()
        end
        
        -- actions+=/call_action_list,name=generic
        if ST() then
            return ST()
        end
    end
    
    -- Mouseover 
    if IsUnitEnemy("mouseover") and not Unit("mouseover"):IsDead() then
        if EnemyRotation("mouseover") then
            return true
        end
    end 
    
    -- Target     
    if IsUnitEnemy("target") and EnemyRotation("target") and not Unit("target"):IsDead() then 
        if EnemyRotation("target") then
            return true
        end
    end  
end 

A[4] = nil
A[5] = nil 
A[6] = nil 
A[7] = nil 
A[8] = nil 

