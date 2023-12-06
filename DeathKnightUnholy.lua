local _G, setmetatable, pairs, type, math    = _G, setmetatable, pairs, type, math
local huge                                     = math.huge

local TMW                                     = _G.TMW 
local A                                         = _G.Action
local Covenant                                    = _G.LibStub("Covenant")

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
local Pet                                       = LibStub("PetLibrary") 
local MultiUnits                            = Action.MultiUnits
local UnitCooldown                            = Action.UnitCooldown
local Unit                                    = Action.Unit 
local IsUnitEnemy                            = Action.IsUnitEnemy
local IsUnitFriendly                        = Action.IsUnitFriendly
local Combat                        = Action.Combat
local ActiveUnitPlates                          = MultiUnits:GetActiveUnitPlates()
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local pairs                                     = pairs


local ACTION_CONST_DEATHKNIGHT_UNHOLY             = CONST.DEATHKNIGHT_UNHOLY
local ACTION_CONST_AUTOTARGET                = CONST.AUTOTARGET
local ACTION_CONST_SPELLID_FREEZING_TRAP    = CONST.SPELLID_FREEZING_TRAP

local IsIndoors, UnitIsUnit                    = _G.IsIndoors, _G.UnitIsUnit

Action[ACTION_CONST_DEATHKNIGHT_UNHOLY] = {
    -- Racial
    ArcaneTorrent                    = Action.Create({ Type = "Spell", ID = 50613    }),
    BloodFury                        = Action.Create({ Type = "Spell", ID = 20572    }),
    Fireblood                        = Action.Create({ Type = "Spell", ID = 265221   }),
    AncestralCall                    = Action.Create({ Type = "Spell", ID = 274738   }),
    Berserking                        = Action.Create({ Type = "Spell", ID = 26297    }),
    ArcanePulse                        = Action.Create({ Type = "Spell", ID = 260364   }),
    QuakingPalm                        = Action.Create({ Type = "Spell", ID = 107079   }),
    Haymaker                        = Action.Create({ Type = "Spell", ID = 287712   }), 
    WarStomp                        = Action.Create({ Type = "Spell", ID = 20549    }),
    BullRush                        = Action.Create({ Type = "Spell", ID = 255654   }),  
    GiftofNaaru                        = Action.Create({ Type = "Spell", ID = 59544    }),
    Shadowmeld                        = Action.Create({ Type = "Spell", ID = 58984    }), 
    Stoneform                        = Action.Create({ Type = "Spell", ID = 20594    }), 
    BagofTricks                        = Action.Create({ Type = "Spell", ID = 312411    }),
    WilloftheForsaken                = Action.Create({ Type = "Spell", ID = 7744        }),   
    EscapeArtist                    = Action.Create({ Type = "Spell", ID = 20589    }), 
    EveryManforHimself                = Action.Create({ Type = "Spell", ID = 59752    }), 
    LightsJudgment                    = Action.Create({ Type = "Spell", ID = 255647    }),
	RocketJump                    	= Action.Create({ Type = "Spell", ID = 69070    }),
	DarkFlight						= Action.Create({ Type = "Spell", ID = 68992    }),
    
    -- Death Knight General
    AntiMagicShell                    = Action.Create({ Type = "Spell", ID = 48707    }),
    AntiMagicZone                    = Action.Create({ Type = "Spell", ID = 51052    }),
    ChainsofIce                        = Action.Create({ Type = "Spell", ID = 45524    }),
    ControlUndead                    = Action.Create({ Type = "Spell", ID = 111673    }),
    DarkCommand                        = Action.Create({ Type = "Spell", ID = 56222    }),
    DeathandDecay                    = Action.Create({ Type = "Spell", ID = 43265    }),
	DeathandDecayBuff                = Action.Create({ Type = "Spell", ID = 188290    }),
    DeathCoil                        = Action.Create({ Type = "Spell", ID = 47541    }),
    DeathGate                        = Action.Create({ Type = "Spell", ID = 50977    }),
    DeathGrip                        = Action.Create({ Type = "Spell", ID = 49576    }),
    DeathStrike                        = Action.Create({ Type = "Spell", ID = 49998    }),
    DeathsAdvance                    = Action.Create({ Type = "Spell", ID = 48265    }),    
    IceboundFortitude                = Action.Create({ Type = "Spell", ID = 48792    }),
    Lichborne                        = Action.Create({ Type = "Spell", ID = 49039    }),    
    MindFreeze                        = Action.Create({ Type = "Spell", ID = 47528    }),
    PathofFrost                        = Action.Create({ Type = "Spell", ID = 3714        }),
    RaiseAlly                        = Action.Create({ Type = "Spell", ID = 61999    }),
    Runeforging                        = Action.Create({ Type = "Spell", ID = 53428    }),
    SacrificialPact                    = Action.Create({ Type = "Spell", ID = 327574    }),
    OnaPaleHorse                    = Action.Create({ Type = "Spell", ID = 51986, Hidden = true        }),
    VeteranoftheFourthWar            = Action.Create({ Type = "Spell", ID = 319278, Hidden = true    }),
    UnholyStrength                    = Action.Create({ Type = "Spell", ID = 53365, Hidden = true        }),
	PetClaw							= Action.Create({ Type = "SpellSingleColor", ID = 47468, Color = "RED", Desc = "Pet1"   }),
	PetAttack						= Action.Create({ Type = "SpellSingleColor", ID = 117440514, Color = "GREEN"        }),
    
    -- Unholy Specific
    Apocalypse                        = Action.Create({ Type = "Spell", ID = 275699    }),
    ArmyoftheDead                    = Action.Create({ Type = "Spell", ID = 42650    }),
    DarkTransformation                = Action.Create({ Type = "Spell", ID = 63560    }),    
    Epidemic                        = Action.Create({ Type = "Spell", ID = 207317    }),
    FesteringStrike                    = Action.Create({ Type = "Spell", ID = 85948    }),
    FesteringWound                    = Action.Create({ Type = "Spell", ID = 194310, Hidden = true    }),
    Outbreak                        = Action.Create({ Type = "Spell", ID = 77575    }),
	FrostFever						= Action.Create({ Type = "Spell", ID = 55095    }),
	BloodPlague						= Action.Create({ Type = "Spell", ID = 55078    }),
    VirulentPlague                    = Action.Create({ Type = "Spell", ID = 191587    }),    
    RaiseDead                        = Action.Create({ Type = "Spell", ID = 46584    }),
    ScourgeStrike                    = Action.Create({ Type = "Spell", ID = 55090    }),
    DarkSuccor                        = Action.Create({ Type = "Spell", ID = 178819, Hidden = true    }),
    MasteryDreadblade                = Action.Create({ Type = "Spell", ID = 77515, Hidden = true        }),
    RunicCorruption                    = Action.Create({ Type = "Spell", ID = 51462, Hidden = true        }),
    SuddenDoom                        = Action.Create({ Type = "Spell", ID = 49530, Hidden = true        }),
    SuddenDoomBuff                    = Action.Create({ Type = "Spell", ID = 81340, Hidden = true        }),        
    
    -- Normal Talents
    InfectedClaws                    = Action.Create({ Type = "Spell", ID = 207272, Hidden = true    }),
    AllWillServe                    = Action.Create({ Type = "Spell", ID = 194916, Hidden = true    }),
    ClawingShadows                    = Action.Create({ Type = "Spell", ID = 207311    }),
    BurstingSores                    = Action.Create({ Type = "Spell", ID = 207264, Hidden = true    }),
    EbonFever                        = Action.Create({ Type = "Spell", ID = 207269, Hidden = true    }),
    UnholyBlight                    = Action.Create({ Type = "Spell", ID = 115989    }),
    UnholyBlightDebuff                = Action.Create({ Type = "Spell", ID = 115994, Hidden = true    }),
    GripoftheDead                    = Action.Create({ Type = "Spell", ID = 273952, Hidden = true    }),
    DeathsReach                        = Action.Create({ Type = "Spell", ID = 276079, Hidden = true    }),
    Asphyxiate                        = Action.Create({ Type = "Spell", ID = 108194    }),
    PestilentPustules                = Action.Create({ Type = "Spell", ID = 194917, Hidden = true    }),
    HarbingerofDoom                    = Action.Create({ Type = "Spell", ID = 276023, Hidden = true    }),
    SoulReaper                        = Action.Create({ Type = "Spell", ID = 343294    }),
    SpellEater                        = Action.Create({ Type = "Spell", ID = 207321, Hidden = true    }),
    WraithWalk                        = Action.Create({ Type = "Spell", ID = 212552    }),
    DeathPact                        = Action.Create({ Type = "Spell", ID = 48743    }),    
    Pestilence                        = Action.Create({ Type = "Spell", ID = 277234, Hidden = true    }),
    UnholyPact                        = Action.Create({ Type = "Spell", ID = 319230, Hidden = true    }),
    Defile                            = Action.Create({ Type = "Spell", ID = 152280    }),
    ArmyoftheDamned                    = Action.Create({ Type = "Spell", ID = 276837, Hidden = true    }),
    SummonGargoyle                    = Action.Create({ Type = "Spell", ID = 49206    }),
    UnholyAssault                    = Action.Create({ Type = "Spell", ID = 207289    }),    
    
    -- PvP Talents
    DarkSimulacrum                    = Action.Create({ Type = "Spell", ID = 77606    }),
    NecroticStrike                    = Action.Create({ Type = "Spell", ID = 223829    }),
    LifeandDeath                    = Action.Create({ Type = "Spell", ID = 288855, Hidden = true    }),
    Reanimation                        = Action.Create({ Type = "Spell", ID = 210128    }),
    CadaverousPallor                = Action.Create({ Type = "Spell", ID = 201995, Hidden = true    }),
    NecroticAura                    = Action.Create({ Type = "Spell", ID = 199642, Hidden = true    }),
    DecomposingAura                    = Action.Create({ Type = "Spell", ID = 199720, Hidden = true    }),
    NecromancersBargain                = Action.Create({ Type = "Spell", ID = 288848, Hidden = true    }),    
    RaiseAbomination                = Action.Create({ Type = "Spell", ID = 288853    }),
    Transfusion                        = Action.Create({ Type = "Spell", ID = 288977    }),
    DomeofAncientShadow                = Action.Create({ Type = "Spell", ID = 328718, Hidden = true    }),    
    
    -- Covenant Abilities
    SummonSteward                    = Action.Create({ Type = "Spell", ID = 324739    }),
    DoorofShadows                    = Action.Create({ Type = "Spell", ID = 300728    }),
    Fleshcraft                        = Action.Create({ Type = "Spell", ID = 321687    }),
	Fleshcraftshield                  = Action.Create({ Type = "Spell", ID = 324867    }),
    Soulshape                        = Action.Create({ Type = "Spell", ID = 310143    }),
    Flicker                            = Action.Create({ Type = "Spell", ID = 324701    }),
    ShackletheUnworthy                = Action.Create({ Type = "Spell", ID = 312202    }),
    SwarmingMist                    = Action.Create({ Type = "Spell", ID = 311648    }),
	SwarmingMistBuff				= Action.Create({ Type = "Spell", ID = 312546    }),
    AbominationLimb                    = Action.Create({ Type = "Spell", ID = 315443    }),
    DeathsDue                        = Action.Create({ Type = "Spell", ID = 324128    }),    
    
    -- Conduits
    ConvocationoftheDead            = Action.Create({ Type = "Spell", ID = 338553, Hidden = true    }),
    EmbraceDeath                    = Action.Create({ Type = "Spell", ID = 337980, Hidden = true    }),
    EternalHunger                    = Action.Create({ Type = "Spell", ID = 337381, Hidden = true    }),
    LingeringPlague                    = Action.Create({ Type = "Spell", ID = 338566, Hidden = true    }),
    Proliferation                    = Action.Create({ Type = "Spell", ID = 338664, Hidden = true    }),    
    ImpenetrableGloom                = Action.Create({ Type = "Spell", ID = 338628, Hidden = true    }),
    BrutalGrasp                        = Action.Create({ Type = "Spell", ID = 338651, Hidden = true    }),
    WitheringGround                    = Action.Create({ Type = "Spell", ID = 341344, Hidden = true    }),
    HardenedBones                    = Action.Create({ Type = "Spell", ID = 337972, Hidden = true    }),
    InsatiableAppetite                = Action.Create({ Type = "Spell", ID = 338330, Hidden = true    }),    
    ReinforcedShell                    = Action.Create({ Type = "Spell", ID = 337764, Hidden = true    }),
    ChilledResilience                = Action.Create({ Type = "Spell", ID = 337704, Hidden = true    }),
    FleetingWind                    = Action.Create({ Type = "Spell", ID = 338093, Hidden = true    }),
    SpiritDrain                        = Action.Create({ Type = "Spell", ID = 337705, Hidden = true    }),
    UnendingGrip                    = Action.Create({ Type = "Spell", ID = 338311, Hidden = true    }),  
	LeadbyExample                    = Action.Create({ Type = "Spell", ID = 342156, Hidden = true    }),	
    
    -- Legendaries
    -- General Legendaries
    DeathsEmbrace                    = Action.Create({ Type = "Spell", ID = 334728, Hidden = true    }),
    GripoftheEverlasting            = Action.Create({ Type = "Spell", ID = 334724, Hidden = true    }),
    Phearomones                        = Action.Create({ Type = "Spell", ID = 335177, Hidden = true    }),
    Superstrain                        = Action.Create({ Type = "Spell", ID = 334974, Hidden = true    }),    
    
    --Unholy Legendaries
    DeadliestCoil                    = Action.Create({ Type = "Spell", ID = 334949, Hidden = true    }),
    DeathsCertainty                    = Action.Create({ Type = "Spell", ID = 334898, Hidden = true    }),
    FrenziedMonstrosity                = Action.Create({ Type = "Spell", ID = 334888, Hidden = true    }),
    ReanimatedShambler                = Action.Create({ Type = "Spell", ID = 334836, Hidden = true    }),    
    
    --Anima Powers - to add later...
    
    
    -- Trinkets
    InscrutableQuantumDevice            = Create({ Type = "Trinket", ID = 179350 }),     
	MacabreSheetMusic		            = Create({ Type = "Trinket", ID = 184024 }),     
	DreadfireVessel			            = Create({ Type = "Trinket", ID = 184030 }),     
	DarkMoonDeckVoracity		        = Create({ Type = "Trinket", ID = 173087 }),     

    
    -- Potions
    PotionofUnbridledFury            = Action.Create({ Type = "Potion", ID = 169299, QueueForbidden = true }),     
    SuperiorPotionofUnbridledFury    = Action.Create({ Type = "Potion", ID = 168489, QueueForbidden = true }),
    PotionofSpectralStrength        = Action.Create({ Type = "Potion", ID = 171275, QueueForbidden = true }),
    PotionofSpectralStamina            = Action.Create({ Type = "Potion", ID = 171274, QueueForbidden = true }),
    PotionofEmpoweredExorcisms        = Action.Create({ Type = "Potion", ID = 171352, QueueForbidden = true }),
    PotionofHardenedShadows            = Action.Create({ Type = "Potion", ID = 171271, QueueForbidden = true }),
    PotionofPhantomFire                = Action.Create({ Type = "Potion", ID = 171349, QueueForbidden = true }),
    PotionofDeathlyFixation            = Action.Create({ Type = "Potion", ID = 171351, QueueForbidden = true }),
    SpiritualHealingPotion            = Action.Create({ Type = "Potion", ID = 171267, QueueForbidden = true }),      
    
    -- Misc
    Channeling                      = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),    -- Show an icon during channeling
    TargetEnemy                     = Action.Create({ Type = "Spell", ID = 44603, Hidden = true     }),    -- Change Target (Tab button)
    StopCast                        = Action.Create({ Type = "Spell", ID = 61721, Hidden = true     }),        -- spell_magic_polymorphrabbit
    PoolResource                    = Action.Create({ Type = "Spell", ID = 209274, Hidden = true     }),
    Quake                           = Action.Create({ Type = "Spell", ID = 240447, Hidden = true     }), -- Quake (Mythic Plus Affix)
	GCD                     	 = Action.Create({ Type = "Spell", ID = 61304, Hidden = true     }),   
}

