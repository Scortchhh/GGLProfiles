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

local ACTION_CONST_DEMONHUNTER_VENGEANCE             = CONST.DEMONHUNTER_VENGEANCE
local ACTION_CONST_AUTOTARGET                = CONST.AUTOTARGET
local ACTION_CONST_SPELLID_FREEZING_TRAP    = CONST.SPELLID_FREEZING_TRAP

local IsIndoors, UnitIsUnit                    = _G.IsIndoors, _G.UnitIsUnit

Action[ACTION_CONST_DEMONHUNTER_VENGEANCE] = {
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
    Metamorphosis                                = Create({ Type = "Spell", ID = 191427                                               }),
    --kick
    Disrupt                                = Create({ Type = "Spell", ID = 183752                                               }),
    --taunt
    Torment                                = Create({ Type = "Spell", ID = 185245                                               }),
    --Passives
    InnerDemons                                = Create({ Type = "Spell", ID = 337548                                               }),
    Momentum                                = Create({ Type = "Spell", ID = 206476                                               }),
    Frailty                                = Create({ Type = "Spell", ID = 224509                                               }),
    -- Rotation       
    FelDevastation                                = Create({ Type = "Spell", ID = 212084                                               }),
    SpiritBomb                                = Create({ Type = "Spell", ID = 247454                                               }),
    Fracture                                = Create({ Type = "Spell", ID = 263642                                               }),
    Shear                                = Create({ Type = "Spell", ID = 203782                                               }),
    SoulCleave                                = Create({ Type = "Spell", ID = 228477                                               }),
    SigilofFlame                                = Create({ Type = "Spell", ID = 204596                                               }),
    InfernalStrike                                = Create({ Type = "Spell", ID = 189110                                               }),
    FieryBrand                                = Create({ Type = "Spell", ID = 204021                                               }),
    DemonSpikes                                = Create({ Type = "Spell", ID = 203720                                               }),
    Annihilation                                = Create({ Type = "Spell", ID = 201427                                               }),
    ThrowGlaive                                = Create({ Type = "Spell", ID = 185123                                               }),
    ImmolationAura                                = Create({ Type = "Spell", ID = 258920                                               }),
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

Action:CreateEssencesFor(ACTION_CONST_DEMONHUNTER_VENGEANCE)
local A = setmetatable(Action[ACTION_CONST_DEMONHUNTER_VENGEANCE], { __index = Action })

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
    for key, val in pairs(Action[ACTION_CONST_DEMONHUNTER_VENGEANCE]) do 
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
            if not notKickAble and A.Disrupt:IsReady(unitID, nil, nil, true) and A.Disrupt:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then
                return A.Disrupt:Show(icon)                                                  
            end                   
        end 
    end                                                                                 
end

local function countInterruptGCD(unitID)
    if not A.Disrupt:IsReadyByPassCastGCD(unitID) or not A.Disrupt:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then 
        return true 
    end 
end 

local function Interrupts(unitID)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime = InterruptIsValid(unitID,  nil, nil, countInterruptGCD(unitID))    

    -- Can waste interrupt action due delays caused by ping, interface input 
    if castRemainsTime < GetLatency() then 
        return 
    end 
    
    if not notInterruptable and A.Disrupt:IsReady(unitID) then 
        return A.Disrupt
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
    local stealthed = false

    -- Rotations 
    function EnemyRotation(unitID)    
        if not IsUnitEnemy(unitID) then return end
        if Unit(unitID):IsDead() then return end
        if UnitCanAttack(player, unitID) == false then return end
        local disrupt = Interrupts(unitID)
        if disrupt then
            return A.Disrupt:Show(icon)
        end
        local isBurst            = BurstIsON(unitID)
        
        -- inMelee                 = A.LavaLash:IsInRange(unitID)    
        
        -- Purge
        if A.ArcaneTorrent:AutoRacial(unitID) then 
            return A.ArcaneTorrent:Show(icon)
        end             
        
        -- [[ finishers ]]
        local function Finishers()
            


        end

        local function Mitigation() 
            if A.DemonSpikes:IsReady(unitID, true) and A.DemonSpikes:GetSpellCharges() >= 2 then
                return A.DemonSpikes:Show(icon)
            end
            if A.SoulCleave:IsReady(unitID, true) and Unit(player):HealthPercent() <= 50 or A.SoulCleave:IsReady(unitID, true) and Player:Rage() <= 80 or  A.SoulCleave:IsReady(unitID, true) and Player:SoulShards() <= 3 then
                return A.SoulCleave:Show(icon)
            end
            if A.FieryBrand:IsReady(unitID, true) then
                return A.FieryBrand:Show(icon)
            end
        end
        
        -- [[ CDs ]]
        local function CDs()  
            local Item = UseItems(unitID)
            if Item then
                return Item:Show(icon)
            end
        end

        -- [[ Single Target ]]
        local function ST()
            if A.Torment:IsReady(unitID, true) and Unit(unitID):GetRange() > 5 and Unit(unitID):GetRange() <= 30 then
                return A.Torment:Show(icon)  
            end
            if A.InfernalStrike:IsReady(unitID, true) and Unit(unitID):GetRange() > 5 and Unit(unitID):GetRange() <= 30 then
                return A.InfernalStrike:Show(icon)
            end
            if A.InfernalStrike:IsReady(unitID, true) and A.InfernalStrike:GetSpellCharges() >= 2 then
                return A.InfernalStrike:Show(icon)
            end
            if A.FelDevastation:IsReady(unitID, true) and Unit(unitID):GetRange() <= 20 then
                return A.FelDevastation:Show(icon)
            end
            if A.SpiritBomb:IsReady(unitID, true) and Player:SoulShards() >= 4 then
                return A.SpiritBomb:Show(icon)
            end
            if A.Fracture:IsReady(unitID, true) and Player:Rage() <= 80 and Player:SoulShards() <= 3 then
                return A.Fracture:Show(icon)
            end
            if A.Shear:IsReady(unitID, true) and Player:Rage() <= 80 and Player:SoulShards() <= 3 then
                return A.Shear:Show(icon)
            end
            if A.ImmolationAura:IsReady(unitID, true) and Player:Rage() <= 80 and Player:SoulShards() <= 3 then
                return A.ImmolationAura:Show(icon)
            end
            if A.SoulCleave:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.Frailty.ID) ~= 0 or A.SoulCleave:IsReady(unitID, true) and Player:Rage() >= 80 then
                return A.SoulCleave:Show(icon)
            end
            if A.SigilofFlame:IsReady(unitID, true) then
                return A.SigilofFlame:Show(icon)
            end
            if A.Shear:IsReady(unitID, true) and Player:Rage() <= 80 and Player:SoulShards() <= 3 then
                return A.Shear:Show(icon)
            end
            if A.ThrowGlaive:IsReady(unitID, true) then
                return A.ThrowGlaive:Show(icon)
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

        if Mitigation() then
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

