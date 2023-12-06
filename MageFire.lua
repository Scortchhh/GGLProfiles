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

local ACTION_CONST_MAGE_FIRE             = CONST.MAGE_FIRE
local ACTION_CONST_AUTOTARGET                = CONST.AUTOTARGET
local ACTION_CONST_SPELLID_FREEZING_TRAP    = CONST.SPELLID_FREEZING_TRAP

local IsIndoors, UnitIsUnit                    = _G.IsIndoors, _G.UnitIsUnit

Action[ACTION_CONST_MAGE_FIRE] = {
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
    BlazingBarrier                                = Create({ Type = "Spell", ID = 235313                                               }),
    -- Healing
    HealingSurge                                = Create({ Type = "Spell", ID = 8004                                               }),
    -- CDS
    Combustion                                = Create({ Type = "Spell", ID = 190319                                               }),
    RuneofPower                                = Create({ Type = "Spell", ID = 116011                                               }),
    --kick
    Counterspell                                = Create({ Type = "Spell", ID = 2139                                               }),
    --Passives
    ArcaneIntellect                                = Create({ Type = "Spell", ID = 1459                                               }),
    FingersofFrost                                = Create({ Type = "Spell", ID = 112965                                               }),
    HotStreak                                = Create({ Type = "Spell", ID = 48108                                               }),
    HeatingUp                                = Create({ Type = "Spell", ID = 48107                                               }),
    FlamePatch                                = Create({ Type = "Spell", ID = 205037                                               }),
    Firestarter                                = Create({ Type = "Spell", ID = 205026                                               }),
    Firestorm                                = Create({ Type = "Spell", ID = 333100                                               }),
    -- Rotation       
    FireBlast                                = Create({ Type = "Spell", ID = 108853                                               }),
    FireBall                                = Create({ Type = "Spell", ID = 133                                               }),
    Scorch                                = Create({ Type = "Spell", ID = 2948                                               }),
    Meteor                                = Create({ Type = "Spell", ID = 153561                                               }),
    PyroBlast                                = Create({ Type = "Spell", ID = 11366                                               }),
    DragonsBreath                                = Create({ Type = "Spell", ID = 31661                                               }),
    PhoenixFlames                                = Create({ Type = "Spell", ID = 257541                                               }),
    FlameStrike                                = Create({ Type = "Spell", ID = 2120                                               }),
    LivingBomb                                = Create({ Type = "Spell", ID = 44457                                               }),
    SearingTouch                                = Create({ Type = "Spell", ID = 269644                                               }),
    PyroClasm                                = Create({ Type = "Spell", ID = 269650                                               }),
    AlexstraszasFury                                = Create({ Type = "Spell", ID = 235870                                               }),
    ArcaneExplosion                                = Create({ Type = "Spell", ID = 1449                                               }),
    MirrorImage                                = Create({ Type = "Spell", ID = 55342                                               }),
    ShiftingPower                                = Create({ Type = "Spell", ID = 314791                                               }),
    --covenant
    SunKingsBlessing                                = Create({ Type = "Spell", ID = 333313                                               }),
    --conduit
    InfernalCascade                                = Create({ Type = "Spell", ID = 336821                                               }),
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

Action:CreateEssencesFor(ACTION_CONST_MAGE_FIRE)
local A = setmetatable(Action[ACTION_CONST_MAGE_FIRE], { __index = Action })

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
    for key, val in pairs(Action[ACTION_CONST_MAGE_FIRE]) do 
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

local isOpener = true
local isFirstCombustionCasted = false
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

        local function IsOpenerFinished()
            if Unit(player):HasBuffs(A.Combustion.ID) == 0 then
                isOpener = false
            end
        end

        local function getLastUsedSpell()
            local myFrame = CreateFrame("Frame");
            local myCurrentCast;
            myFrame:RegisterEvent("UNIT_SPELLCAST_SENT");
            myFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
            myFrame:SetScript("OnEvent",
                function(self, event, arg1, arg2, arg3, arg4)
                    if (event == "UNIT_SPELLCAST_SENT" and arg1 == "player") then
                        myCurrentCast = arg3;
                    elseif (event == "UNIT_SPELLCAST_SUCCEEDED" and arg2 == myCurrentCast) then
                        if (arg3 == A.DragonsBreath.ID) then
                            return "DragonsBreath"
                        elseif (arg3 == A.Scorch.ID) then
                            return "Scorch"
                        elseif (arg3 == A.PyroBlast.ID) then
                            return "PyroBlast"
                        end
                    end
                end
            );
        end
        
        -- [[ CDs ]]
        local function CDs()  
            local Item = UseItems(unitID)
            if Item then
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
            if A.MirrorImage:IsReady(unitID, true) and Unit("player"):HasBuffs(A.HotStreak.ID) ~= 0 then
                return A.MirrorImage:Show(icon)
            end
            if A.RuneofPower:IsReady(unitID, true) and Unit("player"):HasBuffs(A.Combustion.ID) > 0 and Unit("player"):HasBuffs(A.Combustion.ID) <= 3 then
                return A.RuneofPower:Show(icon)
            end
            if A.Combustion:IsReady(unitID, true) and Unit("player"):HasBuffs(A.HotStreak.ID) ~= 0 and Unit("player"):HasBuffs(A.MirrorImage.ID) ~= 0 then
                return A.Combustion:Show(icon)
            end
        end
        
        -- [[ Single Target ]]
        local function ST()
            if inAoE then
                if A.FlameStrike:IsReady(unitID, true) and MultiUnits:GetByRangeInCombat(40) >= 3 and Unit(player):HasBuffs(A.HotStreak.ID) ~= 0 then
                    return A.FlameStrike:Show(icon)
                end
            end
            if Unit("player"):HasBuffs(A.Combustion.ID) ~= 0 then
                if A.Meteor:IsReady(unitID, true) then
                    return A.Meteor:Show(icon)
                end
                if inAoE then
                    if A.FlameStrike:IsReady(unitID, true) and Unit("player"):HasBuffs(A.HotStreak.ID) ~= 0 then
                        return A.FlameStrike:Show(icon)
                    end
                end
                if A.PyroBlast:IsReady(unitID, true) and Unit("player"):HasBuffs(A.PyroClasm.ID) ~= 0 then
                    return A.PyroBlast:Show(icon)
                end
                if A.PyroBlast:IsReady(unitID, true) and Unit("player"):HasBuffs(A.HotStreak.ID) ~= 0 then
                    return A.PyroBlast:Show(icon)
                end
                if A.FireBlast:IsReady(unitID, true) and Unit("player"):HasBuffs(A.HeatingUp.ID) ~= 0 then
                    return A.FireBlast:Show(icon)
                end
                if A.PhoenixFlames:IsReady(unitID, true) and Unit("player"):HasBuffs(A.HeatingUp.ID) ~= 0 and Unit("player"):HasBuffs(A.HotStreak.ID) == 0 then
                    return A.PhoenixFlames:Show(icon)
                end
                if A.Scorch:IsReady(unitID, true) then
                    return A.Scorch:Show(icon)
                end
            end
            if A.PyroBlast:IsReady(unitID, true) and Unit(player):HasBuffs(A.HotStreak.ID) ~= 0 then
                return A.PyroBlast:Show(icon)
            end
            if Unit("player"):HasBuffs(A.Combustion.ID) == 0 then
                if A.Meteor:IsReady(unitID, true) and A.Combustion:GetCooldown() > 30 then
                    return A.Meteor:Show(icon)
                end
                if A.ShiftingPower:IsReady(unitID, true) and A.FireBlast:GetCooldown() == 0 and A.PhoenixFlames:GetCooldown() == 0 then
                    return A.ShiftingPower:Show(icon)
                end
                if A.DragonsBreath:IsReady(unitID, true) and MultiUnits:GetByRangeInCombat(8) >= 1 and Unit(player):HasBuffs(A.HeatingUp.ID) ~= 0 then
                    return A.DragonsBreath:Show(icon)
                end
                if A.PyroBlast:IsReady(unitID, true) and Unit(player):HasBuffs(A.HotStreak.ID) ~= 0 then
                    return A.PyroBlast:Show(icon)
                end
                if A.FireBlast:GetCooldown() == 0 and Unit(player):HasBuffs(A.HeatingUp.ID) ~= 0 and Player:CastRemains(A.FireBall.ID) <= 1.2 and Player:CastRemains(A.FireBall.ID) > 0 then
                    return A.FireBlast:Show(icon)
                end
                if A.Scorch:IsReady(unitID, true) and Unit(unitID):HealthPercent() <= 30 and Unit(player):HasBuffs(A.HotStreak.ID) == 0 then
                    return A.Scorch:Show(icon)
                end
                if A.FireBall:IsReady(unitID, true) and Unit(player):HasBuffs(A.HotStreak.ID) == 0 and not isMoving then
                    return A.FireBall:Show(icon)
                end
                if A.Scorch:IsReady(unitID, true) and isMoving and Unit(player):HasBuffs(A.HotStreak.ID) == 0 then
                    return A.Scorch:Show(icon)
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

    if A.BlazingBarrier:IsReady(unitID, true) and inCombat > 0 and Unit("player"):HasBuffs(A.Combustion.ID) == 0 then
        return A.BlazingBarrier:Show(icon)
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

