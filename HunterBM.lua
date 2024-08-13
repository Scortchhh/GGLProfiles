-- Last Update 8/8/2024
-- Missing Trinkets, CC Interrupt, Soothe and other M+ Utility

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
    Berserking                                = Create({ Type = "Spell", ID = 26297                                                                             }),
    FireBlood                                 = Create({ Type = "Spell", ID = 265221                                                                            }),
    AncestralCall                             = Create({ Type = "Spell", ID = 274738                                                                            }),
    LightsJudgment                            = Create({ Type = "Spell", ID = 255647                                                                            }),
    BagofTricks                               = Create({ Type = "Spell", ID = 312411                                                                            }),
    ArcanePulse                               = Create({ Type = "Spell", ID = 260364                                                                            }),
    GiftoftheNaaru                            = Create({ Type = "Spell", ID = 28880                                                                             }),
    Haymaker                                  = Create({ Type = "Spell", ID = 287712                                                                            }),
    TailSwipe                                 = Create({ Type = "Spell", ID = 368970                                                                            }),
    WingBuffet                                = Create({ Type = "Spell", ID = 357214                                                                            }),
    BullRush                                  = Create({ Type = "Spell", ID = 255654                                                                            }),
    WarStomp                                  = Create({ Type = "Spell", ID = 20549                                                                             }),
    QuakingPalm                               = Create({ Type = "Spell", ID = 107079                                                                            }),
    WilloftheForsaken                         = Create({ Type = "Spell", ID = 7744                                                                              }),
    RocketBarrage                             = Create({ Type = "Spell", ID = 69041                                                                             }),
    ArcaneTorrent                             = Create({ Type = "Spell", ID = 80483                                                                             }),
    StoneForm                                 = Create({ Type = "Spell", ID = 20594                                                                             }),
    WilltoSurvive                             = Create({ Type = "Spell", ID = 59752                                                                             }),
    EscapeArtist                              = Create({ Type = "Spell", ID = 20589                                                                             }),


    CalloftheWild                             = Create({ Type = "Spell", ID = 359844, IsTalent = true                                                                            }),
    BestialWrath                              = Create({ Type = "Spell", ID = 19574, IsTalent = true, Hidden = true                                               }),
    Frenzy                                    = Create({ Type = "Spell", ID = 272790, IsTalent = true                                            }),
    BarbedShot                                = Create({ Type = "Spell", ID = 217200, IsTalent = true                                           }),
    BeastCleave                               = Create({ Type = "Spell", ID = 115939, IsTalent = true                                           }),
    BeastCleavePlayerBuff                     = Create({ Type = "Spell", ID = 268877,                                                                          }),
    BeastCleaveBuff                           = Create({ Type = "Spell", ID = 118455                                                                            }),
    BloodFrenzy                               = Create({ Type = "Spell", ID = 407412, IsTalent = true                                              }),
    KillCommand                               = Create({ Type = "Spell", ID = 34026, IsTalent = true                                             }),
    KillCleave                                = Create({ Type = "Spell", ID = 378207, IsTalent = true                                              }),
    ExplosiveShot                             = Create({ Type = "Spell", ID = 212431, IsTalent = true                                              }),
    Bloodshed                                 = Create({ Type = "Spell", ID = 321530, IsTalent = true                                             }),
    VenomsBite                                = Create({ Type = "Spell", ID = 459565, IsTalent = true                                          }),
    SerpentSting                              = Create({ Type = "Spell", ID = 271788                                          }),
    DireBeast                                 = Create({ Type = "Spell", ID = 120679, IsTalent = true                                             }),
    WildCall                                  = Create({ Type = "Spell", ID = 185789, IsTalent = true                                             }),
    Savagery                                  = Create({ Type = "Spell", ID = 424557, IsTalent = true                                           }),
    Multishot                                 = Create({ Type = "Spell", ID = 2643, IsTalent = true                                         }),
    CobraShot                                 = Create({ Type = "Spell", ID = 193455, IsTalent = true                                            }),
    ScentOfBlood                              = Create({ Type = "Spell", ID = 193532, IsTalent = true                                            }),
    KillShot                                  = Create({ Type = "Spell", ID = 53351, IsTalent = true                                     }),
    KillerCobra                               = Create({ Type = "Spell", ID = 199532, IsTalent = true                                     }),
    AlphaPredator                               = Create({ Type = "Spell", ID = 269737, IsTalent = true                                     }),
    HuntmastersCall                           = Create({ Type = "Spell", ID = 459730, IsTalent = true                                     }),

    --target enemy test
    targetEnemy                                = Create({ Type = "Spell", ID = 102270                                               }),
    --kick
    counter_shot                                = Create({ Type = "Spell", ID = 147362                                             }),
    --Passives
    CallPet                                = Create({ Type = "Spell", ID = 67777                                               }),
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
    useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, countInterruptGCD(unitID))
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

