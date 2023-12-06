local _G, setmetatable							= _G, setmetatable
local A                         			    = _G.Action
local Covenant									= _G.LibStub("Covenant")
local TMW										= _G.TMW
local GetLatency                                = Action.GetLatency
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


FirstTarget = {"FirstTarget"}
SwappedTarget = {"SwappedTarget"}
Swapped = false
DotRotation = false
DotRotationCount = 0
isFirstUnit = true


--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- luacheck: max_line_length 9999

Action[ACTION_CONST_WARLOCK_AFFLICTION] = {
    -- Racial
    ArcaneTorrent				= Action.Create({ Type = "Spell", ID = 50613	}),
    BloodFury					= Action.Create({ Type = "Spell", ID = 20572	}),
    Fireblood					= Action.Create({ Type = "Spell", ID = 265221	}),
    AncestralCall				= Action.Create({ Type = "Spell", ID = 274738	}),
    Berserking					= Action.Create({ Type = "Spell", ID = 26297	}),
    ArcanePulse             	= Action.Create({ Type = "Spell", ID = 260364	}),
    QuakingPalm           		= Action.Create({ Type = "Spell", ID = 107079	}),
    Haymaker           			= Action.Create({ Type = "Spell", ID = 287712	}), 
    BullRush           			= Action.Create({ Type = "Spell", ID = 255654	}),    
    WarStomp        			= Action.Create({ Type = "Spell", ID = 20549	}),
    GiftofNaaru   				= Action.Create({ Type = "Spell", ID = 59544	}),
    Shadowmeld   				= Action.Create({ Type = "Spell", ID = 58984    }),
    Stoneform 					= Action.Create({ Type = "Spell", ID = 20594    }), 
    BagofTricks					= Action.Create({ Type = "Spell", ID = 312411	}),
    WilloftheForsaken			= Action.Create({ Type = "Spell", ID = 7744		}),   
    EscapeArtist				= Action.Create({ Type = "Spell", ID = 20589    }), 
    EveryManforHimself			= Action.Create({ Type = "Spell", ID = 59752    }), 
	
	--Warlock General
    Banish			     		= Action.Create({ Type = "Spell", ID = 710		}),
    Corruption					= Action.Create({ Type = "Spell", ID = 172		}),
    CorruptionDebuff			= Action.Create({ Type = "Spell", ID = 146739, Hidden = true	}),
    CreateHealthstone       	= Action.Create({ Type = "Spell", ID = 6201		}),
    CreateSoulwell		    	= Action.Create({ Type = "Spell", ID = 29893	}),
    CurseofExhaustion      	 	= Action.Create({ Type = "Spell", ID = 334275	}),
    CurseofTongues				= Action.Create({ Type = "Spell", ID = 1714		}),
    CurseofWeakness				= Action.Create({ Type = "Spell", ID = 702		}),
    DemonicCircle				= Action.Create({ Type = "Spell", ID = 48018	}),
    DemonicCircleTeleport		= Action.Create({ Type = "Spell", ID = 48020	}),	
    DemonicGateway				= Action.Create({ Type = "Spell", ID = 111771	}),	
    DrainLife					= Action.Create({ Type = "Spell", ID = 234153	}),
    EyeofKilrogg				= Action.Create({ Type = "Spell", ID = 126		}),
	Fear						= Action.Create({ Type = "Spell", ID = 5782		}),
	FelDomination				= Action.Create({ Type = "Spell", ID = 333889	}),	
	HealthFunnel				= Action.Create({ Type = "Spell", ID = 755		}),	
	RitualofDoom				= Action.Create({ Type = "Spell", ID = 342601	}),	
	RitualofSummoning			= Action.Create({ Type = "Spell", ID = 698		}),	
	ShadowBolt					= Action.Create({ Type = "Spell", ID = 686		}),	
	Shadowfury					= Action.Create({ Type = "Spell", ID = 30283	}),	
	Soulstone					= Action.Create({ Type = "Spell", ID = 20707	}),	
	SubjugateDemon				= Action.Create({ Type = "Spell", ID = 1098		}),	
	UnendingBreath				= Action.Create({ Type = "Spell", ID = 5697		}),	
	UnendingResolve				= Action.Create({ Type = "Spell", ID = 104773	}),	

	--Pet Summon
    SummonImp					= Action.Create({ Type = "Spell", ID = 688		}),    
    SummonVoidwalker			= Action.Create({ Type = "Spell", ID = 697		}),
    SummonFelhunter				= Action.Create({ Type = "Spell", ID = 691		}),
    SummonSuccubus				= Action.Create({ Type = "Spell", ID = 712		}),	
    CommandDemon				= Action.Create({ Type = "Spell", ID = 119898	}),	
    SingeMagic					= Action.Create({ Type = "Spell", ID = 119905	}),	
    ShadowBulwark				= Action.Create({ Type = "Spell", ID = 119907	}),	
    SpellLock					= Action.Create({ Type = "Spell", ID = 19647	}),	
    Seduction					= Action.Create({ Type = "Spell", ID = 119909	}),	

	--Affliction Spells
    Agony						= Action.Create({ Type = "Spell", ID = 980		}),
    AgonyDebuff					= Action.Create({ Type = "Spell", ID = 980, Hidden = true		}),
    MaleficRapture				= Action.Create({ Type = "Spell", ID = 324536, Hidden = true	}),
    SeedofCorruption			= Action.Create({ Type = "Spell", ID = 27243	}),
    SeedofCorruptionDebuff		= Action.Create({ Type = "Spell", ID = 27243, Hidden = true		}),
	SummonDarkglare				= Action.Create({ Type = "Spell", ID = 205180	}),
    UnstableAffliction			= Action.Create({ Type = "Spell", ID = 316099	}),
    UnstableAfflictionDebuff	= Action.Create({ Type = "Spell", ID = 316099, Hidden = true	}),

	--Normal Talents
    Nightfall					= Action.Create({ Type = "Spell", ID = 108558, Hidden = true	}),
    NightfallBuff				= Action.Create({ Type = "Spell", ID = 264571, Hidden = true	}),
    InevitableDemise			= Action.Create({ Type = "Spell", ID = 334319, Hidden = true	}),
    InevitableDemiseBuff		= Action.Create({ Type = "Spell", ID = 273525, Hidden = true	}),
    DrainSoul					= Action.Create({ Type = "Spell", ID = 198590	}),
    WritheInAgony				= Action.Create({ Type = "Spell", ID = 196102	}),
    AbsoluteCorruption			= Action.Create({ Type = "Spell", ID = 196103	}),
    SiphonLife					= Action.Create({ Type = "Spell", ID = 63106	}),
    SiphonLifeDebuff			= Action.Create({ Type = "Spell", ID = 63106, Hidden = true		}),	
    DemonSkin					= Action.Create({ Type = "Spell", ID = 219272, Hidden = true	}),
    BurningRush					= Action.Create({ Type = "Spell", ID = 111400	}),
    DarkPact					= Action.Create({ Type = "Spell", ID = 108416	}),
    SowtheSeeds					= Action.Create({ Type = "Spell", ID = 196226, Hidden = true	}),
    PhantomSingularity			= Action.Create({ Type = "Spell", ID = 205179	}),
    PhantomSingularityDebuff	= Action.Create({ Type = "Spell", ID = 205179, Hidden = true	}),	
    VileTaint					= Action.Create({ Type = "Spell", ID = 278350	}),
    Darkfury					= Action.Create({ Type = "Spell", ID = 264874, Hidden = true	}),
	MortalCoil					= Action.Create({ Type = "Spell", ID = 6789		}),
	HowlofTerror				= Action.Create({ Type = "Spell", ID = 5484		}),
	DarkCaller					= Action.Create({ Type = "Spell", ID = 334183, Hidden = true	}),
    Haunt						= Action.Create({ Type = "Spell", ID = 48181	}),
    GrimoireofSacrifice			= Action.Create({ Type = "Spell", ID = 108503	}),
    GrimoireofSacrificeBuff		= Action.Create({ Type = "Spell", ID = 196099, Hidden = true	}),
    SoulConduit					= Action.Create({ Type = "Spell", ID = 215941, Hidden = true	}),
    CreepingDeath				= Action.Create({ Type = "Spell", ID = 264000, Hidden = true	}),
    DarkSoulMisery				= Action.Create({ Type = "Spell", ID = 113860	}),

	--PvP Talents
    BaneofFragility				= Action.Create({ Type = "Spell", ID = 199954	}),
    Deathbolt					= Action.Create({ Type = "Spell", ID = 264106	}),
    Soulshatter					= Action.Create({ Type = "Spell", ID = 212356	}),
    GatewayMastery				= Action.Create({ Type = "Spell", ID = 248855, Hidden = true	}),
    RotandDecay					= Action.Create({ Type = "Spell", ID = 212371, Hidden = true	}),
    BaneofShadows				= Action.Create({ Type = "Spell", ID = 234877	}),
    NetherWard					= Action.Create({ Type = "Spell", ID = 212295	}),
    EssenceDrain				= Action.Create({ Type = "Spell", ID = 221711, Hidden = true	}),
    CastingCircle				= Action.Create({ Type = "Spell", ID = 221703	}),
    DemonArmor					= Action.Create({ Type = "Spell", ID = 285933	}),
    AmplifyCurse				= Action.Create({ Type = "Spell", ID = 328774	}),
    RampantAfflictions			= Action.Create({ Type = "Spell", ID = 335052, Hidden = true	}),
    RapidContagion				= Action.Create({ Type = "Spell", ID = 344566	}),

}



local player                                    = "player"
local Temp = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
	TotalAndCC                              = {"TotalImun", "CCTotalImun"},
	
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
	TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
    DisablePhys                             = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                              = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
	CastStartTime                           = {},
}

local IsIndoors, UnitIsUnit, UnitName = IsIndoors, UnitIsUnit, UnitName

local function IsSchoolFree()
	return LoC:IsMissed("SILENCE") and LoC:Get("SCHOOL_INTERRUPT", "SHADOW") == 0
end 


-- [2] Kick AntiFake Rotation
A[2] = nil


--- ======= ACTION LISTS =======
-- [3] Single Rotation
A[3] = function(icon, isMulti)



    
    -- Mouseover
    if A.IsUnitEnemy("mouseover") then
        unit = "mouseover"
        if MouseoverRotation(unit) then 
            return true 
        end 
    end 
    
    -- Target  
    if A.IsUnitEnemy("target") then 
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