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

local Azerite                                 = LibStub("AzeriteTraits")

local ACTION_CONST_WARRIOR_ARMS             = CONST.WARRIOR_ARMS
local ACTION_CONST_AUTOTARGET                = CONST.AUTOTARGET
local ACTION_CONST_SPELLID_FREEZING_TRAP    = CONST.SPELLID_FREEZING_TRAP

local IsIndoors, UnitIsUnit                    = _G.IsIndoors, _G.UnitIsUnit

Action[ACTION_CONST_WARRIOR_ARMS] = {
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
    DefensiveStance                                = Create({ Type = "Spell", ID = 197690                                               }),
    --Buffs
    BattleShout                                = Create({ Type = "Spell", ID = 6673                                               }),
    SuddenDeath                                = Create({ Type = "Spell", ID = 29725                                               }),
    IgnorePain                                = Create({ Type = "Spell", ID = 190456                                               }),
    DeepWounds                                = Create({ Type = "Spell", ID = 262111                                               }),
    FervorofBattle                                = Create({ Type = "Spell", ID = 202316                                               }),
    --CD
    DieByTheSword                                = Create({ Type = "Spell", ID = 118038                                               }),
    DeadlyCalm                                = Create({ Type = "Spell", ID = 262228                                               }),
    SweepingStrikes                                = Create({ Type = "Spell", ID = 260708                                               }),
    --kick
    Pummel                                = Create({ Type = "Spell", ID = 6552                                               }),
    -- Rotation       
    Rend                                = Create({ Type = "Spell", ID = 772                                               }),
    Slam                                = Create({ Type = "Spell", ID = 1464                                               }),
    MortalStrike                                = Create({ Type = "Spell", ID = 12294                                               }),
    SkullSplitter                                = Create({ Type = "Spell", ID = 260643                                               }),
    Cleave                                = Create({ Type = "Spell", ID = 845                                               }),
    Charge                                = Create({ Type = "Spell", ID = 100                                               }),
    Overpower                                = Create({ Type = "Spell", ID = 7384                                               }),
    Execute                                = Create({ Type = "Spell", ID = 163201                                               }),
    VictoryRush                                = Create({ Type = "Spell", ID = 34428                                               }),
    Bladestorm                                = Create({ Type = "Spell", ID = 46924                                               }),
    DragonRoar                                = Create({ Type = "Spell", ID = 274775                                               }),
    ColossusSmash                                = Create({ Type = "Spell", ID = 167105                                               }),
    Warbreaker                                = Create({ Type = "Spell", ID = 262161                                               }),
    Ravager                                = Create({ Type = "Spell", ID = 152277                                               }),
    Whirlwind                                = Create({ Type = "Spell", ID = 190411                                               }),
    HeroicLeap                                = Create({ Type = "Spell", ID = 6544                                               }),
    Avatar                                = Create({ Type = "Spell", ID = 107574                                               }),
    --covenant
    spear_of_bastion                                = Create({ Type = "Spell", ID = 307865                                               }),
    ancient_aftershock                                = Create({ Type = "Spell", ID = 325886                                               }),
    conquerers                                = Create({ Type = "Spell", ID = 324143                                               }),
    condemn                                = Create({ Type = "Spell", ID = 317349                                               }),
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
}

Action:CreateEssencesFor(ACTION_CONST_WARRIOR_ARMS)
local A = setmetatable(Action[ACTION_CONST_WARRIOR_ARMS], { __index = Action })

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
    for key, val in pairs(Action[ACTION_CONST_WARRIOR_ARMS]) do 
        if type(val) == "table" and val.Type == "Trinket" then 
            Temp.IsSlotTrinketBlocked[val.ID] = true
        end 
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

local function countInterruptGCD(unitID)
    if not A.Pummel:IsReadyByPassCastGCD(unitID) or not A.Pummel:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then 
        return true 
    end 
end 

