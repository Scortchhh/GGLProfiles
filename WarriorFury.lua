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

local ACTION_CONST_WARRIOR_FURY             = CONST.WARRIOR_FURY
local ACTION_CONST_AUTOTARGET                = CONST.AUTOTARGET
local ACTION_CONST_SPELLID_FREEZING_TRAP    = CONST.SPELLID_FREEZING_TRAP

local IsIndoors, UnitIsUnit                    = _G.IsIndoors, _G.UnitIsUnit

Action[ACTION_CONST_WARRIOR_FURY] = {
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
    -- Passive
    will_of_the_berserker                                = Create({ Type = "Spell", ID = 335594                                               }),
    -- Talent
    frenzy                                = Create({ Type = "Spell", ID = 335077                                               }),
    --Buffs
    enrage                                = Create({ Type = "Spell", ID = 184361                                               }),
    BattleShout                                = Create({ Type = "Spell", ID = 6673                                               }),
    recklessness                                = Create({ Type = "Spell", ID = 1719                                               }),
    EnragedRegeneration                                = Create({ Type = "Spell", ID = 184364                                               }),
    IgnorePain                                = Create({ Type = "Spell", ID = 190456                                               }),
    WhirlwindBuff                                = Create({ Type = "Spell", ID = 12950                                               }),
    --kick
    Pummel                                = Create({ Type = "Spell", ID = 6552                                               }),
    PummelGreen                               = Create({ Type = "SpellSingleColor", ID = 1766, Color = "GREEN", Desc = "[2] Kick", QueueForbidden = true    }), 
    -- Rotation       
    bloodthirst                                = Create({ Type = "Spell", ID = 23881                                               }),
    siegebreaker                                = Create({ Type = "Spell", ID = 280772                                               }),
    raging_blow                                = Create({ Type = "Spell", ID = 85288                                               }),
    crushing_blow                                = Create({ Type = "Spell", ID = 335097                                               }),
    bloodbath                                = Create({ Type = "Spell", ID = 335096                                               }),
    charge                                = Create({ Type = "Spell", ID = 100                                               }),
    rampage                                = Create({ Type = "Spell", ID = 184367                                               }),
    execute                                = Create({ Type = "Spell", ID = 163201                                               }),
    victory_rush                                = Create({ Type = "Spell", ID = 34428                                               }),
    bladestorm                                = Create({ Type = "Spell", ID = 46924                                               }),
    dragon_roar                                = Create({ Type = "Spell", ID = 274775                                               }),
    onslaught                                = Create({ Type = "Spell", ID = 235285                                               }),
    Whirlwind                                = Create({ Type = "Spell", ID = 190411                                               }),
    heroic_leap                                = Create({ Type = "Spell", ID = 6544                                               }),
    sudden_death                                = Create({ Type = "Spell", ID = 29725                                               }),
    cruelty                                = Create({ Type = "Spell", ID = 335070                                               }),
    Massacre                                = Create({ Type = "Spell", ID = 206315                                               }),
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

Action:CreateEssencesFor(ACTION_CONST_WARRIOR_FURY)
local A = setmetatable(Action[ACTION_CONST_WARRIOR_FURY], { __index = Action })

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
    for key, val in pairs(Action[ACTION_CONST_WARRIOR_FURY]) do 
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
    if A.IsUnitEnemy("mouseover") then 
        unitID = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unitID = "target"
    end 

    if unitID then
        local castLeft, _, _, _, notInterruptable = Unit(unitID):IsCastingRemains()
        if castLeft > 0 then 
            -- Kick
            if not notInterruptable and A.PummelGreen:IsReady(unitID, nil, nil, true) and A.PummelGreen:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then
                return A.PummelGreen:Show(icon)
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
    if A.ancient_aftershock:IsReady(unitID, true) and covenant == "NightFae" and Unit("player"):HasBuffs(A.enrage.ID) ~= 0 then
        return A.ancient_aftershock:Show(icon)
    end
    if A.spear_of_bastion:IsReady(unitID, true) and Unit("player"):HasBuffs(A.enrage.ID) ~= 0 and covenant == "Kyrian" then
        return A.spear_of_bastion:Show(icon)
    end
    if A.condemn:IsReady(unitID, true) and covenant == "Venthyr" and Unit(unitID):HealthPercent() >= 80 or A.condemn:IsReady(unitID, true) and covenant == "Venthyr" and Unit(unitID):HealthPercent() <= 20 or A.condemn:IsReady(unitID, true) and covenant == "Venthyr" and A.Massacre:IsTalentLearned() and Unit(unitID):HealthPercent() <= 35  then
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
        
        inMelee                 = A.raging_blow:IsInRange(unitID)    
        
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
            if A.recklessness:IsReady(unitID, true) and Unit(unitID):GetRange() <= 8 and inMelee then
                return A.recklessness:Show(icon)
            end
            if A.EnragedRegeneration:IsReady(unitID, true) and Unit(player):HealthPercent() <= GetToggle(2, "EnragedRegeneration") and inMelee then
                return A.EnragedRegeneration:Show(icon)
            end
        end
    
        -- [[ Single Target ]]
        local function ST()
            if A.victory_rush:IsReady(unitID, true) and Unit(player):HealthPercent() <= GetToggle(2, "VictoryRush") and inMelee then
                return A.victory_rush:Show(icon)
            end
            if A.execute:IsReady(unitID, true) and Unit("player"):HasBuffs(A.sudden_death.ID) ~= 0 or A.execute:IsReady(unitID, true) and Unit(unitID):HealthPercent() <= 20 or A.execute:IsReady(unitID, true) and A.Massacre:IsTalentLearned() and Unit(unitID):HealthPercent() <= 35 then
                return A.execute:Show(icon)
            end
            if A.IgnorePain:IsReady(unitID, true) and Unit(player):HealthPercent() <= GetToggle(2, "IgnorePain") then
                return A.IgnorePain:Show(icon)
            end
            if A.charge:IsReady(unitID, true) and Unit(unitID):GetRange() >= 10 and Unit(unitID):GetRange() <= 25 then
                return A.charge:Show(icon)
            end
            if A.heroic_leap:IsReady(unitID, true) and Unit(unitID):GetRange() > 25 and Unit(unitID):GetRange() <= 40 and A.charge:GetSpellCharges() == 0 then
                return A.heroic_leap:Show(icon)
            end
            if MultiUnits:GetByRangeInCombat(10) >= 2 then
                if A.Whirlwind:IsReady(unitID, true) and Unit("player"):HasBuffs(A.WhirlwindBuff.ID) == 0 then
                    return A.Whirlwind:Show(icon)
                end
            end
            local covSpell = GetCovenantAbility(unitID, icon)
            if covSpell then
                return covSpell
            end
            if A.rampage:IsReady(unitID, true) and Unit("player"):HasBuffs(A.enrage.ID) == 0 or A.rampage:IsReady(unitID, true) and Player:Rage() >= 90 then
                return A.rampage:Show(icon)
            end
            if A.siegebreaker:IsReady(unitID, true) and Unit("player"):HasBuffs(A.recklessness.ID) ~= 0 or A.siegebreaker:IsReady(unitID, true) and A.recklessness:GetCooldown() > 0 then
                return A.siegebreaker:Show(icon)
            end
            if A.onslaught:IsReady(unitID, true) and Unit("player"):HasBuffs(A.enrage.ID) ~= 0 then
                return A.onslaught:Show(icon)
            end
            if A.raging_blow:IsReady(unitID, true) and Unit("player"):HasBuffs(A.enrage.ID) ~= 0 and A.raging_blow:GetSpellCharges() == 2 then
                return A.raging_blow:Show(icon)
            end
            if A.bloodthirst:IsReady(unitID, true) and Unit("player"):HasBuffs(A.enrage.ID) <= 1.3 then
                return A.bloodthirst:Show(icon)
            end
            if A.dragon_roar:IsReady(unitID, true) and Unit("player"):HasBuffs(A.enrage.ID) ~= 0 then
                return A.dragon_roar:Show(icon)
            end
            if A.bladestorm:IsReady(unitID, true) and Unit("player"):HasBuffs(A.enrage.ID) ~= 0 then
                return A.bladestorm:Show(icon)
            end
            if A.raging_blow:IsReady(unitID, true) and Unit("player"):HasBuffs(A.enrage.ID) ~= 0 and A.raging_blow:GetSpellChargesFrac() >= 1.5 then
                return A.raging_blow:Show(icon)
            end
            if A.Whirlwind:IsReady(unitID, true) then
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

