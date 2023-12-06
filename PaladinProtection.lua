local _G, setmetatable, pairs, type, math = _G, setmetatable, pairs, type, math
local huge = math.huge
local TMW = _G.TMW
local Action = _G.Action
local CONST = Action.Const
local Listener = Action.Listener
local Create = Action.Create
local GetToggle = Action.GetToggle
local GetLatency = Action.GetLatency
local GetGCD = Action.GetGCD
local GetCurrentGCD = Action.GetCurrentGCD
local ShouldStop = Action.ShouldStop
local BurstIsON = Action.BurstIsON
local AuraIsValid = Action.AuraIsValid
local InterruptIsValid = Action.InterruptIsValid
local DetermineUsableObject = Action.DetermineUsableObject
local Utils = Action.Utils
local BossMods = Action.BossMods
local TeamCache = Action.TeamCache
local EnemyTeam = Action.EnemyTeam
local FriendlyTeam = Action.FriendlyTeam
local LoC = Action.LossOfControl
local Player = Action.Player
local MultiUnits = Action.MultiUnits
local UnitCooldown = Action.UnitCooldown
local Unit = Action.Unit
local IsUnitEnemy = Action.IsUnitEnemy
local IsUnitFriendly = Action.IsUnitFriendly
local DisarmIsReady = Action.DisarmIsReady
local Azerite = LibStub("AzeriteTraits")
local ACTION_CONST_PALADIN_PROTECTION = CONST.PALADIN_PROTECTION
local ACTION_CONST_AUTOTARGET = CONST.AUTOTARGET
local ACTION_CONST_SPELLID_FREEZING_TRAP = CONST.SPELLID_FREEZING_TRAP
local IsIndoors, UnitIsUnit = _G.IsIndoors, _G.UnitIsUnit

--Some test shit
plist={}