local function Interrupts(unitID, icon)
    isInterrupt = select(9,UnitCastingInfo("target"));
    if A.GetToggle(2, "SnSInterruptList") and (IsInRaid() or A.InstanceInfo.KeyStone > 1) then
     --if A.GetToggle(2, "SnSInterruptList") then
         useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, "SnS_ShadowlandsContent", true, countInterruptGCD(unitID))
     else
         useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, countInterruptGCD(unitID))
     end
         
     if castRemainsTime >= A.GetLatency() then
         if useKick and A.Pummel:IsReady(unitID) then 
             return A.Pummel:Show(icon)
         end  
             
        if useRacial and A.QuakingPalm:AutoRacial(unitID) then 
            return A.QuakingPalm:Show(icon)
        end 
    
        if useRacial and A.Haymaker:AutoRacial(unitID) then 
            return A.Haymaker:Show(icon)
        end 
    
        if useRacial and A.WarStomp:AutoRacial(unitID) then 
            return A.WarStomp:Show(icon)
        end 
    
        if useRacial and A.BullRush:AutoRacial(unitID) then 
            return A.BullRush:Show(icon)
        end 
     end
 end

local function UseItems(unitID)
    if A.Trinket1:IsReady(unitID) and A.Trinket1:GetItemCategory() ~= "DEFF" and not Temp.IsSlotTrinketBlocked[A.Trinket1.ID] and A.Trinket1:AbsentImun(unitID, Temp.TotalAndMagPhys) then 
        return A.Trinket1
    end 
    
    if A.Trinket2:IsReady(unitID) and A.Trinket2:GetItemCategory() ~= "DEFF" and not Temp.IsSlotTrinketBlocked[A.Trinket2.ID] and A.Trinket2:AbsentImun(unitID, Temp.TotalAndMagPhys) then 
        return A.Trinket2
    end     
end

local function GetCovenantAbility(unitID, icon)
    local ability,covenant = Player:GetCovenant()
    if A.ancient_aftershock:IsReady(unitID, true) and covenant == "NightFae" then
        return A.ancient_aftershock:Show(icon)
    end
    if A.spear_of_bastion:IsReady(unitID, true) and covenant == "Kyrian" then
        return A.spear_of_bastion:Show(icon)
    end
    if A.condemn:IsReady(unitID, true) and covenant == "Venthyr" and Unit("player"):HasBuffs(A.SuddenDeath.ID) ~= 0 and Unit(unitID):HealthPercent() >= 80 then
        return A.condemn:Show(icon)
    end
    if A.conquerers:IsReady(unitID, true) and covenant == "Necrolord" and Unit(unitID):GetRange() <= 10 then
        return A.conquerers:Show(icon)
    end
end

