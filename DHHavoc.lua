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

local ACTION_CONST_DEMONHUNTER_HAVOC             = CONST.DEMONHUNTER_HAVOC
local ACTION_CONST_AUTOTARGET                = CONST.AUTOTARGET
local ACTION_CONST_SPELLID_FREEZING_TRAP    = CONST.SPELLID_FREEZING_TRAP

local IsIndoors, UnitIsUnit                    = _G.IsIndoors, _G.UnitIsUnit



Action[ACTION_CONST_DEMONHUNTER_HAVOC] = {
    -- Util
    TargetEnemy                           = Create({ Type = "Spell", ID = 133015 }),
    StartAttack                           = Create({ Type = "Spell", ID = 134310 }),
    StopCasting                           = Create({ Type = "Spell", ID = 319458 }),
    Healthpot                           = Create({ Type = "Spell", ID = 967532  }),
    DamagePotion                           = Create({ Type = "Spell", ID = 176108  }),
    Trinket1                                = Create({ Type = "Spell", ID = 1030902  }),
    Trinket2                             = Create({ Type = "Spell", ID = 1030910  }),

    -- Racial
    ArcaneTorrent                         = Create({ Type = "Spell", ID = 50613 }),

    -- Abilities
    Glide                                 = Create({ Type = "Spell", ID = 131347 }),
    ImmolationAura                        = Create({ Type = "Spell", ID = 258920 }),

    -- Talents
    ChaosNova                             = Create({ Type = "Spell", ID = 179057, IsTalent = true }),
    CollectiveAnguish                     = Create({ Type = "Spell", ID = 390152, IsTalent = true }),
    Demonic                               = Create({ Type = "Spell", ID = 213410, IsTalent = true }),
    --SigilofSpite                          = Create({ Type = "Spell", ID = 390163, IsTalent = true }),
    Felblade                              = Create({ Type = "Spell", ID = 232893, IsTalent = true }),
    FirstoftheIllidari                    = Create({ Type = "Spell", ID = 235893, IsTalent = true }),
    FoddertotheFlame                      = Create({ Type = "Spell", ID = 391429, IsTalent = true }),
    QuickenedSigils                       = Create({ Type = "Spell", ID = 209281, IsTalent = true }),
    SoulSigils                            = Create({ Type = "Spell", ID = 395446, IsTalent = true }),
    StudentofSuffering                    = Create({ Type = "Spell", ID = 452412, IsTalent = true }),
    TheHunt                               = Create({ Type = "Spell", ID = 370965, IsTalent = true }),
    UnhinderedAssault                     = Create({ Type = "Spell", ID = 444931, IsTalent = true }),
    VengefulRetreat                       = Create({ Type = "Spell", ID = 198793, IsTalent = true }),

    -- Sigils
    SigilofChains                         = Create({ Type = "Spell", ID = 202138 }),
    SigilofChains2                         = Create({ Type = "Spell", ID = 389807 }),
    SigilofFlame                          = Create({ Type = "Spell", ID = 204598 }), -- Maybe 204596
    SigilofFlame2                          = Create({ Type = "Spell", ID = 389810 }),
    SigilofMisery                         = Create({ Type = "Spell", ID = 207684 }),
    SigilofMisery2                         = Create({ Type = "Spell", ID = 389813 }),
    SigilofSilence                        = Create({ Type = "Spell", ID = 202137 }),
    SigilofSilence2                        = Create({ Type = "Spell", ID = 389809 }),

    -- Utility
    Disrupt                               = Create({ Type = "Spell", ID = 183752 }),

    -- Debuffs
    -- SigilofFlameDebuff                    = Create({ Type = "Spell", ID = 204598 }),
    SigilofMiseryDebuff                   = Create({ Type = "Spell", ID = 207685 }),

    -- Other
    Pool                                  = Create({ Type = "Spell", ID = 999910 }),

    -- Talents
    ReaversGlaive                         = Create({ Type = "Spell", ID = 442294, IsTalent = true }),

    -- Buffs
    ArtoftheGlaiveBuff                    = Create({ Type = "Spell", ID = 444661 }),
    GlaiveFlurryBuff                      = Create({ Type = "Spell", ID = 442435 }),
    ReaversGlaiveBuff                     = Create({ Type = "Spell", ID = 444764 }),
    ThrilloftheFightAtkBuff               = Create({ Type = "Spell", ID = 442695 }),
    ThrilloftheFightDmgBuff               = Create({ Type = "Spell", ID = 442688 }),

    -- Debuffs
    ReaversMarkDebuff                     = Create({ Type = "Spell", ID = 442624 }),

    -- Abilities
    ConsumingFire                         = Create({ Type = "Spell", ID = 452487 }),
    FelDesolation                         = Create({ Type = "Spell", ID = 452486 }),
    SigilofDoom                           = Create({ Type = "Spell", ID = 452490 }),
    SoulSunder                            = Create({ Type = "Spell", ID = 452436 }),
    SpiritBurst                           = Create({ Type = "Spell", ID = 452437 }),

    -- Talents
    Demonsurge                            = Create({ Type = "Spell", ID = 454402, IsTalent = true }),

    -- Buffs
    StudentofSufferingBuff                = Create({ Type = "Spell", ID = 453239 }),

    -- Debuffs
    SigilofDoomDebuff                     = Create({ Type = "Spell", ID = 462030 }),

    -- Abilities
    Annihilation                          = Create({ Type = "Spell", ID = 201427 }),
    BladeDance                            = Create({ Type = "Spell", ID = 188499 }),
    Blur                                  = Create({ Type = "Spell", ID = 198589 }),
    ChaosStrike                           = Create({ Type = "Spell", ID = 162794 }),
    DeathSweep                            = Create({ Type = "Spell", ID = 210152 }),
    DemonsBite                            = Create({ Type = "Spell", ID = 162243 }),
    FelRush                               = Create({ Type = "Spell", ID = 195072, IsTalent = true }),
    Metamorphosis                         = Create({ Type = "Spell", ID = 191427, IsTalent = true }),
    ThrowGlaive                           = Create({ Type = "Spell", ID = 185123, IsTalent = true }),

    -- Talents
    AFireInside                           = Create({ Type = "Spell", ID = 427775, IsTalent = true }),
    AnyMeansNecessary                     = Create({ Type = "Spell", ID = 388114, IsTalent = true }),
    BlindFury                             = Create({ Type = "Spell", ID = 203550, IsTalent = true }),
    BurningWound                          = Create({ Type = "Spell", ID = 391189, IsTalent = true }),
    ChaosTheory                           = Create({ Type = "Spell", ID = 389687, IsTalent = true }),
    ChaoticTransformation                 = Create({ Type = "Spell", ID = 388112, IsTalent = true }),
    CycleofHatred                         = Create({ Type = "Spell", ID = 258887, IsTalent = true }),
    DemonBlades                           = Create({ Type = "Spell", ID = 203555, IsTalent = true }),
    EssenceBreak                          = Create({ Type = "Spell", ID = 258860, IsTalent = true }),
    EyeBeam                               = Create({ Type = "Spell", ID = 198013, IsTalent = true }),
    FelBarrage                            = Create({ Type = "Spell", ID = 258925, IsTalent = true }),
    FelEruption                           = Create({ Type = "Spell", ID = 211881, IsTalent = true }),
    FirstBlood                            = Create({ Type = "Spell", ID = 206416, IsTalent = true }),
    FuriousGaze                           = Create({ Type = "Spell", ID = 343311, IsTalent = true }),
    FuriousThrows                         = Create({ Type = "Spell", ID = 393029, IsTalent = true }),
    GlaiveTempest                         = Create({ Type = "Spell", ID = 342817, IsTalent = true }),
    Inertia                               = Create({ Type = "Spell", ID = 427640, IsTalent = true }),
    Initiative                            = Create({ Type = "Spell", ID = 388108, IsTalent = true }),
    InnerDemon                            = Create({ Type = "Spell", ID = 389693, IsTalent = true }),
    IsolatedPrey                          = Create({ Type = "Spell", ID = 388113, IsTalent = true }),
    Momentum                              = Create({ Type = "Spell", ID = 206476, IsTalent = true }),
    Ragefire                              = Create({ Type = "Spell", ID = 388107, IsTalent = true }),
    RestlessHunter                        = Create({ Type = "Spell", ID = 390142, IsTalent = true }),
    SerratedGlaive                        = Create({ Type = "Spell", ID = 390154, IsTalent = true }),
    ShatteredDestiny                      = Create({ Type = "Spell", ID = 388116, IsTalent = true }),
    Soulrend                              = Create({ Type = "Spell", ID = 388106, IsTalent = true }),
    TacticalRetreat                       = Create({ Type = "Spell", ID = 389688, IsTalent = true }),
    TrailofRuin                           = Create({ Type = "Spell", ID = 258881, IsTalent = true }),
    UnboundChaos                          = Create({ Type = "Spell", ID = 347461, IsTalent = true }),

    -- Buffs
    ChaosTheoryBuff                       = Create({ Type = "Spell", ID = 390195 }),
    FuriousGazeBuff                       = Create({ Type = "Spell", ID = 343312 }),
    InertiaBuff                           = Create({ Type = "Spell", ID = 427641 }),
    InitiativeBuff                        = Create({ Type = "Spell", ID = 391215 }),
    InnerDemonBuff                        = Create({ Type = "Spell", ID = 390145 }),
    MetamorphosisBuff                     = Create({ Type = "Spell", ID = 162264 }),
    MomentumBuff                          = Create({ Type = "Spell", ID = 208628 }),
    TacticalRetreatBuff                   = Create({ Type = "Spell", ID = 389890 }),
    UnboundChaosBuff                      = Create({ Type = "Spell", ID = 347462 }),

    -- Debuffs
    BurningWoundDebuff                    = Create({ Type = "Spell", ID = 391191 }),
    EssenceBreakDebuff                    = Create({ Type = "Spell", ID = 320338 }),
    SerratedGlaiveDebuff                  = Create({ Type = "Spell", ID = 390155 }),

    -- Items
    WitherbarksBranch                     = Create({ Type = "Trinket", ID = 109999 }),

    -- Set Boni
    T31Boni_2p                               = Create({ Type = "Spell", ID = 422857, isHidden = true}),
}

