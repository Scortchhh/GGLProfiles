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

local DisarmIsReady                            = Action.DisarmIsReady

local Azerite                                 = LibStub("AzeriteTraits")

local ACTION_CONST_MAGE_FROST             = CONST.MAGE_FROST
local ACTION_CONST_AUTOTARGET                = CONST.AUTOTARGET
local ACTION_CONST_SPELLID_FREEZING_TRAP    = CONST.SPELLID_FREEZING_TRAP

local IsIndoors, UnitIsUnit                    = _G.IsIndoors, _G.UnitIsUnit

Action[ACTION_CONST_MAGE_FROST] = {
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
    IcyVeins                                = Create({ Type = "Spell", ID = 12472                                               }),
    RuneofPower                                = Create({ Type = "Spell", ID = 116011                                               }),
    --Weapon Buffs
    FlametongueWeapon                                = Create({ Type = "Spell", ID = 318038                                               }),
    WindfuryWeapon                                = Create({ Type = "Spell", ID = 33757                                               }),
    --totems
    HealingTotem                                = Create({ Type = "Spell", ID = 5394                                               }),
    StunTotem                                = Create({ Type = "Spell", ID = 192058                                               }),
    SlowTotem                                = Create({ Type = "Spell", ID = 2484                                               }),
    WindFuryTotem                                = Create({ Type = "Spell", ID = 8512                                               }),
    --kick
    Counterspell                                = Create({ Type = "Spell", ID = 2139                                               }),
    --Passives
    ArcaneIntellect                                = Create({ Type = "Spell", ID = 1459                                               }),
    FingersofFrost                                = Create({ Type = "Spell", ID = 112965                                               }),
    BrainFreeze                                = Create({ Type = "Spell", ID = 190447                                               }),
    WintersChill                                = Create({ Type = "Spell", ID = 228358                                               }),
    FreezingRain                                = Create({ Type = "Spell", ID = 270233                                               }),
    -- Rotation       
    FireBlast                                = Create({ Type = "Spell", ID = 108853                                               }),
    FrostBolt                                = Create({ Type = "Spell", ID = 116                                               }),
    IceLance                                = Create({ Type = "Spell", ID = 30455                                               }),
    Blizzard                                = Create({ Type = "Spell", ID = 190356                                               }),
    Flurry                                = Create({ Type = "Spell", ID = 44614                                               }),
    FrozenOrb                                = Create({ Type = "Spell", ID = 84714                                               }),
    ArcaneExplosion                                = Create({ Type = "Spell", ID = 1449                                               }),
    RayofFrost                                = Create({ Type = "Spell", ID = 205021                                               }),
    GlacialSpike                                = Create({ Type = "Spell", ID = 199786                                               }),
    CometStorm                                = Create({ Type = "Spell", ID = 153595                                               }),
    IceNova                                = Create({ Type = "Spell", ID = 157997                                               }),
    Ebonbolt                                = Create({ Type = "Spell", ID = 257537                                               }),
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
    -- LegendaryPowers
    CadenceofFujieda                        = Create({ Type = "Spell", ID = 335555, Hidden = true                                                             }),
    Deathmaker                                = Create({ Type = "Spell", ID = 335567, Hidden = true                                                             }),
    Leaper                                    = Create({ Type = "Spell", ID = 335214, Hidden = true                                                             }),
    MisshapenMirror                            = Create({ Type = "Spell", ID = 335253, Hidden = true                                                             }),
    RecklessDefense                            = Create({ Type = "Spell", ID = 335582, Hidden = true                                                             }),
    SeismicReverberation                    = Create({ Type = "Spell", ID = 335758, Hidden = true                                                             }),
    SignetofTormentedKings                    = Create({ Type = "Spell", ID = 335266, Hidden = true                                                             }),
    WilloftheBerserker                        = Create({ Type = "Spell", ID = 335594, Hidden = true                                                             }),
    -- Hidden
    SiegebreakerDebuff                        = Create({ Type = "Spell", ID = 280773, Hidden = true                                                             }), -- Simcraft
    EnrageBuff                                = Create({ Type = "Spell", ID = 184362, Hidden = true                                                             }), -- Simcraft
    MeatCleaverBuff                            = Create({ Type = "Spell", ID = 85739, Hidden = true                                                             }), -- Simcraft
    RecklessAbandon                            = Create({ Type = "Spell", ID = 202751, Hidden = true, isTalent = true                                            }), -- Talent
    Seethe                                    = Create({ Type = "Spell", ID = 335091, Hidden = true, isTalent = true                                            }), -- Talent
    Cruelty                                    = Create({ Type = "Spell", ID = 335070, Hidden = true, isTalent = true                                            }), -- Talent
}

Action:CreateEssencesFor(ACTION_CONST_MAGE_FROST)
local A = setmetatable(Action[ACTION_CONST_MAGE_FROST], { __index = Action })

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
    for key, val in pairs(Action[ACTION_CONST_MAGE_FROST]) do 
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
            if not notKickAble and A.Counterspell:IsReady(unitID, nil, nil, true) and A.Counterspell:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then
                return A.Counterspell:Show(icon)                                                  
            end                   
        end 
    end                                                                                 