Action[ACTION_CONST_PALADIN_PROTECTION] = {
    -- Racial Abilities:
    ArcaneTorrent = Create({Type = "Spell", ID = 50613}),
    BloodFury = Create({Type = "Spell", ID = 20572}),
    Fireblood = Create({Type = "Spell", ID = 265221}),
    AncestralCall = Create({Type = "Spell", ID = 274738}),
    Berserking = Create({Type = "Spell", ID = 26297}),
    ArcanePulse = Create({Type = "Spell", ID = 260364}),
    QuakingPalm = Create({Type = "Spell", ID = 107079}),
    Haymaker = Create({Type = "Spell", ID = 287712}),
    WarStomp = Create({Type = "Spell", ID = 20549}),
    BullRush = Create({Type = "Spell", ID = 255654}),
    BagofTricks = Create({Type = "Spell", ID = 312411}),
    GiftofNaaru = Create({Type = "Spell", ID = 59544}),
    LightsJudgment = Create({Type = "Spell", ID = 255647}),
    Shadowmeld = Create({Type = "Spell", ID = 58984}), -- usable in Action Core
    Stoneform = Create({Type = "Spell", ID = 20594}),
    WilloftheForsaken = Create({Type = "Spell", ID = 7744}), -- usable in Action Core
    EscapeArtist = Create({Type = "Spell", ID = 20589}), -- usable in Action Core
    EveryManforHimself = Create({Type = "Spell", ID = 59752}), -- usable in Action Core
    Regeneratin = Create({Type = "Spell", ID = 291944}), -- not usable in APL but user can Queue it

    -- Supportive:
    Redemption = Create({Type = "Spell", ID = 7328}),
    BlessingOfProtection = Create({Type = "Spell", ID = 1022}),
    BlessingOfFreedom = Action.Create({ Type = "Spell", ID = 1044     }),
    BlessingOfFreedomYellow = Action.Create({ Type = "Spell", ID = 1044, Color = "YELLOW", Desc = "YELLOW Color for Party Blessing"     }),

    -- Finishers:
    DivineStorm = Create({Type = "Spell", ID = 53385}),
    TemplarsVerdict = Create({Type = "Spell", ID = 85256}),
    -- Cool Downs:
    AvengingWrath = Create({Type = "Spell", ID = 31884}),
    Crusade = Create({Type = "Spell", ID = 231895, isTalent = true}),
    LayonHands = Create({Type = "Spell", ID = 633}),
    GuardianofAncientKings = Create({Type = "Spell", ID = 86659}),
    ArdentDefender = Create({Type = "Spell", ID = 31850}),
    FinalStand = Create({Type = "Spell", ID = 204077}),
    DivineShield = Create({Type = "Spell", ID = 642}),
    -- Covenent Abilities:
    DivineToll = Create({Type = "Spell", ID = 304971}),
    VanquishersHammer = Create({Type = "Spell", ID = 328204}),
    AshenHallow = Create({Type = "Spell", ID = 316958}),
    -- Kick:
    Rebuke = Create({Type = "Spell", ID = 96231}),
    HammerofJustice = Create({Type = "Spell", ID = 853}),
    HammerofJusticeGreen = Action.Create({ Type = "SpellSingleColor", ID = 853, Color = "GREEN", Desc = "[1] CC", QueueForbidden = true }),
    -- Primary Abilities:
    WakeOfAshes = Create({Type = "Spell", ID = 255937}),
    CrusaderStrike = Create({Type = "Spell", ID = 35395}),
    Judgement = Create({Type = "Spell", ID = 20271}),
    Consecration = Create({Type = "Spell", ID = 26573}),
    BladeofJustice = Create({Type = "Spell", ID = 184575}),
    HammerOfWrath = Create({Type = "Spell", ID = 24275}),
    Seraphim = Create({Type = "Spell", ID = 152262}),
    ExecutionSentence = Create({Type = "Spell", ID = 343527}),
    ShieldOfVengeance = Create({Type = "Spell", ID = 184662}),
    HolyAvenger = Create({Type = "Spell", ID = 105809}),
    FinalReckoning = Create({Type = "Spell", ID = 343721}),
    AvengersShield = Create({Type = "Spell", ID = 31935}),
    HammeroftheRighteous = Create({Type = "Spell", ID = 53595}),
    BlessedHammer = Create({Type = "Spell", ID = 204019}),
    ShieldoftheRighteous = Create({Type = "Spell", ID = 53600}),
    ShieldoftheRighteousBuff = Create({Type = "Spell", ID = 132403}),
    DivinePurpose = Create({Type = "Spell", ID = 223817}),
    WordofGlory = Create({Type = "Spell", ID = 85673}),
    FlashOfLight = Create({Type = "Spell", ID = 19750}),
    -- Passives:
    Forbearance = Create({Type = "Spell", ID = 25771}),
    ShiningLight = Create({Type = "Spell", ID = 327510}),
    -- Movement:
    Charge = Create({Type = "Spell", ID = 100}),
    Intervene = Create({Type = "Spell", ID = 3411}),
    -- Taunt:
    HandofReckoning = Create({Type = "Spell", ID = 62124}),
    -- Items:
    PotionofUnbridledFury = Create({Type = "Potion", ID = 169299}),
    GalecallersBoon = Create({Type = "Trinket", ID = 159614}),
    LustrousGoldenPlumage = Create({Type = "Trinket", ID = 159617}),
    PocketsizedComputationDevice = Create({Type = "Trinket", ID = 167555}),
    AshvanesRazorCoral = Create({Type = "Trinket", ID = 169311}),
    AzsharasFontofPower = Create({Type = "Trinket", ID = 169314}),
    RemoteGuidanceDevice = Create({Type = "Trinket", ID = 169769}),
    WrithingSegmentofDrestagath = Create({Type = "Trinket", ID = 173946}),
    DribblingInkpod = Create({Type = "Trinket", ID = 169319}),
    -- Gladiator Badges/Medallions:
    DreadGladiatorsMedallion = Create({Type = "Trinket", ID = 161674}),
    DreadCombatantsInsignia = Create({Type = "Trinket", ID = 161676}),
    DreadCombatantsMedallion = Create({Type = "Trinket", ID = 161811, Hidden = true}), -- Game has something incorrect with displaying this
    DreadGladiatorsBadge = Create({Type = "Trinket", ID = 161902}),
    DreadAspirantsMedallion = Create({Type = "Trinket", ID = 162897}),
    DreadAspirantsBadge = Create({Type = "Trinket", ID = 162966}),
    SinisterGladiatorsMedallion = Create({Type = "Trinket", ID = 165055}),
    SinisterGladiatorsBadge = Create({Type = "Trinket", ID = 165058}),
    SinisterAspirantsMedallion = Create({Type = "Trinket", ID = 165220}),
    SinisterAspirantsBadge = Create({Type = "Trinket", ID = 165223}),
    NotoriousGladiatorsMedallion = Create({Type = "Trinket", ID = 167377}),
    NotoriousGladiatorsBadge = Create({Type = "Trinket", ID = 167380}),
    NotoriousAspirantsMedallion = Create({Type = "Trinket", ID = 167525}),
    NotoriousAspirantsBadge = Create({Type = "Trinket", ID = 167528}),
    -- LegendaryPowers:
    CadenceofFujieda = Create({Type = "Spell", ID = 335555, Hidden = true}),
    Deathmaker = Create({Type = "Spell", ID = 335567, Hidden = true}),
    Leaper = Create({Type = "Spell", ID = 335214, Hidden = true}),
    MisshapenMirror = Create({Type = "Spell", ID = 335253, Hidden = true}),
    RecklessDefense = Create({Type = "Spell", ID = 335582, Hidden = true}),
    SeismicReverberation = Create({Type = "Spell", ID = 335758, Hidden = true}),
    SignetofTormentedKings = Create({Type = "Spell", ID = 335266, Hidden = true}),
    WilloftheBerserker = Create({Type = "Spell", ID = 335594, Hidden = true}),
    -- Hidden:
    SiegebreakerDebuff = Create({Type = "Spell", ID = 280773, Hidden = true}), -- Simcraft
    EnrageBuff = Create({Type = "Spell", ID = 184362, Hidden = true}), -- Simcraft
    MeatCleaverBuff = Create({Type = "Spell", ID = 85739, Hidden = true}), -- Simcraft
    RecklessAbandon = Create({Type = "Spell", ID = 202751, Hidden = true, isTalent = true}), -- Talent
    Seethe = Create({Type = "Spell", ID = 335091, Hidden = true, isTalent = true}), -- Talent
    Cruelty = Create({Type = "Spell", ID = 335070, Hidden = true, isTalent = true}), -- Talent
    -- Auras:
    DevotionAura = Create({Type = "Spell", ID = 465}),
    RetributionAura = Create({Type = "Spell", ID = 317906}), -- Rank 2
    CrusaderAura = Create({Type = "Spell", ID = 32223}),
    ConcentrationAura = Create({Type = "Spell", ID = 317920}),
    -- Mitigation:
    CleanseToxins = Action.Create({Type = "Spell", ID = 213644}),
    -- Testing party target for BoP
    Fireblood = Action.Create({ Type = "Spell", ID = 265221	}), -- Party1
    WarStomp = Action.Create({ Type = "Spell", ID = 20549	}), -- Party2
    GiftofNaaru  = Action.Create({ Type = "Spell", ID = 59544	}), -- Party3
    Stoneform = Action.Create({ Type = "Spell", ID = 20594    })  -- Party4

}
Action:CreateEssencesFor(ACTION_CONST_PALADIN_PROTECTION)
local A = setmetatable(Action[ACTION_CONST_PALADIN_PROTECTION], {__index = Action})
local player = "player"
local Temp = {
    TotalAndPhys = {"TotalImun", "DamagePhysImun"},
    TotalAndCC = {"TotalImun", "CCTotalImun"},
    TotalAndMagKick = {"TotalImun", "DamageMagicImun", "KickImun"},
    TotalAndPhysKick = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMagPhys = {"TotalImun", "DamageMagicImun", "DamagePhysImun"},
    DisablePhys = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    BerserkerRageLoC = {"FEAR", "INCAPACITATE"},
    IsSlotTrinketBlocked = {}
}
do
    -- Push IsSlotTrinketBlocked
    for key, val in pairs(Action[ACTION_CONST_PALADIN_PROTECTION]) do
        if type(val) == "table" and val.Type == "Trinket" then
            Temp.IsSlotTrinketBlocked[val.ID] = true
        end
    end
