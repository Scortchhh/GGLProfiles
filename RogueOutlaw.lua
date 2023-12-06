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

local ACTION_CONST_ROGUE_OUTLAW                        = CONST.ROGUE_OUTLAW
local ACTION_CONST_AUTOTARGET                = CONST.AUTOTARGET
local ACTION_CONST_SPELLID_FREEZING_TRAP    = CONST.SPELLID_FREEZING_TRAP

local IsIndoors, UnitIsUnit                    = _G.IsIndoors, _G.UnitIsUnit

Action[ACTION_CONST_ROGUE_OUTLAW] = {
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
    -- general
    Stealth                                = Create({ Type = "Spell", ID = 1784                                               }),
    InstantPoison                                = Create({ Type = "Spell", ID = 315584                                               }),
    CripplingPoison                                = Create({ Type = "Spell", ID = 3408                                               }),
    NumbingPoison                                = Create({ Type = "Spell", ID = 5761                                               }),
    CrimsonVial                                = Create({ Type = "Spell", ID = 185311                                               }),
    -- CDS
    ShadowDance                                = Create({ Type = "Spell", ID = 185313                                               }),
    SymbolOfDeath                                = Create({ Type = "Spell", ID = 212283                                               }),
    AdrenalineRush                                = Create({ Type = "Spell", ID = 186286                                               }),
    RollTheBones                                = Create({ Type = "Spell", ID = 193316                                               }),
    --covenant shit
    Sepsis                                = Create({ Type = "Spell", ID = 328305                                               }),
    SepsisBuff                                = Create({ Type = "Spell", ID = 347037                                               }),
    SerratedBoneSpike                                = Create({ Type = "Spell", ID = 328547                                               }),
    EchoingReprimand                                = Create({ Type = "Spell", ID = 323547                                               }),
    Flagellation                                = Create({ Type = "Spell", ID = 323654                                               }),
    --rollthebonesbuff
    Broadside                                = Create({ Type = "Spell", ID = 193356                                               }),
    BuriedTreasure                                = Create({ Type = "Spell", ID = 199600                                               }),
    GrandMelee                                = Create({ Type = "Spell", ID = 193358                                               }),
    RuthlessPrecision                                = Create({ Type = "Spell", ID = 193357                                               }),
    SkullandCrossbones                                = Create({ Type = "Spell", ID = 199603                                               }),
    TrueBearing                                = Create({ Type = "Spell", ID = 193359                                               }),
    --Buffs
    FindWeakness                                = Create({ Type = "Spell", ID = 91021                                               }),
    NightStalker                                = Create({ Type = "Spell", ID = 14062                                               }),
    PerforatedVeins                                = Create({ Type = "Spell", ID = 341567                                               }),
    SliceAndDice                                = Create({ Type = "Spell", ID = 145418                                               }),
    SecretTechnique                                = Create({ Type = "Spell", ID = 280720                                               }),
    DeeperStratagem                                = Create({ Type = "Spell", ID = 193531                                               }),
    Opportunity                                = Create({ Type = "Spell", ID = 195627                                               }),
    MarkedForDeath                                = Create({ Type = "Spell", ID = 137619                                               }),
    --kick
    Kick                                = Create({ Type = "Spell", ID = 1766                                               }),
    KickGreen                               = Create({ Type = "SpellSingleColor", ID = 1766, Color = "GREEN", Desc = "[2] Kick", QueueForbidden = true    }), 
    -- Rotation       
    ShadowStrike                                = Create({ Type = "Spell", ID = 185438                                               }),
    Shiv                                = Create({ Type = "Spell", ID = 5938                                               }),
    ShurikenStorm                                = Create({ Type = "Spell", ID = 197835                                               }),
    Gloomblade                                = Create({ Type = "Spell", ID = 200758                                               }),
    Backstab                                = Create({ Type = "Spell", ID = 53                                               }),
    Rupture                                = Create({ Type = "Spell", ID = 1943                                               }),
    Eviscerate                                = Create({ Type = "Spell", ID = 196819                                               }),
    Ambush                                = Create({ Type = "Spell", ID = 8676                                               }),
    CheapShot                                = Create({ Type = "Spell", ID = 1833                                               }),
    Dispatch                                = Create({ Type = "Spell", ID = 2098                                               }),
    PistolShot                                = Create({ Type = "Spell", ID = 185763                                               }),
    SinisterStrike                                = Create({ Type = "Spell", ID = 1752                                               }),
    BladeFlurry                                = Create({ Type = "Spell", ID = 13877                                               }),
    GhostlyStrike                                = Create({ Type = "Spell", ID = 196937                                               }),
    KillingSpree                                = Create({ Type = "Spell", ID = 51690                                               }),
    BladeRush                                = Create({ Type = "Spell", ID = 271877                                               }),
    BetweenTheEyes                                = Create({ Type = "Spell", ID = 199804                                               }),
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

Action:CreateEssencesFor(ACTION_CONST_ROGUE_OUTLAW)
local A = setmetatable(Action[ACTION_CONST_ROGUE_OUTLAW], { __index = Action })

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
    for key, val in pairs(Action[ACTION_CONST_ROGUE_OUTLAW]) do 
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
            if not notInterruptable and A.KickGreen:IsReady(unitID, nil, nil, true) and A.KickGreen:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then
                return A.KickGreen:Show(icon)
            end 
        end 
    end
end

local function countInterruptGCD(unitID)
    if not A.Kick:IsReadyByPassCastGCD(unitID) or not A.Kick:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then 
        return true 
    end 
end 

local function Interrupts(unitID)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime = InterruptIsValid(unitID,  nil, nil, countInterruptGCD(unitID))    
    
    -- Can waste interrupt action due delays caused by ping, interface input 
    if castRemainsTime < GetLatency() then 
        return 
    end 
    
    if useKick and not notInterruptable and A.Kick:IsReady(unitID) then 
        return A.Kick
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
        local kick = Interrupts(unitID)
        if kick then
            return A.Kick:Show(icon)
        end  
        -- Variables        
        local isBurst            = BurstIsON(unitID)
        
        inMelee                 = A.Shiv:IsInRange(unitID)
        local isStealthed = Unit(player):HasBuffs(A.Stealth.ID)     
        
        -- Purge
        if A.ArcaneTorrent:AutoRacial(unitID) then 
            return A.ArcaneTorrent:Show(icon)
        end             

        local function CheckBuffCountRB() 
            local count = 0
            if Unit(player):HasBuffs(A.Broadside.ID) ~= 0 then
                count = count + 1
            end
            if Unit(player):HasBuffs(A.BuriedTreasure.ID) ~= 0 then
                count = count + 1
            end
            if Unit(player):HasBuffs(A.GrandMelee.ID) ~= 0 then
                count = count + 1
            end
            if Unit(player):HasBuffs(A.RuthlessPrecision.ID) ~= 0 then
                count = count + 1
            end
            if Unit(player):HasBuffs(A.TrueBearing.ID) ~= 0 then
                count = count + 1
            end
            if Unit(player):HasBuffs(A.SkullandCrossbones.ID) ~= 0 then
                count = count + 1
            end
            return count
        end
        
        -- [[ finishers ]]
        local function Finishers()
            if A.DeeperStratagem:IsTalentLearned() then
                if A.SliceAndDice:IsReady(unitID, true) and Unit(player):HasBuffs(A.SliceAndDice.ID) <= 9 and Player:ComboPoints() >= 5 or A.SliceAndDice:IsReady(unitID, true) and Unit(player):HasBuffs(A.Broadside.ID) >= 1 and Player:ComboPoints() >= 4 and Unit(player):HasBuffs(A.SliceAndDice.ID) <= 9 then
                    return A.SliceAndDice:Show(icon)
                end
                if A.BetweenTheEyes:IsReady(unitID, true) and Player:ComboPoints() >= 5 or A.BetweenTheEyes:IsReady(unitID, true) and Unit(player):HasBuffs(A.Broadside.ID) >= 1 and Player:ComboPoints() >= 4 then
                    return A.BetweenTheEyes:Show(icon)
                end
                if A.Dispatch:IsReady(unitID, true) and Player:ComboPoints() >= 5 or A.Dispatch:IsReady(unitID, true) and Unit(player):HasBuffs(A.Broadside.ID) >= 1 and Player:ComboPoints() >= 4 then
                    return A.Dispatch:Show(icon)
                end
            else
                if A.SliceAndDice:IsReady(unitID, true) and Unit(player):HasBuffs(A.SliceAndDice.ID) <= 7 and Player:ComboPoints() >= 4 or A.SliceAndDice:IsReady(unitID, true) and Unit(player):HasBuffs(A.Broadside.ID) >= 1 and Player:ComboPoints() >= 3 and Unit(player):HasBuffs(A.SliceAndDice.ID) <= 9 then
                    return A.SliceAndDice:Show(icon)
                end
                if A.BetweenTheEyes:IsReady(unitID, true) and Player:ComboPoints() >= 4 or A.BetweenTheEyes:IsReady(unitID, true) and Unit(player):HasBuffs(A.Broadside.ID) >= 1 and Player:ComboPoints() >= 3 then
                    return A.BetweenTheEyes:Show(icon)
                end
                if A.Dispatch:IsReady(unitID, true) and Player:ComboPoints() >= 4 or A.Dispatch:IsReady(unitID, true) and Unit(player):HasBuffs(A.Broadside.ID) >= 1 and Player:ComboPoints() >= 3 then
                    return A.Dispatch:Show(icon)
                end
            end
        end
        
        -- [[ CDs ]]
        local function CDs()  
            if isStealthed == 0 then
                local Item = UseItems(unitID)
                if Item and Unit(unitID):GetRange() <= 8 then
                    return Item:Show(icon)
                end
                if A.Fireblood:IsReady(unitID, true) then
                    return A.Fireblood:Show(icon)
                end
                if A.Berserking:IsReady(unitID, true) then
                    return A.Berserking:Show(icon)
                end
                if A.BloodFury:IsReady(unitID, true) then
                    return A.BloodFury:Show(icon)
                end
                if A.LightsJudgment:IsReady(unitID, true) then
                    return A.LightsJudgment:Show(icon)
                end
                -- if A.Flagellation:IsReady(unitID, true) and Unit(unitID):GetRange() <= 8 and Unit(unitID):HasDeBuffs(A.Flagellation.ID) == 0 or Unit(unitID):HasDeBuffs(A.Flagellation.ID) > 0 and Unit(unitID):HasDeBuffs(A.Flagellation.ID) <= 2 and Unit(unitID):HealthPercent() >= 40 and Unit(unitID):Health() >= 50000 or Unit(unitID):HealthPercent() >= 20 and Unit(unitID):IsBoss() then
                --      return A.Flagellation:Show(icon)
                -- end
                if A.AdrenalineRush:IsReady(unitID, true) and Unit(player):HasBuffs(A.AdrenalineRush.ID) == 0 and Unit(unitID):HealthPercent() >= 80 and MultiUnits:GetByRangeInCombat(8) >= 4 and not Unit(unitID):IsBoss() or A.AdrenalineRush:IsReady(unitID, true) and Unit(unitID):HealthPercent() >= 40 and Unit(unitID):IsBoss() and Unit(unitID):GetRange() <= 8 then
                    return A.AdrenalineRush:Show(icon)
                end
                if A.GhostlyStrike:IsReady(unitID, true) then
                    return A.GhostlyStrike:Show(icon)
                end
                if A.KillingSpree:IsReady(unitID, true) then
                    return A.KillingSpree:Show(icon)
                end
                if A.BladeRush:IsReady(unitID, true) and Unit(unitID):GetRange() <= 8 then
                    return A.BladeRush:Show(icon)
                end
            end
            if A.BladeFlurry:IsReady(unitID, true) and MultiUnits:GetByRange(8) >= 2 and Unit(unitID):GetRange() <= 8 then
                return A.BladeFlurry:Show(icon)
            end
            if A.MarkedForDeath:IsReady(unitID, true) then
                return A.MarkedForDeath:Show(icon)
            end
        end
    
        -- [[ Single Target ]]
        local function ST()
            if A.CrimsonVial:IsReady(unitID, true) and Unit(player):HealthPercent() <= GetToggle(2, "CrimsonVial") then
                return A.CrimsonVial:Show(icon)
            end
            isStealthed = Unit(player):HasBuffs(A.Stealth.ID)
            if Unit(unitID):GetRange() <= 12 then
                local refreshTimer = 2
                if CheckBuffCountRB() <= 1 then
                    if A.RollTheBones:IsReady(unitID, true) and Unit(unitID):GetRange() <= 8 then
                        if CheckBuffCountRB() == 0 or Unit(player):HasBuffs(A.BuriedTreasure.ID) ~= 0 or Unit(player):HasBuffs(A.GrandMelee.ID) ~= 0 or Unit(player):HasBuffs(A.TrueBearing.ID) ~= 0 or Unit(player):HasBuffs(A.Broadside.ID) > 0 and Unit(player):HasBuffs(A.Broadside.ID) <= refreshTimer or Unit(player):HasBuffs(A.RuthlessPrecision.ID) > 0 and Unit(player):HasBuffs(A.RuthlessPrecision.ID) <= refreshTimer or Unit(player):HasBuffs(A.SkullandCrossbones.ID) > 0 and Unit(player):HasBuffs(A.SkullandCrossbones.ID) <= refreshTimer then
                            return A.RollTheBones:Show(icon)
                        end
                    end
                elseif CheckBuffCountRB() >= 2 then
                    if Unit(player):HasBuffs(A.Broadside.ID) > 0 and Unit(player):HasBuffs(A.Broadside.ID) <= refreshTimer or Unit(player):HasBuffs(A.BuriedTreasure.ID) > 0 and Unit(player):HasBuffs(A.BuriedTreasure.ID) <= refreshTimer or Unit(player):HasBuffs(A.GrandMelee.ID) > 0 and Unit(player):HasBuffs(A.GrandMelee.ID) <= refreshTimer or Unit(player):HasBuffs(A.RuthlessPrecision.ID) > 0 and Unit(player):HasBuffs(A.RuthlessPrecision.ID) <= refreshTimer or Unit(player):HasBuffs(A.TrueBearing.ID) > 0 and Unit(player):HasBuffs(A.TrueBearing.ID) <= refreshTimer or Unit(player):HasBuffs(A.SkullandCrossbones.ID) > 0 and Unit(player):HasBuffs(A.SkullandCrossbones.ID) <= refreshTimer then
                        if A.RollTheBones:IsReady(unitID, true) and Unit(unitID):GetRange() <= 8 then
                            return A.RollTheBones:Show(icon)
                        end
                    end
                end
            end
            if isStealthed ~= 0 then
                if A.Ambush:IsReady(unitID, true) and inMelee then
                    return A.Ambush:Show(icon)
                end
                if A.CheapShot:IsReady(unitID, true) and not Unit(unitID):IsBoss() and inMelee then
                    return A.CheapShot:Show(icon)
                end
            else
                if A.BladeFlurry:IsReady(unitID, true) and MultiUnits:GetByRange(8) >= 2 and Unit(unitID):GetRange() <= 8 then
                    return A.BladeFlurry:Show(icon)
                end
                if A.PistolShot:IsReady(unitID, true) and Unit(player):HasBuffs(A.Opportunity.ID) ~= 0 and Unit(unitID):GetRange() <= 20 then
                    return A.PistolShot:Show(icon)
                end
                if Unit(player):HasBuffs(A.SepsisBuff.ID) ~= 0 then
                    if A.Ambush:IsReady(unitID, true) then
                        return A.Ambush:Show(icon)
                    end
                end
                if A.SinisterStrike:IsReady(unitID, true) and inMelee then
                    return A.SinisterStrike:Show(icon)
                end
                if A.Sepsis:IsReady(unitID, true) and inMelee then
                    return A.Sepsis:Show(icon)
                end
                if A.KillingSpree:IsReady(unitID, true) and Player:EnergyTimeToMax() >= 2.5 and Unit(player):HasBuffs(A.BladeFlurry.ID) == 0 then
                    return A.KillingSpree:Show(icon)
                end
                if A.BladeRush:IsReady(unitID, true) and Unit(unitID):GetRange() <= 8 and Unit(player):HasBuffs(A.BladeFlurry.ID) == 0 then
                    return A.BladeRush:Show(icon)
                end
                if A.SerratedBoneSpike:IsReady(unitID, true) and inMelee and A.SerratedBoneSpike:GetSpellChargesFrac() >= 2.95 then
                    return A.SerratedBoneSpike:Show(icon)
                end
                if A.EchoingReprimand:IsReady(unitID, true) and inMelee then
                    return A.EchoingReprimand:Show(icon)
                end
                if A.PistolShot:IsReady(unitID, true) and isStealthed == 0 and Player:Energy() >= 90 and Unit(unitID):GetRange() > 8 then
                    return A.PistolShot:Show(icon)
                end
                if A.Shiv:IsReady(unitID) and Unit(player):HasBuffs(A.NumbingPoison.ID) ~= 0 and Action.AuraIsValid(unitID, "UseExpelEnrage", "Enrage") then
                    return A.Shiv:Show(icon)
                end
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


    if A.Stealth:IsReady(unitID, true) and Unit(player):HasBuffs(A.Stealth.ID) == 0 and inCombat == 0 and not IsMounted() then
        return A.Stealth:Show(icon)
    end
    if A.InstantPoison:IsReady(unitID, true) and Unit(player):HasBuffs(A.InstantPoison.ID) == 0 and inCombat == 0 then
        return A.InstantPoison:Show(icon)
    end
    if A.NumbingPoison:IsReady(unitID, true) and Unit(player):HasBuffs(A.NumbingPoison.ID) == 0 and inCombat == 0 then
        return A.NumbingPoison:Show(icon)
    end
    -- if A.CripplingPoison:IsReady(unitID, true) and Unit(player):HasBuffs(A.CripplingPoison.ID) == 0 and inCombat == 0 then
    --     return A.CripplingPoison:Show(icon)
    -- end
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

