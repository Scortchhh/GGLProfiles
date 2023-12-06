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

local ACTION_CONST_HUNTER_BEASTMASTERY                        = CONST.HUNTER_BEASTMASTERY
local ACTION_CONST_AUTOTARGET                = CONST.AUTOTARGET
local ACTION_CONST_SPELLID_FREEZING_TRAP    = CONST.SPELLID_FREEZING_TRAP

local IsIndoors, UnitIsUnit                    = _G.IsIndoors, _G.UnitIsUnit

Action[ACTION_CONST_HUNTER_BEASTMASTERY] = {
    -- Racial
    ArcaneTorrent                             = Create({ Type = "Spell", ID = 50613                                                                             }),
    BloodFury                                 = Create({ Type = "Spell", ID = 20572                                                                              }),
    Fireblood                                   = Create({ Type = "Spell", ID = 265221                                                                             }),
    AncestralCall                              = Create({ Type = "Spell", ID = 274738                                                                             }),
    Berserking                                = Create({ Type = "Spell", ID = 26297                                                                            }),
    arcane_pulse                                  = Create({ Type = "Spell", ID = 260364                                                                            }),
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
    FeralSpirits                                = Create({ Type = "Spell", ID = 51533                                               }),
    EarthElemental                                = Create({ Type = "Spell", ID = 198103                                               }),
    Ascendance                                = Create({ Type = "Spell", ID = 114051                                               }),
    BloodLust                                = Create({ Type = "Spell", ID = 136012                                               }),
    Sundering                                = Create({ Type = "Spell", ID = 197214                                               }),
    Stormkeeper                                = Create({ Type = "Spell", ID = 191634                                               }),
    --target enemy test
    targetEnemy                                = Create({ Type = "Spell", ID = 102270                                               }),
    focusPet                                = Create({ Type = "SpellSingleColor", Color = "RED"                                               }),
    --pet stuff
    MendPet                                = Create({ Type = "Spell", ID = 136                                               }),
    --traps
    freezing_trap                                = Create({ Type = "Spell", ID = 187650                                               }),
    tar_trap                                = Create({ Type = "Spell", ID = 187698                                               }),
    --kick
    counter_shot                                = Create({ Type = "Spell", ID = 147362                                               }),
    --Passives
    aspect_of_the_wild                                = Create({ Type = "Spell", ID = 193530                                               }),
    CallPet                                = Create({ Type = "Spell", ID = 67777                                               }),
    frenzy                                = Create({ Type = "Spell", ID = 272790                                               }),
    BeastCleave                                = Create({ Type = "Spell", ID = 115939                                               }),
    flare                                = Create({ Type = "Spell", ID = 1543                                               }),
    flayers_mark                                = Create({ Type = "Spell", ID = 324156                                               }),
    --talent
    scent_of_blood                                = Create({ Type = "Spell", ID = 193532                                               }),
    -- Rotation       
    kill_shot                                = Create({ Type = "Spell", ID = 53351                                               }),
    bloodshed                                = Create({ Type = "Spell", ID = 321530                                               }),
    barbed_shot                                = Create({ Type = "Spell", ID = 217200                                               }),
    stampede                                = Create({ Type = "Spell", ID = 201430                                               }),
    a_murder_of_crows                                = Create({ Type = "Spell", ID = 131894                                               }),
    bestial_wrath                                = Create({ Type = "Spell", ID = 19574                                               }),
    kill_command                                = Create({ Type = "Spell", ID = 34026                                               }),
    chimaera_shot                                = Create({ Type = "Spell", ID = 53209                                               }),
    dire_beast                                = Create({ Type = "Spell", ID = 120679                                               }),
    barrage                                = Create({ Type = "Spell", ID = 120360                                               }),
    cobra_shot                                = Create({ Type = "Spell", ID = 193455                                               }),
    multi_shot                                = Create({ Type = "Spell", ID = 2643                                               }),
    concussive_shot                                = Create({ Type = "Spell", ID = 5116                                               }),
    bag_of_tricks                                = Create({ Type = "Spell", ID = 312411                                               }),
    --covenant stuff
    wild_spirits                                = Create({ Type = "Spell", ID = 328231                                               }),
    wild_mark                                = Create({ Type = "Spell", ID = 328275                                               }),
    flayed_shot                                = Create({ Type = "Spell", ID = 324149                                               }),
    death_chakram                                = Create({ Type = "Spell", ID = 325028                                               }),
    resonating_arrow                                = Create({ Type = "Spell", ID = 308491                                               }),
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

Action:CreateEssencesFor(ACTION_CONST_HUNTER_BEASTMASTERY)
local A = setmetatable(Action[ACTION_CONST_HUNTER_BEASTMASTERY], { __index = Action })

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
    for key, val in pairs(Action[ACTION_CONST_HUNTER_BEASTMASTERY]) do 
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
    -- if A.GetToggle(2, "SnSInterruptList") and (IsInRaid() or A.InstanceInfo.KeyStone > 1) then
    if A.GetToggle(2, "SnSInterruptList") then
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, "SnS_ShadowlandsContent", true, countInterruptGCD(unitID))
    else
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, countInterruptGCD(unitID))
    end
    -- Can waste interrupt action due delays caused by ping, interface input 
    if castRemainsTime >= GetLatency() then 
        if useKick and not notInterruptable and A.counter_shot:IsReady(unitID) then 
            return A.counter_shot:Show(icon)
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

        -- Purge
        if A.ArcaneTorrent:AutoRacial(unitID) then 
            return A.ArcaneTorrent:Show(icon)
        end         

        -- [[ CDs ]]
        local function CDs()
            local Item = UseItems(unitID)
            if Item and Unit(player):HasBuffs(A.EnrageBuff.ID, true) > 0 then
                return Item:Show(icon)
            end
            if A.AncestralCall:IsReady(unitID, true) and A.BestialWrath:GetCooldown() > 30 then
                return A.AncestralCall:Show(icon)
            end
            if A.Fireblood:IsReady(unitID, true) and A.BestialWrath:GetCooldown() > 30 then
                return A.Fireblood:Show(icon)
            end
            if A.Berserking:IsReady(unitID, true) and (Unit(player):HasBuffs(A.aspect_of_the_wild.ID) ~= 0) then
                return A.Berserking:Show(icon)
            end
            if A.BloodFury:IsReady(unitID, true) and (Unit(player):HasBuffs(A.aspect_of_the_wild.ID) ~= 0) then
                return A.BloodFury:Show(icon)
            end
            if A.LightsJudgment:IsReady(unitID, true) then
                return A.LightsJudgment:Show(icon)
            end
            -- if A.AspectsofTheWild:IsReady(unitID, true) and (Unit(player):HasBuffs(A.AspectsofTheWild.ID) == 0) and not A.BarbedShot:IsReady() then
            --     return A.AspectsofTheWild:Show(icon)
            -- end
        end
        
        -- [[ Single Target ]]
        local function ST()
            if MultiUnits:GetByRangeInCombat(44) >= 2 then
                if A.multi_shot:IsReady(unitID, true) and Unit(player):HasBuffs(A.BeastCleave.ID) <= 0.3 then
                    return A.multi_shot:Show(icon)
                end
            end
            if A.aspect_of_the_wild:IsReady(unitID, true) then
                return A.aspect_of_the_wild:Show(icon)
            end
            if A.barbed_shot:IsReady(unitID, true) and Unit('pet'):HasBuffs(A.frenzy.ID) ~= 0 and Unit('pet'):HasBuffs(A.frenzy.ID) <= GetGCD() then 
                return A.barbed_shot:Show(icon)
            end
            if A.tar_trap:IsReady(unitID, true) and A.tar_trap:GetCooldown() < GetGCD() and A.flare:GetCooldown() < GetGCD() then 
                return A.tar_trap:Show(icon)
            end
            if A.flare:IsReady(unitID, true) and A.tar_trap:IsReady(unitID, true) then 
                return A.flare:Show(icon)
            end
            if A.bloodshed:IsReady(unitID, true) then
                return A.bloodshed:Show(icon)
            end
            if A.wild_spirits:IsReady(unitID, true) then
                return A.wild_spirits:Show(icon)
            end
            if A.flayed_shot:IsReady(unitID, true) then
                return A.flayed_shot:Show(icon)
            end
            if A.kill_shot:IsReady(unitID, true) and Unit(player):HasBuffs(A.flayers_mark.ID) <5 or A.kill_shot:IsReady(unitID, true) and Unit(unitID):HealthPercent()<=20 then 
                return A.kill_shot:Show(icon)
            end
            if A.barbed_shot:IsReady(unitID, true) and A.bestial_wrath:GetCooldown() <12*A.barbed_shot:GetSpellChargesFrac()+ GetGCD() and A.scent_of_blood:IsTalentLearned() or A.barbed_shot:IsReady(unitID, true) and A.barbed_shot:GetSpellChargesFullRechargeTime()< GetGCD() and A.bestial_wrath.remains or A.barbed_shot:IsReady(unitID, true) and Unit(unitID):TimeToDie() <9 then 
                return A.barbed_shot:Show(icon)
            end
            if A.death_chakram:IsReady(unitID, true) and Player:Focus() + Player:FocusCastRegen(1) <Player:FocusMax() then 
                return A.death_chakram:Show(icon)
            end
            if A.stampede:IsReady(unitID, true) and Unit(player):HasBuffs(A.aspect_of_the_wild.ID) ~= 0 or A.stampede:IsReady(unitID, true) and Unit(unitID):TimeToDie() <15 then 
                return A.stampede:Show(icon)
            end
            if A.a_murder_of_crows:IsReady(unitID, true) then
                return A.a_murder_of_crows:Show(icon)
            end
            if A.resonating_arrow:IsReady(unitID, true) and Unit(player):HasBuffs(A.bestial_wrath.ID) ~= 0 or A.resonating_arrow:IsReady(unitID, true) and Unit(unitID):TimeToDie() <10 then 
                return A.resonating_arrow:Show(icon)
            end
            if A.bestial_wrath:IsReady(unitID, true) and A.wild_spirits:GetCooldown() >15 or A.bestial_wrath:IsReady(unitID, true) and Unit(unitID):TimeToDie() <15 then 
                return A.bestial_wrath:Show(icon)
            end
            if A.chimaera_shot:IsReady(unitID, true) then
                return A.chimaera_shot:Show(icon)
            end
            if A.kill_command:IsReady(unitID, true) then
                return A.kill_command:Show(icon)
            end
            if A.bag_of_tricks:IsReady(unitID, true) and Unit(player):HasBuffs(A.bestial_wrath.ID) == 0 or A.bag_of_tricks:IsReady(unitID, true) and Unit(unitID):TimeToDie() <5 then 
                return A.bag_of_tricks:Show(icon)
            end
            if A.dire_beast:IsReady(unitID, true) then
                return A.dire_beast:Show(icon)
            end
            if A.cobra_shot:IsReady(unitID, true) and (Player:Focus()-A.cobra_shot:GetSpellPowerCost()+Player:FocusRegen()*(A.kill_command:GetCooldown() -1)>A.kill_command:GetSpellPowerCost() or A.cobra_shot:IsReady(unitID, true) and A.kill_command:GetCooldown() >1+ GetGCD()) or A.cobra_shot:IsReady(unitID, true) and (Unit(player):HasBuffs(A.bestial_wrath.ID) ~= 0 ) or A.cobra_shot:IsReady(unitID, true) and Unit(unitID):TimeToDie() <3 then 
                return A.cobra_shot:Show(icon)
            end
            if A.barbed_shot:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.wild_mark.ID) ~= 0 then 
                return A.barbed_shot:Show(icon)
            end
            if A.arcane_pulse:IsReady(unitID, true) and Unit(player):HasBuffs(A.bestial_wrath.ID) == 0 or A.arcane_pulse:IsReady(unitID, true) and Unit(unitID):TimeToDie() <5 then 
                return A.arcane_pulse:Show(icon)
            end
            if A.tar_trap:IsReady(unitID, true) then 
                return A.tar_trap:Show(icon)
            end
            if A.freezing_trap:IsReady(unitID, true) then 
                return A.freezing_trap:Show(icon)
            end            
            -- if A.KillShot:IsReady(unitID, true) and Unit(unitID):GetRange() <= 40 then
            --     return A.KillShot:Show(icon)
            -- end
            -- if A.Exhilaration:IsReady(unitID, true) and Unit(player):HealthPercent() <= GetToggle(2, "Exhilaration") then
            --     return A.Exhilaration:Show(icon)
            -- end
            -- --print(PetLibrary:GetInRange(A.Growl.ID))
            -- --PetLibrary:GetInRange(A.Growl.ID) >= 3 and
            -- if inAoE then
            --     if A.MultiShot:IsReady(unitID, true) and MultiUnits:GetByRange(40) >= 3 and Unit(unitID):GetRange() <= 40 and Unit("pet"):HasBuffs(A.BeastCleave.ID) <= 1 or A.MultiShot:IsReady(unitID, true) and MultiUnits:GetByRange(40) >= 3 and Unit(unitID):GetRange() <= 40 and Player:Focus() >= 100 then
            --         return A.MultiShot:Show(icon)
            --     end
            -- end
            -- if A.BestialWrath:IsReady(unitID, true) then
            --     return A.BestialWrath:Show(icon)
            -- end
            -- if Unit(unitID):GetRange() <= 40 then
            --     if A.BarbedShot:IsReady(unitID, true) and A.BarbedShot:GetSpellCharges() >= 2 or A.BarbedShot:IsReady(unitID, true) and Unit("pet"):HasBuffs(A.Frenzy.ID) <= 2 or A.BarbedShot:IsReady(unitID, true) and A.BarbedShot:GetSpellCharges() == 1 and A.BarbedShot:GetSpellChargesFrac() >= 1.5 then
            --         return A.BarbedShot:Show(icon)
            --     end
            -- end
            -- if A.KillCommand:IsReady(unitID, true) and Unit(unitID):GetRange() <= 40 then
            --     return A.KillCommand:Show(icon)
            -- end
            -- if A.ConcussiveShot:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.ConcussiveShot.ID) == 0 and not Unit(unitID):IsBoss() and Unit(unitID):GetRange() >= 20 and Unit(unitID):GetRange() <= 40 then
            --     return A.ConcussiveShot:Show(icon)
            -- end
            -- if A.BloodShed:IsReady(unitID, true) and Unit(unitID):GetRange() <= 50 then
            --     return A.BloodShed:Show(icon)
            -- end
            -- if A.Stampede:IsReady(unitID, true) and (Unit(player):HasBuffs(A.AspectsofTheWild.ID) == 0) and Unit(unitID):GetRange() <= 30 then
            --     return A.Stampede:Show(icon)
            -- end
            -- if A.MurderofCrows:IsReady(unitID, true) and Unit(unitID):GetRange() <= 40 then
            --     return A.MurderofCrows:Show(icon)
            -- end
            -- if A.ChimearaShot:IsReady(unitID, true) and Unit(unitID):GetRange() <= 40 then
            --     return A.ChimearaShot:Show(icon)
            -- end
            -- if A.DireBeast:IsReady(unitID, true) and Unit(unitID):GetRange() <= 40 then
            --     return A.DireBeast:Show(icon)
            -- end
            -- if A.Barrage:IsReady(unitID, true) and Unit(unitID):GetRange() <= 40 then
            --     return A.Barrage:Show(icon)
            -- end
            -- if A.CobraShot:IsReady(unitID, true) and A.KillCommand:GetCooldown() >= 0.5 and Unit(unitID):GetRange() <= 40 then
            --     return A.CobraShot:Show(icon)
            -- end
            -- if MultiUnits:GetByRange(40, 5) >= 3 then
            --     if A.TarTrap:IsReady(unitID, true) then
            --         return A.TarTrap:Show(icon)
            --     end
            --     if A.FreezingTrap:IsReady(unitID, true) then
            --         return A.FreezingTrap:Show(icon)
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

    if PetLibrary.IsExists == false then
        return A.CallPet:Show(icon)
    end

    if PetLibrary.IsExists == nil or PetLibrary.IsExists == true then
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