end
-- [1] CC AntiFake Rotation
local function AntiFakeStun(unitID)
    return IsUnitEnemy(unitID) and Unit(unitID):GetRange() <= 10 and Unit(unitID):IsControlAble("stun") and
        A.HammerofJusticeGreen:AbsentImun(unitID, Temp.TotalAndPhysAndCCAndStun, true)
end
A[1] = function(icon)
    if A.HammerofJusticeGreen:IsReady(nil, true, nil, true) and AntiFakeStun("target") then
        return A.HammerofJusticeGreen:Show(icon)
    end
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
            if not notKickAble and A.Rebuke:IsReady(unitID, nil, nil, true) and A.Rebuke:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then
                return A.Rebuke:Show(icon)
            end
        end
    end
end
local function countInterruptGCD(unitID)
    if not A.Rebuke:IsReadyByPassCastGCD(unitID) or not A.Rebuke:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then
        return true
    end
end
local function Interrupts(unitID, icon)
    isInterrupt = select(9, UnitCastingInfo("target"))
    if A.GetToggle(2, "SnSInterruptList") and (IsInRaid() or A.InstanceInfo.KeyStone > 1) then 
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, "SnS_ShadowlandsContent", true, countInterruptGCD(unitID))
    else
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unitID, nil, nil, countInterruptGCD(unitID))
    end

    if castRemainsTime >= A.GetLatency() then
        if useKick then
            -- Try Avengers Shield first for maximum DPS/TPS:
            if A.AvengersShield:IsReady(unitID) then
                return A.AvengersShield:Show(icon)
            end
            if useKick and not notInterruptable and A.Rebuke:IsReady(unitID) and A.Rebuke:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then 
                return A.Rebuke:Show(icon)
            end
           -- if A.HammerofJustice:IsReady(unitID) and A.HammerofJustice:AbsentImun(unitID, Temp.TotalAndCC, true) and Unit(unitID):IsControlAble("stun", 0) then
               -- return A.HammerofJustice:Show(icon)
          --  end
        end
        if useCC then
            if A.HammerofJustice:IsReady(unitID) and A.HammerofJustice:AbsentImun(unitID, Temp.TotalAndCC, true) and  Unit(unitID):IsControlAble("stun", 0) then
                return A.HammerofJustice:Show(icon)
            end
        end
        if useRacial then
            if A.ArcaneTorrent:AutoRacial(unitID) then
                return A.ArcaneTorrent:Show(icon)
            end

            if A.QuakingPalm:AutoRacial(unitID) then
                return A.QuakingPalm:Show(icon)
            end

            if A.Haymaker:AutoRacial(unitID) then
                return A.Haymaker:Show(icon)
            end

            if A.WarStomp:AutoRacial(unitID) then
                return A.WarStomp:Show(icon)
            end
            if A.BullRush:AutoRacial(unitID) then
                return A.BullRush:Show(icon)
            end
        end
    end
