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
local lastSpell = Action.PrevSpell

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

local ACTION_CONST_DRUID_FERAL             = CONST.DRUID_FERAL
local ACTION_CONST_AUTOTARGET                = CONST.AUTOTARGET
local ACTION_CONST_SPELLID_FREEZING_TRAP    = CONST.SPELLID_FREEZING_TRAP

local IsIndoors, UnitIsUnit                    = _G.IsIndoors, _G.UnitIsUnit

Action[ACTION_CONST_DRUID_FERAL] = {
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
    Regrowth                                = Create({ Type = "Spell", ID = 8936                                               }),
    -- CDS
    TigerFury                                = Create({ Type = "Spell", ID = 5217                                               }),
    Berserk                                = Create({ Type = "Spell", ID = 106951                                               }),
    FeralFrenzy                                = Create({ Type = "Spell", ID = 274837                                               }),
    --kick
    SkullBash                                = Create({ Type = "Spell", ID = 106839                                               }),
    --Passives
    Clearcasting                                = Create({ Type = "Spell", ID = 16870                                               }),
    Bloodtalons                                = Create({ Type = "Spell", ID = 319439                                               }),
    --stealth
    Prowl                                = Create({ Type = "Spell", ID = 102547                                               }),
    CatForm                                = Create({ Type = "Spell", ID = 768                                               }), 
    TravelForm                                = Create({ Type = "Spell", ID = 783                                               }), 
    -- Rotation       
    Rip                                = Create({ Type = "Spell", ID = 1079                                               }),
    Rake                                = Create({ Type = "Spell", ID = 1822                                               }),
    FerociousBite                                = Create({ Type = "Spell", ID = 22568                                               }),
    Shred                                = Create({ Type = "Spell", ID = 5221                                               }),
    Thrash                                = Create({ Type = "Spell", ID = 106830                                               }),
    BrutalSlash                                = Create({ Type = "Spell", ID = 202028                                               }),
    Swipe                                = Create({ Type = "Spell", ID = 213764                                               }),
    PrimalWrath                                = Create({ Type = "Spell", ID = 285381                                               }),
    SavageRoar                                = Create({ Type = "Spell", ID = 52610                                               }),
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

Action:CreateEssencesFor(ACTION_CONST_DRUID_FERAL)
local A = setmetatable(Action[ACTION_CONST_DRUID_FERAL], { __index = Action })

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
    for key, val in pairs(Action[ACTION_CONST_DRUID_FERAL]) do 
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
            if not notKickAble and A.SkullBash:IsReady(unitID, nil, nil, true) and A.SkullBash:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then
                return A.SkullBash:Show(icon)                                                  
            end                   
        end 
    end                                                                                 
end

local function countInterruptGCD(unitID)
    if not A.SkullBash:IsReadyByPassCastGCD(unitID) or not A.SkullBash:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then 
        return true 
    end 
end 

local function Interrupts(unitID)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime = InterruptIsValid(unitID,  nil, nil, countInterruptGCD(unitID))    
    
    -- Can waste interrupt action due delays caused by ping, interface input 
    if castRemainsTime < GetLatency() then 
        return 
    end 
    
    if useKick and not notInterruptable and A.SkullBash:IsReady(unitID) then 
        return A.SkullBash
    end         
end

local function Purge(unitID)
    local usePurge = AuraIsValid(unitID, "UsePurge", "PurgeHigh")    
    if usePurge and A.Purge:IsReady(unitID) then 
        return A.Purge
    end         
end

local function Cleanse(unitID)
    -- https://questionablyepic.com/bfa-dungeon-debuffs/
    return Unit(unitID):HasBuffs({
            228318, -- Raging (Raging Affix)
            255824, -- Fanatic's Rage (Dazar'ai Juggernaut)
            257476, -- Bestial Wrath (Irontide Mastiff)
            269976, -- Ancestral Fury (Shadow-Borne Champion)
            262092, -- Inhale Vapors (Addled Thug)
            272888, -- Ferocity (Ashvane Destroyer)
            259975, -- Enrage (The Sand Queen)
            265081, -- Warcry (Chosen Blood Matron)
            266209, -- Wicked Frenzy (Fallen Deathspeaker)
    }, true)>2
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
local lastAB = "Thrash"
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
        if A.Prowl:IsReady(unitID, true) and Unit(player):HasBuffs(A.Prowl.ID) == 0  and Unit(player):HasBuffs(A.TravelForm.ID) == 0 and not IsMounted() then
            return A.Prowl:Show(icon)
        end
        local skullBash = Interrupts(unitID)
        if skullBash then
            return A.SkullBash:Show(icon)
        end
        local isBurst            = BurstIsON(unitID)
        if Unit(player):HasBuffs(A.Prowl.ID) ~= 0 then
            stealthed = true
        end
        
        inMelee                 = A.Rake:IsInRange(unitID)    
        
        -- Purge
        if A.ArcaneTorrent:AutoRacial(unitID) then 
            return A.ArcaneTorrent:Show(icon)
        end             
        
        -- [[ finishers ]]
        local function Finishers()
            if A.SavageRoar:IsReady(unitID, true) and Unit(player):HasBuffs(A.SavageRoar.ID) <= 10 then
                return A.SavageRoar:Show(icon)
            end
        end
        
        -- [[ CDs ]]
        local function CDs()  
            local Item = UseItems(unitID)
            if Item and Unit(player):HasBuffs(A.Prowl.ID) == 0 then
                return Item:Show(icon)
            end
            if A.Bloodtalons:IsTalentLearned() then
                if Unit(player):HasBuffs(A.Bloodtalons.ID) ~= 0 and not stealthed then
                    if A.TigerFury:IsReady(unitID, true) and Player:Energy() <= 40 then
                        return A.TigerFury:Show(icon)
                    end
                    if A.Berserk:IsReady(unitID, true) and Unit(player):HasBuffs(A.TigerFury.ID) ~= 0 then
                        return A.Berserk:Show(icon)
                    end
                end
            else
                if A.TigerFury:IsReady(unitID, true) and Player:Energy() <= 40 and not stealthed then
                    return A.TigerFury:Show(icon)
                end
                if A.Berserk:IsReady(unitID, true) and Unit(player):HasBuffs(A.TigerFury.ID) ~= 0 and not stealthed then
                    return A.Berserk:Show(icon)
                end
            end
            if A.FeralFrenzy:IsReady(unitID, true) and Player:ComboPoints() == 0 and Player:Energy() > 50 and not stealthed then
                return A.FeralFrenzy:Show(icon)
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
                        if (arg3 == A.Shred.ID) then
                            lastAB =  "Shred"
                        elseif (arg3 == A.Rake.ID) then
                            lastAB = "Rake"
                        elseif (arg3 == A.Thrash.ID) then
                            lastAB = "Thrash"
                        end
                    end
                end
            );
        end

        -- [[ Single Target ]]
        local function ST()
            if stealthed then
                if A.Rake:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.Rake.ID) <= 4 and inMelee then
                    return A.Rake:Show(icon)
                end
            else
                if A.Regrowth:IsReady(unitID, true) and Unit(player):HealthPercent() <= 75 and A.Regrowth:GetSpellPowerCost() == 0 then
                    return A.Regrowth:Show(icon)
                end
                getLastUsedSpell()
                if A.Bloodtalons:IsTalentLearned() then
                    if A.PrimalWrath:IsReady(unitID, true) and Player:ComboPoints() >= 5 and MultiUnits:GetByRangeInCombat(8) >= 2 and inMelee then
                        return A.PrimalWrath:Show(icon)
                    end
                    if A.Rip:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.Rip.ID) <= 5 and inMelee and Player:ComboPoints() >= 3 then
                        return A.Rip:Show(icon)
                    end
                    if Player:ComboPoints() >= 5 then
                        if A.FerociousBite:IsReady(unitID, true) then
                            return A.FerociousBite:Show(icon)
                        end
                    end
                    if Unit(player):HasBuffs(A.Bloodtalons.ID) ~= 0 then
                        if Player:ComboPoints() >= 5 then
                            if A.FerociousBite:IsReady(unitID, true) then
                                return A.FerociousBite:Show(icon)
                            end
                        else
                            if A.Rake:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.Rake.ID) <= 4 then
                                return A.Rake:Show(icon)
                            end
                            if A.Shred:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.Thrash.ID) > 6 then
                                return A.Shred:Show(icon)
                            end
                            if A.Thrash:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.Thrash.ID) <= 6 then
                                return A.Thrash:Show(icon)
                            end
                        end
                    end
                    if Unit(player):HasBuffs(A.Bloodtalons.ID) == 0 and Unit(player):HasBuffs(A.Clearcasting.ID) ~= 0 then
                        if A.Shred:IsReady(unitID, true) then
                            return A.Shred:Show(icon)
                        end
                    end
                    if Unit(player):HasBuffs(A.Bloodtalons.ID) == 0 and Unit(player):HasBuffs(A.Clearcasting.ID) == 0 and A.TigerFury:IsReady(unitID, true) then
                        if A.Shred:IsReady(unitID, true) and not lastAB == "Shred" then
                            return A.Shred:Show(icon)
                        end
                        if A.TigerFury:IsReady(unitID, true) then
                            return A.TigerFury:Show(icon)
                        end
                    end
                    if Unit(player):HasBuffs(A.TigerFury.ID) ~= 0 then
                        if A.Rake:IsReady(unitID, true) and lastAB == "Thrash" then
                            return A.Rake:Show(icon)
                        end
                        if A.Shred:IsReady(unitID, true) and lastAB == "Rake" then
                            return A.Shred:Show(icon)
                        end
                        if A.Thrash:IsReady(unitID, true) and lastAB == "Shred" and Unit(unitID):HasDeBuffs(A.Thrash.ID) <= 6 then
                            return A.Thrash:Show(icon)
                        end
                    end
                    if A.Rake:IsReady(unitID, true) and lastAB == "Thrash" or A.Rake:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.Rake.ID) <= 4 then
                        return A.Rake:Show(icon)
                    end
                    if A.BrutalSlash:IsTalentLearned() then
                        if A.BrutalSlash:IsReady(unitID, true) then
                            if Unit(unitID):GetRange() <= 8 and MultiUnits:GetByRangeInCombat(8) >= 2 then
                                return A.BrutalSlash:Show(icon)
                            end
                        else
                            if A.Shred:IsReady(unitID, true) and lastAB == "Rake" or A.Shred:IsReady(unitID, true) and lastAB == "Shred" and Unit(unitID):HasDeBuffs(A.Thrash.ID) >= 8 then
                                return A.Shred:Show(icon)
                            end
                        end
                    else
                        if A.Shred:IsReady(unitID, true) and lastAB == "Rake" or A.Shred:IsReady(unitID, true) and lastAB == "Shred" and Unit(unitID):HasDeBuffs(A.Thrash.ID) >= 8 then
                            return A.Shred:Show(icon)
                        end
                    end
                    if A.Thrash:IsReady(unitID, true) and lastAB == "Shred" and Unit(unitID):HasDeBuffs(A.Thrash.ID) <= 6 then
                        return A.Thrash:Show(icon)
                    end
                else
                    if A.Rip:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.Rip.ID) <= 4 and inMelee then
                        return A.Rip:Show(icon)
                    end
                    if A.Rake:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.Rake.ID) <= 4 and inMelee then
                        return A.Rake:Show(icon)
                    end
                    if A.PrimalWrath:IsReady(unitID, true) and Player:ComboPoints() >= 5 and MultiUnits:GetByRangeInCombat(8) >= 2 and inMelee then
                        return A.PrimalWrath:Show(icon)
                    end
                    if A.FerociousBite:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.Rip.ID) ~= 0 and Player:ComboPoints() >= 5 and inMelee then
                        return A.FerociousBite:Show(icon)
                    end
                    if MultiUnits:GetByRange(8) >= 3 then
                        if A.Thrash:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.Thrash.ID) <= 4 and Unit(unitID):GetRange() <= 8 then
                            return A.Thrash:Show(icon)
                        end
                        if A.BrutalSlash:IsReady(unitID, true) and Unit(unitID):GetRange() <= 8 then
                            return A.BrutalSlash:Show(icon)
                        end
                        if A.Swipe:IsReady(unitID, true) and Unit(unitID):GetRange() <= 8 then
                            return A.Swipe:Show(icon)
                        end
                    else
                        if A.Shred:IsReady(unitID, true) and inMelee then
                            return A.Shred:Show(icon)
                        end
                    end
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

    if A.CatForm:IsReady(unitID, true) and Unit(player):HasBuffs(A.CatForm.ID) == 0 and Unit(player):HasBuffs(A.TravelForm.ID) == 0 and not IsMounted() then
        return A.CatForm:Show(icon)
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

