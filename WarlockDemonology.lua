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

local ACTION_CONST_WARLOCK_DEMONOLOGY             = CONST.WARLOCK_DEMONOLOGY
local ACTION_CONST_AUTOTARGET                = CONST.AUTOTARGET
local ACTION_CONST_SPELLID_FREEZING_TRAP    = CONST.SPELLID_FREEZING_TRAP

local IsIndoors, UnitIsUnit                    = _G.IsIndoors, _G.UnitIsUnit

Action[ACTION_CONST_WARLOCK_DEMONOLOGY] = {
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
    CallDreadStalkers                                = Create({ Type = "Spell", ID = 104316                                               }),
    PowerSiphon                                = Create({ Type = "Spell", ID = 264130                                               }),
    VileFiend                                = Create({ Type = "Spell", ID = 264119                                               }),
    SummonDemonicTyrant                                = Create({ Type = "Spell", ID = 265187                                               }),
    NetherPortal                                = Create({ Type = "Spell", ID = 267217                                               }),
    Felguard                                = Create({ Type = "Spell", ID = 111898                                               }),
    --kick
    WindShear                                = Create({ Type = "Spell", ID = 57994                                               }),
    Purge                                = Create({ Type = "Spell", ID = 370                                               }),
    CleanseSpirit                                = Create({ Type = "Spell", ID = 51886                                               }),
    SpiritWalk                                = Create({ Type = "Spell", ID = 58875                                               }),
    --Passives
    DemonicCore                                = Create({ Type = "Spell", ID = 267102                                               }),
    HailStorm                                = Create({ Type = "Spell", ID = 334195                                               }),
    -- Rotation       
    HandofGuldan                                = Create({ Type = "Spell", ID = 105174                                               }),
    DemonBolt                                = Create({ Type = "Spell", ID = 264178                                               }),
    ShadowBolt                                = Create({ Type = "Spell", ID = 686                                               }),
    Implosion                                = Create({ Type = "Spell", ID = 196277                                               }),
    DrainLife                                = Create({ Type = "Spell", ID = 234153                                               }),
    MortalCoil                                = Create({ Type = "Spell", ID = 6789                                               }),
    Doom                                = Create({ Type = "Spell", ID = 603                                               }),
    DemonicStrength                                = Create({ Type = "Spell", ID = 267171                                               }),
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

Action:CreateEssencesFor(ACTION_CONST_WARLOCK_DEMONOLOGY)
local A = setmetatable(Action[ACTION_CONST_WARLOCK_DEMONOLOGY], { __index = Action })

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
    for key, val in pairs(Action[ACTION_CONST_WARLOCK_DEMONOLOGY]) do 
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
    
    -- if unitID then         
    --     local castLeft, _, _, _, notKickAble = Unit(unitID):IsCastingRemains()
    --     if castLeft > 0 then             
    --         if not notKickAble and A.WindShear:IsReady(unitID, nil, nil, true) and A.WindShear:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then
    --             return A.WindShear:Show(icon)                                                  
    --         end                   
    --     end 
    -- end                                                                                 
end

local function countInterruptGCD(unitID)
    if not A.WindShear:IsReadyByPassCastGCD(unitID) or not A.WindShear:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then 
        return true 
    end 
end 

local function Interrupts(unitID)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime = InterruptIsValid(unitID,  nil, nil, countInterruptGCD(unitID))    
    
    -- Can waste interrupt action due delays caused by ping, interface input 
    if castRemainsTime < GetLatency() then 
        return 
    end 
    
    if useKick and not notInterruptable and A.WindShear:IsReady(unitID) then 
        return A.WindShear
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
        local isBurst            = BurstIsON(unitID)
        
        -- inMelee                 = A.LavaLash:IsInRange(unitID)    
        
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
            if Item then
                return Item:Show(icon)
            end
            if A.NetherPortal:IsReady(unitID, true) and Player:SoulShards() >= 1 then
                return A.NetherPortal:Show(icon)
            end
            if A.Felguard:IsReady(unitID, true) and Player:SoulShards() >= 1 then
                return A.Felguard:Show(icon)
            end
            -- need to check for demonic pets active
            -- if A.SummonDemonicTyrant:IsReady(unitID, true) then
            --     return A.SummonDemonicTyrant:Show(icon)
            -- end
        end

        -- [[ Single Target ]]
        local function ST()
            if A.DrainLife:IsReady(unitID, true) and Unit(player):HealthPercent() <= GetToggle(2, "DrainLife") then
                return A.DrainLife:Show(icon)
            end
            if A.MortalCoil:IsReady(unitID, true) and Unit(player):HealthPercent() <= GetToggle(2, "MortalCoil") then
                return A.MortalCoil:Show(icon)
            end
            if A.CallDreadStalkers:IsReady(unitID, true) and inCombat > 0 then
                return A.CallDreadStalkers:Show(icon)
            end
            -- needs different check
            if A.Implosion:GetSpellCharges() >= 3 and A.Implosion:IsReady(unitID, true) then
                return A.Implosion:Show(icon)
            end
            if A.HandofGuldan:IsReady(unitID, true) and Player:SoulShards() >= 4 then
                return A.HandofGuldan:Show(icon)
            end
            if A.DemonBolt:IsReady(unitID, true) and Unit(player):HasBuffsStacks(A.DemonicCore.ID, true) >= 2 then
                return A.DemonBolt:Show(icon)
            end
            if A.PowerSiphon:IsTalentLearned() and A.PowerSiphon:IsReady(unitID, true) then
                return A.PowerSiphon:Show(icon)
            end
            if A.HandofGuldan:IsReady(unitID, true) and Player:SoulShards() >= 3 then
                return A.HandofGuldan:Show(icon)
            end
            if A.VileFiend:IsReady(unitID, true) and inCombat > 0 then
                return A.VileFiend:Show(icon)
            end
            if A.Doom:IsReady(unitID, true) then
                return A.Doom:Show(icon)
            end
            if A.DemonicStrength:IsReady(unitID, true) then
                return A.DemonicStrength:Show(icon)
            end
            if A.ShadowBolt:IsReady(unitID, true) then
                return A.ShadowBolt:Show(icon)
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