Action:CreateEssencesFor(ACTION_CONST_DEATHKNIGHT_UNHOLY)
local A = setmetatable(Action[ACTION_CONST_DEATHKNIGHT_UNHOLY], { __index = Action })

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
    for key, val in pairs(Action[ACTION_CONST_DEATHKNIGHT_UNHOLY]) do 
        if type(val) == "table" and val.Type == "Trinket" then 
            Temp.IsSlotTrinketBlocked[val.ID] = true
        end 
    end 
end 

local function num(val)
    if val then return 1 else return 0 end
end

local function bool(val)
    return val ~= 0
end
local player = "player"

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

function Player:AreaTTD(range)
    local ttdtotal = 0
    local totalunits = 0
    local r = range
    
    for _, unitID in pairs(ActiveUnitPlates) do 
        if Unit(unitID):GetRange() <= r then 
            local ttd = Unit(unitID):TimeToDie()
            totalunits = totalunits + 1
            ttdtotal = ttd + ttdtotal
        end
    end
    
    if totalunits == 0 then
        return 0
    end
    
    return ttdtotal / totalunits
end    

local function InMelee(unit)
    -- @return boolean 
    return A.ScourgeStrike:IsInRange(unit)
end 

local function GetByRange(count, range, isCheckEqual, isCheckCombat)
    -- @return boolean 
    local c = 0 
    for unit in pairs(ActiveUnitPlates) do 
        if (not isCheckEqual or not UnitIsUnit("target", unit)) and (not isCheckCombat or Unit(unit):CombatTime() > 0) then 
            if InMelee(unit) then 
                c = c + 1
            elseif range then 
                local r = Unit(unit):GetRange()
                if r > 0 and r <= range then 
                    c = c + 1
                end 
            end 
            
            if c >= count then 
                return true 
            end 
        end 
    end
end 
GetByRange = A.MakeFunctionCachedDynamic(GetByRange)

-- Non GCD spell check
local function countInterruptGCD(unit)
    if not A.MindFreeze:IsReadyByPassCastGCD(unit) or not A.MindFreeze:AbsentImun(unit, Temp.TotalAndMagKick) then
        return true
    end
end

--Work around fix for AoE off breaking
	if UseAoE == true
		then AoETargets = Action.GetToggle(2,"AoETargets")
	end
	if UseAoE == false
		then AoETargets = 10
	end

--Army Usage
local function CanUseArmyofDead(unitID, AoETargets) 
    -- @return boolean 
    local ArmyUsage = GetToggle(2, "ArmyUsage")
    
    if ArmyUsage == "BOSS" and (Unit("target"):IsBoss() or Unit("target"):IsPlayer()) then
        return true
    end
    
    if ArmyUsage == "AoE" and UseAoE then        
        if GetByRange(AoETargets, 10) then
            return true
        end
    end
    
    if ArmyUsage == "BOTH" then        
        if Unit("target"):IsBoss() or Unit("target"):IsPlayer() or (UseAoE and GetByRange(AoETargets, 10)) then
            return true
        end
    end
    
    if ArmyUsage == "EVERYONE" then
        return true
    end
end
	
