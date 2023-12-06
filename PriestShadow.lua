local _G, setmetatable							= _G, setmetatable
local A                         			    = _G.Action
local Covenant									= _G.LibStub("Covenant")
local TMW										= _G.TMW
local Listener									= Action.Listener
local Create									= Action.Create
local GetToggle									= Action.GetToggle
local SetToggle									= Action.SetToggle
local GetGCD									= Action.GetGCD
local GetCurrentGCD								= Action.GetCurrentGCD
local GetPing									= Action.GetPing
local ShouldStop								= Action.ShouldStop
local BurstIsON									= Action.BurstIsON
local CovenantIsON								= Action.CovenantIsON
local AuraIsValid								= Action.AuraIsValid
local InterruptIsValid							= Action.InterruptIsValid
local FrameHasSpell                             = Action.FrameHasSpell
local Utils										= Action.Utils
local TeamCache									= Action.TeamCache
local EnemyTeam									= Action.EnemyTeam
local FriendlyTeam								= Action.FriendlyTeam
local LoC										= Action.LossOfControl
local Player									= Action.Player
local Pet                                       = LibStub("PetLibrary") 
local MultiUnits								= Action.MultiUnits
local UnitCooldown								= Action.UnitCooldown
local Unit										= Action.Unit 
local IsUnitEnemy								= Action.IsUnitEnemy
local IsUnitFriendly							= Action.IsUnitFriendly
local ActiveUnitPlates                          = MultiUnits:GetActiveUnitPlates()
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local pairs                                     = pairs



--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

Action[ACTION_CONST_PRIEST_SHADOW] = {
    -- Racial
    ArcaneTorrent                          = Action.Create({ Type = "Spell", ID = 50613 }),
    BloodFury                              = Action.Create({ Type = "Spell", ID = 20572 }),
    Fireblood                              = Action.Create({ Type = "Spell", ID = 265221 }),
    AncestralCall                          = Action.Create({ Type = "Spell", ID = 274738 }),
    Berserking                             = Action.Create({ Type = "Spell", ID = 26297 }),
    ArcanePulse                            = Action.Create({ Type = "Spell", ID = 260364 }),
    QuakingPalm                            = Action.Create({ Type = "Spell", ID = 107079 }),
    Haymaker                               = Action.Create({ Type = "Spell", ID = 287712 }), 
    WarStomp                               = Action.Create({ Type = "Spell", ID = 20549 }),
    BullRush                               = Action.Create({ Type = "Spell", ID = 255654 }),    
    GiftofNaaru                            = Action.Create({ Type = "Spell", ID = 59544 }),
    Shadowmeld                             = Action.Create({ Type = "Spell", ID = 58984 }), -- usable in Action Core 
    Stoneform                              = Action.Create({ Type = "Spell", ID = 20594 }), 
    WilloftheForsaken                      = Action.Create({ Type = "Spell", ID = 7744  }), -- not usable in APL but user can Queue it    
    EscapeArtist                           = Action.Create({ Type = "Spell", ID = 20589 }), -- not usable in APL but user can Queue it
    EveryManforHimself                     = Action.Create({ Type = "Spell", ID = 59752 }), -- not usable in APL but user can Queue it
    Darkflight                             = Action.Create({ Type = "Spell", ID = 68992    }),
	LightsJudgement                        = Action.Create({ Type = "Spell", ID = 255647    }),
	BagofTricks							   = Action.Create({ Type = "Spell", ID = 312411    }),
    -- Generics
    Shadowfiend                       	   = Action.Create({ Type = "Spell", ID = 34433    }),
    Mindbender                             = Action.Create({ Type = "Spell", ID = 200174 }),
    SurrenderToMadness                     = Action.Create({ Type = "Spell", ID = 319952 }),
    VampiricTouch                          = Action.Create({ Type = "Spell", ID = 34914 }),
    ShadowWordPain                         = Action.Create({ Type = "Spell", ID = 589 }),
    MindBlast                              = Action.Create({ Type = "Spell", ID = 8092 }),
    MindFlay                               = Action.Create({ Type = "Spell", ID = 15407 }),
    MindSear                               = Action.Create({ Type = "Spell", ID = 48045 }),
    VoidEruption                           = Action.Create({ Type = "Spell", ID = 228260 }),
    VoidBolt                               = Action.Create({ Type = "Spell", ID = 205448 }),
    ShadowCrash                            = Action.Create({ Type = "Spell", ID = 205385 }),
    ShadowWordDeath                        = Action.Create({ Type = "Spell", ID = 32379 }),
    VoidTorrent                            = Action.Create({ Type = "Spell", ID = 263165 }),
    Misery                                 = Action.Create({ Type = "Spell", ID = 238558, Hidden = true }),
    Shadowform                             = Action.Create({ Type = "Spell", ID = 232698 }),
    ChorusofInsanity                       = Action.Create({ Type = "Spell", ID = 278661 }),
    VoidformBuff                           = Action.Create({ Type = "Spell", ID = 194249, Hidden = true }),    
    VampiricTouchDebuff                    = Action.Create({ Type = "Spell", ID = 34914, Hidden = true }),
    ShadowWordPain                   = Action.Create({ Type = "Spell", ID = 589, Hidden = true }),
    WeakenedSoulDebuff                     = Action.Create({ Type = "Spell", ID = 6788, Hidden = true }),
    Damnation                              = Action.Create({ Type = "Spell", ID = 341374}),
    UnfurlingDarknessBuff                  = Action.Create({ Type = "Spell", ID = 341282, Hidden = true}),
	UnfurlingDarknessTalent				   = Action.Create({ Type = "Spell", ID = 341273, Hidden = true}), 
    SearingNightmare                       = Action.Create({ Type = "Spell", ID = 341385}),
    PsychicLink                            = Action.Create({ Type = "Spell", ID = 199484}),
    PowerInfusion                          = Action.Create({ Type = "Spell", ID = 10060}),
    DevouringPlague                        = Action.Create({ Type = "Spell", ID = 335467}),
	DarkThought							   = Action.Create({ Type = "Spell", ID = 341207, Hidden = true }),
	HungeringVoid						   = Action.Create({ Type = "Spell", ID = 345218, Hidden = true }),
	HungeringVoidDebuff					   = Action.Create({ Type = "Spell", ID = 345219, Hidden = true }),
	TwistofFateBuff						   = Action.Create({ Type = "Spell", ID = 123254, Hidden = true }),
	TwistofFateTalent					   = Action.Create({ Type = "Spell", ID = 109142, Hidden = true }),
	ShadowCrashDebuff					   = Action.Create({ Type = "Spell", ID = 342835, Hidden = true }),
	BodyAndSoul							   = Action.Create({ Type = "Spell", ID = 64129, Hidden = true }),
	DeathandMadness						   = Action.Create({ Type = "Spell", ID = 321291, Hidden = true }),
	MindBender							   = Action.Create({ Type = "Spell", ID = 123040}),
--    DevouringPlague                  = Action.Create({ Type = "Spell", ID = 335467, Hidden = true}),
    -- PvP   
    Silence                                = Action.Create({ Type = "Spell", ID = 15487 }),    
    PsychicScream                          = Action.Create({ Type = "Spell", ID = 8122   }), -- Fear
    PsychicHorror                          = Action.Create({ Type = "Spell", ID = 64044 }), -- Fear + Disarm
    -- Covenant Abilities
    AscendedBlast                          = Action.Create({ Type = "Spell", ID = 325283}), 
    AscendedNova                           = Action.Create({ Type = "Spell", ID = 325020}), 
    BoonoftheAscended                      = Action.Create({ Type = "Spell", ID = 325013}), 
    RedirectedAnima	                       = Action.Create({ Type = "Spell", ID = 342814}), 
	SoulShape							   = Action.Create({ Type = "Spell", ID = 310143}), 
    --    BoonoftheAscended                  = Action.Create({ Type = "Spell", ID = 325013}), 
    FaeGuardians                           = Action.Create({ Type = "Spell", ID = 327661}), 
    WrathfulFaerie                         = Action.Create({ Type = "Spell", ID = 342132}), 
	GuardianFaerie                         = Action.Create({ Type = "Spell", ID = 327694}), 
    BenevolentFaerie                       = Action.Create({ Type = "Spell", ID = 327710}), 
    MindGames                              = Action.Create({ Type = "Spell", ID = 323673}), 
    UnholyNova                             = Action.Create({ Type = "Spell", ID = 324724}), 
    -- Conduit Effects
    DissonantEchoesBuff                    = Action.Create({ Type = "Spell", ID = 343144}), 
    -- Utilities 
    PowerWordFortitude                     = Action.Create({ Type = "Spell", ID = 21562 }),    -- Shield
    DispelMagic                            = Action.Create({ Type = "Spell", ID = 528,   }),    
    -- Defensives
    PowerWordShield                        = Action.Create({ Type = "Spell", ID = 17    }), 
    VampiricEmbrace                        = Action.Create({ Type = "Spell", ID = 15286 }),
    Dispersion                             = Action.Create({ Type = "Spell", ID = 47585 }),
	DesperatePrayer   					   = Action.Create({ Type = "Spell", ID = 19236 }),
    -- Oils
    EmbalmersOil                           = Action.Create({ Type = "Spell", ID = 171286, QueueForbidden = true }), 
    ShadowcoreOil                          = Action.Create({ Type = "Spell", ID = 171285, QueueForbidden = true }),  
    -- Potions
    -- stats
    PotionofSpectralAgility                = Action.Create({ Type = "Potion", ID = 171270, QueueForbidden = true }), 
    PotionofSpectralIntellect              = Action.Create({ Type = "Potion", ID = 171273, QueueForbidden = true }), 
    PotionofSpectralStrength               = Action.Create({ Type = "Potion", ID = 171275, QueueForbidden = true }), 
    PotionofSpectralStamina                = Action.Create({ Type = "Potion", ID = 171274, QueueForbidden = true }), 
    -- heal
    SpiritualHealingPotion                 = Action.Create({ Type = "Potion", ID = 171267, QueueForbidden = true }), 
    SpiritualManaPotion                    = Action.Create({ Type = "Potion", ID = 171268, QueueForbidden = true }), 
    SpiritualRejuvenationPotion            = Action.Create({ Type = "Potion", ID = 171269, QueueForbidden = true }), 
    PotionofSpiritualClarity               = Action.Create({ Type = "Potion", ID = 171272, QueueForbidden = true }), 
    -- combat effects potions
    PotionofDeathlyFixation                = Action.Create({ Type = "Potion", ID = 171351, QueueForbidden = true }), 
    PotionofEmpoweredExorcisms             = Action.Create({ Type = "Potion", ID = 171352, QueueForbidden = true }),
    PotionofPhantomFire                    = Action.Create({ Type = "Potion", ID = 171349, QueueForbidden = true }),
    PotionofDivineAwakening                = Action.Create({ Type = "Potion", ID = 171350, QueueForbidden = true }),
    PotionofSacrificialAnima               = Action.Create({ Type = "Potion", ID = 176811, QueueForbidden = true }),
    -- utilities potions
    PotionofHardenedShadows                = Action.Create({ Type = "Potion", ID = 171271, QueueForbidden = true }),
    PotionofShadedSight                    = Action.Create({ Type = "Potion", ID = 171264, QueueForbidden = true }),
    PotionofSoulPurity                     = Action.Create({ Type = "Potion", ID = 171263, QueueForbidden = true }),
    PotionofSpecterSwiftness               = Action.Create({ Type = "Potion", ID = 171370, QueueForbidden = true }),
    PotionoftheHiddenSpirit                = Action.Create({ Type = "Potion", ID = 171266, QueueForbidden = true }),
    PotionofthePsychopompsSpeed            = Action.Create({ Type = "Potion", ID = 184090, QueueForbidden = true }),
    PotionofUnhinderedPassing              = Action.Create({ Type = "Potion", ID = 183823, QueueForbidden = true }),
    -- Nathria Trinkets
    SanguineVintage                        = Action.Create({ Type = "Trinket", ID = 184031 }),
    ManaboundMirror                        = Action.Create({ Type = "Trinket", ID = 184029 }),
    GluttonousSpike                        = Action.Create({ Type = "Trinket", ID = 184023 }),
    DreadfireVessel                        = Action.Create({ Type = "Trinket", ID = 184030 }),
    MemoryofPastSins                       = Action.Create({ Type = "Trinket", ID = 184025 }),
    ConsumptiveInfusion                    = Action.Create({ Type = "Trinket", ID = 184022 }),
    StoneLegionHeraldry                    = Action.Create({ Type = "Trinket", ID = 184027 }),
    BargastsLeash                          = Action.Create({ Type = "Trinket", ID = 184017 }),
    -- OP Dungeons Trinkets
    BloodSpatteredScale                    = Action.Create({ Type = "Trinket", ID = 179331 }),
    OverwhelmingPowerCrystal               = Action.Create({ Type = "Trinket", ID = 179342 }),
    SunbloodAmethyst                       = Action.Create({ Type = "Trinket", ID = 178826 }),
    PulsatingStoneheart                    = Action.Create({ Type = "Trinket", ID = 178825 }),
    BladedancersArmorKit                   = Action.Create({ Type = "Trinket", ID = 178862 }),  
    DarkMoonDeckPutrescence                = Action.Create({ Type = "Trinket", ID = 173069 }), 	
    GlyphOfAssimilation    	               = Action.Create({ Type = "Trinket", ID = 6805 }), 
	EmpyrealOrdinance					   = Action.Create({ Type = "Trinket", ID = 180117 }), 
	InscrutableQuantumDevice			   = Action.Create({ Type = "Trinket", ID = 179350 }), 
	MacabreSheetMusic					   = Action.Create({ Type = "Trinket", ID = 184024 }), 
	SoullettingRuby					       = Action.Create({ Type = "Trinket", ID = 178809 }),
	SinfulGladiatorsBadgeofFerocity		   = Action.Create({ Type = "Trinket", ID = 175921 }),
    
    -- Legendaries
    PainbreakerPsalm               		   = Action.Create({ Type = "Spell", ID = 336165 }),
    TalbadarsStratagem                     = Action.Create({ Type = "Spell", ID = 342415 }),
    ShadowflamePrism                       = Action.Create({ Type = "Spell", ID = 336143 }),
    SephuzsProclamation                    = Action.Create({ Type = "Spell", ID = 339348 }),
    -- Misc
    PoolResource                           = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),
    TargetEnemy                            = Action.Create({ Type = "Spell", ID = 44603, Hidden = true }),-- Change Target (Tab button)
    StopCast                               = Action.Create({ Type = "Spell", ID = 61721, Hidden = true }),    -- spell_magic_polymorphrabbit
    DummyTest                              = Action.Create({ Type = "Spell", ID = 159999, Hidden = true     }), -- Dummy stop dps icon
	ConcentratedFlame					   = Action.Create({ Type = "Spell", ID = 295373, }),
	QuakeDebuff							   = Action.Create({ Type = "Spell", ID = 240447, }),								
	--Soulbinds
	GroveInvigoration					   = Action.Create({ Type = "Spell", ID = 322721, Hidden = true  }),
	CombatMeditation					   = Action.Create({ Type = "Spell", ID = 328266, Hidden = true  }),
	DissonantEchoes						   = Action.Create({ Type = "Spell", ID = 338342, Hidden = true  }),
	FieldofBlossoms						   = Action.Create({ Type = "Spell", ID = 319191, Hidden = true  }),
};

