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

local ACTION_CONST_HUNTER_SURVIVAL                        = CONST.HUNTER_SURVIVAL
local ACTION_CONST_AUTOTARGET                = CONST.AUTOTARGET
local ACTION_CONST_SPELLID_FREEZING_TRAP    = CONST.SPELLID_FREEZING_TRAP

local IsIndoors, UnitIsUnit                    = _G.IsIndoors, _G.UnitIsUnit

Action[ACTION_CONST_HUNTER_SURVIVAL] = {
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
    --interupt 
    Muzzle                                = Create({ Type = "Spell", ID = 187707                                               }),
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
    --Weapon Buffs
    FlametongueWeapon                                = Create({ Type = "Spell", ID = 318038                                               }),
    WindfuryWeapon                                = Create({ Type = "Spell", ID = 33757                                               }),
    --traps
    FreezingTrap                                = Create({ Type = "Spell", ID = 187650                                               }),
    SteelTrap                                = Create({ Type = "Spell", ID = 162488                                               }),
    TarTrap                                = Create({ Type = "Spell", ID = 187698                                               }),
    --kick
    WindShear                                = Create({ Type = "Spell", ID = 57994                                               }),
    --Passives
    AspectsofTheWild                                = Create({ Type = "Spell", ID = 193530                                               }),
    TipofTheSpear                                = Create({ Type = "Spell", ID = 260285                                               }),
    CallPet                                = Create({ Type = "Spell", ID = 67777                                               }),
    LatentPoison                                = Create({ Type = "Spell", ID = 273283                                               }),
    -- Rotation  
    VolatileBomb                                = Create({ Type = "Spell", ID = 271049                                               }),
    PheromoneBomb                                = Create({ Type = "Spell", ID = 270329                                               }),     
    ShrapnelBomb                                = Create({ Type = "Spell", ID = 270335                                               }),
    WildfireBomb                                = Create({ Type = "Spell", ID = 259495                                               }),
    SerpentSting                                = Create({ Type = "Spell", ID = 259491                                               }),
    MongooseBite                                = Create({ Type = "Spell", ID = 190928                                               }),
    Carve                                = Create({ Type = "Spell", ID = 187708                                               }),
    CoordinatedAssault                                = Create({ Type = "Spell", ID = 266779                                               }),
    RaptorStrike                                = Create({ Type = "Spell", ID = 186270                                               }),
    KillShot                                = Create({ Type = "Spell", ID = 53351                                               }),
    FlankingStrike                                = Create({ Type = "Spell", ID = 269751                                               }),
    Harpoon                                = Create({ Type = "Spell", ID = 190925                                               }),
    BloodShed                                = Create({ Type = "Spell", ID = 321530                                               }),
    BarbedShot                                = Create({ Type = "Spell", ID = 217200                                               }),
    Stampede                                = Create({ Type = "Spell", ID = 201430                                               }),
    MurderofCrows                                = Create({ Type = "Spell", ID = 131894                                               }),
    BestialWrath                                = Create({ Type = "Spell", ID = 19574                                               }),
    KillCommand                                = Create({ Type = "Spell", ID = 34026                                               }),
    ChimearaShot                                = Create({ Type = "Spell", ID = 53209                                               }),
    DireBeast                                = Create({ Type = "Spell", ID = 120679                                               }),
    CobraShot                                = Create({ Type = "Spell", ID = 193455                                               }),
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

Action:CreateEssencesFor(ACTION_CONST_HUNTER_SURVIVAL)
local A = setmetatable(Action[ACTION_CONST_HUNTER_SURVIVAL], { __index = Action })

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
    for key, val in pairs(Action[ACTION_CONST_HUNTER_SURVIVAL]) do 
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
            if not notKickAble and A.Muzzle:IsReady(unitID, nil, nil, true) and A.Muzzle:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then
                return A.Muzzle:Show(icon)                                                  
            end                   
        end 
    end                                                                                 
end

local function countInterruptGCD(unitID)
    if not A.Muzzle:IsReadyByPassCastGCD(unitID) or not A.Muzzle:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then 
        return true 
    end 
end 

local function Interrupts(unitID)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime = InterruptIsValid(unitID,  nil, nil, countInterruptGCD(unitID))    
    
    -- Can waste interrupt action due delays caused by ping, interface input 
    if castRemainsTime < GetLatency() then 
        return 
    end 
    
    if useKick and not notInterruptable and A.Muzzle:IsReady(unitID) then 
        return A.Muzzle
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
        local muzzle = Interrupts(unitID)
        if muzzle then
            return A.Muzzle:Show(icon)
        end
        inMelee                 = A.Carve:IsInRange(unitID)    
        -- Variables        
        local isBurst            = BurstIsON(unitID)

        -- Purge3
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
            if A.Berserking:IsReady(unitID, true) and (Unit(player):HasBuffs(A.AspectsofTheWild.ID) ~= 0) then
                return A.Berserking:Show(icon)
            end
            if A.BloodFury:IsReady(unitID, true) and (Unit(player):HasBuffs(A.AspectsofTheWild.ID) ~= 0) then
                return A.BloodFury:Show(icon)
            end
            if A.LightsJudgment:IsReady(unitID, true) then
                return A.LightsJudgment:Show(icon)
            end
            if A.CoordinatedAssault:IsReady(unitID, true) ~= false then
                return A.CoordinatedAssault:Show(icon)
            end
        end
        
        -- [[ Single Target ]]
        local function ST()
            inMelee                 = A.Carve:IsInRange(unitID)    
            if A.Exhilaration:IsReady(unitID, true) and Unit(player):HealthPercent() <= GetToggle(2, "Exhilaration") then
                return A.Exhilaration:Show(icon)
            end
            if A.KillShot:IsReady(unitID, true) then
                return A.KillShot:Show(icon)
            end
            if A.Harpoon:IsReady(unitID, true) and Unit(unitID):GetRange() >= 8 then
                return A.Harpoon:Show(icon)
            end
            if A.FlankingStrike:IsReady(unitID, true) and Player:FocusRegen() < 100 then
                return A.FlankingStrike:Show(icon)
            end
            -- if A.RaptorStrike:IsReady(unitID, true) and inMelee and A.CoordinatedAssault:IsReady(player, true) ~= false or A.RaptorStrike:IsReady(unitID, true) and Unit(player):HasBuffsStacks(A.TipofTheSpear.ID, true) >= 3 or A.RaptorStrike:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.LatentPoison.ID) == 10 then
            --     return A.RaptorStrike:Show(icon)
            -- end
            if A.MongooseBite:IsReady(unitID, true) and A.CoordinatedAssault:IsReady(player, true) ~= false then
                return A.MongooseBite:Show(icon)
            end
            if A.KillCommand:IsReady(unitID, true) then
                return A.KillCommand:Show(icon)
            end
            if A.Carve:IsReady(unitID, true) and inMelee and (Unit(unitID):HasBuffs(A.ShrapnelBomb.ID) ~= 0) or A.Carve:IsReady(unitID, true) and inMelee and MultiUnits:GetByRange(8, 3) then
                return A.Carve:Show(icon)
            end
            if A.SerpentSting:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.LatentPoison.ID) < 10 then
                return A.SerpentSting:Show(icon)
            end
            if A.RaptorStrike:IsReady(unitID, true) then
                return A.RaptorStrike:Show(icon)
            end
            if A.SteelTrap:IsReady(unitID, true) and Player:FocusRegen() < 100 then
                return A.SteelTrap:Show(icon)
            end
            -- if A.WildfireBomb:IsReady(unitID, true) and Player:FocusRegen() < 100 then
            --     return A.ShrapnelBomb:Show(icon)
            -- end
            -- if A.PheromoneBomb:IsReady(unitID, true) and Player:FocusRegen() < 100 then
            --     return A.WildfireBomb:Show(icon)
            -- end
            -- if A.VolatileBomb:IsReady(unitID, true) and Player:FocusRegen() < 100 then
            --     return A.WildfireBomb:Show(icon)
            -- end
            -- if A.ShrapnelBomb:IsReady(unitID, true) and Player:FocusRegen() < 100 then
            --     return A.WildfireBomb:Show(icon)
            -- end
            if A.MurderofCrows:IsReady(unitID, true) and not (Unit(player):HasBuffs(A.CoordinatedAssault.ID) == 0) then
                return A.MurderofCrows:Show(icon)
            end
        end
        
        -- CDs need to re enable isBurst once fixed
        if CDs() and isBurst then 
            return true 
        end

        -- FINISHERS
        if inMelee then
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

    if PetLibrary.IsExists == nil or PetLibrary.IsExists == false then
        return A.CallPet:Show(icon)
    end
    if PetLibrary.IsExists == true then
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