-- Interrupts spells
local function Interrupts(unit)
    isInterrupt = select(9,UnitCastingInfo("target"));
    local DeathGripInterrupt = Action.GetToggle(2, "DeathGripInterrupt")
    local AsphyxiateInterrupt = Action.GetToggle(2, "AsphyxiateInterrupt")
    
 if A.GetToggle(2, "SnSInterruptList") and (IsInRaid() or A.InstanceInfo.KeyStone > 1) then
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, "SnS_ShadowlandsContent", true, countInterruptGCD(unit))
    else
        useKick, useCC, useRacial, notInterruptable, castRemainsTime, castDoneTime = Action.InterruptIsValid(unit, nil, nil, countInterruptGCD(unit))
    end
    
    if castRemainsTime >= A.GetLatency() then
        -- MindFreeze
        if useKick and not notInterruptable and A.MindFreeze:IsReady(unit) then 
            return A.MindFreeze
        end
        
        -- DeathGrip
        if A.DeathGrip:IsReady(unit) and DeathGripInterrupt and A.MindFreeze:GetCooldown() > 1 and useCC then 
            return A.DeathGrip
        end 
        
        -- Asphyxiate
        if A.Asphyxiate:IsSpellLearned() and A.Asphyxiate:IsReady(unit) and AsphyxiateInterrupt and A.MindFreeze:GetCooldown() > 1 and useCC then 
            return A.Asphyxiate
        end 
        
        if useRacial and A.QuakingPalm:AutoRacial(unit) then 
            return A.QuakingPalm
        end 
        
        if useRacial and A.Haymaker:AutoRacial(unit) then 
            return A.Haymaker
        end 
        
        if useRacial and A.WarStomp:AutoRacial(unit) then 
            return A.WarStomp
        end 
        
        if useRacial and A.BullRush:AutoRacial(unit) then 
            return A.BullRush
        end 
    end
end

