local _G, setmetatable, pairs, ipairs, select, math        = _G, setmetatable, pairs, ipairs, select, math 
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
local PetLibrary                    = LibStub("PetLibrary")

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

local ACTION_CONST_HUNTER_MARKSMANSHIP                        = CONST.HUNTER_MARKSMANSHIP
local ACTION_CONST_AUTOTARGET                = CONST.AUTOTARGET
local ACTION_CONST_SPELLID_FREEZING_TRAP    = CONST.SPELLID_FREEZING_TRAP

local IsIndoors, UnitIsUnit                    = _G.IsIndoors, _G.UnitIsUnit

Action[ACTION_CONST_HUNTER_MARKSMANSHIP] = {
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
    Exhilaration                                = Create({ Type = "Spell", ID = 109304                                               }),
    -- CDS
    double_tap                                = Create({ Type = "Spell", ID = 260402                                               }),
    trueshot                                = Create({ Type = "Spell", ID = 288613                                               }),
    --buffs
    trick_shots                                = Create({ Type = "Spell", ID = 257621                                               }),
    steady_focus                                = Create({ Type = "Spell", ID = 193533                                               }),
    --traps
    freezing_trap                                = Create({ Type = "Spell", ID = 187650                                               }),
    --kick
    counter_shot                                = Create({ Type = "Spell", ID = 147362                                               }),
    --Passives
    AspectsofTheWild                                = Create({ Type = "Spell", ID = 193530                                               }),
    precise_shots                                = Create({ Type = "Spell", ID = 260242                                               }),
    CallPet                                = Create({ Type = "Spell", ID = 67777                                               }),
    streamline                                = Create({ Type = "Spell", ID = 260367                                               }),
    -- pet spells
    Growl                                = Create({ Type = "Spell", ID = 2649                                               }),
    MendPet                                = Create({ Type = "Spell", ID = 136                                               }),
    --traps
    tar_trap                                = Create({ Type = "Spell", ID = 187698                                               }),
    --covenant stuff
    wild_spirits                                = Create({ Type = "Spell", ID = 328231                                               }),
    flayed_shot                                = Create({ Type = "Spell", ID = 324149                                               }),
    death_chakram                                = Create({ Type = "Spell", ID = 325028                                               }),
    resonating_arrow                                = Create({ Type = "Spell", ID = 308491                                               }),
    -- Rotation       
    serpent_sting                                = Create({ Type = "Spell", ID = 259491, DeBuffTime = 18                                               }),
    arcane_shot                                = Create({ Type = "Spell", ID = 185358                                               }),
    aimed_shot                                = Create({ Type = "Spell", ID = 19434                                               }),
    rapid_fire                                = Create({ Type = "Spell", ID = 257044                                               }),
    steady_shot                                = Create({ Type = "Spell", ID = 56641                                               }),
    volley                                = Create({ Type = "Spell", ID = 260243                                               }),
    explosive_shot                                = Create({ Type = "Spell", ID = 212431                                               }),
    kill_shot                                = Create({ Type = "Spell", ID = 53351                                               }),
    BloodShed                                = Create({ Type = "Spell", ID = 321530                                               }),
    BarbedShot                                = Create({ Type = "Spell", ID = 217200                                               }),
    Stampede                                = Create({ Type = "Spell", ID = 201430                                               }),
    a_murder_of_crows                                = Create({ Type = "Spell", ID = 131894                                               }),
    BestialWrath                                = Create({ Type = "Spell", ID = 19574                                               }),
    KillCommand                                = Create({ Type = "Spell", ID = 34026                                               }),
    chimaera_shot                                = Create({ Type = "Spell", ID = 53209                                               }),
    DireBeast                                = Create({ Type = "Spell", ID = 120679                                               }),
    barrage                                = Create({ Type = "Spell", ID = 120360                                               }),
    CobraShot                                = Create({ Type = "Spell", ID = 193455                                               }),
    multi_shot                                = Create({ Type = "Spell", ID = 2643                                               }),
    concussive_shot                                = Create({ Type = "Spell", ID = 5116                                               }),
    flare                                = Create({ Type = "Spell", ID = 1543                                               }),
    bursting_shot                                = Create({ Type = "Spell", ID = 186387                                               }),
    tranquilizing_shot                                = Create({ Type = "Spell", ID = 55625                                               }),
    --pvp
    scatter_shot                                = Create({ Type = "Spell", ID = 213691                                               }),
    binding_shot                                = Create({ Type = "Spell", ID = 109248                                               }),
    lock_and_load                                = Create({ Type = "Spell", ID = 194595                                               }),
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

Action:CreateEssencesFor(ACTION_CONST_HUNTER_MARKSMANSHIP)
local A = setmetatable(Action[ACTION_CONST_HUNTER_MARKSMANSHIP], { __index = Action })

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
    for key, val in pairs(Action[ACTION_CONST_HUNTER_MARKSMANSHIP]) do 
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
            if not notKickAble and A.counter_shot:IsReady(unitID, nil, nil, true) and A.counter_shot:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then
                return A.counter_shot:Show(icon)                                                  
            end                   
        end 
    end                                                                                 
end

local function countInterruptGCD(unitID)
    if not A.counter_shot:IsReadyByPassCastGCD(unitID) or not A.counter_shot:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then 
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
         -- WindShear
         if useKick and A.counter_shot:IsReady(unitID) then 
             --print("WindShear")
             return A.counter_shot:Show(icon)
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

local function DetectEnrage(unitID)
    if (AuraIsValid(unitID, "UseExpelEnrage", "Enrage")) then
        return true
    end
    return false
end

local function GetCovenantAbility(unitID, icon)
    local ability,covenant = Player:GetCovenant()
    if A.wild_spirits:IsReady(unitID, true) and covenant == "NightFae" then
        return A.wild_spirits:Show(icon)
    end
    if A.resonating_arrow:IsReady(unitID, true) and covenant == "Kyrian" then
        return A.resonating_arrow:Show(icon)
    end
    if A.flayed_shot:IsReady(unitID, true) and covenant == "Venthyr" then
        return A.flayed_shot:Show(icon)
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
    local isPvpMode = Action.IsInPvP 

    -- Rotations 
    function EnemyRotation(unitID)    
        if not IsUnitEnemy(unitID) then return end
        if Unit(unitID):IsDead() then return end
        if UnitCanAttack(player, unitID) == false then return end
        local Interrupt = Interrupts(unitID, icon)
        if Interrupt then 
            return Interrupt
        end
        local enrage = DetectEnrage(unitID)
        if enrage then
            return A.tranquilizing_shot:Show(icon)
        end
        local unitSpeed 					= Unit(unitID):GetCurrentSpeed()
        if isPvpMode then
            if not Unit(unitID):IsPlayer() then
                Action.ToggleMode()
            end
            local function ST() 
                local EnemyHealerUnitID = EnemyTeam("HEALER"):GetUnitID(44)
                if A.scatter_shot:IsReady(unitID, true) then
                    if EnemyHealerUnitID == "arena1" then
                       return Action.Re:SetFocus("arena1")
                    elseif EnemyHealerUnitID == "arena2" then
                        return Action.Re:SetFocus("arena2")
                    elseif EnemyHealerUnitID == "arena3" then
                        return Action.Re:SetFocus("arena3")
                    end
                    if EnemyHealerUnitID ~= "none" and A.scatter_shot:IsReady(EnemyHealerUnitID, true, nil, nil) then
                        return A.scatter_shot:Show(icon)     
                    end 
                    if unitSpeed == 0 ~= "none" then
                        if A.freezing_trap:IsReady(EnemyHealerUnitID, true, nil, nil) then
                            return A.freezing_trap:Show(icon)
                        end
                    end
                end
                if EnemyHealerUnitID ~= "none" then
                    if A.binding_shot:IsReady(EnemyHealerUnitID, true, nil, nil) then
                        return A.binding_shot:Show(icon)
                    end
                    if unitSpeed < 100 and A.freezing_trap:IsReady(EnemyHealerUnitID, true, nil, nil) then
                        return A.freezing_trap:Show(icon)
                    end
                    if not A.scatter_shot:IsReady(unitID, true) and A.freezing_trap:IsReady(EnemyHealerUnitID, true, nil, nil) then
                        return A.freezing_trap:Show(icon)
                    end
                end
                -- if A.flare:IsReady(unitID, true) then
                --     return A.Flare:Show(icon)
                -- end
                if A.kill_shot:IsReady(unitID, true) then
                    return A.kill_shot:Show(icon)
                end
                if A.bursting_shot:IsReady(unitID, true) and Unit(unitID):GetRange() <= 8 then
                    return A.bursting_shot:Show(icon)
                end
                local isBurst            = BurstIsON(unitID)
                if isBurst then
                    local covSpell = GetCovenantAbility(unitID, icon)
                    if covSpell then
                        return covSpell
                    end
                    if A.trueshot:IsReady(unitID, true) then
                        return A.trueshot:Show(icon)
                    end
                    if Unit("player"):HasBuffs(A.trueshot.ID) ~= 0 and A.aimed_shot:IsReady(unitID, true) and not isMoving then
                        return A.aimed_shot:Show(icon)
                    end
                    if A.explosive_shot:IsReady(unitID, true) then
                        return A.explosive_shot:Show(icon)
                    end
                    if A.lock_and_load:IsTalentLearned() then
                        if Unit("player"):HasBuffs(A.lock_and_load.ID) ~= 0 and A.rapid_fire:IsReady(unitID, true) then
                            return A.rapid_fire:Show(icon)
                        end
                        if Unit("player"):HasBuffs(A.lock_and_load.ID) ~= 0 then
                            if Player:CastRemains(A.rapid_fire.ID) <= 0.25 and Player:CastRemains(A.rapid_fire.ID) > 0 then
                                if A.double_tap:GetCooldown() == 0 then
                                    return A.double_tap:Show(icon)
                                end
                            end
                        end
                        if Unit("player"):HasBuffs(A.lock_and_load.ID) ~= 0 and Unit("player"):HasBuffs(A.double_tap.ID) ~= 0 and A.aimed_shot:IsReady(unitID, true) then
                            return A.aimed_shot:Show(icon)
                        end
                    else
                        if A.double_tap:IsReady(unitID, true) then
                            return A.double_tap:Show(icon)
                        end
                        if Unit("player"):HasBuffs(A.double_tap.ID) ~= 0 and A.rapid_fire:IsReady(unitID, true) then
                            return A.rapid_fire:Show(icon)
                        end
                    end
                    if A.arcane_shot:IsReady(unitID, true) and Unit("player"):HasBuffs(A.precise_shots.ID) ~= 0 then
                        return A.arcane_shot:Show(icon)
                    end
                    if A.aimed_shot:IsReady(unitID, true) and not isMoving then
                        return A.aimed_shot:Show(icon)
                    end
                    if A.arcane_shot:IsReady(unitID, true) and Player:Focus() >= 70 then
                        return A.arcane_shot:Show(icon)
                    end
                    if A.steady_shot:IsReady(unitID, true) and Player:Focus() <= 60 then
                        return A.steady_shot:Show(icon)
                    end
                end
                if unitSpeed >= 100 and A.concussive_shot:IsReady(unitID, true) then
                    return A.concussive_shot:Show(icon)
                end
                if not isBurst then
                    if A.aimed_shot:IsReady(unitID, true) and Unit("player"):HasBuffsStacks(A.precise_shots.ID) < 2 and not isMoving then
                        return A.aimed_shot:Show(icon)
                    end
                    if A.arcane_shot:IsReady(unitID, true) and Unit("player"):HasBuffs(A.precise_shots.ID) ~= 0 then
                        return A.arcane_shot:Show(icon)
                    end
                    if A.rapid_fire:IsReady(unitID, true) then
                        return A.rapid_fire:Show(icon)
                    end
                    if A.aimed_shot:IsReady(unitID, true) and not isMoving then
                        return A.aimed_shot:Show(icon)
                    end
                    if A.steady_shot:IsReady(unitID, true) and Player:Focus() <= 60 then
                        return A.steady_shot:Show(icon)
                    end
                end
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

        if not isPvpMode then
            if Unit(unitID):IsPlayer() then
                Action.ToggleMode()
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
                            if (arg3 == A.SteadyShot.ID) then
                                return "SteadyShot"
                            elseif(arg3 == A.AimedShot.ID) then
                                return "AimedShot"
                            end
                        end
                    end
                );
                return nil
            end
            
            -- [[ CDs ]]
            local function CDs()
                local Item = UseItems(unitID)
                if Item then
                    return Item:Show(icon)
                end
                if A.double_tap:IsReady(unitID, true) then
                    return A.double_tap:Show(icon)
                end
                if A.AncestralCall:IsReady(unitID, true) then
                    return A.AncestralCall:Show(icon)
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
                if A.trueshot:IsReady(unitID, true) then
                    return A.trueshot:Show(icon)
                end
            end
            
            -- [[ Single Target ]]
            local function ST()
                if Unit(player):HasBuffs(A.trueshot.ID) ~= 0 then
                    if A.multi_shot:IsReady(unitID, true) and Unit(player):HasBuffs(A.trick_shots.ID) == 0 and MultiUnits:GetByRangeInCombat(44) >= 3 and Unit(player):HasBuffs(A.steady_focus.ID) > 5 then
                        return A.multi_shot:Show(icon)
                    end
                    if A.rapid_fire:IsReady(unitID, true) and Unit(unitID):GetRange() <= 44 then
                        return A.rapid_fire:Show(icon)
                    end
                    if A.aimed_shot:IsReady(unitID, true) and Unit(unitID):GetRange() <= 44 then
                        return A.aimed_shot:Show(icon)
                    end
                end
                if MultiUnits:GetActiveEnemies(44) >= 3 then
                    if A.multi_shot:IsReady(unitID, true) and Unit(player):HasBuffs(A.trick_shots.ID) == 0 and Unit(player):HasBuffs(A.trueshot.ID) == 0 and Unit(player):HasBuffs(A.steady_focus.ID) > 5 then
                        return A.multi_shot:Show(icon)
                    end
                    if Unit(player):HasBuffs(A.trueshot.ID) ~= 0 then
                        if A.rapid_fire:IsReady(unitID, true) and Unit(unitID):GetRange() <= 44 then
                            return A.rapid_fire:Show(icon)
                        end
                        if A.aimed_shot:IsReady(unitID, true) and Unit(unitID):GetRange() <= 44 then
                            return A.aimed_shot:Show(icon)
                        end
                    end
                end
                if A.steady_shot:IsReady(unitID, true) and Player:Focus() <= 60 and A.steady_focus:IsTalentLearned() and (Player:PrevGCD(1, A.steady_shot) and Unit(player):HasBuffs(A.steady_focus.ID) <5 or A.steady_shot:IsReady(unitID, true) and Unit(player):HasBuffs(A.steady_focus.ID) == 0) and Player:Focus() <= 60 then 
                    return A.steady_shot:Show(icon)
                end
                if A.kill_shot:IsReady(unitID, true) then
                    return A.kill_shot:Show(icon)
                end
                if A.double_tap:IsReady(unitID, true) and A.resonating_arrow:GetCooldown() < GetGCD() or A.double_tap:IsReady(unitID, true) and (A.aimed_shot:GetCooldown() ~= 0  or A.double_tap:IsReady(unitID, true) and A.rapid_fire:GetCooldown() >A.aimed_shot:GetCooldown() ) then 
                    return A.double_tap:Show(icon)
                end
                -- if A.flare:IsReady(unitID, true) and A.tar_trap:IsReady(unitID, true) then 
                --     return A.flare:Show(icon)
                -- end
                -- if A.tar_trap:IsReady(unitID, true) and A.tar_trap:GetCooldown() < GetGCD() and A.flare:GetCooldown() < GetGCD() then 
                --     return A.tar_trap:Show(icon)
                -- end
                if A.explosive_shot:IsReady(unitID, true) then
                    return A.explosive_shot:Show(icon)
                end
                local covSpell = GetCovenantAbility(unitID, icon)
                if covSpell then
                    return covSpell
                end
                if A.flayed_shot:IsReady(unitID, true) then
                    return A.flayed_shot:Show(icon)
                end
                if A.death_chakram:IsReady(unitID, true) and Player:Focus() + Player:FocusCastRegen(1) <Player:FocusMax() then 
                    return A.death_chakram:Show(icon)
                end
                if A.volley:IsReady(unitID, true) and Unit(player):HasBuffs(A.precise_shots.ID) == 0 or A.volley:IsReady(unitID, true) and not A.chimaera_shot:IsTalentLearned() or A.volley:IsReady(unitID, true) and MultiUnits:GetByRangeInCombat(44) <2 then 
                    return A.volley:Show(icon)
                end
                if A.a_murder_of_crows:IsReady(unitID, true) then
                    return A.a_murder_of_crows:Show(icon)
                end
                if A.resonating_arrow:IsReady(unitID, true) then
                    return A.resonating_arrow:Show(icon)
                end
                if A.trueshot:IsReady(unitID, true) and Unit(player):HasBuffs(A.precise_shots.ID) == 0 or A.trueshot:IsReady(unitID, true) and Unit(player):HasBuffs(A.resonating_arrow.ID) ~= 0 or A.trueshot:IsReady(unitID, true) and Unit(player):HasBuffs(A.wild_spirits.ID) ~= 0 or A.trueshot:IsReady(unitID, true) and Unit(player):HasBuffs(A.volley.ID) ~= 0 and MultiUnits:GetByRangeInCombat(44) >1 then 
                    return A.trueshot:Show(icon)
                end
                if A.aimed_shot:IsReady(unitID, true) and MultiUnits:GetByRangeInCombat(44) == 1 and Unit(player):HasBuffs(A.precise_shots.ID) == 0 or A.aimed_shot:IsReady(unitID, true) and (Unit(player):HasBuffs(A.trueshot.ID) ~= 0 or A.aimed_shot:IsReady(unitID, true) and A.aimed_shot:GetSpellChargesFullRechargeTime()< GetGCD()+A.aimed_shot:GetSpellCastTime()) and (not A.chimaera_shot:IsTalentLearned() or A.aimed_shot:IsReady(unitID, true) and MultiUnits:GetByRangeInCombat(44) <2) or A.aimed_shot:IsReady(unitID, true) and Unit(player):HasBuffs(A.trick_shots.ID) >A.aimed_shot:GetSpellCastTime() and MultiUnits:GetByRangeInCombat(44) >1 then 
                    return A.aimed_shot:Show(icon)
                end
                if A.rapid_fire:IsReady(unitID, true) and Player:Focus() + Player:FocusCastRegen(1) <Player:FocusMax() and (Unit(player):HasBuffs(A.trueshot.ID) == 0 and (Unit(player):HasBuffs(A.double_tap.ID) == 0 or A.rapid_fire:IsReady(unitID, true) and A.streamline:IsTalentLearned())) then 
                    return A.rapid_fire:Show(icon)
                end
                if A.chimaera_shot:IsReady(unitID, true) and Unit(player):HasBuffs(A.precise_shots.ID) ~= 0 or A.chimaera_shot:IsReady(unitID, true) and Player:Focus() >A.chimaera_shot:GetSpellPowerCost()+A.aimed_shot:GetSpellPowerCost() then 
                    return A.chimaera_shot:Show(icon)
                end
                if A.arcane_shot:IsReady(unitID, true) and Unit(player):HasBuffs(A.precise_shots.ID) ~= 0 or A.arcane_shot:IsReady(unitID, true) and Player:Focus() >A.arcane_shot:GetSpellPowerCost()+A.aimed_shot:GetSpellPowerCost() then 
                    return A.arcane_shot:Show(icon)
                end
                if A.serpent_sting:IsReady(unitID, true) and MultiUnits:GetByRangeInCombat(44) == 1 and Unit(unitID):HasDeBuffs(A.serpent_sting.ID) <= 4 and Unit(unitID):TimeToDie() > A.serpent_sting.DeBuffTime then 
                    return A.serpent_sting:Show(icon)
                end
                if A.barrage:IsReady(unitID, true) and MultiUnits:GetByRangeInCombat(44) >1 then 
                    return A.barrage:Show(icon)
                end
                if A.rapid_fire:IsReady(unitID, true) and Player:Focus() + Player:FocusCastRegen(1) <Player:FocusMax() and (Unit(player):HasBuffs(A.double_tap.ID) == 0 or A.rapid_fire:IsReady(unitID, true) and A.streamline:IsTalentLearned()) then 
                    return A.rapid_fire:Show(icon)
                end
                if A.steady_shot:IsReady(unitID, true) then
                    return A.steady_shot:Show(icon)
                end
                
                -- if A.KillShot:IsReady(unitID, true) and Unit(unitID):GetRange() <= 44 then
                --     return A.KillShot:Show(icon)
                -- end
                -- if A.Exhilaration:IsReady(unitID, true) and Unit(player):HealthPercent() <= GetToggle(2, "Exhilaration") then
                --     return A.Exhilaration:Show(icon)
                -- end
                -- if Unit(player):HasBuffs(A.PreciseShots.ID) ~= 0 then
                --     if MultiUnits:GetByRangeInCombat(44) <= 1 then
                --         if A.ArcaneShot:IsReady(unitID, true) and Unit(unitID):GetRange() <= 44 then
                --             return A.ArcaneShot:Show(icon)
                --         end
                --     else
                --         if A.MultiShot:IsReady(unitID, true) and Unit(unitID):GetRange() <= 44 then
                --             return A.MultiShot:Show(icon)
                --         end
                --     end
                -- end
                -- if Unit(player):HasBuffs(A.TrueShot.ID) ~= 0 then
                --     if A.RapidFire:IsReady(unitID, true) and Unit(unitID):GetRange() <= 44 then
                --         return A.RapidFire:Show(icon)
                --     end
                --     if A.AimedShot:IsReady(unitID, true) and Unit(unitID):GetRange() <= 44 then
                --         return A.AimedShot:Show(icon)
                --     end
                -- end
                -- if MultiUnits:GetByRangeInCombat(44) >= 3 then
                --     if Unit(player):HasBuffs(A.TrickShots.ID) == 0 then
                --         if A.MultiShot:IsReady(unitID, true) and Unit(unitID):GetRange() <= 44 then
                --             return A.MultiShot:Show(icon)
                --         end
                --     end
                --     if Unit(player):HasBuffs(A.TrickShots.ID) ~= 0 then
                --         if A.RapidFire:IsReady(unitID, true) and Unit(unitID):GetRange() <= 44 then
                --             return A.RapidFire:Show(icon)
                --         end
                --         if A.AimedShot:IsReady(unitID, true) and Unit(unitID):GetRange() <= 44 then
                --             return A.AimedShot:Show(icon)
                --         end
                --     end
                -- else
                --     if A.SteadyFocus:IsTalentLearned() then
                --         if A.SteadyShot:IsReady(unitID, true) and Unit(player):HasBuffs(A.SteadyFocus.ID) <= 5 and Unit(unitID):GetRange() <= 44 then
                --             return A.SteadyShot:Show(icon)
                --         end
                --     end
                --     if A.DoubleTap:IsReady(unitID, true) and A.AimedShot:IsReady(unitID, true) and not A.RapidFire:IsReady(unitID, true) then
                --         return A.DoubleTap:Show(icon)
                --     end
                --     -- if A.TarTrap:IsReady(unitID, true) then
                --     --     return A.TarTrap:Show(icon)
                --     -- end
                --     -- if A.Flare:IsReady(unitID, true) and not A.TarTrap:IsReady(unitID, true) then
                --     --     return A.Flare:Show(icon)
                --     -- end
                --     if A.ExplosiveShot:IsReady(unitID, true) and Unit(unitID):GetRange() <= 44 then
                --         return A.ExplosiveShot:Show(icon)
                --     end
                --     if A.WildSpirits:IsReady(unitID, true) and Unit(unitID):GetRange() <= 44 then
                --         return A.WildSpirits:Show(icon)
                --     end
                --     if A.FlayedShot:IsReady(unitID, true) and Unit(unitID):GetRange() <= 44 then
                --         return A.FlayedShot:Show(icon)
                --     end
                --     if A.DeathChakram:IsReady(unitID, true) and Player:Focus() <= 80 and Unit(unitID):GetRange() <= 44 then
                --         return A.DeathChakram:Show(icon)
                --     end
                --     if A.Volley:IsReady(unitID, true) and Unit(player):HasBuffs(A.PreciseShots.ID) == 0 and not A.ChimaeraShot:IsTalentLearned() and Unit(unitID):GetRange() <= 44 then
                --         return A.Volley:Show(icon)
                --     end
                --     if A.MurderofCrows:IsReady(unitID, true) and Unit(unitID):GetRange() <= 44 then
                --         return A.MurderofCrows:Show(icon)
                --     end
                --     if A.ResonatingArrow:IsReady(unitID, true) and Unit(unitID):GetRange() <= 44 then
                --         return A.ResonatingArrow:Show(icon)
                --     end
                --     if A.TrueShot:IsReady(unitID, true) and Unit(player):HasBuffs(A.PreciseShots.ID) == 0 or A.TrueShot:IsReady(unitID, true) and Unit(player):HasBuffs(A.ResonatingArrow.ID) ~= 0 or A.TrueShot:IsReady(unitID, true) and Unit(player):HasBuffs(A.WildSpirits.ID) ~= 0 or A.TrueShot:IsReady(unitID, true) and Unit(player):HasBuffs(A.Volley.ID) ~= 0 then
                --         return A.TrueShot:Show(icon)
                --     end
                --     if A.AimedShot:IsReady(unitID, true) and Unit(player):HasBuffs(A.PreciseShots.ID) == 0 and A.AimedShot:GetSpellCharges() > 1 or A.AimedShot:IsReady(unitID, true) and Unit(player):HasBuffs(A.TrueShot.ID) ~= 0 or A.AimedShot:IsReady(unitID, true) and Unit(player):HasBuffs(A.TrickShots.ID) ~= 0 and Unit(unitID):GetRange() <= 44 then
                --         return A.AimedShot:Show(icon)
                --     end
                --     if A.RapidFire:IsReady(unitID, true) and Player:Focus() <= 70 and Unit(unitID):GetRange() <= 44 then
                --         return A.RapidFire:Show(icon)
                --     end
                --     if A.ChimaeraShot:IsReady(unitID, true) and Unit(player):HasBuffs(A.PreciseShots.ID) ~= 0 and Unit(unitID):GetRange() <= 44 then
                --         return A.ChimaeraShot:Show(icon)
                --     end
                --     if A.ArcaneShot:IsReady(unitID, true) and Unit(player):HasBuffs(A.PreciseShots.ID) ~= 0 and Unit(unitID):GetRange() <= 44 then
                --         return A.ArcaneShot:Show(icon)
                --     end
                --     if A.SerpentSting:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.SerpentSting.ID) <= 3 and Unit(player):TimeToDie() > 10 and Unit(unitID):GetRange() <= 44 then
                --         return A.SerpentSting:Show(icon)
                --     end
                --     if A.Barrage:IsReady(unitID, true) and MultiUnits:GetByRangeInCombat(30) >= 2 and Unit(unitID):GetRange() <= 44 then
                --         return A.Barrage:Show(icon)
                --     end
                --     if A.RapidFire:IsReady(unitID, true) and Player:Focus() <= 70 and Unit(player):HasBuffs(A.DoubleTap.ID) == 0 and A.Streamline:IsTalentLearned() and Unit(unitID):GetRange() <= 44 then
                --         return A.RapidFire:Show(icon)
                --     end
                --     if A.SteadyShot:IsReady(unitID, true) and Unit(unitID):GetRange() <= 44 then
                --         return A.SteadyShot:Show(icon)
                --     end
                -- end
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
    
    end

    if PetLibrary.IsExists == false and GetToggle(2, "Call Pet") then
        return A.CallPet:Show(icon)
    end

    if PetLibrary.IsExists == true and GetToggle(2, "Call Pet") or PetLibrary.IsExists == nil and GetToggle(2, "Call Pet") then
        local petHP = Unit("pet"):HealthPercent()
        local mendingRate = petHP <= GetToggle(2, "Mend Pet")
        if mendingRate and A.MendPet:GetCooldown() == 0 then
            return A.CallPet:Show(icon)
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