end

local function UseItems(unitID)
    if
        A.Trinket1:IsReady(unitID) and A.Trinket1:GetItemCategory() ~= "DEFF" and
            not Temp.IsSlotTrinketBlocked[A.Trinket1.ID] and
            A.Trinket1:AbsentImun(unitID, Temp.TotalAndMagPhys)
     then
        return A.Trinket1
    end

    if
        A.Trinket2:IsReady(unitID) and A.Trinket2:GetItemCategory() ~= "DEFF" and
            not Temp.IsSlotTrinketBlocked[A.Trinket2.ID] and
            A.Trinket2:AbsentImun(unitID, Temp.TotalAndMagPhys)
     then
        return A.Trinket2
    end
end

A[3] = function(icon) -- Single Target Rotation
    --local EnemyRotation, FriendlyRotation
    local isMoving = Player:IsMoving() -- @boolean
    local inCombat = Unit(player):CombatTime() -- @number
    local inAoE = GetToggle(2, "AoE") -- @boolean
    local inDisarm = LoC:Get("DISARM") > 0 -- @boolean
    local inMelee = false -- @boolean
    local configuredCombatAura = A.GetToggle(2, "PallyCombatAura")
    local configuredNonCombatAura = A.GetToggle(2, "PallyOutOfCombatAura")
    local nearbyEnemies = A.MultiUnits:GetByRangeAreaTTD(10) -- How many enemies are within X Yardss.
    local inPvP = A.IsInPvP
    local BoPPartyMembers = A.GetToggle(2, "BoP Party Members")

        -------------------------------------------------------------------------------
        -- HealthStone Healing
        -------------------------------------------------------------------------------
        if not Player:IsStealthed() then     
            -- Healthstone | AbyssalHealingPotion
            local Healthstone = GetToggle(1, "HealthStone") 
            if Healthstone >= 0 then 
                if A.HS:IsReady(player) then                     
                    if Healthstone >= 100 then -- AUTO 
                        if Unit(player):TimeToDie() <= 9 and Unit(player):HealthPercent() <= 40 then                      
                            return A.HS:Show(icon)
                        end 
                    elseif Unit(player):HealthPercent() <= Healthstone then              
                        return A.HS:Show(icon)                             
                    end
                elseif A.Zone ~= "arena" and (A.Zone ~= "pvp" or not A.InstanceInfo.isRated) and A.SpiritualHealingPotion:IsReady(player) then 
                    if Healthstone >= 100 then -- AUTO 
                        if Unit(player):TimeToDie() <= 9 and Unit(player):HealthPercent() <= 40 and Unit(player):HealthDeficit() >= A.SpiritualHealingPotion:GetItemDescription()[1] then               
                            return A.AbyssalHealingPotion:Show(icon)
                        end 
                    elseif Unit(player):HealthPercent() <= Healthstone then             
                        return A.AbyssalHealingPotion:Show(icon)                         
                    end                
                end 
            end
        end

    function SetAuras()
        if not Player:IsMounted() and not Player:IsStealthed() then
            -- Validate Correct Combat Aura in place:
            if configuredCombatAura == 1 and Unit(player):HasBuffs(A.CrusaderAura.ID) == 0 then
                return A.CrusaderAura:Show(icon)
            end

            if configuredCombatAura == 2 and Unit(player):HasBuffs(A.DevotionAura.ID) == 0 then
                return A.DevotionAura:Show(icon)
            end

            if configuredCombatAura == 3 and Unit(player):HasBuffs(A.ConcentrationAura.ID) == 0 then
                return A.ConcentrationAura:Show(icon)
            end

            if configuredCombatAura == 4 and Unit(player):HasBuffs(A.RetributionAura.ID) == 0 then
                return A.RetributionAura:Show(icon)
            end
        else
            if configuredNonCombatAura == 1 and Unit(player):HasBuffs(A.CrusaderAura.ID) == 0 then
                return A.CrusaderAura:Show(icon)
            end

            if configuredNonCombatAura == 2 and Unit(player):HasBuffs(A.DevotionAura.ID) == 0 then
                return A.DevotionAura:Show(icon)
            end

            if configuredNonCombatAura == 3 and Unit(player):HasBuffs(A.ConcentrationAura.ID) == 0 then
                return A.ConcentrationAura:Show(icon)
            end

            if configuredNonCombatAura == 4 and Unit(player):HasBuffs(A.RetributionAura.ID) == 0 then
                return A.RetributionAura:Show(icon)
            end
        end
    end

    function outofCombatHealing()
        if not Player:IsStealthed() and not Player:IsMounted() and inCombat == 0 then
            if GetNumGroupMembers() <= 1 then -- Solo
                if Unit(player):HealthPercent() < A.GetToggle(2, "PallySoloOutOfCombatHealingHealthPercent") then    
                    if A.WordofGlory:IsReady(player, true) then
                        return A.WordofGlory:Show(icon)
                    end

                    if isMoving == false and A.FlashOfLight:IsReady(player, true) then
                        return A.FlashOfLight:Show(icon)
                    end
                
                end
            else -- Party
                if Unit(player):HealthPercent() < A.GetToggle(2, "PallyGroupOutOfCombatHealingHealthPercent") then
                    if A.WordofGlory:IsReady(player, true) then
                        return A.WordofGlory:Show(icon)
                    end

                    if isMoving == false and A.FlashOfLight:IsReady(player, true) then
                        return A.FlashOfLight:Show(icon)
                    end
                end
            end
        end
    end

    -- Rotations:
    function EnemyRotation(unitID)
        if not IsUnitEnemy(unitID) then
            return
        end
        if Unit(unitID):IsDead() then
            return
        end
        if UnitCanAttack(player, unitID) == false then
            return
        end

        -- Variables:
        local isBurst = BurstIsON(unitID)
        local inMelee = A.CrusaderStrike:IsInRange(unitID)
        
        local function shouldCastDivineShield()      
            if inPvP then
                if 
                    Unit(player):HealthPercent() <= A.GetToggle(2, "PallyPvpDivineShieldHealth") and
                    Unit(player):HasDeBuffs(A.Forbearance.ID) == 0 and A.DivineShield:IsReady(unitID, true) then
                    return A.DivineShield:Show(icon)
                end
            else
                -- If your solo divine shield is OK to cast, however in party it will drop threat. 
                if GetNumGroupMembers() <= 1 and Unit(player):HealthPercent() <= A.GetToggle(2, "PallyFinalStandHealth") and Unit(player):HasDeBuffs(A.Forbearance.ID) == 0 and A.DivineShield:IsReady(unitID, true) then
                    return A.DivineShield:Show(icon)
                end
                if A.FinalStand:IsTalentLearned() and Unit(player):HealthPercent() <= A.GetToggle(2, "PallyFinalStandHealth") and Unit(player):HasDeBuffs(A.Forbearance.ID) == 0 and A.DivineShield:IsReady(unitID, true) then
                    return A.DivineShield:Show(icon)
                end
            end
        end

        local function castAshenHallow()
            if A.AshenHallow:IsReady("player") then
                return A.AshenHallow:Show(icon)
            end
        end

        local function shouldCastDivineToll()
            if A.DivineToll:IsReady(unitID, true) and Unit(unitID):GetRange() <= 6 then
                return A.DivineToll:Show(icon)
            end
        end

        local function shouldCastWordOfGlory()
            if A.WordofGlory:IsReady(unitID, true) and Unit(player):HasBuffs(A.ShiningLight.ID) > 0 and Unit(player):HealthPercent() <= A.GetToggle(2, "PallyWordOfGloryHealthShiningLight") then
                return A.WordofGlory:Show(icon)
            end
            
            -- Word of Glory consumption of Holy Power can reduce uptime on Shield of Righteous so better to cast when free. 
            if A.WordofGlory:IsReady(unitID, true) and Unit(player):HealthPercent() <= A.GetToggle(2, "PallyWordOfGloryHealth") then
                return A.WordofGlory:Show(icon)
            end
        end

        local function Mitigation()
            -- Priority: Word of Glory, Argent Defender, Guardian of Ancient Kings, Lay on Hands

            if shouldCastWordOfGlory() then
                return true
            end

            if
                A.ArdentDefender:IsReady(unitID, true) and
                    Unit(player):HealthPercent() <= A.GetToggle(2, "PallyArgentDefenderHealth")
             then
                return A.ArdentDefender:Show(icon)
            end

            if
                A.GuardianofAncientKings:IsReady(unitID, true) and
                    Unit(player):HealthPercent() <= A.GetToggle(2, "PallyGuardianOfAncientKingsHealth")
             then
                return A.GuardianofAncientKings:Show(icon)
            end

            if
                A.LayonHands:IsReady(unitID, true) and
                    Unit(player):HealthPercent() <= A.GetToggle(2, "PallyLayOnHandsHealth") and
                    Unit(player):HasDeBuffs(A.Forbearance.ID) == 0
             then
                return A.LayonHands:Show(icon)
            end

            if shouldCastDivineShield() then
                return true
            end

            -- Cleanse Check: 
            if A.GetToggle(2, "PallyCleanse") == true and AuraIsValid(unitID, "UseDispel", "Dispel") and not UnitIsUnit("target", unitID) then
                return A.CleanseToxins:Show(icon)
            end
 
            if A.ShieldoftheRighteous:IsReady(unitID, true) and Unit(player):HasBuffs(A.DivinePurpose.ID) then
                return A.ShieldoftheRighteous:Show(icon)
             end
 
             if A.ShieldoftheRighteous:IsReady(unitID, true) and Player:HolyPower() >= 3 and Player:HasBuffs(A.ShieldoftheRighteousBuff.ID) <= 1 then
                 return A.ShieldoftheRighteous:Show(icon)
             end
 
             if A.ShieldoftheRighteous:IsReady(unitID, true) and Player:HolyPower() >= 3 then
                 return A.ShieldoftheRighteous:Show(icon)
             end

            if (LoC:Get("SLOW") ~= 0 or Unit(player):GetCurrentSpeed() > 0 and Unit(player):GetMaxSpeed() < 100) then
                return A.BlessingOfFreedom:Show(icon)
            end
        end

        local function CoolDowns()
            if A.AvengingWrath:IsReady(unitID, true) and Unit(unitID):GetRange() <= 6 then
                return A.AvengingWrath:Show(icon)
            end

            if A.Seraphim:IsReadyByPassCastGCD(unitID, true) then
                return A.Seraphim:Show(icon)
            end

            if shouldCastDivineToll() then
                return true
            end

            if castAshenHallow() then
                return true
            end

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
            --if A.GuardianofAncientKings:IsReady(unitID, true) and A.AvengingWrath:IsReady(unitID, true) and Unit(unitID):GetRange() <= 6 and Unit(player):HealthPercent() <= 40 then
            --    return A.GuardianofAncientKings:Show(icon)
            --end
        end

        local function SingleTarget()
            if A.Consecration:IsReady(unitID, true) and Unit(unitID):GetRange() <= 5 and
                    Unit(player):HasBuffs(A.Consecration.ID) == 0 and
                    isMoving == A.GetToggle(2, "ConsecrationWhileMoving")
             then
                return A.Consecration:Show(icon)
            end

            if A.HandofReckoning:IsReady(unitID, true) and Unit(unitID):GetRange() > 5 and
                    Unit(unitID):GetRange() <= A.GetToggle(2, "PallyHandOfReckoningMaxRange")
             then
                return A.HandofReckoning:Show(icon)
            end

            if A.Judgement:IsReady(unitID, true) and Unit(unitID):GetRange() <= A.GetToggle(2, "PallyJudgementMaxRange") then
                return A.Judgement:Show(icon)
            end

            if A.HammerOfWrath:IsReady(unitID, true) and
                    Unit(unitID):GetRange() <= A.GetToggle(2, "PallyHammerOfWrathMaxRange")
             then
                return A.HammerOfWrath:Show(icon)
            end

            if A.AvengersShield:IsReady(unitID, true) and
                    Unit(unitID):GetRange() <= A.GetToggle(2, "PallyAvengersShieldMaxRange")
             then
                return A.AvengersShield:Show(icon)
            end

            if A.HammeroftheRighteous:IsReady(unitID, true) and Unit(unitID):GetRange() <= 8 then
                return A.HammeroftheRighteous:Show(icon)
            end

            if A.BlessedHammer:IsReady(unitID, true) and Unit(unitID):GetRange() <= 8 then
                return A.BlessedHammer:Show(icon)
            end

            if A.Consecration:IsReady(unitID, true) and Unit(unitID):GetRange() <= 5 and
                    Unit(player):HasBuffs(A.Consecration.ID) ~= 0 and
                    isMoving == A.GetToggle(2, "ConsecrationWhileMoving")
             then
                return A.Consecration:Show(icon)
            end
        end

        local function MultiTarget()
            if A.Consecration:IsReady(unitID, true) and Unit(unitID):GetRange() <= 5 and
                    Unit(player):HasBuffs(A.Consecration.ID) == 0 and
                    isMoving == A.GetToggle(2, "ConsecrationWhileMoving")
             then
                return A.Consecration:Show(icon)
            end

            if A.AvengersShield:IsReady(unitID, true) and
                    Unit(unitID):GetRange() <= A.GetToggle(2, "PallyAvengersShieldMaxRange")
             then
                return A.AvengersShield:Show(icon)
            end

            if A.Judgement:IsReady(unitID, true) and Unit(unitID):GetRange() <= A.GetToggle(2, "PallyJudgementMaxRange") then
                return A.Judgement:Show(icon)
            end

            if A.HammerOfWrath:IsReady(unitID, true) and
                    Unit(unitID):GetRange() <= A.GetToggle(2, "PallyHammerOfWrathMaxRange")
             then
                return A.HammerOfWrath:Show(icon)
            end

            if A.HammeroftheRighteous:IsReady(unitID, true) and Unit(unitID):GetRange() <= 8 then
                return A.HammeroftheRighteous:Show(icon)
            end

            if A.BlessedHammer:IsReady(unitID, true) and Unit(unitID):GetRange() <= 8 then
                return A.BlessedHammer:Show(icon)
            end

            if A.Consecration:IsReady(unitID, true) and Unit(unitID):GetRange() <= 5 and
                    Unit(player):HasBuffs(A.Consecration.ID) ~= 0 and
                    isMoving == A.GetToggle(2, "ConsecrationWhileMoving")
             then
                return A.Consecration:Show(icon)
            end
        end

        -- PVP vs PVE ::
        if A.IsInPvP == false then -- PVE Mode
            if isBurst and CoolDowns() then
                return true
            end

            if Mitigation() then return true end

            if Interrupts(unitID, icon) then return true end
            
            if nearbyEnemies > A.GetToggle(2, "PallyAoeEnemyCount") - 1 then
                if MultiTarget() then return true end
            else
                if SingleTarget() then return true end
            end

            -- GiftofNaaru
            if A.GiftofNaaru:AutoRacial(player) and Unit(player):TimeToDie() < 10 then
                return A.GiftofNaaru:Show(icon)
            end
        else

            if isBurst and CoolDowns() then
                return true
            end

            if Mitigation() then
                return true
            end

            if Interrupts(unitID, icon) then
                return true
            end

            if SingleTarget() then
                return true
            end
            -- GiftofNaaru
            if A.GiftofNaaru:AutoRacial(player) and Unit(player):TimeToDie() < 10 then
                return A.GiftofNaaru:Show(icon)
            end
        end
    end

    function FriendlyRotation(unitID)
        if inCombat == 0 then
            if Unit(unitID):IsDead() and Unit(unitID):IsPlayer() and (UnitInRaid(unitID) or UnitInParty(unitID)) and not IsPlayerMoving() and not IsUnitEnemy(unitID) then
                return A.Redemption:Show(icon)
            end

            if A.FlashOfLight:IsReady(unitID) and Unit(unitID):HealthPercent() <= A.GetToggle(2, "PallyGroupOutOfCombatHealingHealthPercent") then 
                return A.FlashOfLight:Show(icon)
            end
        end

        if A.WordofGlory:IsReady(unitID) and Unit(unitID):HealthPercent() <= A.GetToggle(2, "PallyWordOfGloryHealth") then
            return A.WordofGlory:Show(icon)
        end
        
        if A.BlessingOfProtection:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.Forbearance.ID, true) == 0 and Unit(unitID):HealthPercent() <= A.GetToggle(2, "PallyBoPAllies") and Unit(unitID):IsPlayer() and (UnitInRaid(unitID) or UnitInParty(unitID)) and not IsUnitEnemy(unitID) then
			return A.BlessingOfProtection:Show(icon)
        end
    end


    if SetAuras() then return true end

    -- Setup Target and proper Rotation: Friendly vs Enemy:
    if A.IsUnitFriendly("mouseover") then
        unitId = "mouseover"
        if FriendlyRotation(unitID) then
            return true
        end
    end

    if A.IsUnitFriendly("target") then
        unitID = "target"
        if FriendlyRotation(unitID) then
            return true
        end
    end
   
    if IsUnitEnemy("target") then
        unitID = "target"
        if EnemyRotation(unitID) then 
            return true
        end
    end
    
    -- Heal after combat:
    if outofCombatHealing() then return true end

end
A[4] = function(icon) 

end

A[5] = nil
A[6] = nil
A[7] = nil
A[8] = nil