local function SelfDefensives(unit)
    local HPLoosePerSecond = Unit(player):GetDMG() * 100 / Unit(player):HealthMax()
    
    if Unit(player):CombatTime() == 0 then 
        return 
    end 
    
    -- Icebound Fortitude
    
    local IceboundFortitudeAntiStun = GetToggle(2, "IceboundFortitudeAntiStun")
    local IceboundFortitude = GetToggle(2, "IceboundFortitudeHP")
    if     IceboundFortitude >= 0 and A.IceboundFortitude:IsReady(player) and 
    (
        (   -- Auto 
            IceboundFortitude >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 30 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.30 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 2 or
                -- Player stunned
                LoC:Get("STUN") > 2 and IceboundFortitudeAntiStun or            
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            IceboundFortitude < 100 and 
            Unit(player):HealthPercent() <= IceboundFortitude
        )
    ) 
    then 
        return A.IceboundFortitude
    end  
	
	-- Lichborne
	local LichborneAntiStun = GetToggle(2, "LichborneAntiStun")
    local Lichborne = GetToggle(2, "LichborneHP")
    if     Lichborne >= 0 and A.Lichborne:IsReady(player) and 
    (
        (   -- Auto 
            Lichborne >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 30 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.30 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 2 or
                -- Player stunned
                LoC:Get("STUN") > 2 and LichborneAntiStun or  				
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            Lichborne < 100 and 
            Unit(player):HealthPercent() <= Lichborne
        )
    ) 
    then 
        return A.Lichborne
    end  
	
    -- Emergency AntiMagicShell
    local AntiMagicShell = GetToggle(2, "AntiMagicShellHP")
    if     AntiMagicShell >= 0 and A.AntiMagicShell:IsReady(player) and 
    (
        (   -- Auto 
            AntiMagicShell >= 100 and 
            (
                -- HP lose per sec >= 10
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 15 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.15 or 
                -- TTD Magic
                Unit(player):TimeToDieMagicX(30) < 3 or 
                
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            AntiMagicShell < 100 and 
            Unit(player):HealthPercent() <= AntiMagicShell
		) or
		(    -- Custom 226512
            Unit("player"):HasDeBuffs(226512, true) > 0
        ) or 
        (    -- Custom 334852
            Unit("player"):HasDeBuffs(334852, true) > 0
        ) or 
        (    -- Custom 340860
            Unit("player"):HasDeBuffs(340860, true) > 0
        ) or 
        (    -- Custom 326271
            Unit("player"):HasDeBuffs(326271, true) > 0
        ) or 
        (    -- Custom 325873
            Unit("player"):HasDeBuffs(325873, true) > 0
        ) or 
        (    -- Custom 326538
            Unit("player"):HasDeBuffs(326538, true) > 0
        ) or 
        (    -- Custom 327619
            Unit("player"):HasDeBuffs(327619, true) > 0
        ) or 
        (    -- Custom 337110
            Unit("player"):HasDeBuffs(337110, true) > 0
        ) or 
        (    -- Custom 334765
            Unit("player"):HasDeBuffs(334765, true) > 0
        ) or 
        (    -- Custom 335873
            Unit("player"):HasDeBuffs(335873, true) > 0
        )
    ) 
    then 
        return A.AntiMagicShell
    end          
    -- Emergency Death Pact
    local DeathPact = GetToggle(2, "DeathPactHP")
    if     DeathPact >= 0 and A.DeathPact:IsReady(player) and A.DeathPact:IsSpellLearned() and 
    (
        (   -- Auto 
            DeathPact >= 100 and 
            (
                -- HP lose per sec >= 30
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 30 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.30 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            DeathPact < 100 and 
            Unit(player):HealthPercent() <= DeathPact
        )
    ) 
    then 
        return A.DeathPact
    end          
    
    -- HealingPotion
    local SpiritualHealingPotion = A.GetToggle(2, "SpiritualHealingPotionHP")
    if     SpiritualHealingPotion >= 0 and A.SpiritualHealingPotion:IsReady(player) and 
    (
        (     -- Auto 
            SpiritualHealingPotion >= 100 and 
            (
                -- HP lose per sec >= 20
                Unit(player):GetDMG() * 100 / Unit(player):HealthMax() >= 20 or 
                Unit(player):GetRealTimeDMG() >= Unit(player):HealthMax() * 0.20 or 
                -- TTD 
                Unit(player):TimeToDieX(25) < 5 or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit("player", 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused() 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs", true) == 0
        ) or 
        (    -- Custom
            SpiritualHealingPotion < 100 and 
            Unit(player):HealthPercent() <= SpiritualHealingPotion
        )
    ) 
    then 
        return A.SpiritualHealingPotion
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

local hasGoneInMelee = false
-- [3] Single Rotation
A[3] = function(icon)
    --local EnemyRotation, FriendlyRotation
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit("player"):CombatTime() > 0
    local combatTime = Unit("player"):CombatTime()
    local RunicPower = Player:RunicPower()
    local RunicPowerDeficit = Player:RunicPowerDeficit()
    local VirulentPlagueTargets = Player:GetDeBuffsUnitCount(A.VirulentPlague.ID)
    local VirulentPlagueRefreshable = Unit("target"):HasDeBuffs(A.VirulentPlague.ID, true) < 4 or Unit("target"):HasDeBuffs(A.VirulentPlague.ID, true) == 0
	local FrostFeverRefreshable = Unit("target"):HasDeBuffs(A.FrostFever.ID, true) < 4 or Unit("target"):HasDeBuffs(A.FrostFever.ID, true) == 0
	local BloodPlagueRefreshable = Unit("target"):HasDeBuffs(A.BloodPlague.ID, true) < 4 or Unit("target"):HasDeBuffs(A.BloodPlague.ID, true) == 0

    --    local PotionTTD = Unit("target"):TimeToDie() > Action.GetToggle(2, "PotionTTD")
    local AutoPotionSelect = Action.GetToggle(2, "AutoPotionSelect")
    local PotionTrue = Action.GetToggle(1, "Potion")    
    local GargoyleActive = A.SummonGargoyle:GetSpellTimeSinceLastCast() <= 30
    --    local UseArmyoftheDead = A.ArmyoftheDead:IsReady("player") and not A.ArmyoftheDead:IsBlocked() and Unit("target"):IsBoss()
    local DeathandDecayTicking = Unit(player):HasBuffs(A.DeathandDecayBuff.ID, true) > 0
    local Racial = Action.GetToggle(1, "Racial")
    local UseAoE = Action.GetToggle(2, "AoE")
    local DeathStrikeHP = Action.GetToggle(2, "DeathStrikeHP")    
    local AoETargets = Action.GetToggle(2, "AoETargets")
    local AutoSwitchFesteringStrike = GetToggle(2, "AutoSwitchFesteringStrike")
    local currentTargets = MultiUnits:GetByRange(7)    
    local MissingFesteringWound = MultiUnits:GetByRangeMissedDoTs(10, 5, A.FesteringWound.ID)
    local ActiveFesteringWound = MultiUnits:GetByRangeAppliedDoTs(6, 5, A.FesteringWound.ID)
	local MouseoverTarget = UnitName("mouseover")
	local DnDSlider = Action.GetToggle(2, "DnDSlider")
	local AbomSlider = Action.GetToggle(2, "AbomSlider")
	local ability,covenant = Player:GetCovenant()

	

    ------------------------------------------------------
    ---------------- ENEMY UNIT ROTATION -----------------
    ------------------------------------------------------
    local function EnemyRotation(unit)
	
-- actions+=/variable,name=pooling_runic_power,value=cooldown.summon_gargoyle.remains<5&talent.summon_gargoyle
	VarPoolingRunicPower = A.SummonGargoyle:GetCooldown() < 5 and A.SummonGargoyle:IsTalentLearned() and A.BurstIsON("target")
	
-- actions+=/variable,name=pooling_runes,value=talent.soul_reaper&rune<2&target.time_to_pct_35<5&fight_remains>5
	VarPoolingRunes = A.SoulReaper:IsTalentLearned() and Player:Rune() < 2 and Unit("target"):TimeToDieX(35) < 5 and Player:AreaTTD(10) > 5
	
-- actions+=/variable,name=st_planning,value=active_enemies=1&(!raid_event.adds.exists|raid_event.adds.in>15)
	VarStPlanning = MultiUnits:GetByRange(10, 11) < AoETargets
	
-- actions+=/variable,name=major_cooldowns_active,value=pet.gargoyle.active|buff.unholy_assault.up|talent.army_of_the_damned&pet.apoc_ghoul.active|buff.dark_transformation.up
    VarMajorCooldownsActive = GargoyleActive or Unit("player"):HasBuffs(A.UnholyAssault.ID, true) > 0 or (A.ArmyoftheDamned:IsTalentLearned() and A.Apocalypse:GetSpellTimeSinceLastCast() < 15) or Unit("pet"):HasBuffs(A.DarkTransformation.ID, true) > 0
		
		--Explosive Rotation        
		local function ExplosiveRotation()
			if A.ScourgeStrike:IsReady("target") then
				return A.ScourgeStrike:Show(icon)
			end
			if A.ClawingShadows:IsReady("target") then
				return A.ClawingShadows:Show(icon)
			end
			if A.DeathStrike:IsReady("target") then
				return A.DeathStrike:Show(icon)
			end
			if A.DeathCoil:IsReady("target") then
				return A.DeathCoil:Show(icon)
			end
		end
		
		if Unit("target"):IsExplosives() and ExplosiveRotation() then
			return true
		end
		
--Explosive TargetMouseOver
A[6] = function(icon, isMulti)		
		if (InMelee or A.DeathCoil:IsReady("mouseover")) and (A.ScourgeStrike:IsInRange("mouseover") or (A.DeathCoil:IsInRange("mouseover") and A.DeathCoil:IsReady("mouseover"))) and Action.GetToggle(2, "ExplosiveMouseover") and Unit("mouseover"):IsExplosives() then
			return A:Show(icon, ACTION_CONST_LEFT)
		end
		
		if IsUnitEnemy("target") and Unit("target"):GetRange() <= 10 and inCombat and UnitGUID("pettarget") ~= UnitGUID("target") then
			return A.PetAttack:Show(icon)
		end
		
end		

		local Interrupt = Interrupts(unit)
        if Interrupt then 
            return Interrupt:Show(icon)
        end    
	
		--Fleshcraft precombat cast
		--	if A.Fleshcraft:IsReady(player) 
		--	and Unit("player"):CombatTime() == 0 then
		--return A.Fleshcraft:Show(icon)
		--end
		
        --Death Strike below HP %
        if A.DeathStrike:IsReady(unit) and Unit(player):HealthPercent() <= DeathStrikeHP then
            return A.DeathStrike:Show(icon)
        end

		--actions.cooldowns+=/soul_reaper,target_if=target.time_to_pct_35<5&target.time_to_die>5
        if A.SoulReaper:IsReady() and Unit("target"):TimeToDieX(35) < 5 and Unit("target"):TimeToDie() > 5 and Unit("mouseover"):HasDeBuffs(A.SoulReaper.ID, true) == 0 then
            return A.SoulReaper:Show(icon)
         end 
			
		-- Return to Focus
		if UnitGUID("target") ~= UnitGUID("focus") and UnitExists("focus") and UnitHealth("focus") > 0 and not UnitIsFriend("player", "focus") and Action.GetToggle(2, "FocusTunnel") and Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) > 0 and IsItemInRange(37727, "focus") then
			return A.RocketJump:Show(icon)
		end
			
		--Spiteful Soul Slow
		if A.ChainsofIce:IsReady("mouseover") and Action.GetToggle(2, "SlowSpiteful") and (string.find(UnitGUID("mouseover"), 174773)) and Unit("mouseover"):GetRange() < 30 and UnitName("mouseovertarget") == UnitName(player) then
			return A.ChainsofIce:Show(icon)
		end
		        
		--Soul Reaper scan for <35 or TimeTo35 < 5  @mouseover     
        if A.SoulReaper:IsReady() and Action.GetToggle(2, "mouseover") and Action.GetToggle(2, "SoulReaperMouseover") and Unit("mouseover"):GetRange() < 5 and Unit("target"):TimeToDieX(35) > 5 and InMelee("mouseover") and not Unit("mouseover"):InLOS() and Unit("mouseover"):TimeToDieX(35) < 5 and Unit("mouseover"):TimeToDie() > 5 and Unit("mouseover"):HasDeBuffs(A.SoulReaper.ID, true) == 0 then 
            return A.SoulReaper:Show(icon)
        end
		
        -- Festering Strike auto target (credit to Taste for this)
        if AutoSwitchFesteringStrike and A.BurstIsON(unit) and (Unit(unit):HasDeBuffsStacks(A.FesteringWound.ID, true) > 0 or not InMelee(unit)) and Player:AreaTTD(10) > 5 and Player:Rune() >= 2 and A.DeathandDecay:GetCooldown() <= 5 and currentTargets >= 2 and currentTargets <= 5 and (MissingFesteringWound > 0 and MissingFesteringWound < 5)
        then
            local FesteringStrike_Nameplates = MultiUnits:GetActiveUnitPlates()
            if FesteringStrike_Nameplates then  
                for FesteringStrike_UnitID in pairs(FesteringStrike_Nameplates) do   
					if ((UnitCanAttack("player", FesteringStrike_UnitID) and UnitAffectingCombat("target") and IsItemInRange(37727, FesteringStrike_UnitID) and UnitDetailedThreatSituation("player", FesteringStrike_UnitID) ~= nil) or Unit(FesteringStrike_UnitID):IsDummy()) then				
						if Unit(FesteringStrike_UnitID):GetRange() < 6 and InMelee(FesteringStrike_UnitID) and not Unit(FesteringStrike_UnitID):InLOS() and Unit(FesteringStrike_UnitID):HasDeBuffsStacks(A.FesteringWound.ID, true) == 0 then 
							return A:Show(icon, ACTION_CONST_AUTOTARGET)
					   end 
					end
                end 
            end
        end
		
		--Festering Switch with CD off
		if AutoSwitchFesteringStrike and not A.BurstIsON(unit) and (Unit(unit):HasDeBuffsStacks(A.FesteringWound.ID, true) > 0 or not InMelee(unit)) and Player:AreaTTD(10) > 5 and Player:Rune() >= 2 and A.DeathandDecay:GetCooldown() <= 5 and currentTargets >= 2 and currentTargets <= 5 and (MissingFesteringWound > 0 and MissingFesteringWound < 5 or Unit(unit):IsDummy())
		 then
            local FesteringStrike_Nameplates = MultiUnits:GetActiveUnitPlates()
            if FesteringStrike_Nameplates then  
                for FesteringStrike_UnitID in pairs(FesteringStrike_Nameplates) do   
					if ((UnitCanAttack("player", FesteringStrike_UnitID) and UnitAffectingCombat("target") and IsItemInRange(37727, FesteringStrike_UnitID) and UnitDetailedThreatSituation("player", FesteringStrike_UnitID) ~= nil) or Unit(FesteringStrike_UnitID):IsDummy()) then				
						if Unit(FesteringStrike_UnitID):GetRange() < 6 and InMelee(FesteringStrike_UnitID) and not Unit(FesteringStrike_UnitID):InLOS() and Unit(FesteringStrike_UnitID):HasDeBuffsStacks(A.FesteringWound.ID, true) == 0 then 
							return A:Show(icon, ACTION_CONST_AUTOTARGET)
					   end 
					end
                end 
            end
        end
		
		--actions.cooldowns+=/raise_dead,if=!pet.ghoul.active
        if not Pet:IsActive() and A.RaiseDead:IsReady() then
            return A.RaiseDead:Show(icon)
        end  
		
		--#####################
        --####### OPENER ######
        --#####################
		
		--actions+=/sequence,if=active_enemies=1&!death_knight.disable_aotd,name=opener:army_of_the_dead:festering_strike:festering_strike:potion:unholy_blight:dark_transformation:apocalypse
		local function Opener()
			if A.ArmyoftheDead:IsReady("player") and CanUseArmyofDead(unitID, AoETargets) then
				return A.ArmyoftheDead:Show(icon)
			end
			
			if A.FesteringStrike:IsReady(unit) and Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) < 4 then
				return A.FesteringStrike:Show(icon)
			end
		
            if A.PotionofSpectralStrength:IsReady(player) and Action.GetToggle(1, "Potion") and IsItemInRange(32321) and Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) < 4
            then
                return A.PotionofSpectralStrength:Show(icon)
            end
			
			if A.UnholyBlight:IsReady("player") and Unit("target"):GetRange() <= 8 and Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) < 4 then
				return A.UnholyBlight:Show(icon)
			end
			
			if A.DarkTransformation:IsReady("player") and Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) < 4 and Unit("target"):GetRange() <= 10 then
				return A.DarkTransformation:Show(icon)
			end
			
			if A.Apocalypse:IsReady(unit) and Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) >= 4 then
				return A.Apocalypse:Show(icon)
			end
		end
        
		--#####################
        --##### AoE BURST #####
        --#####################
		
         local function AoEBurst() 
            	
			--actions.aoe_burst=death_coil,if=(buff.sudden_doom.react|!variable.pooling_runic_power)&(buff.dark_transformation.up&runeforge.deadliest_coil&active_enemies<=3|active_enemies=2)
			if A.DeathCoil:IsReady(unit) and (Unit("player"):HasBuffs(A.DeathCoil.ID, true) > 0 or not VarPoolingRunicPower) and Unit("pet"):HasBuffs(A.DarkTransformation.ID, true) > 0 and ((A.DeadliestCoil:HasLegendaryCraftingPower() and MultiUnits:GetByRange(10, 4) <= 3) or MultiUnits:GetByRange(10, 4) == 2) then
				return A.DeathCoil:Show(icon)
			end
			
			--actions.aoe_burst+=/epidemic,if=runic_power.deficit<(10+death_knight.fwounded_targets*3)&death_knight.fwounded_targets<6&!variable.pooling_runic_power|buff.swarming_mist.up
            if A.Epidemic:IsReady(player) and Unit("target"):HasDeBuffs(A.VirulentPlague.ID, true) > 0 and Player:RunicPowerDeficit() < (10 + (ActiveFesteringWound * 3)) and ((ActiveFesteringWound < 6 and not VarPoolingRunicPower) or Unit(player):HasBuffs(A.SwarmingMistBuff.ID, true) > 0) then
				return A.Epidemic:Show(icon)
            end
            
            --actions.aoe_burst+=/epidemic,if=runic_power.deficit<25&death_knight.fwounded_targets>5&!variable.pooling_runic_power
            if A.Epidemic:IsReady(player) and Unit("target"):HasDeBuffs(A.VirulentPlague.ID, true) > 0 and Player:RunicPowerDeficit() < 25 and ActiveFesteringWound > 5 and not VarPoolingRunicPower then
				return A.Epidemic:Show(icon)
            end

            --actions.aoe_burst+=/epidemic,if=!death_knight.fwounded_targets&!variable.pooling_runic_power|fight_remains<5|raid_event.adds.exists&raid_event.adds.remains<5
            if A.Epidemic:IsReady(player) and Unit("target"):HasDeBuffs(A.VirulentPlague.ID, true) > 0 and ((ActiveFesteringWound == 0 and not VarPoolingRunicPower) or (Player:AreaTTD(10) < 5)) then 
				return A.Epidemic:Show(icon)
            end    
			
            --actions.aoe_burst+=/wound_spender
            if A.ScourgeStrike:IsReady(unit) then
                return A.ScourgeStrike:Show(icon)
            end    
            
            if A.ClawingShadows:IsReady(unit) then
                return A.ClawingShadows:Show(icon)
            end
			
            --actions.aoe_burst+=/epidemic,if=!variable.pooling_runic_power
            if A.Epidemic:IsReady(player) and Unit("target"):HasDeBuffs(A.VirulentPlague.ID, true) > 0 and not VarPoolingRunicPower then
				return A.Epidemic:Show(icon)
            end       

        end 
        
        
        --#####################
        --##### AOE SETUP #####
        --#####################
        
        local function AoESetup()    
             
			--actions.aoe_setup=any_dnd,if=death_knight.fwounded_targets=active_enemies|raid_event.adds.exists&raid_event.adds.remains<=11
            if A.DeathandDecay:IsReady(player) and (MissingFesteringWound == 0 or Player:AreaTTD(10) <= 11) then
                return A.DeathandDecay:Show(icon)
            end
            
            if A.Defile:IsReady(player) and (MissingFesteringWound == 0 or Player:AreaTTD(10) <= 11) and A.Defile:IsTalentLearned() then
                return A.Defile:Show(icon)
            end
            
            if A.DeathsDue:IsReady(unit) and (MissingFesteringWound == 0 or Player:AreaTTD(10) <= 11) then
                return A.DeathsDue:Show(icon)
            end            
            
            --actions.aoe_setup+=/any_dnd,if=death_knight.fwounded_targets>=5
            if A.DeathandDecay:IsReady(player) and ActiveFesteringWound >= DnDSlider then
                return A.DeathandDecay:Show(icon)
            end
            
            if A.Defile:IsReady(player) and A.Defile:IsTalentLearned() and ActiveFesteringWound >= DnDSlider then
                return A.Defile:Show(icon)
            end
            
            if A.DeathsDue:IsReady(unit) and ActiveFesteringWound >= DnDSlider then
                return A.DeathsDue:Show(icon)
            end   

			--actions.aoe_setup+=/death_coil,if=!variable.pooling_runic_power&(buff.dark_transformation.up&runeforge.deadliest_coil&active_enemies<=3|active_enemies=2)
			if A.DeathCoil:IsReady(unit) and not VarPoolingRunicPower and ((Unit("pet"):HasBuffs(A.DarkTransformation.ID, true) > 0 and A.DeadliestCoil:HasLegendaryCraftingPower() and MultiUnits:GetByRange(10, 4) <= 3) or MultiUnits:GetByRange(10, 3) == 2) then
				return A.DeathCoil:Show(icon)
			end
			
			--actions.aoe_setup+=/epidemic,if=!variable.pooling_runic_power
			if A.Epidemic:IsReady(player) and Unit("target"):HasDeBuffs(A.VirulentPlague.ID, true) > 0 and not VarPoolingRunicPower then
				return A.Epidemic:Show(icon)
			end

            --actions.aoe_setup+=/festering_strike,target_if=max:debuff.festering_wound.stack,if=debuff.festering_wound.stack<=3&cooldown.apocalypse.remains<3
            if A.FesteringStrike:IsReady(unit) and Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) <= 3 and A.Apocalypse:GetCooldown() < 3 then
                return A.FesteringStrike:Show(icon)
            end    
            
            --actions.aoe_setup+=/festering_strike,target_if=debuff.festering_wound.stack<1
            if A.FesteringStrike:IsReady(unit) and Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) < 1 then
                return A.FesteringStrike:Show(icon)
            end
			
			--actions.aoe_setup+=/festering_strike,target_if=min:debuff.festering_wound.stack,if=rune.time_to_4<(cooldown.death_and_decay.remains&!talent.defile|cooldown.defile.remains&talent.defile)
			if A.FesteringStrike:IsReady(unit) and ((not A.Defile:IsTalentLearned() and Player:RuneTimeToX(4) < (A.DeathandDecay:GetCooldown())) or (A.Defile:IsTalentLearned()and Player:RuneTimeToX(4) < (A.Defile:GetCooldown()))) then
				return A.FesteringStrike:Show(icon)
			end
			
			--festering if finished spread or spread off
			if A.ScourgeStrike:IsReady(unit) and (not AutoSwitchFesteringStrike or MissingFesteringWound == 0) then
				return A.ScourgeStrike:Show(icon)
			end
			
			if A.ClawingShadows:IsReady(unit) and (not AutoSwitchFesteringStrike or MissingFesteringWound == 0) then
				return A.ClawingShadows:Show(icon)
			end
            
        end  
        
        
        --#####################
        --##### COOLDOWNS #####
        --#####################
        
        local function Cooldowns()    
            
            --Spectral Strength
			--actions.cooldowns=potion,if=variable.major_cooldowns_active|fight_remains<26
            if A.PotionofSpectralStrength:IsReady(player) and Action.GetToggle(1, "Potion") and IsItemInRange(32321) and (VarMajorCooldownsActive or Player:AreaTTD(10) < 26) then
                return A.PotionofSpectralStrength:Show(icon)
            end
			
			--actions.cooldowns+=/army_of_the_dead,if=cooldown.unholy_blight.remains<5&cooldown.dark_transformation.remains_expected<5&talent.unholy_blight|!talent.unholy_blight|fight_remains<35
			if A.ArmyoftheDead:IsReady(player) and CanUseArmyofDead(unitID, AoETargets) and ((A.UnholyBlight:GetCooldown() < 3 and A.DarkTransformation:GetCooldown() < 5 and A.UnholyBlight:IsTalentLearned()) or (not A.UnholyBlight:IsTalentLearned()) or Player:AreaTTD(10) < 35) then
				return A.ArmyoftheDead:Show(icon)
			end	
			
			-- Holds Blight for up to 5 seconds to sync with Apocalypse, Otherwise, use with Dark Transformation.
			--actions.cooldowns+=/unholy_blight,if=variable.st_planning&(cooldown.apocalypse.remains_expected<5|cooldown.apocalypse.remains_expected>10)&(cooldown.dark_transformation.remains<gcd|buff.dark_transformation.up)
			if A.UnholyBlight:IsReady(player) and VarStPlanning and Unit("target"):GetRange() < 10 and (A.Apocalypse:GetCooldown() < 5 or A.Apocalypse:GetCooldown() > 10) and (A.DarkTransformation:GetCooldown() < GetGCD() or Unit("pet"):HasBuffs(A.DarkTransformation.ID, true) > 0) then
				return A.UnholyBlight:Show(icon)
			end   
		
			--actions.cooldowns+=/unholy_blight,if=active_enemies>=2|fight_remains<21
			if A.UnholyBlight:IsReady(player) and Unit("target"):GetRange() < 10 and (MultiUnits:GetByRange(10, AoETargets) >= AoETargets or Player:AreaTTD(10) < 21) then
				return A.UnholyBlight:Show(icon)
			end
            
            --actions.cooldowns+=/dark_transformation,if=variable.st_planning&(dot.unholy_blight_dot.remains|!talent.unholy_blight)
            if A.DarkTransformation:IsReady(player) and Unit("target"):GetRange() <= 8 and Unit("pet"):HasDeBuffs(A.ControlUndead.ID, true) == 0 and VarStPlanning and (Unit("target"):HasDeBuffs(A.UnholyBlightDebuff.ID, true) > 0 or not A.UnholyBlight:IsTalentLearned()) then
                return A.DarkTransformation:Show(icon)
            end    
            
            --actions.cooldowns+=/dark_transformation,if=active_enemies>=2|fight_remains<21
            if A.DarkTransformation:IsReady(player) and Unit("target"):GetRange() <= 8 and Unit("pet"):HasDeBuffs(A.ControlUndead.ID, true) == 0 and (MultiUnits:GetByRange(10, AoETargets) >= AoETargets or Player:AreaTTD(10) < 21) then
                return A.DarkTransformation:Show(icon)
            end    
			
            --actions.cooldowns+=/apocalypse,if=active_enemies=1&debuff.festering_wound.stack>=4
            if A.Apocalypse:IsReady(unit) and MultiUnits:GetByRange(10, 11) < AoETargets and Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) >= 4 then
				return A.Apocalypse:Show(icon)
            end    
            
			--actions.cooldowns+=/apocalypse,target_if=max:debuff.festering_wound.stack,if=active_enemies>=2&debuff.festering_wound.stack>=4&!death_and_decay.ticking
			if A.Apocalypse:IsReady(unit) and MultiUnits:GetByRange(10, 11) >= AoETargets and Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) >= 4 and not DeathandDecayTicking then
				return A.Apocalypse:Show(icon)
			end

            --actions.cooldowns+=/summon_gargoyle,if=runic_power.deficit<14&(cooldown.unholy_blight.remains<10|dot.unholy_blight_dot.remains)
            if A.SummonGargoyle:IsReady(unit) and RunicPowerDeficit < 14 and (A.UnholyBlight:GetCooldown() < 10 or Unit("target"):HasDeBuffs(A.UnholyBlightDebuff.ID, true) > 0) then
                return A.SummonGargoyle:Show(icon)
            end    
            
            --actions.cooldowns+=/unholy_assault,if=variable.st_planning&debuff.festering_wound.stack<2&(pet.apoc_ghoul.active|buff.dark_transformation.up&!pet.army_ghoul.active)
            if A.UnholyAssault:IsReady(unit) and VarStPlanning and Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) < 2 and (A.Apocalypse:GetSpellTimeSinceLastCast() < 15 or (Unit("pet"):HasBuffs(A.DarkTransformation.ID, true) > 0 and A.Apocalypse:GetSpellTimeSinceLastCast() > 15))  then
                return A.UnholyAssault:Show(icon)
            end    
            
            --actions.cooldowns+=/unholy_assault,target_if=min:debuff.festering_wound.stack,if=active_enemies>=2&debuff.festering_wound.stack<2
            if A.UnholyAssault:IsReady(unit) and MultiUnits:GetByRange(10, AoETargets) >= AoETargets and Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) < 2 then
                return A.UnholyAssault:Show(icon)
            end     
			
			--actions.cooldowns+=/raise_dead,if=!pet.ghoul.active
			if not Pet:IsActive() and A.RaiseDead:IsReady() then
				return A.RaiseDead:Show(icon)
			end 
			
			--actions.cooldowns+=/sacrificial_pact,if=active_enemies>=2&!buff.dark_transformation.up&!cooldown.dark_transformation.ready|fight_remains<gcd
			if A.SacrificialPact:IsReady(player) and A.RaiseDead:IsReady() and ((MultiUnits:GetByRange(10, AoETargets) >= AoETargets and Unit("pet"):HasBuffs(A.DarkTransformation.ID, true) == 0 and A.DarkTransformation:GetCooldown() > 0) or Player:AreaTTD(10) < GetGCD()) then
				return A.SacrificialPact:Show(icon)
			end
			
        end
        
		--######################
        --###### COVENANTS #####
        --######################
		
		local function Covenants()
			--actions.covenants=swarming_mist,if=variable.st_planning&runic_power.deficit>16&(cooldown.apocalypse.remains|!talent.army_of_the_damned&cooldown.dark_transformation.remains)|fight_remains<11
			if A.SwarmingMist:IsReady(player) and (VarStPlanning and Player:RunicPowerDeficit() > 16 and (A.Apocalypse:GetCooldown() > 0 or (not A.ArmyoftheDamned:IsTalentLearned() and A.DarkTransformation:GetCooldown() > 0)) or Player:AreaTTD(10) < 11) then
				return A.SwarmingMist:Show(icon)
			end
			
			--Set to use after apoc is on CD as to prevent overcapping RP while setting up CD's
			--actions.covenants+=/swarming_mist,if=cooldown.apocalypse.remains&(active_enemies>=2&active_enemies<=5&runic_power.deficit>10+(active_enemies*6)|active_enemies>5&runic_power.deficit>40)
			if A.SwarmingMist:IsReady(player) and A.Apocalypse:GetCooldown() > 0 and (MultiUnits:GetByRange(10,11) >= AoETargets and ((MultiUnits:GetByRange(10,11) <= 5 and Player:RunicPowerDeficit() > (10 + (MultiUnits:GetByRange(10,11) * 6))) or MultiUnits:GetByRange(10,11) > 5 and Player:RunicPowerDeficit() > 40)) then
				return A.SwarmingMist:Show(icon)
			end
			
			--actions.covenants+=/abomination_limb,if=variable.st_planning&!soulbind.lead_by_example&(cooldown.apocalypse.remains|!talent.army_of_the_damned&cooldown.dark_transformation.remains)&rune.time_to_4>(3+buff.runic_corruption.remains)|fight_remains<21
			if A.AbominationLimb:IsReady(player) and ((VarStPlanning and not A.LeadbyExample:IsSoulbindLearned() and (A.Apocalypse:GetCooldown() > 0 or (not A.ArmyoftheDamned:IsTalentLearned() and A.DarkTransformation:GetCooldown() > 0)) and Player:RuneTimeToX(4) > (3 + Unit(player):HasBuffs(A.RunicCorruption.ID, true))) or Player:AreaTTD(10) < 21) then
				return A.AbominationLimb:Show(icon)
			end
			
			--actions.covenants+=/abomination_limb,if=variable.st_planning&soulbind.lead_by_example&(dot.unholy_blight_dot.remains>11|!talent.unholy_blight&cooldown.dark_transformation.remains)
			if A.AbominationLimb:IsReady(player) and VarStPlanning and A.LeadbyExample:IsSoulbindLearned() and (Unit("target"):HasDeBuffs(A.UnholyBlightDebuff.ID, true) > 11 or (not A.UnholyBlight:IsTalentLearned() and A.DarkTransformation:GetCooldown() > 0)) then
				return A.AbominationLimb:Show(icon)
			end
			
			--actions.covenants+=/abomination_limb,if=active_enemies>=2&rune.time_to_4>(3+buff.runic_corruption.remains)
			if A.AbominationLimb:IsReady(player) and MultiUnits:GetByRange(10, 11) >= AoETargets and Player:RuneTimeToX(4) > (3 + Unit(player):HasBuffs(A.RunicCorruption.ID, true)) then
				return A.AbominationLimb:Show(icon)
			end
			
			--actions.covenants+=/shackle_the_unworthy,if=variable.st_planning&(cooldown.apocalypse.remains|!talent.army_of_the_damned&cooldown.dark_transformation.remains)|fight_remains<15
			if A.ShackletheUnworthy:IsReady(unit) and VarStPlanning and ((A.Apocalypse:GetCooldown() > 0 or (not A.ArmyoftheDamned:IsTalentLearned() and A.DarkTransformation:GetCooldown() > 0)) or Player:AreaTTD(10) < 15) then
				return A.ShackletheUnworthy:Show(icon)
			end
			
			--actions.covenants+=/shackle_the_unworthy,if=active_enemies>=2&(death_and_decay.ticking|raid_event.adds.remains<=14)
			if A.ShackletheUnworthy:IsReady(unit) and MultiUnits:GetByRange(10,11) >= AoETargets and (DeathandDecayTicking or Player:AreaTTD(10) <= 14) then
				return A.ShackletheUnworthy:Show(icon)
			end
		end 
		
        --######################
        --##### GENERIC ST #####
        --######################
        
        local function GenericST()
            
			--Plague if Burst is off
			if A.Outbreak:IsReady(unit) and Unit("target"):HasDeBuffs(A.VirulentPlague.ID, true) < 4 then
				return A.Outbreak:Show(icon)
			end
			
            --actions.generic=death_coil,if=buff.sudden_doom.react&!variable.pooling_runic_power|pet.gargoyle.active
            if A.DeathCoil:IsReady(unit) and ((Unit(player):HasBuffs(A.SuddenDoomBuff.ID, true) > 0 and not VarPoolingRunicPower) or GargoyleActive) then
                return A.DeathCoil:Show(icon)
            end    
            
            --actions.generic+=/death_coil,if=runic_power.deficit<13|fight_remains<5&!debuff.festering_wound.up
            if A.DeathCoil:IsReady(unit) and ((RunicPowerDeficit < 13) or (Player:AreaTTD(10) < 5 and ActiveFesteringWound == 0)) then
                return A.DeathCoil:Show(icon)
            end    
            
            --actions.generic+=/any_dnd,if=cooldown.apocalypse.remains&(talent.defile.enabled|covenant.night_fae|runeforge.phearomones)&(!variable.pooling_runes|fight_remains<5)
            if A.DeathandDecay:IsReady(player) and A.Apocalypse:GetCooldown() > 0 and (A.Defile:IsTalentLearned() or covenant == "NightFae" or A.Phearomones:HasLegendaryCraftingPower()) and (not VarPoolingRunes or Player:AreaTTD(10) < 5) then
                return A.DeathandDecay:Show(icon)
            end   
			
            if A.Defile:IsReady(player) and A.Apocalypse:GetCooldown() > 0 and (A.Defile:IsTalentLearned() or covenant == "NightFae" or A.Phearomones:HasLegendaryCraftingPower()) and (not VarPoolingRunes or Player:AreaTTD(10) < 5) then
                return A.Defile:Show(icon)
            end      
			
            if A.DeathsDue:IsReady(player) and A.Apocalypse:GetCooldown() > 0 and (A.Defile:IsTalentLearned() or covenant == "NightFae" or A.Phearomones:HasLegendaryCraftingPower()) and (not VarPoolingRunes or Player:AreaTTD(10) < 5) then
                return A.DeathsDue:Show(icon)
            end    
            
            --actions.generic+=/wound_spender,if=debuff.festering_wound.stack>4&!variable.pooling_runes
            if A.ScourgeStrike:IsReady(unit) and Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) > 4 and not VarPoolingRunes then
                return A.ScourgeStrike:Show(icon)
            end    
            
            if A.ClawingShadows:IsReady(unit) and Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) > 4 and not VarPoolingRunes then
                return A.ClawingShadows:Show(icon)
            end
            
			--actions.generic+=/wound_spender,if=debuff.festering_wound.up&cooldown.apocalypse.remains_expected>5&!variable.pooling_runes
            if A.ScourgeStrike:IsReady(unit) and A.BurstIsON(unit) and Unit("target"):HasDeBuffs(A.FesteringWound.ID, true) > 0 and A.Apocalypse:GetCooldown() > 5 and not VarPoolingRunes then
				return A.ScourgeStrike:Show(icon)
            end    
            
            if A.ClawingShadows:IsReady(unit) and A.BurstIsON(unit) and Unit("target"):HasDeBuffs(A.FesteringWound.ID, true) > 0 and A.Apocalypse:GetCooldown() > 5 and not VarPoolingRunes then
				return A.ClawingShadows:Show(icon)
            end               

			--Wound Spender if CD is off
			if A.ScourgeStrike:IsReady(unit) and not A.BurstIsON(unit) and Unit("target"):HasDeBuffs(A.FesteringWound.ID, true) > 0 then
				return A.ScourgeStrike:Show(icon)
			end
			
			if A.ClawingShadows:IsReady(unit) and not A.BurstIsON(unit) and Unit("target"):HasDeBuffs(A.FesteringWound.ID, true) > 0 then
				return A.ScourgeStrike:Show(icon)
			end
			
            --actions.generic+=/death_coil,if=runic_power.deficit<20&!variable.pooling_runic_power
            if A.DeathCoil:IsReady(unit) and RunicPowerDeficit < 20 and not VarPoolingRunicPower then
                return A.DeathCoil:Show(icon)
            end    
            
            --actions.generic+=/festering_strike,if=debuff.festering_wound.stack<1&!variable.pooling_runes
            if A.FesteringStrike:IsReady(unit) and Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) < 1 and not VarPoolingRunes then
                return A.FesteringStrike:Show(icon)
            end    
            
			--actions.generic+=/festering_strike,if=debuff.festering_wound.stack<4&cooldown.apocalypse.remains_expected<5&!variable.pooling_runes
            if A.FesteringStrike:IsReady(unit) and A.BurstIsON(unit) and Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) < 4 and A.Apocalypse:GetCooldown() < 5 and not VarPoolingRunes then
				return A.FesteringStrike:Show(icon)
            end    

			--if Burst is off
			if A.FesteringStrike:IsReady(unit) and not A.BurstIsON(unit) and Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) < 4 then
                return A.FesteringStrike:Show(icon)
            end
            
            --actions.generic+=/death_coil,if=!variable.pooling_runic_power
            if A.DeathCoil:IsReady(unit) and not VarPoolingRunicPower then
                return A.DeathCoil:Show(icon)
            end
            
        end
        
        --#######################
        --##### GENERIC AOE #####
        --#######################
        
        local function GenericAOE()
            
			--actions.generic_aoe=wait_for_cooldown,name=actions.cooldowns+=/soul_reaper,target_if=target.time_to_pct_35<5&target.time_to_die>5&active_enemies<=3
            if A.SoulReaper:IsReady(unit) and Unit("target"):HasDeBuffs(A.SoulReaper.ID, true) == 0 and A.SoulReaper:IsTalentLearned() and Unit("target"):TimeToDieX(35) < 5 and Unit("target"):TimeToDie() > 5 and MultiUnits:GetByRange(10, 4) <= 3 then
                return A.SoulReaper:Show(icon)
            end 
			
			--Plague if Burst is off
			if A.Outbreak:IsReady(unit) and Unit("target"):HasDeBuffs(A.VirulentPlague.ID, true) < 4 then
				return A.Outbreak:Show(icon)
			end
			
			--actions.generic_aoe+=/death_coil,if=(!variable.pooling_runic_power|buff.sudden_doom.react)&(buff.dark_transformation.up&runeforge.deadliest_coil&active_enemies<=3|active_enemies=2)
			if A.DeathCoil:IsReady(unit) and (not VarPoolingRunicPower or Unit(player):HasBuffs(A.SuddenDoom.ID, true) > 0) and ((Unit("pet"):HasBuffs(A.DarkTransformation.ID, true) > 0 and A.DeadliestCoil:HasLegendaryCraftingPower() and MultiUnits:GetByRange(10,4) <= 3) or MultiUnits:GetByRange(10,4) == 2) then
				return A.DeathCoil:Show(icon)
			end
			
            --actions.generic_aoe+=/epidemic,if=buff.sudden_doom.react|!variable.pooling_runic_power
            if A.Epidemic:IsReady(player) and Unit("target"):HasDeBuffs(A.VirulentPlague.ID, true) > 0 and (Unit(player):HasBuffs(A.SuddenDoom.ID, true) > 0 or not VarPoolingRunicPower) then
				return A.Epidemic:Show(icon)
            end  
			
            --actions.generic_aoe+=/wound_spender,target_if=max:debuff.festering_wound.stack,if=(cooldown.apocalypse.remains>5&debuff.festering_wound.up|debuff.festering_wound.stack>4)&(fight_remains<cooldown.death_and_decay.remains+10|fight_remains>cooldown.apocalypse.remains)
			if A.ScourgeStrike:IsReady(unit) and ((A.Apocalypse:GetCooldown() > 5 and Unit("target"):HasDeBuffs(A.FesteringWound.ID, true) > 0) or Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) > 4) and (Player:AreaTTD(10) < (A.DeathandDecay:GetCooldown() + 10) or (Player:AreaTTD(10) > A.Apocalypse:GetCooldown())) then 
                return A.ScourgeStrike:Show(icon)
            end    
            
            if A.ClawingShadows:IsReady(unit) and ((A.Apocalypse:GetCooldown() > 5 and Unit("target"):HasDeBuffs(A.FesteringWound.ID, true) > 0) or Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) > 4) and (Player:AreaTTD(10) < (A.DeathandDecay:GetCooldown() + 10) or (Player:AreaTTD(10) > A.Apocalypse:GetCooldown())) then 
                return A.ClawingShadows:Show(icon)
            end

			--if Burst is off
			if A.ScourgeStrike:IsReady(unit) and not A.BurstIsON(unit) and (Unit("target"):HasDeBuffs(A.FesteringWound.ID, true) > 0) and Player:AreaTTD(10) < (A.DeathandDecay:GetCooldown() + 10) then 
                return A.ScourgeStrike:Show(icon)
            end

			if A.ClawingShadows:IsReady(unit) and not A.BurstIsON(unit) and (Unit("target"):HasDeBuffs(A.FesteringWound.ID, true) > 0) and Player:AreaTTD(10) < (A.DeathandDecay:GetCooldown() + 10) then 
                return A.ClawingShadows:Show(icon)
            end   
            
            --actions.generic_aoe+=/festering_strike,target_if=max:debuff.festering_wound.stack,if=debuff.festering_wound.stack<=3&cooldown.apocalypse.remains<3|debuff.festering_wound.stack<1
            if A.FesteringStrike:IsReady(unit) and A.BurstIsON(unit) and ((Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) <= 3 and A.Apocalypse:GetCooldown() < 3) or Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) < 1) then
                return A.FesteringStrike:Show(icon)
            end
			
			if A.FesteringStrike:IsReady(unit) and not A.BurstIsON(unit) and ((Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) <= 3) or Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) < 1) then
                return A.FesteringStrike:Show(icon)
            end
            
            --actions.generic_aoe+=/festering_strike,target_if=min:debuff.festering_wound.stack,if=cooldown.apocalypse.remains>5&debuff.festering_wound.stack<1
            if A.FesteringStrike:IsReady(unit) and A.BurstIsON(unit) and A.Apocalypse:GetCooldown() > 5 and Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) < 1 then
                return A.FesteringStrike:Show(icon)
            end 

            --actions.generic_aoe+=/festering_strike,target_if=min:debuff.festering_wound.stack,if=cooldown.apocalypse.remains>5&debuff.festering_wound.stack<1
            if A.FesteringStrike:IsReady(unit) and not A.BurstIsON(unit) and Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) < 1 then
                return A.FesteringStrike:Show(icon)
            end 			
			
			--Festering if Burst if off
            if A.FesteringStrike:IsReady(unit) and not A.BurstIsON(unit) and Unit("target"):HasDeBuffsStacks(A.FesteringWound.ID, true) < 1 then
                return A.FesteringStrike:Show(icon)
            end  
			
            
        end    
        
		--#######################
        --####### TRINKETS ######
        --#######################
	
		local function Trinkets()
			--actions.trinkets=use_item,name=inscrutable_quantum_device,if=(cooldown.unholy_blight.remains|cooldown.dark_transformation.remains)&(pet.army_ghoul.active|pet.apoc_ghoul.active&!talent.army_of_the_damned|target.time_to_pct_20<5)|fight_remains<21
			if A.InscrutableQuantumDevice:IsReady(unit) and ((A.UnholyBlight:GetCooldown() > 0 or A.DarkTransformation:GetCooldown() > 0) and (A.ArmyoftheDead:GetSpellTimeSinceLastCast() < 30 or (A.Apocalypse:GetSpellTimeSinceLastCast() < 15 and not A.ArmyoftheDamned:IsTalentLearned()) or Unit("target"):TimeToDieX(20) < 5) or Player:AreaTTD(10) < 21) then
				return A.InscrutableQuantumDevice:Show(icon)
			end
			
			--actions.trinkets+=/use_item,name=macabre_sheet_music,if=cooldown.apocalypse.remains<5&(!equipped.inscrutable_quantum_device|cooldown.inscrutable_quantum_device.remains)|fight_remains<21
			if A.MacabreSheetMusic:IsReady(player) and (A.Apocalypse:GetCooldown() < 5 and (not IsEquippedItem(179350) or (IsEquippedItem(179350) and A.InscrutableQuantumDevice:GetCooldown() > 0)) or Player:AreaTTD(10) < 21) then
				return A.MacabreSheetMusic:Show(icon)
			end
			
			--actions.trinkets+=/use_item,name=dreadfire_vessel,if=cooldown.apocalypse.remains&(!equipped.inscrutable_quantum_device|cooldown.inscrutable_quantum_device.remains)|fight_remains<3
			if A.DreadfireVessel:IsReady(unit) and (A.Apocalypse:GetCooldown() > 0 and (not IsEquippedItem(179350) or (IsEquippedItem(179350) and A.InscrutableQuantumDevice:GetCooldown() > 0)) or Player:AreaTTD(10) < 3) then
				return A.DreadfireVessel:Show(icon)
			end
			
			--actions.trinkets+=/use_item,name=darkmoon_deck_voracity,if=cooldown.apocalypse.remains&(!equipped.inscrutable_quantum_device|cooldown.inscrutable_quantum_device.remains)|fight_remains<21
			if A.DarkMoonDeckVoracity:IsReady(unit) and (A.Apocalypse:GetCooldown() > 0 and (not IsEquippedItem(179350) or (IsEquippedItem(179350) and A.InscrutableQuantumDevice:GetCooldown() > 0)) or Player:AreaTTD(10) < 21) then
				return A.DarkMoonDeckVoracity:Show(icon)
			end
			
			--actions.trinkets+=/use_items,if=(cooldown.apocalypse.remains|buff.dark_transformation.up)&(!equipped.inscrutable_quantum_device|cooldown.inscrutable_quantum_device.remains)
			if A.Trinket1:IsReady(unit) and (A.Apocalypse:GetCooldown() > 0 or Unit("pet"):HasBuffs(A.DarkTransformation.ID, true) > 0) and (not IsEquippedItem(179350) or (IsEquippedItem(179350) and A.InscrutableQuantumDevice:GetCooldown() > 0)) then
				return A.Trinket1:Show(icon)    
            end
			
			if A.Trinket2:IsReady(unit) and (A.Apocalypse:GetCooldown() > 0 or Unit("pet"):HasBuffs(A.DarkTransformation.ID, true) > 0) and (not IsEquippedItem(179350) or (IsEquippedItem(179350) and A.InscrutableQuantumDevice:GetCooldown() > 0)) then
				return A.Trinket2:Show(icon)    
            end
		end
		
      --actions+=/arcane_torrent,if=runic_power.deficit>65&(pet.gargoyle.active|!talent.summon_gargoyle.enabled)&rune.deficit>=5
        if A.ArcaneTorrent:IsReady(player) and A.BurstIsON(unit) and Racial and RunicPowerDeficit > 65 and (GargoyleActive or not A.SummonGargoyle:IsTalentLearned()) and Player:Rune() < 2 then
            return A.ArcaneTorrent:Show(icon)
        end    
        
        --actions+=/blood_fury,if=variable.major_cooldowns_active|target.time_to_die<=buff.blood_fury.duration
        if A.BloodFury:IsReady(player) and A.BurstIsON(unit) and Racial and (VarMajorCooldownsActive or Unit("target"):TimeToDie() <= 15) then
			return A.BloodFury:Show(icon)
        end    
        
        --actions+=/berserking,if=variable.major_cooldowns_active|target.time_to_die<=buff.berserking.duration
        if A.Berserking:IsReady(player) and A.BurstIsON(unit) and Racial and (VarMajorCooldownsActive or Unit("target"):TimeToDie() <= 12) then
            return A.Berserking:Show(icon)
        end                
        --actions+=/lights_judgment,if=buff.unholy_strength.up
        if A.LightsJudgment:IsReady(unit) and A.BurstIsON(unit) and Racial and Unit(player):HasBuffs(A.UnholyStrength.ID, true) > 0 then
            return A.LightsJudgment:Show(icon)
        end
        
		--Ancestral Call can trigger 4 potential buffs, each lasting 15 seconds. Utilized hard coded time as a trigger to keep it readable.
        --actions+=/ancestral_call,if=variable.major_cooldowns_active|target.time_to_die<=15
        if A.AncestralCall:IsReady(player) and A.BurstIsON(unit) and Racial and (VarMajorCooldownsActive or Unit("target"):TimeToDie() <= 15) then
            return A.AncestralCall:Show(icon)
        end    
        
        --actions+=/arcane_pulse,if=active_enemies>=2|(rune.deficit>=5&runic_power.deficit>=60)
        if A.ArcanePulse:IsReady(unit) and A.BurstIsON(unit) and Racial and (MultiUnits:GetByRange(8, 2) >= 2 or (Player:Rune() < 2 and RunicPowerDeficit >= 60)) then
            return A.ArcanePulse:Show(icon)
        end    
        
        --actions+=/fireblood,if=variable.major_cooldowns_active|target.time_to_die<=buff.fireblood.duration
        if A.Fireblood:IsReady(player) and A.BurstIsON(unit) and Racial and (VarMajorCooldownsActive or Unit("target"):TimeToDie() <= 8) then
			return A.Fireblood:Show(icon)
        end                
        
        --actions+=/bag_of_tricks,if=buff.unholy_strength.up&active_enemies=1
        if A.BagofTricks:IsReady(unit) and A.BurstIsON(unit) and Racial and Unit(player):HasBuffs(A.UnholyStrength.ID, true) > 0 and MultiUnits:GetByRange(10, 11) < AoETargets then
            return A.BagofTricks:Show(icon)
        end   
		
		--Maintaining Virulent Plague is a priority
		--actions+=/outbreak,if=dot.virulent_plague.refreshable&!talent.unholy_blight&!raid_event.adds.exists
        if A.Outbreak:IsReady(unit) and VirulentPlagueRefreshable and not A.UnholyBlight:IsTalentLearned() then
            return A.Outbreak:Show(icon)
        end 

		-- OutBreak if Burst is off
		if A.Outbreak:IsReady(unit) and not A.BurstIsON(unit) and VirulentPlagueRefreshable then
            return A.Outbreak:Show(icon)
        end 
        
        --actions+=/outbreak,if=dot.virulent_plague.refreshable&active_enemies>=2&(!talent.unholy_blight|talent.unholy_blight&cooldown.unholy_blight.remains)
        if A.Outbreak:IsReady(unit) and VirulentPlagueRefreshable and (not A.UnholyBlight:IsTalentLearned() or (A.UnholyBlight:IsTalentLearned() and A.UnholyBlight:GetCooldown() > 0)) then
            return A.Outbreak:Show(icon)
        end  
		
		--actions+=/outbreak,if=runeforge.superstrain&(dot.frost_fever.refreshable|dot.blood_plague.refreshable)
		if A.Outbreak:IsReady(unit) and A.Superstrain:HasLegendaryCraftingPower() and (FrostFeverRefreshable or BloodPlagueRefreshable) then
			return A.Outbreak:Show(icon)
		end
		
		-- Outbreak if Burst is off
		if A.Outbreak:IsReady(unit) and not A.BurstIsON(unit) and A.Superstrain:HasLegendaryCraftingPower() and (FrostFeverRefreshable or BloodPlagueRefreshable) then
			return A.Outbreak:Show(icon)
		end
		
		--actions+=/wait_for_cooldown,name=soul_reaper,if=talent.soul_reaper&target.time_to_pct_35<5&fight_remains>5&cooldown.soul_reaper.remains<(gcd*0.75)&active_enemies=1
		if A.SoulReaper:IsTalentLearned() and Unit("target"):TimeToDieX(35) < 5 and Player:AreaTTD(10) > 5 and A.SoulReaper:GetCooldown() < (GetGCD() * 0.75) and MultiUnits:GetByRange(10, 11) < AoETargets then
			return A.PoolResource:Show(icon)
		end  
 
        --actions+=/call_action_list,name=trinkets
        if A.BurstIsON(unit) and inCombat and Trinkets() then     
            return Trinkets()
        end
        
		--actions+=/call_action_list,name=covenants
		if A.BurstIsON(unit) and inCombat and Covenants() then
			return Covenants()
		end
		
		--actions+=/sequence,if=active_enemies=1&!death_knight.disable_aotd,name=opener:army_of_the_dead:festering_strike:festering_strike:potion:unholy_blight:dark_transformation:apocalypse
		if A.BurstIsON(unit) and Opener() and Unit("player"):CombatTime() <= 15 then
			return Opener()
		end
		
		--actions+=/call_action_list,name=cooldowns
		if A.BurstIsON(unit) and Cooldowns() then
			return Cooldowns()
		end
		
        --actions+=/run_action_list,name=aoe_setup,if=active_enemies>=2&(cooldown.death_and_decay.remains<10&!talent.defile|cooldown.defile.remains<10&talent.defile)&!death_and_decay.ticking
        if MultiUnits:GetByRange(10, AoETargets) >= AoETargets and (A.DeathandDecay:GetCooldown() < 10 and not A.Defile:IsTalentLearned() or (A.Defile:GetCooldown() < 10 and A.Defile:IsTalentLearned())) and not DeathandDecayTicking and AoESetup() then             
            return AoESetup()
        end
        
        --actions+=/run_action_list,name=aoe_burst,if=active_enemies>=2&death_and_decay.ticking
        if MultiUnits:GetByRange(10, AoETargets) >= AoETargets and DeathandDecayTicking and AoEBurst() then             
            return AoEBurst()
        end    
        
        --actions+=/run_action_list,name=generic_aoe,if=active_enemies>=2&(!death_and_decay.ticking&(cooldown.death_and_decay.remains>10&!talent.defile|cooldown.defile.remains>10&talent.defile))
        if MultiUnits:GetByRange(10, AoETargets) >= AoETargets and GenericAOE() and (not DeathandDecayTicking and (A.DeathandDecay:GetCooldown() > 10 and not A.Defile:IsTalentLearned() or (A.Defile:GetCooldown() > 10 and A.Defile:IsTalentLearned()))) then             
            return GenericAOE()
        end    
        
        --actions+=/call_action_list,name=generic,if=active_enemies=1
        if MultiUnits:GetByRange(10, 11) < AoETargets and GenericST() then             
            return GenericST()
        end    
        
        
    end 
    
    -- End on EnemyRotation()
    
    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive and inCombat then 
        return SelfDefensive:Show(icon)
    end 
    
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
end

A[4] = nil
A[5] = nil 
A[6] = nil 
A[7] = nil 
A[8] = nil 