Action:CreateEssencesFor(ACTION_CONST_DEMONHUNTER_HAVOC)
local A = setmetatable(Action[ACTION_CONST_DEMONHUNTER_HAVOC], { __index = Action })

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
    for key, val in pairs(Action[ACTION_CONST_DEMONHUNTER_HAVOC]) do 
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
            if not notKickAble and A.Disrupt:IsReady(unitID, nil, nil, true) and A.Disrupt:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then
                return A.Disrupt:Show(icon)                                                  
            end                   
        end 
    end                                                                                 
end

local function countInterruptGCD(unitID)
    if not A.Disrupt:IsReadyByPassCastGCD(unitID) or not A.Disrupt:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then 
        return true 
    end 
end 

local function Interrupts(unitID)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime = InterruptIsValid(unitID,  nil, nil, countInterruptGCD(unitID))    
    
    -- Can waste interrupt action due delays caused by ping, interface input 
    if castRemainsTime < GetLatency() then 
        return 
    end 
    
    if useKick and not notInterruptable and A.Disrupt:IsReady(unitID) then 
        return A.Disrupt
    end         
end

local function UseItem1(unitID)
    if A.Trinket1:IsReady(unitID) and A.Trinket1:GetItemCategory() ~= "DEFF" and not Temp.IsSlotTrinketBlocked[A.Trinket1.ID] and A.Trinket1:AbsentImun(unitID, Temp.TotalAndMagPhys) then 
        return A.Trinket1:Show(icon)
    end 
end

local function UseItem2(unitID)
    if A.Trinket2:IsReady(unitID) and A.Trinket2:GetItemCategory() ~= "DEFF" and not Temp.IsSlotTrinketBlocked[A.Trinket2.ID] and A.Trinket2:AbsentImun(unitID, Temp.TotalAndMagPhys) then 
        return A.Trinket2(icon)
    end
end

local function CurrentActiveEnemies(range)
    return MultiUnits:GetByRangeinCombat(range)
end

local function MultiCountCondition()

    return false