local function ActiveEnemies()
    local spells = {17253, 16827, 49966, 2649} -- 2649 is Growl, remove if wanted
    local v_activeEnemies

    if not PetLibrary:IsActive() then
        return 0
    else 
        for _, spell in pairs(spells) do
            if PetLibrary:IsSpellKnown(spell) then --works
                v_activeEnemies = PetLibrary:GetInRange(spell)
                if v_activeEnemies > 0 then
                    return v_activeEnemies
                end
            end
        end
    end
    return 0
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

        local function Cleave()
            if A.BarbedShot:IsTalentLearned() and A.BarbedShot:IsReady(unitID) and 
            (
                (Unit("pet"):HasBuffs(A.Frenzy.ID) <= GetGCD() + 0.25) or
                (A.ScentOfBlood:IsTalentLearned() and A.BestialWrath:GetCooldown() < 12 + GetGCD()) or 
                (Unit("pet"):HasBuffsStacks(A.BarbedShot.ID) < 3 and (A.BestialWrath:IsReady(unitID) or A.CalloftheWild:IsReady(unitID))) or 
                ((A.BarbedShot:GetSpellChargesFullRechargeTime() < GetGCD()) and A.BestialWrath:GetCooldown() > 0)
            ) 
            then
                -- TODO: Target least buff duration on enemy unit
                return A.BarbedShot:Show(icon)
            end
            
            if A.BeastCleave:IsTalentLearned() and A.Multishot:IsReady(unitID) and (Unit(player):HasBuffs(A.BeastCleavePlayerBuff.ID) < 0.25 + GetGCD() and (not A.BloodFrenzy:IsTalentLearned() or A.CalloftheWild:GetCooldown() > 0)) then
                return A.Multishot:Show(icon)
            end
        
            if A.BestialWrath:IsTalentLearned() and A.BestialWrath:IsReady(player) then
                return A.BestialWrath:Show(icon)
            end
        
            if A.CalloftheWild:IsTalentLearned() and A.CalloftheWild:IsReady(player) then
                return A.CalloftheWild:Show(icon)
            end

            if A.KillCommand:IsTalentLearned() and A.KillCleave:IsTalentLearned() and A.KillCommand:IsReady(player) then
                return A.KillCommand:Show(icon)
            end

            if A.ExplosiveShot:IsTalentLearned() and A.ExplosiveShot:IsReady(unitID) then
                return A.ExplosiveShot:Show(icon)
            end
        
            if A.Bloodshed:IsTalentLearned() and A.Bloodshed:IsReady(player) then
                return A.Bloodshed:Show(icon)
            end

            if A.KillShot:IsTalentLearned() and A.KillShot:IsReady(unitID) and A.VenomsBite:IsTalentLearned() then
                if (Unit(unitID):HasDeBuffs(A.SerpentSting.ID, true) and Unit(unitID):HasDeBuffs(A.SerpentSting.ID, true) < GetGCD()) and
                    Unit(unitID):TimeToDie() > 10 then
                   -- TODO: Target enemy who meets the conditions
                   return A.KillShot:Show(icon)
                end
            end
            
            if A.DireBeast:IsTalentLearned() and A.DireBeast:IsReady(player) then
                return A.DireBeast:Show(icon)
            end
        
            if A.BarbedShot:IsTalentLearned() and A.BarbedShot:IsReady(unitID) and 
                (Unit(player):HasBuffs(A.CalloftheWild.ID) > 0 or
                MultiUnits:GetByRangeAreaTTD(44) < 9 or
                (A.WildCall:IsTalentLearned() and A.BarbedShot:GetSpellChargesFrac() > 1.2) or
                A.Savagery:IsTalentLearned()) then
                -- TODO: Target lowest barb shot remained
                return A.BarbedShot:Show(icon)
            end
        
            if A.KillCommand:IsTalentLearned() and A.KillCommand:IsReady(unitID, true) then
                return A.KillCommand:Show(icon)
            end
        
            if A.Multishot:IsTalentLearned() and A.Multishot:IsReady(unitID) and Unit(player):HasBuffs(A.BeastCleavePlayerBuff.ID) < GetGCD() * 2 then
                return A.Multishot:Show(icon)
            end
        
            if A.LightsJudgment:IsReady(unitID) and (not Unit(player):HasBuffs(A.BestialWrath.ID) or Unit(unitID):TimeToDie() < 5) then
                return A.LightsJudgment:Show(icon)
            end
        
            if A.KillShot:IsTalentLearned() and A.KillShot:IsReady(unitID) then
                return A.KillShot:Show(icon)
            end
        
            if A.CobraShot:IsTalentLearned() and A.CobraShot:IsReady(unitID) and Player:FocusTimeToMax() < GetGCD() * 2 then
                return A.CobraShot:Show(icon)
            end
        
            if A.BagofTricks:IsReady(unitID) and (not Unit(player):HasBuffs(A.BestialWrath.ID) or Unit(unitID):TimeToDie() < 5) then
                return A.BagofTricks:Show(icon)
            end
        
            if A.ArcaneTorrent:IsReady(unitID) and (Player:Focus() + Player:FocusRegen() + 30) < Player:FocusMax() then
                return A.ArcaneTorrent:Show(icon)
            end
        end
        
        -- [[ Single Target ]]
        local function ST()
            if A.BarbedShot:IsTalentLearned() and A.BarbedShot:IsReady(unitID) and 
                (
                    Unit("pet"):HasBuffs(A.Frenzy.ID) <= GetGCD() + 0.25 or 
                    Unit("pet"):HasBuffsStacks(A.Frenzy.ID) < 3 and 
                    (
                        (A.ScentOfBlood:IsTalentLearned() and (A.BestialWrath:IsReady(player) or A.CalloftheWild:IsReady(player))) or
                        not A.BestialWrath:IsReady(player)
                    )
                ) 
            then
                -- TODO: Target least buff duration on enemy unit
                return A.BarbedShot:Show(icon)
            end
        
            if A.BestialWrath:IsTalentLearned() and A.BestialWrath:IsReady(player) then
                return A.BestialWrath:Show(icon)
            end
        
            if A.KillCommand:IsTalentLearned() and A.KillCommand:IsReady(player) and 
                (
                    (A.KillCommand:GetSpellChargesFullRechargeTime() < GetGCD() and A.AlphaPredator:IsTalentLearned()) or 
                    A.CalloftheWild:IsTalentLearned()
                ) 
            then
                return A.KillCommand:Show(icon)
            end
        
            if A.DireBeast:IsTalentLearned() and A.DireBeast:IsReady(player) and 
                (
                    A.HuntmastersCall:IsTalentLearned() and 
                    (
                        ((not Unit(player):HasBuffs(A.BestialWrath.ID)) and A.KillerCobra:IsTalentLearned()) or 
                        A.CalloftheWild:IsReady(player)
                    )
                ) 
            then
                return A.DireBeast:Show(icon)
            end
        
            if A.KillShot:IsTalentLearned() and A.KillShot:IsReady(unitID) and A.VenomsBite:IsTalentLearned() and 
                Unit(unitID):HasDeBuffs(A.SerpentSting.ID, true) < GetGCD() 
            then
                -- TODO: Target least buff duration on enemy unit
                return A.KillShot:Show(icon)
            end
        
            if A.CalloftheWild:IsTalentLearned() and A.CalloftheWild:IsReady(player) then
                return A.CalloftheWild:Show(icon)
            end
        
            if A.Bloodshed:IsTalentLearned() and A.Bloodshed:IsReady(player) then
                return A.Bloodshed:Show(icon)
            end
        
            if A.KillCommand:IsTalentLearned() and A.KillCommand:IsReady(player) then
                return A.KillCommand:Show(icon)
            end
        
            if A.BarbedShot:IsTalentLearned() and A.BarbedShot:IsReady(unitID) and 
                (
                    (A.WildCall:IsTalentLearned() and A.BarbedShot:GetSpellChargesFrac() > 1.4) or 
                    Unit(player):HasBuffs(A.CalloftheWild.ID) > 0 or 
                    (A.BarbedShot:GetSpellChargesFullRechargeTime() < GetGCD() and A.BestialWrath:GetCooldown() > 0) or 
                    (A.ScentOfBlood:IsTalentLearned() and A.BestialWrath:GetCooldown() < 12 + GetGCD()) or 
                    A.Savagery:IsTalentLearned() or 
                    MultiUnits:GetByRangeAreaTTD(44) < 9
                ) 
            then
                -- TODO: Target lowest barb shot remained
                return A.BarbedShot:Show(icon)
            end
        
            if A.CobraShot:IsTalentLearned() and A.CobraShot:IsReady(unitID) and Unit(player):HasBuffs(A.BestialWrath.ID) and A.KillerCobra:IsTalentLearned() then
                return A.CobraShot:Show(icon)
            end
        
            if A.DireBeast:IsTalentLearned() and A.DireBeast:IsReady(player) then
                return A.DireBeast:Show(icon)
            end
        
            if A.ExplosiveShot:IsTalentLearned() and A.ExplosiveShot:IsReady(unitID) and 
                (
                    (not Unit(player):HasBuffs(A.BestialWrath.ID) and A.KillerCobra:IsTalentLearned()) or 
                    not A.KillerCobra:IsTalentLearned()
                ) 
            then
                return A.ExplosiveShot:Show(icon)
            end
        
            if A.KillShot:IsTalentLearned() and A.KillShot:IsReady(unitID) and 
                (
                    Unit(player):HasBuffs(A.HuntersPrey.ID) < GetGCD() * 2
                ) 
            then
                return A.KillShot:Show(icon)
            end
        
            if A.LightsJudgment:IsReady(unitID) and 
                (
                    Unit(player):HasBuffs(A.BestialWrath.ID) == 0 or 
                    Unit(unitID):TimeToDie() < 5
                ) 
            then
                return A.LightsJudgment:Show(icon)
            end
        
            if A.CobraShot:IsTalentLearned() and A.CobraShot:IsReady(unitID) then
                return A.CobraShot:Show(icon)
            end
        
            if A.BagofTricks:IsReady(unitID) and 
                (
                    Unit(player):HasBuffs(A.BestialWrath.ID) == 0 or 
                    Unit(unitID):TimeToDie() < 5
                ) 
            then
                return A.BagofTricks:Show(icon)
            end
        
            if A.ArcanePulse:IsReady(unitID) and 
                (
                    Unit(player):HasBuffs(A.BestialWrath.ID) == 0 or 
                    Unit(unitID):TimeToDie() < 5
                ) 
            then
                return A.ArcanePulse:Show(icon)
            end
        
            if A.ArcaneTorrent:IsReady(unitID) and 
                (
                    Player:Focus() + Player:FocusRegen() + 15 < Player:FocusMax()
                ) 
            then
                return A.ArcaneTorrent:Show(icon)
            end
        end

        -- CDs need to re enable isBurst once fixed
        if CDs() and isBurst then 
            return true 
        end

        if ActiveEnemies() < 2 or (not A.BeastCleave:IsTalentLearned() and ActiveEnemies() < 3) then
            --Single Target
            if ST() then
                return true
            end
        end

        if ActiveEnemies() > 2 or (not A.BeastCleave:IsTalentLearned() and ActiveEnemies() > 3) then
            if Cleave() then
                return true
            end
        end

        -- GiftofNaaru
        if A.GiftoftheNaaru:AutoRacial(player) and Unit(player):TimeToDie() < 10 then 
            return A.GiftoftheNaaru:Show(icon)
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