local A = setmetatable(Action[ACTION_CONST_PRIEST_SHADOW], { __index = Action })



local Temp = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndCC                              = {"TotalImun", "CCTotalImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
    TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
    TotalAndMagAndCCAndStun                 = {"TotalImun", "DamageMagicImun", "CCTotalImun", "StunImun"},
    DisablePhys                             = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                              = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
    IsSlotTrinketBlocked                    = {},
}; do     
    
    -- Push IsSlotTrinketBlocked
    for key, val in pairs(Action[ACTION_CONST_PRIEST_SHADOW]) do 
        if type(val) == "table" and val.Type == "Trinket" then 
            Temp.IsSlotTrinketBlocked[val.ID] = true
        end 
    end 
end 

local IsIndoors, UnitIsUnit, UnitName = IsIndoors, UnitIsUnit, UnitName

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 


function Player:AreaTTD(range)
    local ttdtotal = 0
	local totalunits = 0
    local r = range
    
	for _, unit in pairs(ActiveUnitPlates) do 
		if Unit(unit):GetRange() <= r then 
			local ttd = Unit(unit):TimeToDie()
			totalunits = totalunits + 1
			ttdtotal = ttd + ttdtotal
		end
	end
    
	if totalunits == 0 then
		return 0
	end
    
	return ttdtotal / totalunits
end	

local function CheckingRange()
    
    local rangeCheckCount = 0     
        
        for irangeCheckCount in pairs(ActiveUnitPlates) do     
            local unit = "nameplate"..irangeCheckCount
            if UnitCanAttack("player", irangeCheckCount) and UnitAffectingCombat("target") and IsItemInRange(Checkitem, irangeCheckCount) and not UnitDetailedThreatSituation("player", irangeCheckCount) == nil then
                rangeCheckCount = rangeCheckCount + 1
                
            end
        end
    
    if rangeCheckCount > 1 then return true else return false end
end

local function EnemiesCount()
    
    local enemiesCheckCount = 0     
        
        for ienemiesCheckCount in pairs(ActiveUnitPlates) do  
			local unit = "nameplate"..ienemiesCheckCount
            if (UnitCanAttack("player", ienemiesCheckCount) and UnitAffectingCombat("target") and IsItemInRange(Checkitem, ienemiesCheckCount) and UnitDetailedThreatSituation("player", ienemiesCheckCount) ~= nil) or Unit(ienemiesCheckCount):IsDummy() then
                enemiesCheckCount = (enemiesCheckCount + 1)
               
            end

        end

    if enemiesCheckCount >= 1 then return enemiesCheckCount else return 0 end

end


-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.Silence:IsReadyByPassCastGCD(unit) or not A.Silence:AbsentImun(unit, Temp.TotalAndMagKick) then
	    return true
	end
end

-- Interrupts spells
local function Interrupts(unit)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime
	local HorrorInterrupt = Action.GetToggle(2, "HorrorInterrupt")
    local ScreamInterrupt = Action.GetToggle(2, "ScreamInterrupt")
	
    if A.GetToggle(2, "SnSInterruptList") and (IsInRaid() or A.InstanceInfo.KeyStone > 1) then
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid("target", "SnS_ShadowlandsContent", true, countInterruptGCD("target"))
	else
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, nil, nil, countInterruptGCD(unit))
    end

    if castRemainsTime >= A.GetLatency() then
        if useKick and not notInterruptable and A.Silence:IsReady("target") and A.Silence:AbsentImun("target", Temp.TotalAndMagKick, true) then 
            return A.Silence
        end 
    
        if useCC and A.PsychicHorror:IsReady("target") and HorrorInterrupt and A.PsychicHorror:AbsentImun("target", Temp.TotalAndCC, true) and Unit("target"):IsControlAble("stun", 0) then 
            return A.PsychicHorror             
        end          
	
	    if useCC and A.PsychicScream:IsReady("target") and ScreamInterrupt and A.PsychicScream:AbsentImun("target", Temp.TotalAndCC, true) and Unit("target"):IsControlAble("disorient", 75) then 
            return A.PsychicScream           
        end
		    
   	    if useRacial and A.QuakingPalm:AutoRacial("target") then 
   	        return A.QuakingPalm:Show("target")
   	    end 
    
   	    if useRacial and A.Haymaker:AutoRacial("target") then 
            return A.Haymaker:Show("target")
   	    end 
    
   	    if useRacial and A.WarStomp:AutoRacial("target") then 
            return A.WarStomp:Show("target")
   	    end 
    
   	    if useRacial and A.BullRush:AutoRacial("target") then 
            return A.BullRush:Show("target")
   	    end 
    end