end

local function BossCondition(unitID)
    return Unit(unitID):IsBoss()
end

local function isMelee(unitID)
    return A.ChaosStrike:IsReady(unitID) and A.ChaosStrike:IsInRange(unitID) or A.Annihilation:IsReady(unitID) and A.Annihilation:IsRange(unitID)
end

-- [3] Single Rotation
A[3] = function(icon)
    --local EnemyRotation, FriendlyRotation
    local isMoving             = Player:IsMoving()                    -- @boolean 
    local inCombat             = Unit(player):CombatTime()            -- @number 
    local inAoE                = GetToggle(2, "AoE")                -- @boolean 
    local inDisarm            = LoC:Get("DISARM") > 0                -- @boolean


    -- Rotations 
    function EnemyRotation(unitID)    
        if not IsUnitEnemy(unitID) then return end
        if Unit(unitID):IsDead() then return end
        if UnitCanAttack(player, unitID) == false then return end
        local isMelee               = isMelee(unitID)
        local disrupt = Interrupts(unitID)
        if disrupt then
            return A.Disrupt:Show(icon)
        end
        local isBurst            = BurstIsON(unitID)
        
        -- Purge
        if A.ArcaneTorrent:AutoRacial(unitID) then 
            return A.ArcaneTorrent:Show(icon)
        end

        -- [[ CDs ]]
        local function CDs(unitID)
            -- actions.cooldown=metamorphosis,if=(!talent.initiative|cooldown.vengeful_retreat.remains)&((!talent.demonic|prev_gcd.1.death_sweep|prev_gcd.2.death_sweep|prev_gcd.3.death_sweep)&cooldown.eye_beam.remains&(!talent.essence_break|debuff.essence_break.up)&buff.fel_barrage.down&(raid_event.adds.in>40|(raid_event.adds.remains>8|!talent.fel_barrage)&active_enemies>2)|!talent.chaotic_transformation|fight_remains<30)
            if isMelee and A.Metamorphosis:IsReady(unitID) and 
                (
                    (not A.Initiative:IsTalentLearned() or A.VengefulRetreat:GetCooldown() > 0) and 
                    ((not A.Demonic:IsTalentLearned() or A.DeathSweep:GetSpellTimeSinceLastCast() < GetGCD() * 3) and 
                    A.EyeBeam:GetCooldown() > 0 and (not A.EssenceBreak:IsTalentLearned() or Unit(unitID):HasDeBuffs(A.EssenceBreak.ID) and Unit(player):HasBuffs(A.FelBarrage.ID) == 0 and (not isBurst or MultiUnits:GetByRangeAreaTTD(25) < 30)) )
                ) then 
                return A.Metamorphosis:Show(icon)
            end

            -- actions.cooldown+=/potion,if=fight_remains<35|buff.metamorphosis.up
            -- if A.Potion:IsReady(unitID) and (Unit(Player):HasBuffs(A.MetamorphosisBuff.ID) > 0) then
            --     return A.Potion:Show(icon)
            -- end


            -- actions.cooldown+=/use_item,name=witherbarks_branch,if=(talent.essence_break&cooldown.essence_break.remains<gcd.max|!talent.essence_break)&(active_enemies+3>=desired_targets+raid_event.adds.count|raid_event.adds.in>105)|fight_remains<25
            local trinketSlot1ID = GetInventoryItemID("player", 13)
            local trinketSlot2ID = GetInventoryItemID("player", 14)
            if isBurst and isMelee and trinketSlot1ID and trinketSlot1ID == A.WitherbarksBranch.ID then
                if ((A.EssenceBreak:IsTalentLearned() and A.EssenceBreak:GetCooldown() < GetGCD()) or not A.EssenceBreak:IsTalentLearned()) then
                    return A.Trinket1:Show()
                end
            elseif isBurst and isMelee and trinketSlot2ID and trinketSlot2ID == A.WitherbarksBranch.ID then
                if ((A.EssenceBreak:IsTalentLearned() and A.EssenceBreak:GetCooldown() < GetGCD()) or not A.EssenceBreak:IsTalentLearned()) then
                    return A.Trinket2:Show()
                end
            end

            -- actions.cooldown+=/use_item,slot=trinket1,use_off_gcd=1,if=((cooldown.eye_beam.remains<gcd.max&active_enemies>1|buff.metamorphosis.up)&(raid_event.adds.in>trinket.1.cooldown.duration-15|raid_event.adds.remains>8)|!trinket.1.has_buff.any|fight_remains<25)&(!equipped.witherbarks_branch|trinket.2.cooldown.remains>20)&time>0
            if isBurst and isMelee and (A.EyeBeam:GetCooldown() < GetGCD() or Unit(player):HasBuffs(A.MetamorphosisBuff.ID) > 0) then
                if UseItem1() then
                    return true
                end
            end

            -- actions.cooldown+=/use_item,slot=trinket2,use_off_gcd=1,if=((cooldown.eye_beam.remains<gcd.max&active_enemies>1|buff.metamorphosis.up)&(raid_event.adds.in>trinket.2.cooldown.duration-15|raid_event.adds.remains>8)|!trinket.2.has_buff.any|fight_remains<25)&(!equipped.witherbarks_branch|trinket.1.cooldown.remains>20)&time>0
            if isBurst and isMelee and (A.EyeBeam:GetCooldown() < GetGCD() or Unit(player):HasBuffs(A.MetamorphosisBuff.ID) > 0) then
                if UseItem2() then
                    return true
                end
            end
            
            -- actions.cooldown+=/the_hunt,if=debuff.essence_break.down&(active_enemies>=desired_targets+raid_event.adds.count|raid_event.adds.in>(1+!set_bonus.tier31_2pc)*45)&time>5
            if isBurst and A.TheHunt:IsReady(unitID) then
                if Unit(player):HasBuffs(A.EssenceBreak.ID) == 0 then
                    return A.TheHunt:Show(icon)
                end
            end
            
            -- actions.cooldown+=/sigil_of_spite,if=debuff.essence_break.down
            -- if A.SigilOfSpite:IsReady(unitID) then
            --     if Unit(player):HasBuffs(A.EssenceBreak.ID) == 0 then
            --         return A.SigilOfSpite:Show(icon)
            --     end
            -- end
        end

        local function Opener(unitID)
            -- actions.opener=use_items
            if UseItem1() or UseItem2() then
                return true
            end
        
            -- actions.opener+=/vengeful_retreat,if=prev_gcd.1.death_sweep
            if isMelee and A.VengefulRetreat:IsReady(unitID) and A.DeathSweep:GetSpellTimeSinceLastCast() < GetGCD() * 1.25 then
                return A.VengefulRetreat:Show(icon)
            end
        
            -- actions.opener+=/metamorphosis,if=prev_gcd.1.death_sweep|(!talent.chaotic_transformation)&(!talent.initiative|cooldown.vengeful_retreat.remains>2)|!talent.demonic
            if isBurst and isMelee and A.Metamorphosis:IsReady(unitID) and (A.DeathSweep:GetSpellTimeSinceLastCast() < GetGCD() * 1.25 or not A.ChaoticTransformation:IsTalentLearned() and (not A.Initiative:IsTalentLearned() or A.VengefulRetreat:GetCooldown() > 2) or not A.Demonic:IsTalentLearned()) then
                return A.Metamorphosis:Show(icon)
            end
        
            -- actions.opener+=/felblade,if=debuff.essence_break.down,line_cd=60
            if A.Felblade:IsReady(unitID) and Unit(player):HasBuffs(A.EssenceBreak.ID) == 0 then
                return A.Felblade:Show(icon)
            end
        
            -- actions.opener+=/potion
            -- if Potion:IsReady(unitID) then
            --     return Potion:Use()
            -- end
        
            -- actions.opener+=/immolation_aura,if=charges=2&buff.unbound_chaos.down&(buff.inertia.down|active_enemies>2)
            if isMelee and A.ImmolationAura:IsReady(unitID) and A.ImmolationAura:GetSpellCharges() == 2 and Unit(player):HasBuffs(A.UnboundChaos.ID) == 0 and (Unit(player):HasBuffs(A.Inertia.ID) == 0 or MultiUnits:GetByRange(8) > 2) then
                return A.ImmolationAura:Show(icon)
            end
        
            -- actions.opener+=/annihilation,if=buff.inner_demon.up&(!talent.chaotic_transformation|cooldown.metamorphosis.up)
            if isMelee and A.Annihilation:IsReady(unitID) and Unit(player):HasBuffs(A.InnerDemon.ID) > 0 and (not A.ChaoticTransformation:IsTalentLearned() or A.Metamorphosis:GetCooldown() == 0) then
                return A.Annihilation:Show(icon)
            end
        
            -- actions.opener+=/eye_beam,if=debuff.essence_break.down&buff.inner_demon.down&(!buff.metamorphosis.up|cooldown.blade_dance.remains)
            if isMelee and A.EyeBeam:IsReady(unitID) and Unit(player):HasBuffs(A.EssenceBreak.ID) == 0 and Unit(player):HasBuffs(A.InnerDemon.ID) > 0 and (Unit(player):HasBuffs(A.MetamorphosisBuff.ID) == 0 or A.BladeDance:GetCooldown() > 0) then
                return A.EyeBeam:Show(icon)
            end
        
            -- actions.opener+=/fel_rush,if=talent.inertia&(buff.inertia.down|active_enemies>2)&buff.unbound_chaos.up
            if A.FelRush:IsReady(unitID) and A.Inertia:IsTalentLearned() and (Unit(player):HasBuffs(A.Inertia.ID) == 0 or MultiUnits:GetByRange(8) > 2) and Unit(player):HasBuffs(A.UnboundChaos.ID) > 0 then
                return A.FelRush:Show(icon)
            end
        
            -- actions.opener+=/the_hunt,if=active_enemies>desired_targets|raid_event.adds.in>40+50*!set_bonus.tier31_2pc
            if isBurst and A.TheHunt:IsReady(unitID) then
                return A.TheHunt:Show(icon)
            end
        
            -- actions.opener+=/essence_break
            if isBurst and isMelee and A.EssenceBreak:IsReady(unitID) then
                return A.EssenceBreak:Show(icon)
            end
        
            -- actions.opener+=/death_sweep
            if isMelee and A.DeathSweep:IsReady(unitID) then
                return A.DeathSweep:Show(icon)
            end
        
            -- actions.opener+=/annihilation
            if isMelee and A.Annihilation:IsReady(unitID) then
                return A.Annihilation:Show(icon)
            end
        
            -- actions.opener+=/demons_bite
            if isMelee and A.DemonsBite:IsReady(unitID) and A.DemonBlades:IsTalentLearned() == false then
                return A.DemonsBite:Show(icon)
            end
        end
        
        local function FelBarageUsage(unitID)
            -- actions.fel_barrage+=/annihilation,if=buff.inner_demon.up
            if isBurst and isMelee and A.Annihilation:IsReady(unitID) and Unit(player):HasBuffs(A.InnerDemon.ID) > 0 then
                return A.Annihilation:Show(icon)
            end
        
            -- actions.fel_barrage+=/eye_beam,if=buff.fel_barrage.down&(active_enemies>1&raid_event.adds.up|raid_event.adds.in>40)
            if isMelee and A.EyeBeam:IsReady(unitID) and Unit(player):HasBuffs(A.FelBarrage.ID) == 0 then
                return A.EyeBeam:Show(icon)
            end
        
            -- actions.fel_barrage+=/essence_break,if=buff.fel_barrage.down&buff.metamorphosis.up
            if isBurst and isMelee and A.EssenceBreak:IsReady(unitID) and Unit(player):HasBuffs(A.FelBarrage.ID) == 0 and Unit(player):HasBuffs(A.MetamorphosisBuff.ID) > 0 then
                return A.EssenceBreak:Show(icon)
            end
        
            -- actions.fel_barrage+=/death_sweep,if=buff.fel_barrage.down
            if isMelee and A.DeathSweep:IsReady(unitID) and Unit(player):HasBuffs(A.FelBarrage.ID) == 0 then
                return A.DeathSweep:Show(icon)
            end
        
            -- actions.fel_barrage+=/immolation_aura,if=buff.unbound_chaos.down&(active_enemies>2|buff.fel_barrage.up)
            if isMelee and A.ImmolationAura:IsReady(unitID) and Unit(player):HasBuffs(A.UnboundChaos.ID) == 0 and (MultiUnits:GetByRange(8) > 2 or Unit(player):HasBuffs(A.FelBarrage.ID) > 0) then
                return A.ImmolationAura:Show(icon)
            end
        
            -- actions.fel_barrage+=/glaive_tempest,if=buff.fel_barrage.down&active_enemies>1
            if isMelee and A.GlaiveTempest:IsReady(unitID) and Unit(player):HasBuffs(A.FelBarrage.ID) > 0 then
                return A.GlaiveTempest:Show(icon)
            end
        
            -- actions.fel_barrage+=/blade_dance,if=buff.fel_barrage.down
            if isMelee and A.BladeDance:IsReady(unitID) and Unit(player):HasBuffs(A.FelBarrage.ID) == 0 then
                return A.BladeDance:Show(icon)
            end
        
            -- actions.fel_barrage+=/fel_barrage,if=fury>100&(raid_event.adds.in>90|raid_event.adds.in<gcd.max|raid_event.adds.remains>4&active_enemies>2)
            if isMelee and A.FelBarrage:IsReady(unitID) and Player:Fury() >= 100 then
                return A.FelBarrage:Show(icon)
            end
        
            -- actions.fel_barrage+=/metamorphosis,if=cooldown.eye_beam.remains>gcd.max&buff.metamorphosis.down
            if isBurst and isMelee and A.Metamorphosis:IsReady(unitID) and A.EyeBeam:GetCooldown() > GetGCD() and Unit(player):HasBuffs(A.MetamorphosisBuff.ID) == 0 then
                return A.Metamorphosis:Show(icon)
            end
        end

        local function MetaRotation(unitID)
            -- actions.meta=death_sweep,if=buff.metamorphosis.remains<gcd.max
            if isMelee and A.DeathSweep:IsReady(unitID) and Unit(player):HasBuffs(A.MetamorphosisBuff.ID) < GetGCD() then
                return A.DeathSweep:Show(icon)
            end
        
            -- actions.meta+=/annihilation,if=buff.metamorphosis.remains<gcd.max
            if isMelee and A.Annihilation:IsReady(unitID) and Unit(player):HasBuffs(A.MetamorphosisBuff.ID) < GetGCD() then
                return A.Annihilation:Show(icon)
            end
        
            -- actions.meta+=/fel_rush,if=buff.unbound_chaos.up&talent.inertia
            if A.FelRush:IsReady(unitID) and Unit(player):HasBuffs(A.UnboundChaos.ID) > 0 and A.Inertia:IsTalentLearned() and Unit(unitID):GetRange() >= 7 and Unit(unitID):GetRange() <= 18 then
                return A.FelRush:Show(icon)
            end
        
            -- actions.meta+=/fel_rush,if=talent.momentum&buff.momentum.remains<gcd.max*2
            if A.FelRush:IsReady(unitID) and A.Momentum:IsTalentLearned() and Unit(player):HasBuffs(A.Momentum.ID) < GetGCD() * 2 and Unit(unitID):GetRange() >= 7 and Unit(unitID):GetRange() <= 18 then
                return A.FelRush:Show(icon)
            end
        
            -- actions.meta+=/annihilation,if=buff.inner_demon.up&(cooldown.eye_beam.remains<gcd.max*3&cooldown.blade_dance.remains|cooldown.metamorphosis.remains<gcd.max*3)
            if isMelee and A.Annihilation:IsReady(unitID) and Unit(player):HasBuffs(A.InnerDemon.ID) > 0 and 
                (A.EyeBeam:GetCooldown() < GetGCD() * 3 and A.BladeDance:GetCooldown() > 0 or 
                 A.Metamorphosis:GetCooldown() < GetGCD() * 3) then
                return A.Annihilation:Show(icon)
            end
        
            -- actions.meta+=/essence_break,if=fury>20&(cooldown.metamorphosis.remains>10|cooldown.blade_dance.remains<gcd.max*2)&(buff.unbound_chaos.down|buff.inertia.up|!talent.inertia)|fight_remains<10
            if isBurst and isMelee and A.EssenceBreak:IsReady(unitID) and (Player:Fury() > 20 and 
                (A.Metamorphosis:GetCooldown() > 10 or A.BladeDance:GetCooldown() < GetGCD() * 2) and 
                (Unit(player):HasBuffs(A.UnboundChaos.ID) == 0 or Unit(player):HasBuffs(A.Inertia.ID) > 0 or not A.Inertia:IsTalentLearned()) or MultiUnits:GetByRangeAreaTTD(25) < 10) then
                return A.EssenceBreak:Show(icon)
            end
        
            -- actions.meta+=/immolation_aura,if=debuff.essence_break.down&cooldown.blade_dance.remains>gcd.max+0.5&buff.unbound_chaos.down&talent.inertia&buff.inertia.down&full_recharge_time+3<cooldown.eye_beam.remains&buff.metamorphosis.remains>5
            if isMelee and A.ImmolationAura:IsReady(unitID) and Unit(player):HasBuffs(A.EssenceBreak.ID) == 0 and 
                A.BladeDance:GetCooldown() > GetGCD() + 0.5 and Unit(player):HasBuffs(A.UnboundChaos.ID) == 0 and 
                A.Inertia:IsTalentLearned() and Unit(player):HasBuffs(A.Inertia.ID) == 0 and 
                A.ImmolationAura:GetSpellChargesFullRechargeTime() + 3 < A.EyeBeam:GetCooldown() and 
                Unit(player):HasBuffs(A.MetamorphosisBuff.ID) > 5 then
                return A.ImmolationAura:Show(icon)
            end
        
            -- actions.meta+=/death_sweep
            if isMelee and A.DeathSweep:IsReady(unitID) then
                return A.DeathSweep:Show(icon)
            end
        
            -- actions.meta+=/eye_beam,if=debuff.essence_break.down&buff.inner_demon.down
            if isMelee and A.EyeBeam:IsReady(unitID) and Unit(player):HasBuffs(A.EssenceBreak.ID) == 0 and Unit(player):HasBuffs(A.InnerDemon.ID) == 0 then
                return A.EyeBeam:Show(icon)
            end
        
            -- actions.meta+=/glaive_tempest,if=debuff.essence_break.down&(cooldown.blade_dance.remains>gcd.max*2|fury>60)&(active_enemies>=desired_targets+raid_event.adds.count|raid_event.adds.in>10)
            if isMelee and A.GlaiveTempest:IsReady(unitID) and Unit(player):HasBuffs(A.EssenceBreak.ID) == 0 and 
                (A.BladeDance:GetCooldown() > GetGCD() * 2 or Player:Fury() > 60) then
                return A.GlaiveTempest:Show(icon)
            end
        
            -- actions.meta+=/sigil_of_flame,if=active_enemies>2
            if isMelee and A.SigilofFlame:IsReady(player) and MultiUnits:GetByRange(8) > 2 then
                return A.SigilofFlame:Show(icon)
            end
        
            -- actions.meta+=/annihilation,if=cooldown.blade_dance.remains>gcd.max*2|fury>60|buff.metamorphosis.remains<5&cooldown.felblade.up
            if isMelee and A.Annihilation:IsReady(unitID) and 
                (A.BladeDance:GetCooldown() > GetGCD() * 2 or Player:Fury() > 60 or 
                Unit(player):HasBuffs(A.MetamorphosisBuff.ID) < 5 and A.Felblade:GetCooldown() == 0) then
                return A.Annihilation:Show(icon)
            end
        
            -- actions.meta+=/sigil_of_flame,if=buff.metamorphosis.remains>5
            if isMelee and A.SigilofFlame:IsReady(player) and Unit(player):HasBuffs(A.MetamorphosisBuff.ID) > 5 then
                return A.SigilofFlame:Show(icon)
            end
        
            -- actions.meta+=/felblade
            if A.Felblade:IsReady(unitID) then
                return A.Felblade:Show(icon)
            end
        
            -- actions.meta+=/sigil_of_flame,if=debuff.essence_break.down
            if isMelee and A.SigilofFlame:IsReady(player) and Unit(player):HasBuffs(A.EssenceBreak.ID) == 0 then
                return A.SigilofFlame:Show(icon)
            end
        
            -- actions.meta+=/immolation_aura,if=buff.out_of_range.down&recharge_time<(cooldown.eye_beam.remains<?buff.metamorphosis.remains)&(active_enemies>=desired_targets+raid_event.adds.count|raid_event.adds.in>full_recharge_time)
            if isMelee and A.ImmolationAura:IsReady(unitID) and 
                A.ImmolationAura:GetSpellChargesFullRechargeTime() < math.min(A.EyeBeam:GetCooldown(), Unit(player):HasBuffs(A.MetamorphosisBuff.ID)) then
                return A.ImmolationAura:Show(icon)
            end
        
            -- actions.meta+=/fel_rush,if=talent.momentum
            if A.FelRush:IsReady(unitID) and A.Momentum:IsTalentLearned() and Unit(unitID):GetRange() >= 7 and Unit(unitID):GetRange() <= 18 then
                return A.FelRush:Show(icon)
            end
        
            -- actions.meta+=/fel_rush,if=buff.unbound_chaos.down&recharge_time<cooldown.eye_beam.remains&debuff.essence_break.down&(cooldown.eye_beam.remains>8|charges_fractional>1.01)&buff.out_of_range.down
            if A.FelRush:IsReady(unitID) and Unit(player):HasBuffs(A.UnboundChaos.ID) == 0 and 
                A.FelRush:GetSpellChargesFullRechargeTime() < A.EyeBeam:GetCooldown() and 
                Unit(player):HasBuffs(A.EssenceBreak.ID) == 0 and 
                (A.EyeBeam:GetCooldown() > 8 or A.FelRush:ChargesFractional() > 1.01) and Unit(unitID):GetRange() >= 7 and Unit(unitID):GetRange() <= 18 then
                return A.FelRush:Show(icon)
            end
        
            -- actions.meta+=/demons_bite
            if isMelee and A.DemonsBite:IsReady(unitID) and A.DemonBlades:IsTalentLearned() == false then
                return A.DemonsBite:Show(icon)
            end
        end

        -- actions=auto_attack,if=!buff.out_of_range.up
        --if not Player:IsAttacking() then
        --    return A.StartAttack:Show(icon)
        --end

        -- actions+=/retarget_auto_attack,line_cd=1,target_if=min:debuff.burning_wound.remains,if=talent.burning_wound&talent.demon_blades&active_dot.burning_wound<(spell_targets>?3)

        -- actions+=/retarget_auto_attack,line_cd=1,target_if=min:!target.is_boss,if=talent.burning_wound&talent.demon_blades&active_dot.burning_wound=(spell_targets>?3)

        -- actions+=/call_action_list,name=cooldown
        if CDs(unitID) and isBurst then 
            return true 
        end

        -- actions+=/fel_rush,if=buff.unbound_chaos.up&buff.unbound_chaos.remains<gcd.max*2
        if A.FelRush:IsReady(unitID, true) and Unit(unitID):GetRange() >= 5 and Unit(unitID):GetRange() <= 18 and 
            (
                Unit(player):HasBuffs(A.UnboundChaos.ID) > 0 and Unit(player):HasBuffs(A.UnboundChaos.ID) < GetGCD() * 2
            ) then
            return A.FelRush:Show(icon)
        end

        -- actions+=/run_action_list,name=opener,if=(cooldown.eye_beam.up|cooldown.metamorphosis.up)&time<15&(raid_event.adds.in>40)
        if isMelee and (A.EyeBeam:IsReady(unitID) or A.Metamorphosis:IsReady(unitID)) and inCombat < 15 and Opener(unitID) then
            return true
        end

        -- actions+=/run_action_list,name=fel_barrage,if=variable.fel_barrage&raid_event.adds.up
        if FelBarageUsage(unitID) then
            return true
        end

        -- actions+=/immolation_aura,if=active_enemies>2&talent.ragefire&buff.unbound_chaos.down&(!talent.fel_barrage|cooldown.fel_barrage.remains>recharge_time)&debuff.essence_break.down
        if isMelee and A.ImmolationAura:IsReady(unitID) and MultiUnits:GetByRange(8) > 2 and A.Ragefire:IsTalentLearned() and Unit(player):HasBuffs(A.UnboundChaos.ID) == 0 and 
            (not A.FelBarrage:IsTalentLearned() or A.FelBarrage:GetCooldown() > A.ImmolationAura:GetSpellChargesFullRechargeTime()) and 
            Unit(player):HasBuffs(A.EssenceBreak.ID) == 0 then
            return A.ImmolationAura:Show(icon)
        end

        -- actions+=/immolation_aura,if=active_enemies>2&talent.ragefire&raid_event.adds.up&raid_event.adds.remains<15&raid_event.adds.remains>5&debuff.essence_break.down
        if isMelee and A.ImmolationAura:IsReady(unitID) and MultiUnits:GetByRange(8) > 2 and A.Ragefire:IsTalentLearned() and 
            Unit(player):HasBuffs(A.EssenceBreak.ID) == 0 then
            return A.ImmolationAura:Show(icon)
        end

        -- actions+=/fel_rush,if=buff.unbound_chaos.up&active_enemies>2&(!talent.inertia|cooldown.eye_beam.remains+2>buff.unbound_chaos.remains)
        if A.FelRush:IsReady(unitID) and Unit(player):HasBuffs(A.UnboundChaos.ID) > 0 and MultiUnits:GetByRange(8) > 2 and Unit(unitID):GetRange() >= 7 and Unit(unitID):GetRange() <= 18 and 
            (not A.Inertia:IsTalentLearned() or A.EyeBeam:GetCooldown() + 2 > Unit(player):HasBuffs(A.UnboundChaos.ID) > 0) then
            return A.FelRush:Show(icon)
        end

        -- actions+=/vengeful_retreat,use_off_gcd=1,if=talent.initiative&(cooldown.eye_beam.remains>15&gcd.remains<0.3|gcd.remains<0.1&cooldown.eye_beam.remains<=gcd.remains&(cooldown.metamorphosis.remains>10|cooldown.blade_dance.remains<gcd.max*2))&time>4
        if isMelee and A.VengefulRetreat:IsReady(unitID) and A.Initiative:IsTalentLearned() and 
        ((A.EyeBeam:GetCooldown() > 15 and Player:GCDRemains() < 0.3) or 
            (Player:GCDRemains() < 0.1 and A.EyeBeam:GetCooldown() <= Player:GCDRemains() and 
            (A.Metamorphosis:GetCooldown() > 10 or A.BladeDance:GetCooldown() < GetGCD() * 2))) and 
            inCombat > 4 then
            return A.VengefulRetreat:Show(icon)
        end
        
        -- actions+=/run_action_list,name=meta,if=buff.metamorphosis.up
        if (Unit(player):HasBuffs(A.MetamorphosisBuff.ID) > 0) and MetaRotation(unitID) then
            return true
        end

        -- actions+=/fel_rush,if=buff.unbound_chaos.up&talent.inertia&buff.inertia.down&cooldown.blade_dance.remains<4&cooldown.eye_beam.remains>5&(action.immolation_aura.charges>0|action.immolation_aura.recharge_time+2<cooldown.eye_beam.remains|cooldown.eye_beam.remains>buff.unbound_chaos.remains-2)
        if A.FelRush:IsReady(unitID) and Unit(unitID):GetRange() >= 5 and Unit(unitID):GetRange() <= 18 and Unit(player):HasBuffs(A.UnboundChaos.ID) and A.Inertia:IsTalentLearned() and Unit(unitID):GetRange() >= 7 and Unit(unitID):GetRange() <= 18 and 
            Unit(player):HasBuffs(A.Inertia.ID) == 0 and A.BladeDance:GetCooldown() < 4 and A.EyeBeam:GetCooldown() > 5 and 
            (A.ImmolationAura:GetSpellCharges() > 0 or A.ImmolationAura:GetSpellChargesFullRechargeTime() + 2 < A.EyeBeam:GetCooldown() or 
            A.EyeBeam:GetCooldown() > Unit(player):HasBuffs(A.UnboundChaos.ID) - 2) then
            return A.FelRush:Show(icon)
        end

        -- actions+=/fel_rush,if=talent.momentum&cooldown.eye_beam.remains<gcd.max*2
        if A.FelRush:IsReady(unitID) and Unit(unitID):GetRange() >= 5 and Unit(unitID):GetRange() <= 18 and A.Momentum:IsTalentLearned() and A.EyeBeam:GetCooldown() < GetGCD() * 2 and Unit(unitID):GetRange() >= 7 and Unit(unitID):GetRange() <= 18 then
            return A.FelRush:Show(icon)
        end

        -- actions+=/eye_beam,if=!talent.essence_break&(!talent.chaotic_transformation|cooldown.metamorphosis.remains<5+3*talent.shattered_destiny|cooldown.metamorphosis.remains>15)&(active_enemies>desired_targets*2|raid_event.adds.in>30-talent.cycle_of_hatred.rank*13)
        if isMelee and A.EyeBeam:IsReady(unitID) and not A.EssenceBreak:IsTalentLearned() and 
            (not A.ChaoticTransformation:IsTalentLearned() or A.Metamorphosis:GetCooldown() < 5 + 3 * A.ShatteredDestiny:GetTalentRank() or A.Metamorphosis:GetCooldown() > 15) and 
            MultiUnits:GetByRange(8) > 2 then
            return A.EyeBeam:Show(icon)
        end

        -- actions+=/eye_beam,if=talent.essence_break&(cooldown.essence_break.remains<gcd.max*2+5*talent.shattered_destiny|talent.shattered_destiny&cooldown.essence_break.remains>10)&(cooldown.blade_dance.remains<7|raid_event.adds.up)&(!talent.initiative|cooldown.vengeful_retreat.remains>10|raid_event.adds.up)&(active_enemies+3>=desired_targets+raid_event.adds.count|raid_event.adds.in>30-talent.cycle_of_hatred.rank*6)&(!talent.inertia|buff.unbound_chaos.up|action.immolation_aura.charges=0&action.immolation_aura.recharge_time>5)&(!raid_event.adds.up|raid_event.adds.remains>8)|fight_remains<10
        if isMelee and A.EyeBeam:IsReady(unitID) and (A.EssenceBreak:IsTalentLearned() and 
            (A.EssenceBreak:GetCooldown() < GetGCD() * 2 + 5 * A.ShatteredDestiny:GetTalentRank() or (A.ShatteredDestiny:IsTalentLearned() and A.EssenceBreak:GetCooldown() > 10)) and 
            (A.BladeDance:GetCooldown() < 7) and 
            (not A.Initiative:IsTalentLearned() or A.VengefulRetreat:GetCooldown() > 10) and 
            (MultiUnits:GetByRange(8) > 2) and 
            (not A.Inertia:IsTalentLearned() or Unit(player):HasBuffs(A.UnboundChaos.ID) > 0 or (A.ImmolationAura:GetSpellCharges() == 0 and A.ImmolationAura:GetSpellChargesFullRechargeTime() > 5))
            or MultiUnits:GetByRangeAreaTTD(25) < 10) then
            return A.EyeBeam:Show(icon)
        end

        -- actions+=/blade_dance,if=cooldown.eye_beam.remains>gcd.max|cooldown.eye_beam.up
        if isMelee and A.BladeDance:IsReady(unitID) and (A.EyeBeam:GetCooldown() > GetGCD() or A.EyeBeam:IsReady(unitID)) then
            return A.BladeDance:Show(icon)
        end

        -- actions+=/glaive_tempest,if=active_enemies>=desired_targets+raid_event.adds.count|raid_event.adds.in>10
        if isMelee and A.GlaiveTempest:IsReady(unitID) and (MultiUnits:GetByRange(8) >= 2) then
            return A.GlaiveTempest:Show(icon)
        end

        -- actions+=/sigil_of_flame,if=active_enemies>3
        if isMelee and A.SigilofFlame:IsReady(player) and MultiUnits:GetByRange(8) > 3 then
            return A.SigilofFlame:Show(icon)
        end

        -- actions+=/chaos_strike,if=debuff.essence_break.up
        if isMelee and A.ChaosStrike:IsReady(unitID) and Unit(unitID):HasDeBuffs(A.EssenceBreak.ID) > 0 then
            return A.ChaosStrike:Show(icon)
        end

        -- actions+=/felblade
        if A.Felblade:IsReady(unitID) then
            return A.Felblade:Show(icon)
        end

        -- actions+=/throw_glaive,if=full_recharge_time<=cooldown.blade_dance.remains&cooldown.metamorphosis.remains>5&talent.soulscar&set_bonus.tier31_2pc
        if A.ThrowGlaive:IsReady(unitID) and A.ThrowGlaive:GetSpellChargesFullRechargeTime() <= A.BladeDance:GetCooldown() and 
            A.Metamorphosis:GetCooldown() > 5 and A.Soulrend:IsTalentLearned() and Unit(player):HasBuffs(A.T31Boni_2p.ID) then
            return A.ThrowGlaive:Show(icon)
        end

        -- actions+=/throw_glaive,if=!set_bonus.tier31_2pc&(active_enemies>1|talent.soulscar)
        if A.ThrowGlaive:IsReady(unitID) and Unit(player):HasBuffs(A.T31Boni_2p.ID) == 0 and (MultiUnits:GetByRange(15) > 1 or A.Soulrend:IsTalentLearned()) then
            return A.ThrowGlaive:Show(icon)
        end

        -- actions+=/chaos_strike,if=cooldown.eye_beam.remains>gcd.max*2|fury>80
        if isMelee and A.ChaosStrike:IsReady(unitID) and (A.EyeBeam:GetCooldown() > GetGCD() * 2 or Player:Fury() > 80) then
            return A.ChaosStrike:Show(icon)
        end

        -- actions+=/immolation_aura,if=!talent.inertia&(raid_event.adds.in>full_recharge_time|active_enemies>desired_targets&active_enemies>2)
        if isMelee and A.ImmolationAura:IsReady(unitID) and not A.Inertia:IsTalentLearned() and 
            ( MultiUnits:GetByRange(8) > 2) then
            return A.ImmolationAura:Show(icon)
        end

        -- actions+=/sigil_of_flame,if=buff.out_of_range.down&debuff.essence_break.down&(!talent.fel_barrage|cooldown.fel_barrage.remains>25|(active_enemies=1&!raid_event.adds.exists))
        if isMelee and A.SigilofFlame:IsReady(player) and Unit(player):HasBuffs(A.EssenceBreak.ID) == 0 and 
            (not A.FelBarrage:IsTalentLearned() or A.FelBarrage:GetCooldown() > 25 or (isMelee and MultiUnits:GetByRange(25) == 1)) then
            return A.SigilofFlame:Show(icon)
        end

        -- actions+=/demons_bite
        if isMelee and A.DemonsBite:IsReady(unitID)  and A.DemonBlades:IsTalentLearned() == false then
            return A.DemonsBite:Show(icon)
        end

        -- actions+=/fel_rush,if=buff.unbound_chaos.down&recharge_time<cooldown.eye_beam.remains&debuff.essence_break.down&(cooldown.eye_beam.remains>8|charges_fractional>1.01)
        if A.FelRush:IsReady(unitID) and Unit(player):HasBuffs(A.UnboundChaos.ID) == 0 and Unit(unitID):GetRange() >= 7 and Unit(unitID):GetRange() <= 18 and 
            A.FelRush:GetSpellChargesFullRechargeTime() < A.EyeBeam:GetCooldown() and 
            Unit(player):HasBuffs(A.EssenceBreak.ID) == 0 and 
            (A.EyeBeam:GetCooldown() > 8 or A.FelRush:ChargesFractional() > 1.01) then
            return A.FelRush:Show(icon)
        end

        -- actions+=/arcane_torrent,if=buff.out_of_range.down&debuff.essence_break.down&fury<100
        if isMelee and A.ArcaneTorrent:IsReady(unitID) and 
            Unit(player):HasBuffs(A.EssenceBreak.ID) == 0 and Player:Fury() < 100 then
            return A.ArcaneTorrent:Show(icon)
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