end

local function countInterruptGCD(unitID)
    if not A.Counterspell:IsReadyByPassCastGCD(unitID) or not A.Counterspell:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then 
        return true 
    end 
end 

local function Interrupts(unitID)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime = InterruptIsValid(unitID,  nil, nil, countInterruptGCD(unitID))    
    
    -- Can waste interrupt action due delays caused by ping, interface input 
    if castRemainsTime < GetLatency() then 
        return 
    end 
    
    if useKick and not notInterruptable and A.Counterspell:IsReady(unitID) then 
        return A.Counterspell
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
        local counterspell = Interrupts(unitID)
        if counterspell then
            return A.Counterspell:Show(icon)
        end
        -- Variables        
        local isBurst            = BurstIsON(unitID)
        
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
            if A.IcyVeins:IsReady(unitID, true) then
                return A.IcyVeins:Show(icon)
            end
        end
        
        -- [[ Single Target ]]
        local function ST()
            if MultiUnits:GetByRangeInCombat(30) >= 2 then
                if A.IcyVeins:IsReady(unitID, true) then
                    return A.IcyVeins:Show(icon)
                end
                if A.FrozenOrb:IsReady(unitID, true) then
                    return A.FrozenOrb:Show(icon)
                end
                if A.Blizzard:IsReady(unitID, true) then
                    return A.Blizzard:Show(icon)
                end
                if A.Flurry:IsReady(unitID, true) and Unit(player):HasBuffs(A.BrainFreeze.ID) ~= 0 and Unit(unitID):HasDeBuffs(A.WintersChill.ID) == 0 then
                    return A.Flurry:Show(icon)
                end
                if A.IceNova:IsReady(unitID, true) then
                    return A.IceNova:Show(icon)
                end
                if A.CometStorm:IsReady(unitID, true) then
                    return A.CometStorm:Show(icon)
                end
                if A.IceLance:IsReady(unitID, true) and Unit(player):HasBuffs(A.FingersofFrost.ID) ~= 0 or A.IceLance:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.WintersChill.ID) ~= 0 then
                    return A.IceLance:Show(icon)
                end
                if A.ArcaneExplosion:IsReady(unitID, true) and Player:ManaPercent() >= 30 then
                    return A.ArcaneExplosion:Show(icon)
                end
                if A.Ebonbolt:IsReady(unitID, true) then
                    return A.Ebonbolt:Show(icon)
                end
                if A.FrostBolt:IsReady(unitID, true) then
                    return A.FrostBolt:Show(icon)
                end
            else
                if A.RuneofPower:IsReady(unitID, true) and A.IcyVeins:GetCooldown() >= 15 then
                    return A.RuneofPower:Show(icon)
                end
                if A.IcyVeins:IsReady(unitID, true) then
                    return A.IcyVeins:Show(icon)
                end
                if A.Flurry:IsReady(unitID, true) and Unit(player):HasBuffs(A.BrainFreeze.ID) ~= 0 and Unit(unitID):HasDeBuffs(A.WintersChill.ID) == 0 then
                    return A.Flurry:Show(icon)
                end
                if A.FrozenOrb:IsReady(unitID, true) then
                    return A.FrozenOrb:Show(icon)
                end
                if A.Blizzard:IsReady(unitID, true) and Unit(player):HasBuffs(A.FreezingRain.ID) ~= 0 then
                    return A.Blizzard:Show(icon)
                end
                if A.RayofFrost:IsReady(unitID, true) and Unit(unitID):HasDebuffsStacks(A.WintersChill.ID) == 1 then
                    return A.RayofFrost:Show(icon)
                end
                if A.GlacialSpike:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.WintersChill.ID) ~= 0 or A.GlacialSpike:IsReady(unitID, true) and MultiUnits:GetByRangeInCombat(30) >= 2 then
                    return A.GlacialSpike:Show(icon)
                end
                if A.IceLance:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.WintersChill.ID) ~= 0 then
                    return A.IceLance:Show(icon)
                end
                if A.CometStorm:IsReady(unitID, true) then
                    return A.CometStorm:Show(icon)
                end
                if A.IceNova:IsReady(unitID, true) then
                    return A.IceNova:Show(icon)
                end
                if A.IceLance:IsReady(unitID, true) and Unit(player):HasBuffs(A.FingersofFrost.ID) ~= 0 then
                    return A.IceLance:Show(icon)
                end
                if A.EbonBolt:IsReady(unitID, true) then
                    return A.EbonBolt:Show(icon)
                end
                if A.FrostBolt:IsReady(unitID, true) then
                    return A.FrostBolt:Show(icon)
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

    if A.ArcaneIntellect:IsReady(unitID, true) and (Unit(player):HasBuffs(A.ArcaneIntellect.ID) == 0) then
        return A.ArcaneIntellect:Show(icon)
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