local hasGoneInMelee = false
-- [3] Single Rotation
A[3] = function(icon)
    --local EnemyRotation, FriendlyRotation
    local isMoving             = Player:IsMoving()                    -- @boolean 
    local inCombat             = Unit(player):CombatTime()            -- @number 
    local inAoE                = GetToggle(2, "AoE")                -- @boolean 
    local inDisarm            = LoC:Get("DISARM") > 0                -- @boolean 
    local inMelee             = false                                -- @boolean 

    -- Rotations 
    function EnemyRotation(unitID)    
        if not IsUnitEnemy(unitID) then return end
        if Unit(unitID):IsDead() then return end
        if UnitCanAttack(player, unitID) == false then return end
        local Interupt = Interrupts(unitID, icon)
        if Interupt then
            return Interupt
        end
        -- Variables        
        local isBurst            = BurstIsON(unitID)
        
        inMelee                 = A.MortalStrike:IsInRange(unitID)    
        
        -- Purge
        if A.ArcaneTorrent:AutoRacial(unitID) then 
            return A.ArcaneTorrent:Show(icon)
        end             
        
        -- [[ finishers ]]
        local function Finishers()
            


        end
        
        -- [[ CDs ]]
        local function CDs()  
            local Item = UseItems(unitID)
            if Item and inMelee then
                return Item:Show(icon)
            end
            if A.Fireblood:IsReady(unitID, true) and inMelee then
                return A.Fireblood:Show(icon)
            end
            if A.Berserking:IsReady(unitID, true) and inMelee then
                return A.Berserking:Show(icon)
            end
            if A.BloodFury:IsReady(unitID, true) and inMelee then
                return A.BloodFury:Show(icon)
            end
            if A.LightsJudgment:IsReady(unitID, true) and inMelee then
                return A.LightsJudgment:Show(icon)
            end
            if A.Avatar:IsReady(unitID, true) and inMelee and Unit(unitID):HasDeBuffs(A.ColossusSmash.ID) ~= 0 then
                return A.Avatar:Show(icon)
            end
            if A.SweepingStrikes:IsReady(unitID, true) and MultiUnits:GetByRangeInCombat(10) > 1 and Unit(unitID):HasDeBuffs(A.ColossusSmash.ID) == 0 then
                return A.SweepingStrikes:Show(icon)
            end
        end
    
        -- [[ Single Target ]]
        local function ST()
            if A.VictoryRush:IsReady(unitID, true) and Unit(player):HealthPercent() <= GetToggle(2, "VictoryRush") then
                return A.VictoryRush:Show(icon)
            end
            if A.IgnorePain:IsReady(unitID, true) and Unit(player):HealthPercent() <= GetToggle(2, "IgnorePain") then
                return A.IgnorePain:Show(icon)
            end
            if A.Charge:IsReady(unitID, true) and Unit(unitID):GetRange() >= 10 and Unit(unitID):GetRange() <= 25 then
                return A.Charge:Show(icon)
            end
            if not A.Charge:IsReady(unitID, true) then
                if A.HeroicLeap:IsReady(unitID, true) then
                    return A.HeroicLeap:Show(icon)
                end
            else
                if A.HeroicLeap:IsReady(unitID, true) and Unit(unitID):GetRange() > 25 and Unit(unitID):GetRange() <= 40 then
                    return A.HeroicLeap:Show(icon)
                end
            end
            if A.Execute:IsReady(unitID, true) and Unit("player"):HasBuffs(A.SuddenDeath.ID) ~= 0 or A.Execute:IsReady(unitID, true) and Unit(unitID):HealthPercent() <= 20 then
                return A.Execute:Show(icon)
            end
            local covSpell = GetCovenantAbility(unitID, icon)
            if covSpell then
                return covSpell
            end
            if A.Ravager:IsReady(unitID, true) then
                return A.Ravager:Show(icon)
            end
            if A.ColossusSmash:IsReady(unitID, true) then
                return A.ColossusSmash:Show(icon)
            end
            if A.Warbreaker:IsReady(unitID, true) then
                return A.Warbreaker:Show(icon)
            end
            if A.Rend:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.Rend.ID) <= 4 then
                return A.Rend:Show(icon)
            end
            if A.SkullSplitter:IsReady(unitID, true) and Player:Rage() <= 60 and not A.Bladestorm:IsReady(unitID, true) then
                return A.SkullSplitter:Show(icon)
            end
            if A.MortalStrike:IsReady(unitID, true) and Unit(unitID):HasBuffs(A.DeepWounds.ID) <= 4 then
                return A.MortalStrike:Show(icon)
            end
            if A.DeadlyCalm:IsReady(unitID, true) then
                return A.DeadlyCalm:Show(icon)
            end
            if A.Overpower:IsReady(unitID, true) then
                return A.Overpower:Show(icon)
            end
            if A.MortalStrike:IsReady(unitID, true) then
                return A.MortalStrike:Show(icon)
            end
            if A.Bladestorm:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.ColossusSmash.ID) ~= 0 then
                return A.Bladestorm:Show(icon)
            end
            if A.Slam:IsReady(unitID, true) and not A.FervorofBattle:IsTalentLearned() and MultiUnits:GetByRangeInCombat(10) == 1 then
                return A.Slam:Show(icon)
            end
            if A.Whirlwind:IsReady(unitID, true) and MultiUnits:GetByRangeInCombat(10) > 1 then
                return A.Whirlwind:Show(icon)
            end
        end
        
        -- CDs need to re enable isBurst once fixed
        if CDs() and isBurst then 
            return true 
        end
        
        -- FINISHERS
        if inMelee and Finishers() then
            return true
        end
        
        --Single Target
        if ST() then
            return true
        end
        
        -- GiftofNaaru
        if A.GiftofNaaru:AutoRacial(player) and Unit(player):TimeToDie() < 10 then 
            return A.GiftofNaaru:Show(icon)
        end            
    end

    if A.BattleShout:IsReady(unitID, true) and Unit(player):HasBuffs(A.BattleShout.ID) == 0 then
        return A.BattleShout:Show(icon)
    end
    -- Target     
    if IsUnitEnemy("target") and EnemyRotation("target") then 
        return true 
    end
end 

A[4] = nil
A[5] = nil 
A[6] = nil 
A[7] = nil 
A[8] = nil 

