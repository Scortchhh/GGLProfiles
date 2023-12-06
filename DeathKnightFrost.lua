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

local ACTION_CONST_DEATHKNIGHT_FROST             = CONST.DEATHKNIGHT_FROST
local ACTION_CONST_AUTOTARGET                = CONST.AUTOTARGET
local ACTION_CONST_SPELLID_FREEZING_TRAP    = CONST.SPELLID_FREEZING_TRAP

local IsIndoors, UnitIsUnit                    = _G.IsIndoors, _G.UnitIsUnit

Action[ACTION_CONST_DEATHKNIGHT_FROST] = {
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
    IceboundFortitude                                = Create({ Type = "Spell", ID = 48792                                               }),
    AntiMagicShell                                = Create({ Type = "Spell", ID = 48707                                               }),
    AntiMagicZone                                = Create({ Type = "Spell", ID = 51052                                               }),
    Lichborne                                = Create({ Type = "Spell", ID = 50397                                               }),
    DeathPact                                = Create({ Type = "Spell", ID = 48743                                               }),
    -- Healing
    HealingSurge                                = Create({ Type = "Spell", ID = 8004                                               }),
    -- CDS
    BreathofSindragosa                                = Create({ Type = "Spell", ID = 152279                                               }),
    EmpowerRuneWeapon                                = Create({ Type = "Spell", ID = 47568                                               }),
    RaiseDead                                = Create({ Type = "Spell", ID = 46584                                               }),
    SacrificialPact                                = Create({ Type = "Spell", ID = 327574                                               }),
    HornOfWinter                                = Create({ Type = "Spell", ID = 57330                                               }),
    HypothermicPresence                                = Create({ Type = "Spell", ID = 321995                                               }),
    --kick
    MindFreeze                                = Create({ Type = "Spell", ID = 47528                                               }),
    Purge                                = Create({ Type = "Spell", ID = 370                                               }),
    CleanseSpirit                                = Create({ Type = "Spell", ID = 51886                                               }),
    SpiritWalk                                = Create({ Type = "Spell", ID = 58875                                               }),
    --Passives
    IcyCitadel                                = Create({ Type = "Spell", ID = 272718                                               }),
    GatheringStorm                                = Create({ Type = "Spell", ID = 194912                                               }),
    Rime                                = Create({ Type = "Spell", ID = 59057                                               }),
    KillingMachine                                = Create({ Type = "Spell", ID = 51128                                               }),
    ColdHeart                                = Create({ Type = "Spell", ID = 281208                                               }),
    IcyTalons                                = Create({ Type = "Spell", ID = 194878                                               }),
    FrozenPulse                                = Create({ Type = "Spell", ID = 194909                                               }),
    -- Rotation       
    ChainsofIce                                = Create({ Type = "Spell", ID = 45524                                               }),
    PillarofFrost                                = Create({ Type = "Spell", ID = 51271                                               }),
    FrostwyrmsFury                                = Create({ Type = "Spell", ID = 279302                                               }),
    RemorselessWinter                                = Create({ Type = "Spell", ID = 196770                                               }),
    HowlingBlast                                = Create({ Type = "Spell", ID = 49184                                               }),
    Obliterate                                = Create({ Type = "Spell", ID = 49020                                               }),
    FrostStrike                                = Create({ Type = "Spell", ID = 49143                                               }),
    Frostscythe                                = Create({ Type = "Spell", ID = 207230                                               }),
    DeathGrip                                = Create({ Type = "Spell", ID = 49576                                               }),
    DeathCoil                                = Create({ Type = "Spell", ID = 47541                                               }),
    GlacialAdvance                                = Create({ Type = "Spell", ID = 194913                                               }),
    DeathandDecay                                = Create({ Type = "Spell", ID = 43265                                               }),
    DeathStrike                                = Create({ Type = "Spell", ID = 49998                                               }),
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

Action:CreateEssencesFor(ACTION_CONST_DEATHKNIGHT_FROST)
local A = setmetatable(Action[ACTION_CONST_DEATHKNIGHT_FROST], { __index = Action })

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
    for key, val in pairs(Action[ACTION_CONST_DEATHKNIGHT_FROST]) do 
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
            if not notKickAble and A.MindFreeze:IsReady(unitID, nil, nil, true) and A.MindFreeze:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then
                return A.MindFreeze:Show(icon)                                                  
            end                   
        end 
    end                                                                                 
end

local function countInterruptGCD(unitID)
    if not A.MindFreeze:IsReadyByPassCastGCD(unitID) or not A.MindFreeze:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then 
        return true 
    end 
end 

local function Interrupts(unitID)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime = InterruptIsValid(unitID,  nil, nil, countInterruptGCD(unitID))    
    
    -- Can waste interrupt action due delays caused by ping, interface input 
    if castRemainsTime < GetLatency() then 
        return 
    end 
    
    if useKick and not notInterruptable and A.MindFreeze:IsReady(unitID) then 
        return A.MindFreeze
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

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
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
        local mindfreeze = Interrupts(unitID)
        if mindfreeze then
            return A.MindFreeze:Show(icon)
        end
        local isBurst            = BurstIsON(unitID)
        
        inMelee                 = A.Obliterate:IsInRange(unitID)    
        
        -- Purge
        if A.ArcaneTorrent:AutoRacial(unitID) then 
            return A.ArcaneTorrent:Show(icon)
        end             

        local function Mitigation()
            if inCombat >= 2 then
                if LoC:Get("STUN") ~= 0 or LoC:Get("STUN_MECHANIC") ~= 0 then
                    if A.IceboundFortitude:IsReady(unitID, true) then
                        return A.IceboundFortitude:Show(icon)
                    end
                end
                if A.AntiMagicShell:IsReady(unitID, true) and Unit(player):HealthPercent() <= GetToggle(2, "AntiMagicShell") then
                    return A.AntiMagicShell:Show(icon)
                end
                if A.AntiMagicZone:IsReady(unitID, true) and Unit(player):HealthPercent() <= GetToggle(2, "AntiMagicZone") then
                    return A.AntiMagicZone:Show(icon)
                end
                if A.DeathStrike:IsReady(unitID, true) and Unit(player):HealthPercent() <= GetToggle(2, "DeathStrike") then
                    return A.DeathStrike:Show(icon)
                end
                if A.IceboundFortitude:IsReady(unitID, true) and Unit(player):HealthPercent() <= GetToggle(2, "IceboundFortitude") then
                    return A.IceboundFortitude:Show(icon)
                end
                if A.Lichborne:IsReady(unitID, true) and Unit(player):HealthPercent() <= GetToggle(2, "Lichborne") then
                    return A.Lichborne:Show(icon)
                end
                if A.DeathPact:IsReady(unitID, true) and Unit(player):HealthPercent() <= GetToggle(2, "DeathPact") then
                    return A.DeathPact:Show(icon)
                end
            end
        end

        local function BreathofSindragosa() 
            if Unit(player):HasBuffs(A.BreathofSindragosa.ID) ~= 0 then
                if A.Obliterate:IsReady(unitID, true) and Player:RunicPower() <= 30 then
                    return A.Obliterate:Show(icon)
                end
                if A.RemorselessWinter:IsReady(unitID, true) and A.GatheringStorm:IsTalentLearned() then
                    return A.RemorselessWinter:Show(icon)
                end
                if A.HowlingBlast:IsReady(unitID, true) and Unit(player):HasBuffs(A.Rime.ID) ~= 0 then
                    return A.HowlingBlast:Show(icon)
                end
                if A.Obliterate:IsReady(unitID, true) and Player:Rune() >= 5 or A.Obliterate:IsReady(unitID, true) and Player:RunicPower() <= 45 then
                    return A.Obliterate:Show(icon)
                end
                if A.RemorselessWinter:IsReady(unitID, true) then
                    return A.RemorselessWinter:Show(icon)
                end
                if A.Obliterate:IsReady(unitID, true) and Player:RunicPower() <= 73 then
                    return A.Obliterate:Show(icon)
                end
            end
        end

        local function PillarofFrost()
            if Unit(player):HasBuffs(A.PillarofFrost.ID) ~= 0 then
                if A.Obliterate:IsReady(unitID, true) and Unit(player):HasBuffs(A.KillingMachine.ID) ~= 0 then
                    return A.Obliterate:Show(icon)
                end
                if Unit(player):HasBuffs(A.BreathofSindragosa.ID) == 0 then
                    if A.FrostStrike:IsReady(unitID, true) and Unit(player):HasBuffs(A.KillingMachine.ID) == 0 or A.FrostStrike:IsReady(unitID, true) and Player:RunicPower() >= 73 then
                        return A.FrostStrike:Show(icon)
                    end
                end
                if A.HowlingBlast:IsReady(unitID, true) and Unit(player):HasBuffs(A.Rime.ID) ~= 0 then
                    return A.HowlingBlast:Show(icon)
                end
                if A.Obliterate:IsReady(unitID, true) then
                    return A.Obliterate:Show(icon)
                end
            end
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
            if A.PillarofFrost:IsReady(unitID, true) and Player:Rune() >= 2 and Player:RunicPower() >= 25 or A.PillarofFrost:IsReady(unitID, true) and Player:Rune() >= 2 and Unit(player):HasBuffs(A.Rime.ID) ~= 0 then
                return A.PillarofFrost:Show(icon)
            end
            if A.BreathofSindragosa:IsReady(unitID, true) and Player:RunicPower() >= 60 and Player:Rune() <= 1 and A.PillarofFrost:IsReady(unitID, true) or A.BreathofSindragosa:IsReady(unitID, true) and Player:RunicPower() >= 60 and Player:Rune() <= 1 and Unit(player):HasBuffs(A.PillarofFrost.ID) ~= 0 then
                return A.BreathofSindragosa:Show(icon)
            end
            if A.EmpowerRuneWeapon:IsReady(unitID, true) and Unit(player):HasBuffs(A.PillarofFrost) ~= 0 or A.EmpowerRuneWeapon:IsReady(unitID, true) and A.BreathofSindragosa:GetCooldown() >= 115 then
                return A.EmpowerRuneWeapon:Show(icon)
            end
            if A.RaiseDead:IsReady(unitID, true) then
                return A.RaiseDead:Show(icon)
            end
            if A.SacrificialPact:IsReady(unitID, true) and Unit(player):HealthPercent() <= GetToggle(2, "SacrificialPact") then
                return A.SacrificialPact:Show(icon)
            end
            if A.HornOfWinter:IsReady(unitID, true) and Unit(player):HasBuffs(A.PillarofFrost) >= 8 or A.HornOfWinter:IsReady(unitID, true) and Player:RunicPower() <= 25 then
                return A.HornOfWinter:Show(icon)
            end
            if A.HypothermicPresence:IsReady(unitID, true) and Unit(player):HasBuffs(A.EmpowerRuneWeapon.ID) == 0 or A.HypothermicPresence:IsReady(unitID, true) and Player:RunicPower() <= 25 then
                return A.HypothermicPresence:Show(icon)
            end
            if MultiUnits:GetByRangeInCombat(12) >= 2 then
                if A.FrostwyrmsFury:IsReady(unitID, true) and Unit(player):HasBuffs(A.PillarofFrost.ID) <= 3 then
                    return A.FrostwyrmsFury:Show(icon)
                end
            end
        end

        -- [[ Single Target ]]
        local function ST()
            if MultiUnits:GetByRangeInCombat(8) >= 2 then
                if A.GlacialAdvance:IsTalentLearned() then
                    if A.GlacialAdvance:IsReady(unitID, true) and A.IcyTalons:IsTalentLearned() and Unit(player):HasBuffs(A.IcyTalons.ID) <= 2 then
                        return A.GlacialAdvance:Show(icon)
                    end
                else
                    if A.FrostStrike:IsReady(unitID, true) then
                        return A.FrostStrike:Show(icon)
                    end
                end
                if A.FrostStrike:IsReady(unitID, true) and Player:RunicPower() >= 25 and Player:RunicPower() <= 30 then
                    return A.FrostStrike:Show(icon)
                end
                if A.RemorselessWinter:IsReady(unitID, true) and A.GatheringStorm:IsTalentLearned() then
                    return A.RemorselessWinter:Show(icon)
                end
                if A.HowlingBlast:IsReady(unitID, true) and Unit(player):HasBuffs(A.Rime.ID) ~= 0 then
                    return A.HowlingBlast:Show(icon)
                end
                if A.Frostscythe:IsReady(unitID, true) and A.Frostscythe:IsTalentLearned() and Unit(player):HasBuffs(A.KillingMachine.ID) ~= 0 then
                    return A.Frostscythe:Show(icon)
                end
                if A.RemorselessWinter:IsReady(unitID, true) then
                    return A.RemorselessWinter:Show(icon)
                end
                if A.DeathandDecay:IsReady(unitID, true) then
                    return A.DeathandDecay:Show(icon)
                end
                if A.Frostscythe:IsReady(unitID, true) and A.Frostscythe:IsTalentLearned() then
                    return A.Frostscythe:Show(icon)
                end
                if A.Obliterate:IsReady(unitID, true) then
                    return A.Obliterate:Show(icon)
                end
                if A.GlacialAdvance:IsReady(unitID, true) and A.GlacialAdvance:IsTalentLearned() then
                    return A.GlacialAdvance:Show(icon)
                end
                if A.FrostStrike:IsReady(unitID, true) then
                    return A.FrostStrike:Show(icon)
                end
            else
                PillarofFrost()
                BreathofSindragosa()
                if Unit(player):HasBuffs(A.BreathofSindragosa.ID) == 0 and Unit(player):HasBuffs(A.PillarofFrost.ID) == 0 then
                    --normal rotation
                    if A.ChainsofIce:IsReady(unitID, true) and Unit(player):HasBuffsStacks(A.ColdHeart.ID) >= 20 then
                        return A.ChainsofIce:Show(icon)
                    end
                    if A.FrostStrike:IsReady(unitID, true) and Unit(player):HasBuffs(A.IcyTalons.ID) <= 2 then
                        return A.FrostStrike:Show(icon)
                    end
                    if A.HowlingBlast:IsReady(unitID, true) and Unit(player):HasBuffs(A.Rime.ID) ~= 0 then
                        return A.HowlingBlast:Show(icon)
                    end
                    if A.Obliterate:IsReady(unitID, true) and Player:Rune() > 2 and A.FrozenPulse:IsTalentLearned() then
                        return A.Obliterate:Show(icon)
                    end
                    if A.FrostStrike:IsReady(unitID, true) and Player:RunicPower() >= 73 then
                        return A.FrostStrike:Show(icon)
                    end
                    if A.Obliterate:IsReady(unitID, true) then
                        return A.Obliterate:Show(icon)
                    end
                    if A.FrostStrike:IsReady(unitID, true) then
                        return A.FrostStrike:Show(icon)
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