end

local function SelfDefensives()

    if Unit("player"):CombatTime() == 0 then 
        return 
    end 
    
    local unit
    if A.IsUnitEnemy("mouseover") then 
        unit = "mouseover"
    elseif A.IsUnitEnemy("target") then 
        unit = "target"
    end  

--Desperate Prayer
    local DesperatePrayer = GetToggle(2, "DesperatePrayer")
    if     DesperatePrayer >= 0 and A.DesperatePrayer:IsReady("player") and 
    (
        (   -- Auto 
            DesperatePrayer >= 100 and 
            (
                -- HP lose per sec >= 15
                Unit("player"):HealthPercent() <= 30 or
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            DesperatePrayer < 100 and 
            Unit("player"):HealthPercent() <= DesperatePrayer
        )
    ) 
    then 
        return A.DesperatePrayer
    end 

--VampiricEmbrace	
    local VampiricEmbrace = GetToggle(2, "VampiricEmbrace")
    if     VampiricEmbrace >= 0 and A.VampiricEmbrace:IsReady("player") and 
    (
        (   -- Auto 
            VampiricEmbrace >= 100 and 
            (
                -- HP lose per sec >= 30
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 20 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.20 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            VampiricEmbrace < 100 and 
            Unit("player"):HealthPercent() <= VampiricEmbrace
        )
    ) 
    then 
        return A.VampiricEmbrace
    end
	
--Dispersion
    local Dispersion = GetToggle(2, "Dispersion")
    if     Dispersion >= 0 and A.Dispersion:IsReady("player") and 
    (
        (   -- Auto 
            Dispersion >= 100 and 
            (
                -- HP lose per sec >= 30
                Unit("player"):GetDMG() * 100 / Unit("player"):HealthMax() >= 30 or 
                Unit("player"):GetRealTimeDMG() >= Unit("player"):HealthMax() * 0.3 or 
                -- TTD 
                Unit("player"):TimeToDieX(25) < 3 or 
                (
                    A.IsInPvP and 
                    (
                        Unit("player"):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit("player"):GetRealTimeDMG() > 0 and 
                            Unit("player"):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit("player"):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            Dispersion < 100 and 
            Unit("player"):HealthPercent() <= Dispersion
        )
    ) 
    then 
        return A.Dispersion
    end  
	
    -- Stoneform on self dispel (only PvE)
    if A.Stoneform:IsRacialReady("player", true) and not A.IsInPvP and A.AuraIsValid("player", "UseDispel", "Dispel") then 
        return A.Stoneform
    end 
	
end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)

-- [2] Kick AntiFake Rotation
A[2] = nil

SetTarget = UnitGUID("target")
SetTime = 0
VTDelay = 0

-- [3] Single Rotation
A[3] = function(icon, isMulti)

	--------------------
	---  UI stuff  ---
	--------------------
	local MultiDotDistance = A.GetToggle(2, "MultiDotDistance")
	local TargetSwapDelay = A.GetToggle(2, "TargetSwapDelay")
	local AoE = A.GetToggle(2, "AoE")
	local PWSTime = A.GetToggle(2, "PWSTime")
	local VTCastDelay = A.GetToggle(2, "VTCastDelay")
	local _, _, _, CastStart, CastEnd, _, _, ChannelCheckplayer = UnitChannelInfo("player")
	local _, _, _, CastStart, CastEnd, _, _, _, CastCheckplayer = UnitCastingInfo("player")	
	
if UnitGUID("target") ~= SetTarget then
	SetTime = (TMW.time + (TargetSwapDelay / 1000)) 
	SetTarget = UnitGUID("target")
end

--Quaking Check
	if ChannelCheckplayer ~= nil or CastCheckplayer ~= nil then

		if Unit("player"):HasDeBuffs(A.QuakeDebuff.ID, true) < 2 and Unit("player"):HasDeBuffs(A.QuakeDebuff.ID, true) > 0 then
			isMoving = true
		elseif (((CastCheckplayer ~= nil and Unit("player"):HasDeBuffs(A.QuakeDebuff.ID, true) < (CastEnd/1000 - GetTime())) or (ChannelCheckplayer ~= nil and Unit("player"):HasDeBuffs(A.QuakeDebuff.ID, true) < 1)) and Unit("player"):HasDeBuffs(A.QuakeDebuff.ID, true) > 0) then
			return A.StopCast:Show(icon)
		else
			isMoving = A.Player:IsMoving()
		end
	end
	
if TMW.time < SetTime then
	return A.PoolResource:Show(icon)
end

if CastCheckplayer == A.VampiricTouch.ID then
	VTDelay = TMW.time + (CastEnd/1000 - GetTime()) + (VTCastDelay/1000)
end

if TMW.time < VTDelay then
	return A.PoolResource:Show(icon)
end

if A.PowerWordShield:IsReady("player") and not Player:IsMounted() and Unit("player"):HasDeBuffs(A.WeakenedSoulDebuff.ID, true) == 0 and Player:IsMovingTime() > PWSTime and Player:IsMoving() and A.BodyAndSoul:IsTalentLearned() and Unit("player"):HasBuffs(A.SoulShape.ID, true) == 0 then
	return A.PowerWordShield:Show(icon)
end

	if MultiDotDistance <= 5 then
		Checkitem = 37727 -- Ruby Acorn
	elseif MultiDotDistance > 5 and MultiDotDistance <= 10 then
		Checkitem = 32321 -- Sparrowhawk Net
	elseif MultiDotDistance > 10 and MultiDotDistance <= 15 then
		Checkitem = 33069 -- Sturdy Rope
	elseif MultiDotDistance > 15 and MultiDotDistance <= 20 then
		Checkitem = 10645 -- Gnomish Death Ray
	elseif MultiDotDistance > 20 and MultiDotDistance <= 25 then
		Checkitem = 31463 -- Zezzak's Shard
	elseif MultiDotDistance > 25 and MultiDotDistance <= 30 then
		Checkitem = 34191 -- Handful of Snowflakes
	elseif MultiDotDistance > 30 and MultiDotDistance <= 35 then
		Checkitem = 18904 -- Zorbin's Ultra-Shrinker
	elseif MultiDotDistance > 35 and MultiDotDistance <= 40 then
		Checkitem = 32698 -- Vial of the Sunwell
	end		
		
	--------------------
	---  VARIABLES   ---
	--------------------
    local isMoving = A.Player:IsMoving()
    local Pull = Action.BossMods:GetPullTimer()
    local Pull2 = Unit("player"):CombatTime()
	local profileStop = false	
	local inCombat = Unit("player"):CombatTime() > 0
    local ShouldStop = Action.ShouldStop()
    local AutoSwapped = false
	local ShouldReturn -- Used to get the return string
	local Enemies8yMelee, Enemies30y, Enemies40y
	local PetActiveCD
    local SWPmaxTargets = Action.GetToggle(2, "SWPmaxTargets")
    local VTmaxTargets = Action.GetToggle(2, "VTmaxTargets")
	local MultiDoTCheck = Action.GetToggle(2, "MultiDoTCheck")
    local UseAoE = Action.GetToggle(2, "AoE")	
	local CastTime = 0

	--------------------
	---  DOT Stuff and AoE  ---
	--------------------

	local function num(val)
	  if val then return 1 else return 0 end
	end

	local function bool(val)
	  return val ~= 0
	end
		
	local function swpCheck()
		for SWPCheckUnit in pairs(ActiveUnitPlates) do
			if ((UnitCanAttack("player", SWPCheckUnit) and UnitAffectingCombat("target") and IsItemInRange(Checkitem, SWPCheckUnit) and UnitDetailedThreatSituation("player", SWPCheckUnit) ~= nil) or Unit(SWPCheckUnit):IsDummy()) then
				if (MultiDoTCheck and ((Unit(SWPCheckUnit):HasDeBuffs(A.ShadowWordPain.ID, true) < 4 and Unit(SWPCheckUnit):TimeToDie() > 4)
				or (Player:GetDeBuffsUnitCount(A.ShadowWordPain.ID) <= SWPmaxTargets and Player:GetDeBuffsUnitCount(A.ShadowWordPain.ID) < EnemiesCount())))
				or (not MultiDoTCheck and Unit("target"):HasDeBuffs(A.ShadowWordPain.ID, true) < 4 and Unit("target"):TimeToDie() > 4) then
					return false
				else
					return true
				end
			end
		end
	end

	function vtCheck()
		for VTCheckUnit in pairs(ActiveUnitPlates) do
			if ((UnitCanAttack("player", VTCheckUnit) and UnitAffectingCombat("target") and IsItemInRange(Checkitem, VTCheckUnit) and UnitDetailedThreatSituation("player", VTCheckUnit) ~= nil) or Unit(VTCheckUnit):IsDummy()) then
				if (MultiDoTCheck and (((Unit(VTCheckUnit):HasDeBuffs(A.VampiricTouchDebuff.ID, true) < (4 + A.VampiricTouch:CastTime()) and Unit(VTCheckUnit):TimeToDie() > (4 + A.VampiricTouch:CastTime())) and ((A.SearingNightmare:IsTalentLearned() and EnemiesCount() < 7) or not A.SearingNightmare:IsTalentLearned()))				
				or (Player:GetDeBuffsUnitCount(A.VampiricTouch.ID) <= VTmaxTargets and Player:GetDeBuffsUnitCount(A.VampiricTouch.ID) < EnemiesCount())))
				or (not MultiDoTCheck and Unit("target"):HasDeBuffs(A.VampiricTouch.ID, true) < 4 and Unit("target"):TimeToDie() > 4) then
					return false
				else
					return true
				end
			end
		end
	end

	local function noDotCheck(unit)
		if string.find(UnitGUID(unit), 171557) or Unit(unit):HasDeBuffs("Charm") > 0 then
			return true
		else
			return false
		end
	end

	local function VTDoubleCheck(unit)
		if UnitGUID("target") ~= LastVTTarget or (CastTime + 0.5 < TMW.time) then
			return true
		else
			return false
		end
	end

	local function fiendCD()
		if A.MindBender:IsTalentLearned() then
			return A.MindBender:GetCooldown()
		else
			return A.Shadowfiend:GetCooldown()
		end
	end
			
	------------------------------------------------------
	---------------- ENEMY UNIT ROTATION -----------------
	------------------------------------------------------
    local function EnemyRotation(unit)
	local Pull = Action.BossMods:GetPullTimer()
	local _, _, _, CastStart, CastEnd, _, _, _, CastCheckplayer = UnitCastingInfo("player")	
	local _, _, _, ChannelStart, ChannelEnd, _, _, ChannelCheckplayer = UnitChannelInfo("player")

	
	VarDotsUp = vtCheck() and swpCheck()
	VarAllDotsUp = vtCheck() and swpCheck() and Unit("target"):HasBuffs(A.DevouringPlague.ID, true) > 0
	--actions.precombat+=/variable,name=mind_sear_cutoff,op=set,value=2
	searCutoff = 2
	--# Start using Searing Nightmare at 3+ targets or 4+ if you are in Voidform
	--actions+=/variable,name=searing_nightmare_cutoff,op=set,value=spell_targets.mind_sear>2+buff.voidform.up
    snmCutoff = EnemiesCount() > 2 + num(Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > 0)
	--# Cooldown Pool Variable, Used to pool before activating voidform. Currently used to control when to activate voidform with incoming adds.
	--actions+=/variable,name=pool_for_cds,op=set,value=cooldown.void_eruption.up&(!raid_event.adds.up|raid_event.adds.duration<=10|raid_event.adds.remains>=10+5*(talent.hungering_void.enabled|covenant.kyrian))&((raid_event.adds.in>20|spell_targets.void_eruption>=5)|talent.hungering_void.enabled|covenant.kyrian)
	pool = A.BurstIsON(unit) and (A.VoidEruption:GetCooldown() == 0 and (( EnemiesCount() == 1 or EnemiesCount() >= 5) or A.HungeringVoid:IsTalentLearned() or C_Covenants.GetActiveCovenantID() == 1))

	if CastCheckplayer == A.VampiricTouch.ID then
		LastVTTarget = UnitGUID("target")
		CastTime = TMW.time
	end
	
--Defensive
    if inCombat then
        local SelfDefensive = SelfDefensives()
        if SelfDefensive then 
            return SelfDefensive:Show(icon)
        end 
    end
	
local function Precombat()	  
        -- # Executed before combat begins. Accepts non-harmful actions only.
        -- actions.precombat=flask
        -- actions.precombat+=/food
        -- actions.precombat+=/augmentation
        -- # Snapshot raid buffed stats before combat begins and pre-potting is done.
        -- actions.precombat+=/snapshot_stats
		-- shadowform,if=!buff.shadowform.up
		if A.Shadowform:IsReady("player") and (Unit("player"):HasBuffs(A.Shadowform.ID, true) == 0) then
		  return A.Shadowform:Show(icon)
		end
        -- actions.precombat+=/arcane_torrent
		if A.ArcaneTorrent:IsReady("player") and Pull < 5 and Pull > 0 then
			return A.ArcaneTorrent:Show(icon)
		end
		
        -- actions.precombat+=/use_item,name=azsharas_font_of_power
        -- actions.precombat+=/variable,name=mind_sear_cutoff,op=set,value=2
        -- actions.precombat+=/vampiric_touch
		if A.VampiricTouch:IsReady(unit) and not isMoving and CastCheckplayer ~= A.VampiricTouch.ID and VTDoubleCheck() then
		  return A.VampiricTouch:Show(icon)
		end
end

local function DmgTrinkets()
		-- use_item,name=darkmoon_deck_putrescence
		if A.DarkMoonDeckPutrescence:IsReady(unit) then
			return A.DarkMoonDeckPutrescence:Show(icon)
		end
		  
		-- use_item,name=sunblood_amethyst
		if A.SunbloodAmethyst:IsReady(unit) then
			return A.SunbloodAmethyst:Show(icon)
		end
		  
		-- use_item,name=glyph_of_assimilation
		if A.GlyphOfAssimilation:IsReady(unit) then
			return A.GlyphOfAssimilation:Show(icon)
		end
		  
		-- use_item,name=dreadfire_vessel
		if A.DreadfireVessel:IsReady(unit) then
			return A.DreadfireVessel:Show(icon)
		end
end

local function Trinkets()
        -- # Use on CD ASAP to get DoT ticking and expire to line up better with Voidform
        -- actions.trinkets=use_item,name=empyreal_ordnance(180117),if=cooldown.void_eruption.remains<=12|cooldown.void_eruption.remains>27
		if A.EmpyrealOrdinance:IsReady(unit) and (A.VoidEruption:GetCooldown() <= 14 or A.VoidEruption:GetCooldown() > 27) then
			return A.EmpyrealOrdinance:Show(icon)
		end
		
        -- # Sync IQD with Voidform		
		-- use_item,name=inscrutable_quantum_device,if=cooldown.void_eruption.remains>10
		if A.InscrutableQuantumDevice:IsReady(unit) and (A.VoidEruption:GetCooldown() > 10) then
			return A.InscrutableQuantumDevice:Show(icon)
		end
		
		-- # Sync Sheet Music with Voidform  
		-- use_item,name=macabre_sheet_music,if=cooldown.void_eruption.remains>10
		if A.MacabreSheetMusic:IsReady(unit) and (A.VoidEruption:GetCooldown() > 10) then
			return A.MacabreSheetMusic:Show(icon)
		end
		
		-- # Use Badge inside of VF for the first use or on CD after the first use. Short circuit if void eruption cooldown is 10s or more away.		
		-- use_item,name=sinful_gladiators_badge_of_ferocity,if=cooldown.void_eruption.remains>=10
		if A.SinfulGladiatorsBadgeofFerocity:IsReady(unit) and (A.VoidEruption:GetCooldown() >= 10) then
			return A.SinfulGladiatorsBadgeofFerocity:Show(icon)
		end
		  
		-- call_action_list,name=dmg_trinkets,if=(!talent.hungering_void.enabled|debuff.hungering_void.up)&(buff.voidform.up|cooldown.void_eruption.remains>10)
		if ((not A.HungeringVoid:IsTalentLearned() or Unit("target"):HasDeBuffs(A.HungeringVoidDebuff.ID, true) > 0) and (Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > 0 or A.VoidEruption:GetCooldown() > 10)) then
			return DmgTrinkets()
		end
		  
		-- use_items,if=buff.voidform.up|buff.power_infusion.up|cooldown.void_eruption.remains>10
		if (Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > 0 or Unit("player"):HasBuffs(A.PowerInfusion.ID, true) > 0 or A.VoidEruption:GetCooldown() > 10) then
			-- Trinket 1
            if A.Trinket1:IsReady(unit) then
                return A.Trinket1:Show(icon)    
            end
            
            -- Trinket 2
            if A.Trinket2:IsReady(unit) then
                return A.Trinket2:Show(icon)    
            end   
		end
end

local function Cds()
		
		-- # Use Power Infusion with Voidform. Hold for Voidform comes off cooldown in the next 10 seconds otherwise use on cd unless the Pelagos Trait Combat Meditation is talented, or if there will not be another Void Eruption this fight.
		-- actions.cds=power_infusion,if=priest.self_power_infusion&(buff.voidform.up|!soulbind.grove_invigoration.enabled&!soulbind.combat_meditation.enabled&cooldown.void_eruption.remains>=10|fight_remains<cooldown.void_eruption.remains|soulbind.grove_invigoration.enabled&(buff.redirected_anima.stack>=12|cooldown.fae_guardians.remains>10))
        if A.PowerInfusion:IsReady("player") and (Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > 0 or (not A.GroveInvigoration:IsSoulbindLearned() and not A.CombatMeditation:IsSoulbindLearned() and A.VoidEruption:GetCooldown() >= 10)
		or (A.GroveInvigoration:IsSoulbindLearned() and (Unit("player"):HasBuffsStacks(A.RedirectedAnima.ID, true) >= 12 or A.FaeGuardians:GetCooldown() > 10))) then
            return A.PowerInfusion:Show(icon)
        end
		
		--fae_guardians,if=!buff.voidform.up&(!cooldown.void_torrent.up|!talent.void_torrent.enabled)|buff.voidform.up&(soulbind.grove_invigoration.enabled|soulbind.field_of_blossoms.enabled)
		if A.FaeGuardians:IsReady(unit) and ((Unit("player"):HasBuffs(A.VoidformBuff.ID, true) == 0 and (A.VoidTorrent:GetCooldown() > 0 or not A.VoidTorrent:IsTalentLearned())) or (Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > 0 and (A.GroveInvigoration:IsSoulbindLearned() or A.FieldofBlossoms:IsSoulbindLearned()))) then
			return A.FaeGuardians:Show(icon)
		end
		
		--mindgames,target_if=insanity<90&((variable.all_dots_up&(!cooldown.void_eruption.up|!talent.hungering_void.enabled))|buff.voidform.up)&(!talent.hungering_void.enabled|debuff.hungering_void.up|!buff.voidform.up)&(!talent.searing_nightmare.enabled|spell_targets.mind_sear<5)
		if A.MindGames:IsReady(unit) and (Player:Insanity() < 90 and ((VarAllDotsUp and (A.VoidEruption:GetCooldown() > 0 or A.HungeringVoid:IsTalentLearned())) or Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > 0) and (not A.HungeringVoid:IsTalentLearned() or Unit("target"):HasDeBuffs(A.HungeringVoidDebuff.ID, true) > 0) and (not A.SearingNightmare:IsTalentLearned() or EnemiesCount() <5)) then
			return A.MindGames:Show(icon)
		end
		
		--unholy_nova,if=(buff.power_infusion.up|cooldown.power_infusion.remains>=10|!priest.self_power_infusion)&(!talent.hungering_void.enabled|debuff.hungering_void.up|!buff.voidform.up)
		if A.UnholyNova:IsReady(unit) and ((Unit("player"):HasBuffs(A.PowerInfusion.ID, true) > 0 or A.PowerInfusion:GetCooldown() >= 10) and (not A.HungeringVoid:IsTalentLearned() or Unit("target"):HasDeBuffs(A.HungeringVoidDebuff.ID, true) > 0 or Unit("player"):HasBuffs(A.VoidFormBuff.ID, true) == 0)) then
			return A.UnholyNova:Show(icon)
		end
		
		-- # Use on CD but prioritise using Void Eruption first, if used inside of VF on ST use after a voidbolt for cooldown efficiency and for hungering void uptime if talented.
		-- actions.cds+=/boon_of_the_ascended,if=!buff.voidform.up&!cooldown.void_eruption.up&spell_targets.mind_sear>1&!talent.searing_nightmare.enabled|(buff.voidform.up&spell_targets.mind_sear<2&!talent.searing_nightmare.enabled&(prev_gcd.1.void_bolt&(!equipped.empyreal_ordnance|!talent.hungering_void.enabled)|equipped.empyreal_ordnance&trinket.empyreal_ordnance.cooldown.remains<=162&debuff.hungering_void.up))|(buff.voidform.up&talent.searing_nightmare.enabled)	
		if A.BoonoftheAscended:IsReady("player") and ((Unit("player"):HasBuffs(A.VoidformBuff.ID, true) == 0 and A.VoidEruption:GetCooldown() > 0 and EnemiesCount() > 1 and UseAoE and not A.SearingNightmare:IsTalentLearned()) or (Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > 0 and (EnemiesCount() < 2 or not UseAoE) and not A.SearingNightmare:IsTalentLearned() and (Player:PrevGCD(1, A.VoidBolt)) or (Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > 0 and A.SearingNightmare:IsTalentLearned())) or (Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > 0 and A.SearingNightmare:IsTalentLearned())) then
			return A.BoonoftheAscended:Show(icon)
		end
		
		-- call_action_list,name=trinkets
		if A.BurstIsON(unit) and Trinkets() then
			return Trinkets()
		end
end

local function Boon()
		-- ascended_blast,if=spell_targets.mind_sear<=3
		if A.AscendedBlast:IsReady(unit) and (EnemiesCount() <= 3 or not UseAoE) then
			return A.AscendedBlast:Show(icon)
		end
		-- ascended_nova,if=spell_targets.ascended_nova>1&spell_targets.mind_sear>1+talent.searing_nightmare.enabled
		if A.AscendedNova:IsReady("player") and (MultiUnits:GetByRange(8, 2) > 1 and EnemiesCount() > (1 + num(A.SearingNightmare:IsTalentLearned()))) then
			return A.AscendedNova:Show(icon)
		end
end

local function Cwc()

	-- # Use Searing Nightmare if you will hit enough targets and Power Infusion and Voidform are not ready, or to refresh SW:P on two or more targets.
    -- actions.cwc=searing_nightmare,use_while_casting=1,target_if=(variable.searing_nightmare_cutoff&!variable.pool_for_cds)|(dot.shadow_word_pain.refreshable&spell_targets.mind_sear>1)
    if not A.SearingNightmare:IsBlocked() and Player:Insanity() >= 30 and ChannelCheckplayer == A.MindSear.ID and A.SearingNightmare:IsTalentLearned() and ((snmCutoff and not pool) or (not swpCheck() and EnemiesCount() > 1)) then
        return A.SearingNightmare:Show(icon)
    end

    -- # Short Circuit Searing Nightmare condition to keep SW:P up in AoE
    -- actions.cwc+=/searing_nightmare,use_while_casting=1,target_if=talent.searing_nightmare.enabled&dot.shadow_word_pain.refreshable&spell_targets.mind_sear>2
    if not A.SearingNightmare:IsBlocked() and Player:Insanity() >= 30 and ChannelCheckplayer == A.MindSear.ID and (A.SearingNightmare:IsTalentLearned() and not swpCheck() and EnemiesCount() > 2) then
		return A.SearingNightmare:Show(icon)
    end
	
	-- # Only_cwc makes the action only usable during channeling and not as a regular action.
	-- actions.cwc+=/mind_blast,only_cwc=1	
	if not A.MindBlast:IsBlocked() and (A.MindBlast:GetCooldown() == 0 and ((EnemiesCount() < 4) 
	or (EnemiesCount() >= 4 and Unit("player"):HasBuffs(A.DarkThought.ID, true) > 0))) and (ChannelCheckplayer == A.MindSear.ID or ChannelCheckplayer == A.MindFlay.ID) and ((Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > A.VoidBolt:GetCooldown() and A.VoidBolt:GetCooldown() > A.MindBlast:CastTime()) or (Unit("player"):HasBuffs(A.VoidformBuff.ID, true) == 0)) then
		return A.MindBlast:Show(icon)
	end

	if not A.VoidEruption:IsBlocked() and A.VoidEruption:GetCooldown() == 0 and Unit("player"):HasBuffs(A.VoidformBuff.ID, true) == 0 and (ChannelCheckplayer == A.MindFlay.ID or ChannelCheckplayer == A.MindSear.ID) and A.BurstIsON(unit) and not isMoving and (pool and Player:Insanity() >= 40 and (Player:Insanity() <= 85 or (A.SearingNightmare:IsTalentLearned() and snmCutoff)) and fiendCD() > 0 and (A.MindBlast:GetCooldown() > 0 or EnemiesCount() > 2)) then
		return A.VoidEruption:Show(icon)
	end
		
	if not A.Damnation:IsBlocked() and A.Damnation:IsReady(unit) and not VarAllDotsUp and (ChannelCheckplayer == A.MindFlay.ID or ChannelCheckplayer == A.MindSear.ID) and swpCheck() then
		return A.Damnation:Show(icon)
	end
		
	if not A.VoidBolt:IsBlocked() and A.VoidBolt:GetCooldown() == 0 and swpCheck() and (Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > 0 or Unit("player"):HasBuffs(A.DissonantEchoesBuff.ID, true) > 0) and (ChannelCheckplayer == A.MindFlay.ID or ChannelCheckplayer == A.MindSear.ID) 
	and ((Player:Insanity() <= 85 and A.SearingNightmare:IsTalentLearned() and EnemiesCount() <= 6) or (A.HungeringVoid:IsTalentLearned() and not A.SearingNightmare:IsTalentLearned()) or (EnemiesCount() == 1)) then
		return A.VoidBolt:Show(icon)
	end
	
	if not A.DevouringPlague:IsBlocked() and (Player:Insanity() >= 50) and (ChannelCheckplayer == A.MindFlay.ID or ChannelCheckplayer == A.MindSear.ID) 
	and ((Unit("target"):HasDeBuffs(A.DevouringPlague.ID, true) <= 2 or Player:Insanity() > 75) and (not pool or Player:Insanity() >= 85) 
	and (not A.SearingNightmare:IsTalentLearned() or (A.SearingNightmare:IsTalentLearned() and not snmCutoff))) then
		return A.DevouringPlague:Show(icon)
	end	
	
	if not A.VoidBolt:IsBlocked() and A.VoidBolt:GetCooldown() == 0 and (Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > 0 or Unit("player"):HasBuffs(A.DissonantEchoesBuff.ID, true) > 0) and ((EnemiesCount() < (4 + num(A.DissonantEchoes:IsSoulbindLearned())) and Player:Insanity() <= 85 and A.SearingNightmare:IsTalentLearned()) or (not A.SearingNightmare:IsTalentLearned())) then
		return A.VoidBolt:Show(icon)
	end
	
	if not A.ShadowWordDeath:IsBlocked() and (A.ShadowWordDeath:GetCooldown() == 0) and Unit("player"):HealthPercent() >= 50 and (ChannelCheckplayer == A.MindFlay.ID or ChannelCheckplayer == A.MindSear.ID) 
	and ((Unit("target"):HealthPercent() < 20 and (EnemiesCount() < 4 or not UseAoE)) or ((A.MindBender:GetSpellTimeSinceLastCast() < 15 or A.Shadowfiend:GetSpellTimeSinceLastCast() <15) and A.ShadowflamePrism:HasLegendaryCraftingPower())) then
		return A.ShadowWordDeath:Show(icon)
	end
	
	if not A.VoidTorrent:IsBlocked() and (A.VoidTorrent:GetCooldown() == 0 and A.VoidTorrent:IsTalentLearned()) and (ChannelCheckplayer == A.MindFlay.ID or ChannelCheckplayer == A.MindSear.ID)  
	and ((VarDotsUp and Unit("target"):TimeToDie() > 3 and not isMoving and (Unit("player"):HasBuffs(A.VoidformBuff.ID, true) == 0)) or (Unit("player"):HasBuffs(A.VoidformBuff.ID, true) < A.VoidBolt:GetCooldown()) and vtCheck() and (EnemiesCount() < (5 + (6 * (num(A.TwistofFateTalent:IsTalentLearned())))) or not UseAoE)) then
		return A.VoidTorrent:Show(icon)
	end
	
	if ((not A.MindBender:IsBlocked() and A.MindBender:IsTalentLearned()) or (not A.Shadowfiend:IsBlocked() and not A.MindBender:IsTalentLearned())) and (ChannelCheckplayer == A.MindFlay.ID or ChannelCheckplayer == A.MindSear.ID) and ((A.MindBender:GetCooldown() == 0 and A.MindBender:IsTalentLearned()) or (A.Shadowfiend:GetCooldown() == 0 and not A.MindBender:IsTalentLearned())) and A.BurstIsON(unit) and Unit("target"):HasDeBuffs(A.VampiricTouch.ID, true) > 0 and (A.SearingNightmare:IsTalentLearned() and EnemiesCount() > searCutoff or Unit("target"):HasDeBuffs(A.ShadowWordPain.ID, true)) and (not A.ShadowflamePrism:HasLegendaryCraftingPower() or vtCheck()) then
		if A.MindBender:IsTalentLearned() and Unit("target"):TimeToDie() >= 6 then
			return A.MindBender:Show(icon)
		else
			return A.Shadowfiend:Show(icon)
		end
	end
		
	if not A.ShadowWordDeath:IsBlocked() and (ChannelCheckplayer == A.MindFlay.ID or ChannelCheckplayer == A.MindSear.ID) and Unit("player"):HealthPercent() >= 50 and A.ShadowWordDeath:GetCooldown() == 0 and (A.PainbreakerPsalm:HasLegendaryCraftingPower() and VarDotsUp and Unit("target"):TimeToDieX(20) > (A.ShadowWordDeath:GetCooldownDuration() + GetGCD())) then
		return A.ShadowWordDeath:Show(icon)
	end
	
	if not A.MindGames:IsBlocked() and A.BurstIsON(unit) and (ChannelCheckplayer == A.MindFlay.ID or ChannelCheckplayer == A.MindSear.ID) and A.MindGames:GetCooldown() == 0 and C_Covenants.GetActiveCovenantID() == 2 and (Unit("player"):HasBuffs(A.VoidformBuff.ID, true) == 0 and A.VoidEruption:GetCooldown() > 0) and not IsMoving and Unit("target"):TimeToDie() > 10 then
		return A.MindGames:Show(icon)
	end	
	
	if not A.ShadowCrash:IsBlocked() and (ChannelCheckplayer == A.MindFlay.ID or ChannelCheckplayer == A.MindSear.ID) and (A.ShadowCrash:GetCooldown() == 0 and A.ShadowCrash:IsTalentLearned()) and Unit("target"):TimeToDie() > 3 then
		return A.ShadowCrash:Show(icon)
	end	
	
	if not A.MindBlast:IsBlocked() and (ChannelCheckplayer == A.MindFlay.ID or ChannelCheckplayer == A.MindSear.ID) and A.MindBlast:GetCooldown() == 0 and not isMoving and VarDotsUp and (((A.MindBender:GetSpellTimeSinceLastCast() < 15 or A.Shadowfiend:GetSpellTimeSinceLastCast() <15) and A.ShadowflamePrism:HasLegendaryCraftingPower()) or ((EnemiesCount() < 4 or not UseAoE) and not A.Misery:IsTalentLearned()) or ((EnemiesCount() < 6 or not UseAoE) and A.Misery:IsTalentLearned())) and ((Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > A.VoidBolt:GetCooldown() and A.VoidBolt:GetCooldown() > A.MindBlast:CastTime()) or (Unit("player"):HasBuffs(A.VoidformBuff.ID, true) == 0)) then
		return A.MindBlast:Show(icon)
	end

	if not A.VampiricTouch:IsBlocked() and (ChannelCheckplayer == A.MindFlay.ID or ChannelCheckplayer == A.MindSear.ID) and A.VampiricTouch:GetCooldown() == 0 and not isMoving and not vtCheck() and VTDoubleCheck() and ((Unit("target"):HasDeBuffs(A.VampiricTouchDebuff.ID, true) < (4 + A.VampiricTouch:CastTime()) and Unit("target"):TimeToDie() > (6 + A.VampiricTouch:CastTime())) or (A.Misery:IsTalentLearned() and Unit("target"):HasDeBuffs(A.ShadowWordPain.ID, true) < (4 + A.VampiricTouch:CastTime())) or (Unit("player"):HasBuffs(A.UnfurlingDarknessBuff.ID, true) > 0)) then
		return A.VampiricTouch:Show(icon)
	end
		
	if not A.VampiricTouch:IsBlocked() and (ChannelCheckplayer == A.MindFlay.ID or ChannelCheckplayer == A.MindSear.ID) and Player:GetDeBuffsUnitCount(A.VampiricTouchDebuff.ID) < VTmaxTargets and VTDoubleCheck() and (A.MindFlay:GetSpellTimeSinceLastCast() >= 1 or A.MindSear:GetSpellTimeSinceLastCast() >= 1) and not vtCheck() and ((A.SearingNightmare:IsTalentLearned() and (EnemiesCount() < 7 and Player:Insanity() < 30 and Unit("player"):HasBuffs(A.DarkThought.ID, true) == 0)) or not A.SearingNightmare:IsTalentLearned()) and CastCheckplayer ~= A.VampiricTouch.ID
	and Unit("target"):HasDeBuffs(A.VampiricTouchDebuff.ID, true) > (4 + A.VampiricTouch:CastTime()) and MultiDoTCheck then
		for VTUnit in pairs(ActiveUnitPlates) do
			if not isMoving and CastCheckplayer ~= A.VampiricTouch.ID and (Unit(VTUnit):HasDeBuffs(A.VampiricTouchDebuff.ID, true) < (4 + A.VampiricTouch:CastTime()) and Unit(VTUnit):TimeToDie() > (6 + A.VampiricTouch:CastTime()) or (A.Misery:IsTalentLearned() and Unit(VTUnit):HasDeBuffs(A.ShadowWordPain.ID, true) < 4 + A.VampiricTouch:CastTime()) or (Unit("player"):HasBuffs(A.UnfurlingDarknessBuff.ID, true) > 0))
			and ((UnitCanAttack("player", VTUnit) and UnitAffectingCombat("target") and IsItemInRange(Checkitem, VTUnit) and UnitDetailedThreatSituation("player", VTUnit) ~= nil) or Unit(VTUnit):IsDummy()) then
				if not noDotCheck(VTUnit) then
                     return A:Show(icon, ACTION_CONST_AUTOTARGET)
				end
			end
		end
	end

	if not A.ShadowWordPain:IsBlocked() and A.ShadowWordPain:GetCooldown() == 0 and (ChannelCheckplayer == A.MindFlay.ID or ChannelCheckplayer == A.MindSear.ID) and Unit('target'):HasDeBuffs(A.ShadowWordPain.ID, true) < 2 and Unit("target"):TimeToDie() > 4 and not A.Misery:IsTalentLearned() and A.PsychicLink:IsTalentLearned() and EnemiesCount() > 2 then
		return A.ShadowWordPain:Show(icon)
	end

	if not A.ShadowWordPain:IsBlocked() and A.ShadowWordPain:GetCooldown() == 0 and Unit("player"):HealthPercent() >= 50 and (ChannelCheckplayer == A.MindFlay.ID or ChannelCheckplayer == A.MindSear.ID) and (Unit("target"):HasDeBuffs(A.ShadowWordPain.ID, true) < 2 and Unit("target"):TimeToDie() > 4 and not A.Misery:IsTalentLearned() and not (A.SearingNightmare:IsTalentLearned() and EnemiesCount() > searCutoff) and ((not A.PsychicLink:IsTalentLearned()) or (A.PsychicLink:IsTalentLearned() and (EnemiesCount() <= 2 or not UseAoE)))) then
		return A.ShadowWordPain:Show(icon)
	end

	if not A.ShadowWordPain:IsBlocked() and A.ShadowWordPain:GetCooldown() == 0 and Player:GetDeBuffsUnitCount(A.ShadowWordPain.ID) < SWPmaxTargets 
	and Unit("target"):HasDeBuffs(A.ShadowWordPain.ID, true) > 4  and MultiDoTCheck then
		for SWPUnit in pairs(ActiveUnitPlates) do
			if A.ShadowWordPain:IsReady(unit) and (Unit(SWPUnit):HasDeBuffs(A.ShadowWordPain.ID, true) < 4 and Unit(SWPUnit):TimeToDie() > 4 and not A.Misery:IsTalentLearned() and not (A.SearingNightmare:IsTalentLearned() and EnemiesCount() > searCutoff) and ((not A.PsychicLink:IsTalentLearned()) or (A.PsychicLink:IsTalentLearned() and (EnemiesCount() <= 2 or not UseAoE))))
			and ((UnitCanAttack("player", SWPUnit) and UnitAffectingCombat("target") and IsItemInRange(Checkitem, SWPUnit) and UnitDetailedThreatSituation("player", SWPUnit) ~= nil) or Unit(SWPUnit):IsDummy()) then
				if not noDotCheck(SWPUnit) then
					return A:Show(icon, ACTION_CONST_AUTOTARGET)
				end
			end
		end
	end
end


local function Main()

		-- call_action_list,name=boon,if=buff.boon_of_the_ascended.up
		if (Unit("player"):HasBuffs(A.BoonoftheAscended.ID, true) > 0) and Boon() then
			return Boon()
		end
		
		-- # Use Void Eruption on cooldown pooling at least 40 insanity but not if you will overcap insanity in VF. Make sure shadowfiend/mindbender and Mind Blast is on cooldown before VE.
		-- actions.main+=/void_eruption,if=variable.pool_for_cds&insanity>=40&(insanity<=85|talent.searing_nightmare.enabled&variable.searing_nightmare_cutoff)&!cooldown.fiend.up&(!cooldown.mind_blast.up|spell_targets.mind_sear>2)
		if A.VoidEruption:IsReady(unit) and A.BurstIsON(unit) and not isMoving and (pool and Player:Insanity() >= 40 and (Player:Insanity() <= 85 or (A.SearingNightmare:IsTalentLearned() and snmCutoff)) and fiendCD() > 0 and (A.MindBlast:GetCooldown() > 0 or EnemiesCount() > 2)) then
			return A.VoidEruption:Show(icon)
		end
		
		-- # Make sure you put up SW:P ASAP on the target if Wrathful Faerie isn't active.
		-- actions.main+=/shadow_word_pain,if=buff.fae_guardians.up&!debuff.wrathful_faerie.up
		if A.ShadowWordPain:IsReady(unit) and ((Unit("player"):HasBuffs(A.BenevolentFaerie.ID, true) > 0 or Unit("player"):HasBuffs(A.GuardianFaerie.ID, true) > 0) and Unit("target"):HasDeBuffs(A.WrathfulFaerie.ID, true) == 0) then
			return A.ShadowWordPain:Show(icon)
		end
		
		if Cds() and A.BurstIsON(unit) then
			return Cds()
		end
		
		-- # High Priority Mind Sear action to refresh DoTs with Searing Nightmare
		-- actions.main+=/mind_sear,target_if=talent.searing_nightmare.enabled&spell_targets.mind_sear>variable.mind_sear_cutoff&!dot.shadow_word_pain.ticking&!cooldown.fiend.up
		if A.MindSear:IsReady(unit) and not isMoving and UseAoE and (A.SearingNightmare:IsTalentLearned() and EnemiesCount() > searCutoff and swpCheck() and fiendCD() > 0) then
			return A.MindSear:Show(icon)
		end

		-- # Prefer to use Damnation ASAP if any DoT is not up.
		-- actions.main+=/damnation,target_if=!variable.all_dots_up
		if A.Damnation:IsReady(unit) and not VarAllDotsUp then
			return A.Damnation:Show(icon)
		end
		-- # Use Void Bolt at higher priority with Hungering Void up to 4 targets, or other talents on ST.
		-- actions.main+=/void_bolt,if=insanity<=85&talent.hungering_void.enabled&talent.searing_nightmare.enabled&spell_targets.mind_sear<=6|((talent.hungering_void.enabled&!talent.searing_nightmare.enabled)|spell_targets.mind_sear=1)		
		if A.VoidBolt:IsReady(unit) and (Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > 0 or Unit("player"):HasBuffs(A.DissonantEchoesBuff.ID, true) > 0) and ((Player:Insanity() <= 85 and A.HungeringVoid:IsTalentLearned() and A.SearingNightmare:IsTalentLearned() and (EnemiesCount() <= 6 or not UseAoE)) or ((A.HungeringVoid:IsTalentLearned() and not A.SearingNightmare:IsTalentLearned()) or (EnemiesCount() == 1 or not UseAoE))) then
			return A.VoidBolt:Show(icon)
		end

		-- # Don't use Devouring Plague if you can get into Voidform instead, or if Searing Nightmare is talented and will hit enough targets.
		-- actions.main+=/devouring_plague,target_if=(refreshable|insanity>75)&(!variable.pool_for_cds|insanity>=85)&(!talent.searing_nightmare.enabled|(talent.searing_nightmare.enabled&!variable.searing_nightmare_cutoff))
		if A.DevouringPlague:IsReady(unit) and ((Unit("target"):HasDeBuffs(A.DevouringPlague.ID, true) < 2 or Player:Insanity() > 75) and (not pool or Player:Insanity() >= 85) and (not A.SearingNightmare:IsTalentLearned() or (A.SearingNightmare:IsTalentLearned() and not snmCutoff))) then
			return A.DevouringPlague:Show(icon)
		end

		-- # Use VB on CD if you don't need to cast Devouring Plague, and there are less than 4 targets out (5 with conduit).
		-- actions.main+=/void_bolt,if=spell_targets.mind_sear<(4+conduit.dissonant_echoes.enabled)&insanity<=85&talent.searing_nightmare.enabled|!talent.searing_nightmare.enabled
		if A.VoidBolt:IsReady(unit) and (Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > 0 or Unit("player"):HasBuffs(A.DissonantEchoesBuff.ID, true) > 0) and (((EnemiesCount() < (4 + num(A.DissonantEchoes:IsSoulbindLearned())) or not UseAoE) and Player:Insanity() <= 85 and A.SearingNightmare:IsTalentLearned()) or (not A.SearingNightmare:IsTalentLearned())) then
			return A.VoidBolt:Show(icon)
		end

		-- # Use Shadow Word: Death if the target is about to die or you have Shadowflame Prism equipped with Mindbender or Shadowfiend active.
		-- actions.main+=/shadow_word_death,target_if=(target.health.pct<20&spell_targets.mind_sear<4)|(pet.fiend.active&runeforge.shadowflame_prism.equipped)
		if A.ShadowWordDeath:IsReady(unit) and Unit("player"):HealthPercent() >= 50 and ((Unit("target"):HealthPercent() < 20 and (EnemiesCount() < 4 or not UseAoE)) or ((A.MindBender:GetSpellTimeSinceLastCast() < 15 or A.Shadowfiend:GetSpellTimeSinceLastCast() <15) and A.ShadowflamePrism:HasLegendaryCraftingPower())) then
			return A.ShadowWordDeath:Show(icon)
		end		
		
		-- # Use Surrender to Madness on a target that is going to die at the right time.
		-- actions.main+=/surrender_to_madness,target_if=target.time_to_die<25&buff.voidform.down
		if A.SurrenderToMadness:IsReady(unit) and Unit('target'):TimeToDie() < 20 and Unit("target"):HealthPercent() < 15 and Unit("player"):HasBuffs(A.VoidformBuff.ID, true) == 0 and A.BurstIsON(unit) then
			return A.SurrenderToMadness:Show(icon)
		end

		-- # Use Void Torrent only if SW:P and VT are active and the target won't die during the channel.
		-- actions.main+=/void_torrent,target_if=variable.dots_up&target.time_to_die>3&(buff.voidform.down|buff.voidform.remains<cooldown.void_bolt.remains)&active_dot.vampiric_touch==spell_targets.vampiric_touch&spell_targets.mind_sear<(5+(6*talent.twist_of_fate.enabled))
		if A.VoidTorrent:IsReady(unit) and not isMoving and (VarDotsUp and Unit("target"):TimeToDie() > 3 and (Unit("player"):HasBuffs(A.VoidformBuff.ID, true) == 0 or Unit("player"):HasBuffs(A.VoidformBuff.ID, true) < A.VoidBolt:GetCooldown()) and vtCheck() and (EnemiesCount() < (5 + (6 * (num(A.TwistofFateTalent:IsTalentLearned())))) or not UseAoE)) then
			return A.VoidTorrent:Show(icon)
		end
	
		-- actions.main+=/mindbender,if=dot.vampiric_touch.ticking&(talent.searing_nightmare.enabled&spell_targets.mind_sear>variable.mind_sear_cutoff|dot.shadow_word_pain.ticking)&(!runeforge.shadowflame_prism.equipped|active_dot.vampiric_touch==spell_targets.vampiric_touch)
		if ((A.MindBender:IsReady("player") and A.MindBender:IsTalentLearned()) or (A.Shadowfiend:IsReady("player") and not A.MindBender:IsTalentLearned())) and A.BurstIsON(unit) and Unit("target"):HasDeBuffs(A.VampiricTouch.ID, true) > 0 and ((A.SearingNightmare:IsTalentLearned() and EnemiesCount() > searCutoff) or (Unit("target"):HasDeBuffs(A.ShadowWordPain.ID, true))) and (not A.ShadowflamePrism:HasLegendaryCraftingPower() or vtCheck()) then
			if A.MindBender:IsTalentLearned() and Unit("target"):TimeToDie() >= 6 then
				return A.MindBender:Show(icon)
			else
				return A.Shadowfiend:Show(icon)
			end
		end
		
		-- # Use SW:D with Painbreaker Psalm unless the target will be below 20% before the cooldown comes back
		-- actions.main+=/shadow_word_death,if=runeforge.painbreaker_psalm.equipped&variable.dots_up&target.time_to_pct_20>(cooldown.shadow_word_death.duration+gcd)
		if A.ShadowWordDeath:IsReady(unit) and Unit("player"):HealthPercent() >= 50 and (A.PainbreakerPsalm:HasLegendaryCraftingPower() and VarDotsUp and Unit("target"):TimeToDieX(20) > (A.ShadowWordDeath:GetCooldownDuration() + GetGCD())) then
			return A.ShadowWordDeath:Show(icon)
		end

		--MindGames
		if A.MindGames:IsReady(unit) and (Unit("player"):HasBuffs(A.VoidformBuff.ID, true) == 0 and A.VoidEruption:GetCooldown() > 0) and not IsMoving and Unit("target"):TimeToDie() > 10 then
			return A.MindGames:Show(icon)
		end
		
		-- # Use Shadow Crash on CD unless there are adds incoming.
		-- actions.main+=/shadow_crash,if=raid_event.adds.in>10
		if A.ShadowCrash:IsReady("player") and Unit("target"):TimeToDie() > 3 then
			return A.ShadowCrash:Show(icon)
		end		
		
		-- # Use Mind Sear to consume Dark Thoughts procs on AOE. TODO Confirm is this is a higher priority than redotting on AOE unless dark thoughts is about to time out
		-- actions.main+=/mind_sear,target_if=spell_targets.mind_sear>variable.mind_sear_cutoff&buff.dark_thought.up,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2
		if A.MindSear:IsReady(unit) and not isMoving and UseAoE and (EnemiesCount() > searCutoff and Unit("player"):HasBuffs(A.DarkThought.ID, true) > 0) then
			return A.MindSear:Show(icon)
		end

		-- # Use Mind Flay to consume Dark Thoughts procs on ST. TODO Confirm if this is a higher priority than redotting unless dark thoughts is about to time out
		-- actions.main+=/mind_flay,if=buff.dark_thought.up&variable.dots_up,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2&cooldown.void_bolt.up
		if A.MindFlay:IsReady(unit) and not isMoving and Unit("player"):HasBuffs(A.DarkThought.ID, true) > 0 and VarDotsUp then
			return A.MindFlay:Show(icon)
		end

		-- # Use Mind Blast if you don't need to refresh DoTs. Stop casting at 4 or more targets with Searing Nightmare talented and you are not using Shadowflame Prism.
		-- actions.main+=/mind_blast,if=variable.dots_up&(pet.fiend.active&runeforge.shadowflame_prism.equipped
		--|spell_targets.mind_sear<4&!talent.misery.enabled|spell_targets.mind_sear<6&talent.misery.enabled)
		if A.MindBlast:IsReady(unit) and not isMoving and VarDotsUp and (((EnemiesCount() < 4 or not UseAoE) and not A.Misery:IsTalentLearned()) or ((EnemiesCount() < 6 or not UseAoE) and A.Misery:IsTalentLearned()) and ((Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > A.VoidBolt:GetCooldown() and A.VoidBolt:GetCooldown() > A.MindBlast:CastTime()) or (Unit("player"):HasBuffs(A.VoidformBuff.ID, true) == 0))) then
			return A.MindBlast:Show(icon)
		end

		--actions.main+=/vampiric_touch,target_if=refreshable&target.time_to_die>6|(talent.misery.enabled&dot.shadow_word_pain.refreshable)|buff.unfurling_darkness.up
		if A.VampiricTouch:IsReady(unit) and not isMoving and CastCheckplayer ~= A.VampiricTouch.ID and not vtCheck() and VTDoubleCheck() and ((Unit("target"):HasDeBuffs(A.VampiricTouchDebuff.ID, true) < (4 + A.VampiricTouch:CastTime()) and Unit("target"):TimeToDie() > (6 + A.VampiricTouch:CastTime())) or (A.Misery:IsTalentLearned() and Unit("target"):HasDeBuffs(A.ShadowWordPain.ID, true) < 4 + A.VampiricTouch:CastTime()) or (Unit("player"):HasBuffs(A.UnfurlingDarknessBuff.ID, true) > 0)) then
			return A.VampiricTouch:Show(icon)
		end

		if A.VampiricTouch:IsReady(unit) and Player:GetDeBuffsUnitCount(A.VampiricTouchDebuff.ID) < VTmaxTargets and not vtCheck() and CastCheckplayer ~= A.VampiricTouch.ID and ((not A.SearingNightmare:IsTalentLearned()) or (A.SearingNightmare:IsTalentLearned() and ((EnemiesCount() < 7 and Player:Insanity() <= 30) or EnemiesCount() < 4)))
		and Unit("target"):HasDeBuffs(A.VampiricTouchDebuff.ID, true) > 4 and Unit("target"):HasDeBuffs(A.ShadowWordPain.ID, true) > 4 and MultiDoTCheck then
			for VTUnit in pairs(ActiveUnitPlates) do
				if not isMoving and CastCheckplayer ~= A.VampiricTouch.ID and ((Unit(VTUnit):HasDeBuffs(A.VampiricTouchDebuff.ID, true) < (4 + A.VampiricTouch:CastTime()) and Unit(VTUnit):TimeToDie() > (6 + A.VampiricTouch:CastTime())) or (A.Misery:IsTalentLearned() and Unit(VTUnit):HasDeBuffs(A.ShadowWordPain.ID, true) < 4 + A.VampiricTouch:CastTime()) or (Unit("player"):HasBuffs(A.UnfurlingDarknessBuff.ID, true) > 0))				
				and ((UnitCanAttack("player", VTUnit) and UnitAffectingCombat("target") and IsItemInRange(Checkitem, VTUnit) and UnitDetailedThreatSituation("player", VTUnit) ~= nil) or Unit(VTUnit):IsDummy()) then
					if not noDotCheck(VTUnit) then
                        return A:Show(icon, ACTION_CONST_AUTOTARGET)
					end
				end
			end
		end

		-- # Special condition to stop casting SW:P on off-targets when fighting 3 or more stacked mobs and using Psychic Link and NOT Misery.
		-- actions.main+=/shadow_word_pain,if=refreshable&target.time_to_die>4&!talent.misery.enabled&talent.psychic_link.enabled&spell_targets.mind_sear>2
		if A.ShadowWordPain:IsReady(unit) and Unit('target'):HasDeBuffs(A.ShadowWordPain.ID, true) < 4 and Unit("target"):TimeToDie() > 4 and not A.Misery:IsTalentLearned() and A.PsychicLink:IsTalentLearned() and EnemiesCount() > 2 then
			return A.ShadowWordPain:Show(icon)
		end

		-- # Keep SW:P up on as many targets as possible, except when fighting 3 or more stacked mobs with Psychic Link.
		-- actions.main+=/shadow_word_pain,target_if=refreshable&target.time_to_die>4&!talent.misery.enabled&!(talent.searing_nightmare.enabled&spell_targets.mind_sear>variable.mind_sear_cutoff)&(!talent.psychic_link.enabled|(talent.psychic_link.enabled&spell_targets.mind_sear<=2))
		if A.ShadowWordPain:IsReady(unit) and (Unit("target"):HasDeBuffs(A.ShadowWordPain.ID, true) < 4 and Unit("target"):TimeToDie() > 4 and not A.Misery:IsTalentLearned() and not (A.SearingNightmare:IsTalentLearned() and EnemiesCount() > searCutoff) and ((not A.PsychicLink:IsTalentLearned()) or (A.PsychicLink:IsTalentLearned() and (EnemiesCount() <= 2 or not UseAoE)))) then
			return A.ShadowWordPain:Show(icon)
		end

		if A.ShadowWordPain:IsReady(unit) and Player:GetDeBuffsUnitCount(A.ShadowWordPain.ID) < SWPmaxTargets 
		and Unit("target"):HasDeBuffs(A.ShadowWordPain.ID, true) > 4  and MultiDoTCheck then
			for SWPUnit in pairs(ActiveUnitPlates) do
				if A.ShadowWordPain:IsReady(unit) and (Unit(SWPUnit):HasDeBuffs(A.ShadowWordPain.ID, true) < 4 and Unit(SWPUnit):TimeToDie() > 4 and ((not A.Misery:IsTalentLearned() and not (A.SearingNightmare:IsTalentLearned() and EnemiesCount() > searCutoff) and ((not A.PsychicLink:IsTalentLearned()) or (A.PsychicLink:IsTalentLearned() and (EnemiesCount() <= 2 or not UseAoE)))) or (isMoving)))
				and ((UnitCanAttack("player", SWPUnit) and UnitAffectingCombat("target") and IsItemInRange(Checkitem, SWPUnit) and UnitDetailedThreatSituation("player", SWPUnit) ~= nil) or Unit(SWPUnit):IsDummy()) then
					if not noDotCheck(SWPUnit) then
                        return A:Show(icon, ACTION_CONST_AUTOTARGET)
					end
				end
			end
		end

		--actions.main+=/mind_sear,target_if=spell_targets.mind_sear>variable.mind_sear_cutoff,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2
		if A.MindSear:IsReady(unit) and EnemiesCount() > searCutoff and UseAoE and not isMoving then
			return A.MindSear:Show(icon)
		end

		--actions.main+=/mind_flay,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2&cooldown.void_bolt.up
		if A.MindFlay:IsReady(unit) and not isMoving then
			return A.MindFlay:Show(icon)
		end

		-- # Use SW:D as last resort if on the move
		-- actions.main+=/shadow_word_death
		if A.ShadowWordDeath:IsReady(unit) and Unit("player"):HealthPercent() >= 50 then
			return A.ShadowWordDeath:Show(icon)
		end

		-- # Use SW:P as last resort if on the move and SW:D is on CD
		-- actions.main+=/shadow_word_pain
		if A.ShadowWordPain:IsReady(unit) then
			return A.ShadowWordPain:Show(icon)
		end
end


	if Unit("player"):HasBuffs(A.Shadowform.ID, true) == 0 then
		if Unit("player"):HasBuffs(A.VoidformBuff.ID, true) == 0 then
			return A.Shadowform:Show(icon)
		end
    end
	
	if not inCombat and Precombat() then
		return Precombat()
	end
			
	local Interrupt = Interrupts(unit)
    if Interrupt then 
        return Interrupt:Show(icon)
    end   
	
	if (A.BurstIsON(unit)) then
		-- fireblood,if=buff.voidform.up
		if A.Fireblood:IsReady() and (Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > 0) then
			return A.Fireblood:Show(icon)
		end
		
		 -- berserking,if=buff.voidform.up
		if A.Berserking:IsReady("player") and (Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > 0) then
			return A.Berserking:Show(icon)
		end
		
		-- lights_judgment,if=spell_targets.lights_judgment>=2|(!raid_event.adds.exists|raid_event.adds.in>75)
		if A.LightsJudgement:IsReady("player") then
			return A.LightsJudgement:Show(icon)
		end
		
		-- ancestral_call,if=buff.voidform.up
		if A.AncestralCall:IsReady("player") and (Unit("player"):HasBuffs(A.VoidformBuff.ID, true) > 0) then
			return A.AncestralCall:Show(icon)
		end
		
		-- bag_of_tricks
		if A.BagofTricks:IsReady("player") then
			return A.BagofTricks:Show(icon)
		end
    end

	if Cwc() then
		return Cwc()
	end
	
	if Main() then
		return Main()
	end
	
    end -- End on EnemyRotation()   	   
	
        -- Mouseover     
        if A.IsUnitEnemy("mouseover") and not Unit("mouseover"):IsDead() then 
            unit = "mouseover"
                if EnemyRotation(unit) then 
                    return true 
                end 
        end 
    
        -- Target             
        if A.IsUnitEnemy("target") and not Unit("target"):IsDead() then 
            unit = "target"
                if EnemyRotation(unit) then 
                    return true 
                end 
        end         
end -- A[3] end
-- Finished

A[1] = nil

A[4] = nil

A[5] = nil

A[6] = nil

A[7] = nil

A[8] = nil