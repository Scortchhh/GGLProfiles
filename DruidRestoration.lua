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

local UnitInLOS								= A.UnitInLOS
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
local HealingEngine                           = Action.HealingEngine

local DisarmIsReady                            = Action.DisarmIsReady

local Azerite                                 = LibStub("AzeriteTraits")

local ACTION_CONST_DRUID_RESTORATION             = CONST.DRUID_RESTORATION
local ACTION_CONST_AUTOTARGET                = CONST.AUTOTARGET
local ACTION_CONST_SPELLID_FREEZING_TRAP    = CONST.SPELLID_FREEZING_TRAP
local ActiveUnitPlates                          = MultiUnits:GetActiveUnitPlates()
local IsIndoors, UnitIsUnit                    = _G.IsIndoors, _G.UnitIsUnit
local getmembersAll = HealingEngine.Data.SortedUnitIDs

Action[ACTION_CONST_DRUID_RESTORATION] = {
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
    ----> Restoration <----
    Lifebloom                                 = Create({ Type = "Spell", ID = 33763     }),
    Rejuvenation                              = Create({ Type = "Spell", ID = 774     }),
    RejuvenationGermimation                   = Create({ Type = "Spell", ID = 155777    }),
    WildGrowth                                = Create({ Type = "Spell", ID = 48438     }),
    CenarionWard                              = Create({ Type = "Spell", ID = 102351     }),
    Regrowth                                  = Create({ Type = "Spell", ID = 8936     }),
    Swiftmend                                 = Create({ Type = "Spell", ID = 18562     }),
    Efflorescence                             = Create({ Type = "Spell", ID = 145205     }),
    Tranquility                             = Create({ Type = "Spell", ID = 740     }),
    Renewal                             = Create({ Type = "Spell", ID = 108238     }),
    Nourish                                   = Create({ Type = "Spell", ID = 50464     }),
    Overgrowth                                = Create({ Type = "Spell", ID = 203651     }),
    ClearCasting                              = Create({ Type = "Spell", ID = 16870     }), 
    Innervate                                 = Create({ Type = "Spell", ID = 29166     }),
    NaturesSwiftness                          = Create({ Type = "Spell", ID = 132158     }),  
    ConvokeTheSpirits                         = Create({ Type = "Spell", ID = 337433     }),
    Barkskin                                  = Create({ Type = "Spell", ID = 22812     }),
    Ironbark                                  = Create({ Type = "Spell", ID = 102342     }),
    EntanglingRoots                           = Create({ Type = "Spell", ID = 339    }),
    Cyclone                                   = Create({ Type = "Spell", ID = 33786       }),
    UrsolVortex                               = Create({ Type = "Spell", ID = 102793     }), 
    Hibernate                                 = Create({ Type = "Spell", ID = 2637     }), 
    NaturesCure                               = Create({ Type = "Spell", ID = 88423     }), 
    Soothe                                    = Create({ Type = "Spell", ID = 2908     }), 
    Photosynthesis                                   = Create({ Type = "Spell", ID = 274902     }),
    HearthofTheWild                                   = Create({ Type = "Spell", ID = 319454     }),
    Rebirth                                   = Create({ Type = "Spell", ID = 20484     }),
    Revive                                    = Create({ Type = "Spell", ID = 50769     }), 
    Revitalize                                = Create({ Type = "Spell", ID = 212040     }), 
    MoonFire                                  = Create({ Type = "Spell", ID = 8921     }),
    Sunfire                                   = Create({ Type = "Spell", ID = 93402     }),
    Starfire                                   = Create({ Type = "Spell", ID = 197628     }),
    Starsurge                                   = Create({ Type = "Spell", ID = 197626     }),
    Wrath                                = Create({ Type = "Spell", ID = 190984                                               }),
    NaturesSwiftness                                   = Create({ Type = "Spell", ID = 132158     }),
    SpringBlossoms                                   = Create({ Type = "Spell", ID = 207385     }),
    MoonKinForm                                = Create({ Type = "Spell", ID = 197625                                               }),
    BearForm                                = Create({ Type = "Spell", ID = 5487                                               }),
    TravelForm                                = Create({ Type = "Spell", ID = 783                                               }), 
    CatForm                                = Create({ Type = "Spell", ID = 768                                               }), 
    Heroism                                = Create({ Type = "Spell", ID = 32182                                               }),
    Bloodlust                                = Create({ Type = "Spell", ID = 204361                                               }),
    Timewarp                                = Create({ Type = "Spell", ID = 80353                                               }),
    Typhoon                                = Create({ Type = "Spell", ID = 132469                                               }),
    --legendaries
    VisionofUnendingGrowth                                = Create({ Type = "Spell", ID = 338832                                               }),
    TheDarkTitanLesson                                = Create({ Type = "Spell", ID = 338831                                               }),
    MemoryoftheMotherTree                                = Create({ Type = "Spell", ID = 339064                                               }), 
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
    Thorns                                    = Create({ Type = "Spell", ID = 305497, isTalent = true     }), 
    BlessingofProtection                   = Create({ Type = "Spell", ID = 1022, Hidden = true     }),	-- Used to check on offensive dispell 
    --Mythic Plus Spells 
	Quake                                     = Create({ Type = "Spell", ID = 240447, Hidden = true     }), -- Quake (Mythic Plus Affix)
	Burst                                     = Create({ Type = "Spell", ID = 240443, Hidden = true     }), -- Bursting (Mythic Plus Affix) Suffering 279 Shadow damage every 1 sec.
	GrievousWound                             = Create({ Type = "Spell", ID = 240559, Hidden = true     }), -- Grievous (Mythic Plus Affix) Bleeding for 1 Physical damage every 3 sec until healed above 90% of your maximum health. Direct heals remove 1 stacks.
    -- DPS stuff
    EclipseLunar                                = Create({ Type = "Spell", ID = 48518                                               }),
    EclipseSolar                                = Create({ Type = "Spell", ID = 48517                                               }),
    Rip                                = Create({ Type = "Spell", ID = 1079                                               }),
    Rake                                = Create({ Type = "Spell", ID = 1822                                               }),
    FerociousBite                                = Create({ Type = "Spell", ID = 22568                                               }),
    Swipe                                = Create({ Type = "Spell", ID = 213764                                               }),
    Shred                                = Create({ Type = "Spell", ID = 5221                                               }),
    FeralAffinity                                = Create({ Type = "Spell", ID = 197490     }),
    BalanceAffinity                                = Create({ Type = "Spell", ID = 197632     }),
    Ironfur                                   = Create({ Type = "Spell", ID = 192081     }),

    
}

Action:CreateEssencesFor(ACTION_CONST_DRUID_RESTORATION)
local A = setmetatable(Action[ACTION_CONST_DRUID_RESTORATION], { __index = Action })

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
    for key, val in pairs(Action[ACTION_CONST_DRUID_RESTORATION]) do 
        if type(val) == "table" and val.Type == "Trinket" then 
            Temp.IsSlotTrinketBlocked[val.ID] = true
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

local function CheckingRange()
    
    local rangeCheckCount = 0     
        
        for irangeCheckCount in pairs(ActiveUnitPlates) do     
            local unit = "nameplate"..irangeCheckCount
            if UnitCanAttack("player", unit) and UnitAffectingCombat("target") and IsItemInRange(10645, unit) then
                rangeCheckCount = rangeCheckCount + 1
                
            end
        end
    
    if rangeCheckCount > 1 then return true else return false end
end

local function EnemiesCount()
    
    local enemiesCheckCount = 0     
        
        for ienemiesCheckCount in pairs(ActiveUnitPlates) do    
            local unit = "nameplate"..ienemiesCheckCount
            if UnitCanAttack("player", unit) and UnitAffectingCombat("target") and IsItemInRange(10645, unit) then
                enemiesCheckCount = enemiesCheckCount + 1
                
            end
        end
    
    if enemiesCheckCount > 1 then return enemiesCheckCount else return 0 end
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
            -- if not notKickAble and A.SolarBeam:IsReady(unitID, nil, nil, true) and A.SolarBeam:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then
            --     return A.SolarBeam:Show(icon)                                                  
            -- end                   
        end 
    end                                                                                 
end

local function countInterruptGCD(unitID)
    -- if not A.SolarBeam:IsReadyByPassCastGCD(unitID) or not A.SolarBeam:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then 
    --     return true 
    -- end 
end 

local function Interrupts(unitID)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime = InterruptIsValid(unitID,  nil, nil, countInterruptGCD(unitID))    
    
    -- Can waste interrupt action due delays caused by ping, interface input 
    if castRemainsTime < GetLatency() then 
        return 
    end 
    
    -- if useKick and not notInterruptable and A.SolarBeam:IsReady(unitID) then 
    --     return A.SolarBeam
    -- end     
    if useKick and not notInterruptable and A.Typhoon:IsReady(unitID, true) and Unit(unitID):GetRange() <= 20 then
        return A.Typhoon
    end    
end

local function Soothe(unitID)

    if Unit(unitID):HasBuffs({
        333227,
        334800,
        326450,
        324737,
        321220,
        320012,
        320703,
        327155,
        324085,
        331510,
        342139
    })>1 then
            --print("enrage match list")
            if A.Soothe:IsReady(unitID) then
                --print("Soothe in matched list")
                return A.Soothe
            elseif not A.Soothe:IsReady(unitID) and GetToggle(2, "RootEnraged") and A.EntanglingRoots:IsReady(unitID) and A.InstanceInfo.KeyStone > 1 and not Unit(unitID):IsBoss() and not IsInRaid() and A.EntanglingRoots:AbsentImun(unitID, Temp.TotalAndPhysAndCCAndStun) and Unit(unitID):HasBuffs("CCMagicImun") == 0 and Unit(unitID):HasBuffs("CCTotalImun") == 0 and A.LastPlayerCastName ~= A.EntanglingRoots:Info() then
                --print("Roots in matched list")
                return A.EntanglingRoots 
            end
    end

   -- local useSooth = A.AuraIsValid(unitID, "UseExpelEnrage", "Enrage2")   
 --   if useSooth and A.Soothe:IsReady(unitID) then 
   --     return A.Soothe
  --  end
  --  if useSooth and not A.Soothe:IsReady(unitID) and A.EntanglingRoots:IsReady(unitID) then
   --     return A.EntanglingRoots   
   -- end      
end
local guid = UnitGUID("player")

local function Cleanse(unitID)
    if A.NaturesCure:IsReady(unitID, true) and (IsInRaid() or A.InstanceInfo.KeyStone > 1) then
        for i = 1, #getmembersAll do 
            if UnitGUID(getmembersAll[i].Unit) ~= guid then
                if Unit(getmembersAll[i].Unit):HasDeBuffs({
                    --Plaguefall
                    329110,
                    322410,
                    325552,
                    328395,
                    328180,
                    334926,
                    --The Necrotic Wake
                    328664,
                    323347,
                    324293,
                    --Mists of Tirna Scithe
                    323137,
                    328756,
                    322557,
                    325224,
                    321968,
                    322968,
                    326092,
                    324859,
                    --Halls of Atonement
                    339237,
                    319603,
                    319611,
                    325701,
                    326607,
                    326632,
                    325876,
                    --De Other Side
                    325725,
                    340026,
                    332605,
                    334493,
                    334496,
                    332707,
                    --Sanguine Depths
                    328494,
                    325885,
                    326836,
                    336277,
                    321038,
                    --Spires of Ascension
                    327481,
                    323636,
                    338731,
                    322818,
                    317963,
                    327648,
                    328331,
                    317661,
                    --Theather of Pain
                    319626,
                    323831,
                    330725,
                    333299,
                    333708,
                    -- Castle Nathria
                    343322,
                    334765,
                })>2 then
                    local delay = math.random(0.7, 1.25)
                    HealingEngine.SetTarget(getmembersAll[i].Unit, delay)
                    return true
                end
            end
        end
    elseif A.NaturesCure:IsReady(unitID, true) and not (IsInRaid() or A.InstanceInfo.KeyStone > 1) then
        for i = 1, #getmembersAll do 
            if Unit(getmembersAll[i].Unit):GetRange() <= 40 and AuraIsValid(getmembersAll[i].Unit, "UseDispel", "Dispel") then  
                HealingEngine.SetTarget(getmembersAll[i].Unit)
                return true                  												
            end				
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

local function GetCovenantAbility(unitID, icon)
    local ability,covenant = Player:GetCovenant()
    if A.ConvokeTheSpirits:IsReady(unitID, true) and covenant == "NightFae" and HealingEngine.GetBelowHealthPercentUnits(GetToggle(2, "ConvokeTheSpiritsParty")) >= GetToggle(2, "ConvokeTheSpiritsPartyCount") then
        return A.ConvokeTheSpirits:Show(icon)
    end
end

local shouldTab = true
local timeSinceLastTab = 0
local delayTabTime = 1.5
local tankHasLifeBloom = false
-- [3] Single Rotation
A[3] = function(icon)
    --local EnemyRotation, FriendlyRotation
    local isMoving             = Player:IsMoving()                    -- @boolean 
    local inCombat = Unit("player"):CombatTime()          -- @number 
    local inAoE                = GetToggle(2, "AoE")                -- @boolean 
    local inDisarm            = LoC:Get("DISARM") > 0                -- @boolean 
    local stealthed = false
    -- Group and Solo DPS
    local UseMoonkinForm = GetToggle(2, "UseMoonkinForm") 
    local UseCatForm = GetToggle(2, "UseCatForm")
    -- PvP DPS 
    local UseMoonkinFormPvP = GetToggle(2, "UseMoonkinFormPvP") 
    local UseCycloneInPvP = Action.GetToggle(2, "UseCycloneInPvP")
    -- Raid DPS
    local UseMoonkinFormInRaid = GetToggle(2, "UseMoonkinFormInRaid") 
    local UseCatFormInRaid = GetToggle(2, "UseCatFormInRaid") 
    -- Raid Healing stuff
    local HealRippedSoul  = GetToggle(2, "HealRippedSoul") 
    local HealSunKing  = GetToggle(2, "HealSunKing") 

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

    --------------------
	---  ENEMIES   ---
	--------------------

    if (UseMoonkinForm or UseMoonkinFormInRaid) and (UseCatForm or UseCatFormInRaid) then
        print("You cant use both Moonkin Form and Cat Form, please pick only one of them")
        return Action.SetToggle({2, "UseCatForm", "Use Cat form too DPS: "}, nil)
    end
    if A.FeralAffinity:IsTalentLearned() and (UseMoonkinForm or UseMoonkinFormInRaid) then
        print("To DPS in Moonkin form, you need to talent into Balance Affinity\n AUTO UNCHECKING Use Moonkin Form DPS Spells")
        return Action.SetToggle({2, "UseMoonkinForm", "Use Moonkin form DPS Spells: "}, nil)
    elseif A.BalanceAffinity:IsTalentLearned() and (UseCatForm or UseCatFormInRaid) then
        print("To DPS in Cat Form, you need to talent into Feral Affinity\n AUTO UNCHECKING Use Cat form to DPS")
        return Action.SetToggle({2, "UseCatForm", "Use Cat form too DPS: "}, nil)
    end

    -- Rotations 
    function EnemyRotation(unitID)
        local soothe = Soothe(unitID)
        if soothe and A.Soothe:IsReady(unitID, true) then
            return A.Soothe:Show(icon)
        elseif soothe and A.EntanglingRoots:IsReady(unitID, true) and not A.Soothe:IsReady(unitID) and GetToggle(2, "RootEnraged") and A.EntanglingRoots:IsReady(unitID) and A.InstanceInfo.KeyStone > 1 and not Unit(unitID):IsBoss() and not IsInRaid() and A.EntanglingRoots:AbsentImun(unitID, Temp.TotalAndPhysAndCCAndStun) and Unit(unitID):HasBuffs("CCMagicImun") == 0 and Unit(unitID):HasBuffs("CCTotalImun") == 0 and A.LastPlayerCastName ~= A.EntanglingRoots:Info() then
            return A.EntanglingRoots:Show(icon)
        end
        local typhoon = Interrupts(unitID)
        if typhoon and A.Typhoon:IsReady(unitID, true) then
            return A.Typhoon:Show(icon)
        end
        local inMelee = A.Rip:IsInRange(unitID)
 
    end

 

    function FriendlyRotation(unitID)    
        -- local typhoon = Interrupts(unitID)
        -- if typhoon and A.Typhoon:IsReady(unitID, true) then
        --     return A.Typhoon:Show(icon)
        -- end
        local naturescure = Cleanse()
        if naturescure then
            return A.NaturesCure:Show(icon)
        end
        local isBurst            = BurstIsON(unitID)
        
        -- inMelee                 = A.LavaLash:IsInRange(unitID)    
        
        -- Purge
        if A.ArcaneTorrent:AutoRacial(unitID) then 
            return A.ArcaneTorrent:Show(icon)
        end             
        
        -- [[ finishers ]]
        local function Finishers() 

        end


        local function SelfHealing()
            if A.Innervate:IsReady(unitID, true) and Player:Mana() <= GetToggle(2, "InnervateSelf") then
                return A.Innervate:Show(icon)
            end

            if A.Rejuvenation:IsReady(unitID, true) and Unit("player"):HealthPercent() <= GetToggle(2, "RejuvenationSelf") and Unit("player"):HasBuffs(A.Rejuvenation.ID) <= 3 then
                HealingEngine.SetTarget("player")
                return A.Rejuvenation:Show(icon)
            end

            if Unit("player"):HealthPercent() <= GetToggle(2, "RenewalSelf") and A.Renewal:IsReady(unitID, true) then 
                HealingEngine.SetTarget("player")
                return A.Renewal:Show(icon)
            end

            if Unit("player"):HealthPercent() <= GetToggle(2, "BarkSkinSelf") and A.Barkskin:IsReady(unitID, true) then
                return A.Barkskin:Show(icon)
            end

            if Unit("player"):HealthPercent() <= GetToggle(2, "IronBarkSelf") and A.Ironbark:IsReady(unitID, true) then
                HealingEngine.SetTarget("player")
                return A.Ironbark:Show(icon)
            end

            if A.Regrowth:IsReady(unitID, true) and Unit("player"):HealthPercent() <= GetToggle(2, "RegrowthSelf") and not isMoving then
                HealingEngine.SetTarget("player")
                return A.Regrowth:Show(icon)
            end
        end
        
        -- [[ CDs ]]
        local function CDs()  
            local Item = UseItems(unitID)
            if Item then
                return Item:Show(icon)
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
            if A.HearthofTheWild:IsReady(unitID, true) then
                if Unit("player"):HasBuffs(A.Bloodlust.ID) ~= 0 or Unit("player"):HasBuffs(A.Heroism.ID) ~= 0 or Unit("player"):HasBuffs(A.Heroism.ID) ~= 0 then
                    return A.HearthofTheWild:Show(icon)
                end
            end
        end

        local function hasEfflorance()
            for i = 1, #getmembersAll do 
                if Unit(getmembersAll[i].Unit):HasBuffs(A.SpringBlossoms.ID) >= 2 or A.Efflorescence:GetSpellTimeSinceLastCast() <= 20 then
                    return true
                end
            end
            return false
        end

        local function hasWildGrowth()
            for i = 1, #getmembersAll do 
                if Unit(getmembersAll[i].Unit):HasBuffs(A.WildGrowth.ID) >= 2 then
                    return true
                end
            end
            return false
        end

        local function hasLifebloom()
            local count = 0
            for i = 1, #getmembersAll do 
                if Unit(getmembersAll[i].Unit):HasBuffs(A.Lifebloom.ID) >= 2 then
                    count = count + 1
                end
                if Unit(getmembersAll[i].Unit):IsTank() and Unit(getmembersAll[i].Unit):HasBuffs(A.Lifebloom.ID) == 0 then
                    tankHasLifeBloom = false
                end
            end
            -- if Unit("player"):HasBuffs(A.Lifebloom.ID) >= 2 then
            --     count = count + 1
            -- end
            if count == 2 then
                return true
            elseif not A.TheDarkTitanLesson:HasLegendaryCraftingPower() and count == 1 then
                return true
            else
                return false
            end
        end

        local whenToDealDmgValue = GetToggle(2, "whenToDealDamage")
        -- [[ Single Target ]]
        local function HealingRotation()
            local covSpell = GetCovenantAbility(unitID, icon)
            if covSpell and GetToggle(1, "Covenant") then
                return covSpell
            end
            for i = 1, #getmembersAll do
                if IsInRaid() and GetToggle(2, "RebirthInRaid") then
                    if Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):IsDead() and IsInRaid() and GetToggle(2, "RebirthInRaid") then
                        if A.Rebirth:IsReady(unitID, true) and not isMoving then
                            HealingEngine.SetTarget(getmembersAll[i].Unit)
                            return A.Rebirth:Show(icon)
                        end
                    end
                elseif GetNumGroupMembers() >= 1 and not IsInRaid() and GetToggle(2, "RebirthInGroups") then
                    if Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):IsDead() and not IsInRaid() and GetToggle(2, "RebirthInGroups") then
                        if A.Rebirth:IsReady(unitID, true) and not isMoving then
                            HealingEngine.SetTarget(getmembersAll[i].Unit)
                            return A.Rebirth:Show(icon)
                        end
                    end
                end

               -- if GetNumGroupMembers() >= 2 and Unit("player"):CombatTime() <= 0 then
                --    if Unit("party1"):Role("TANK") and not UnitIsUnit("target", "party1") then
                --        HealingEngine.SetTarget("party1")
               --     elseif Unit("party2"):Role("TANK") and not UnitIsUnit("target", "party2") then
                 --       HealingEngine.SetTarget("party2")
                --    elseif Unit("party3"):Role("TANK") and not UnitIsUnit("target", "party3") then
                     --   HealingEngine.SetTarget("party3")
                 --   elseif Unit("party4"):Role("TANK") and not UnitIsUnit("target", "party4") then
                       -- HealingEngine.SetTarget("party4")
                  --  elseif Unit("party5"):Role("TANK") and not UnitIsUnit("target", "party5") then
                     --   HealingEngine.SetTarget("party5")
                  --  elseif IsInRaid() and not UnitIsUnit("target", "raid1") then
                   --     HealingEngine.SetTarget("raid1")
                   -- end
               -- end

                -- if Unit(getmembersAll[i].Unit):GetRange() <= 40 and A.BossMods:GetTimer(name) then
                --     if A.Tranquility:IsReady(unitID, true) then
                --         HealingEngine.SetTarget(getmembersAll[i].Unit)
                --         return A.Tranquility:Show(icon)
                --     end
                -- end

                -- PvE and Solo
                if GetToggle(2, "AutoTargeting") and not IsInRaid() then
                    if HealingEngine.GetBelowHealthPercentUnits(whenToDealDmgValue) == 0 and shouldTab and Unit("player"):CombatTime() > 0 and not IsUnitEnemy("target") and TMW.time > timeSinceLastTab then
                        timeSinceLastTab = TMW.time + delayTabTime
                        shouldTab = false
                        return A:Show(icon, ACTION_CONST_AUTOTARGET)    
                    end
    
                    if HealingEngine.GetBelowHealthPercentUnits(whenToDealDmgValue) == 0 and not shouldTab then   
                        shouldTab = true
                    end 
    
                    if HealingEngine.GetBelowHealthPercentUnits(whenToDealDmgValue) ~= 0 then   
                        shouldTab = false
                    end
                end

                -- PvP 
                if GetToggle(2, "AutoTargetingPvP") and (A.Zone == "arena" or A.Zone == "pvp") then
                    if HealingEngine.GetBelowHealthPercentUnits(whenToDealDmgValue) == 0 and shouldTab and Unit("player"):CombatTime() > 0 and not IsUnitEnemy("target") and TMW.time > timeSinceLastTab then
                        timeSinceLastTab = TMW.time + delayTabTime
                        shouldTab = false
                        return A:Show(icon, ACTION_CONST_AUTOTARGET)    
                    end
    
                    if HealingEngine.GetBelowHealthPercentUnits(whenToDealDmgValue) == 0 and not shouldTab then   
                        shouldTab = true
                    end 
    
                    if HealingEngine.GetBelowHealthPercentUnits(whenToDealDmgValue) ~= 0 then   
                        shouldTab = false
                    end
                end
                -- Raid DPS
                if GetToggle(2, "AutoTargetingRaid") and IsInRaid() then
                    if HealingEngine.GetBelowHealthPercentUnits(whenToDealDmgValue) == 0 and shouldTab and Unit("player"):CombatTime() > 0 and not IsUnitEnemy("target") and TMW.time > timeSinceLastTab then
                        timeSinceLastTab = TMW.time + delayTabTime
                        shouldTab = false
                        return A:Show(icon, ACTION_CONST_AUTOTARGET)    
                    end
    
                    if HealingEngine.GetBelowHealthPercentUnits(whenToDealDmgValue) == 0 and not shouldTab then   
                        shouldTab = true
                    end 
    
                    if HealingEngine.GetBelowHealthPercentUnits(whenToDealDmgValue) ~= 0 then   
                        shouldTab = false
                    end
                end
                -- Thorns Player
                if Unit(getmembersAll[i].Unit):GetRange() <= 40 and A.IsInPvP and (A.Zone == "arena" or A.Zone == "pvp") and not Player:IsStealthed() then
                    if A.Thorns:IsReady(player) and A.Thorns:IsSpellLearned() and Unit(getmembersAll[i].Unit):CombatTime() > 0 and Unit(getmembersAll[i].Unit):IsFocused("MELEE") and UnitGUID(getmembersAll[i].Unit) ~= guid then
                        HealingEngine.SetTarget(getmembersAll[i].Unit) 
                        return A.Thorns:Show(icon)
                    end	
                end
                -- M+ affix Grievous Wound  
                if Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):HasBuffs(A.GrievousWound.ID) >= 1 and not isMoving and GetToggle(2, "PrioGrievousWoundPartyMember") then  
                    if A.Regrowth:IsReady(unitID, true) and UnitGUID(getmembersAll[i].Unit) ~= guid then
                        HealingEngine.SetTarget(getmembersAll[i].Unit)
                        return A.Regrowth:Show(icon)
                    end
                end

                -- M+ affix Burst - Force spread Rejuvenation to handle bursting affix
		        if Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):HasBuffs(A.Rejuvenation.ID) == 0 and Unit(getmembersAll[i].Unit):HasBuffs(A.Burst.ID) >= 1 and GetToggle(2, "BurstAffixSpreadRejParty") then
                    if A.Rejuvenation:IsReadyByPassCastGCD(getmembersAll[i].Unit) and Unit(getmembersAll[i].Unit):GetRange() < 40 and Unit(getmembersAll[i].Unit):IsPlayer() and Unit(getmembersAll[i].Unit):HasBuffs(A.Rejuvenation.ID, true, player) < GetGCD() + 0.1 then
                        A.HealingEngine.SetTarget(getmembersAll[i].Unit)
						A.Rejuvenation:SetQueue(getmembersAll[i].Unit)			
	                    Action.SendNotification("Force Spreading " .. A.GetSpellInfo(A.Rejuvenation.ID), A.Rejuvenation.ID)	
					end
		        end

                if Unit(getmembersAll[i].Unit):GetRange() <= 40 and tankHasLifeBloom and Unit(player):HasBuffs(A.Lifebloom.ID) <= 2 then  
                    if A.Lifebloom:IsReady(unitID, true) and UnitGUID(getmembersAll[i].Unit) ~= guid then
                        HealingEngine.SetTarget("player")
                        return A.Lifebloom:Show(icon) 
                    end
                end

                if Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):HealthPercent() <= GetToggle(2, "NaturesSwiftness") and A.Swiftmend:GetCooldown() ~= 0 then  
                    if A.NaturesSwiftness:IsReady(unitID, true) and UnitGUID(getmembersAll[i].Unit) ~= guid and Unit(getmembersAll[i].Unit):CombatTime() > 0 then
                        HealingEngine.SetTarget(getmembersAll[i].Unit)
                        return A.NaturesSwiftness:Show(icon)
                    end
                end

                if Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):HealthPercent() <= GetToggle(2, "IronBarkParty")  and Unit(getmembersAll[i].Unit):IsTank() then  
                    if A.Ironbark:IsReady(unitID, true) and UnitGUID(getmembersAll[i].Unit) ~= guid and Unit(getmembersAll[i].Unit):CombatTime() > 0 then
                        HealingEngine.SetTarget(getmembersAll[i].Unit)
                        return A.Ironbark:Show(icon)
                    end
                end

                local LifebloomActive = hasLifebloom()
                if Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):HealthPercent() <= GetToggle(2, "LifebloomParty") and Unit(getmembersAll[i].Unit):IsTank() and not LifebloomActive then  
                    if A.Lifebloom:IsReady(unitID, true) and UnitGUID(getmembersAll[i].Unit) ~= guid and Unit(getmembersAll[i].Unit):HasBuffs(A.Lifebloom.ID) <= 2 then
                        tankHasLifeBloom = true
                        HealingEngine.SetTarget(getmembersAll[i].Unit)
                        return A.Lifebloom:Show(icon) 
                    end
                end

                LifebloomActive = hasLifebloom()
                if HealingEngine.GetBelowHealthPercentUnits(60) >= 3 then
                    if A.Photosynthesis:IsTalentLearned() and A.Lifebloom:IsReady(unitID, true) and Unit("player"):HasBuffs(A.Lifebloom.ID) <= 2 then
                        HealingEngine.SetTarget("player")
                        return A.Lifebloom:Show(icon)
                    end
                else
                    if Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):HealthPercent() <= GetToggle(2, "LifebloomParty") and not LifebloomActive and tankHasLifeBloom then  
                        if A.Lifebloom:IsReady(unitID, true) and UnitGUID(getmembersAll[i].Unit) ~= guid and Unit(getmembersAll[i].Unit):HasBuffs(A.Lifebloom.ID) <= 2 then
                            HealingEngine.SetTarget(getmembersAll[i].Unit)
                            return A.Lifebloom:Show(icon) 
                        end
                    end
                end

                if Unit(getmembersAll[i].Unit):GetRange() <= 40 and HealingEngine.GetBelowHealthPercentUnits(GetToggle(2, "TranquilityParty")) >= GetToggle(2, "TranquilityPartyCount") and not isMoving then  
                    if A.Tranquility:IsReady(unitID, true) and UnitGUID(getmembersAll[i].Unit) ~= guid then
                        HealingEngine.SetTarget(getmembersAll[i].Unit)
                        return A.Tranquility:Show(icon) 
                    end
                end

                local WildGrowthActive = hasWildGrowth()
                if Unit(getmembersAll[i].Unit):GetRange() <= 40 and HealingEngine.GetBelowHealthPercentUnits(GetToggle(2, "WildGrowthParty")) >= GetToggle(2, "WildGrowthPartyCount") and not WildGrowthActive and not isMoving then  
                    if A.WildGrowth:IsReady(unitID, true) and UnitGUID(getmembersAll[i].Unit) ~= guid then
                        HealingEngine.SetTarget(getmembersAll[i].Unit)
                        return A.WildGrowth:Show(icon) 
                    end
                end

                local EfflorescenceActive = hasEfflorance()
                if Unit(getmembersAll[i].Unit):GetRange() <= 40 and HealingEngine.GetBelowHealthPercentUnits(GetToggle(2, "EfflorescenceParty")) >= GetToggle(2, "EfflorescencePartyCount") and not EfflorescenceActive then  
                    if A.Efflorescence:IsReady(unitID, true) and UnitGUID(getmembersAll[i].Unit) ~= guid then
                        return A.Efflorescence:Show(icon) 
                    end
                end

                if Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):HasBuffs(A.Rejuvenation.ID) ~= 0 and Unit(getmembersAll[i].Unit):HealthPercent() <= GetToggle(2, "SwiftmendParty") then  
                    if A.Swiftmend:IsReady(unitID, true) and UnitGUID(getmembersAll[i].Unit) ~= guid then
                        HealingEngine.SetTarget(getmembersAll[i].Unit)
                        return A.Swiftmend:Show(icon) 
                    end
                end

                if Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):HasBuffs(A.Rejuvenation.ID) <= 3 and Unit(getmembersAll[i].Unit):HealthPercent() <= GetToggle(2, "RejuvenationParty") then  
                    if A.Rejuvenation:IsReady(unitID, true) and UnitGUID(getmembersAll[i].Unit) ~= guid then
                        HealingEngine.SetTarget(getmembersAll[i].Unit)
                        return A.Rejuvenation:Show(icon) 
                    end
                end

                if Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):HealthPercent() <= GetToggle(2, "CenarionWardParty")  and Unit(getmembersAll[i].Unit):IsTank() then  
                    if A.CenarionWard:IsReady(unitID, true) and UnitGUID(getmembersAll[i].Unit) ~= guid and Unit(getmembersAll[i].Unit):CombatTime() > 0 then
                        HealingEngine.SetTarget(getmembersAll[i].Unit)
                        return A.CenarionWard:Show(icon)
                    end
                end

                if Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):HealthPercent() <= GetToggle(2, "RegrowthParty") and Player:Mana() >= 40 and not isMoving then  
                    if A.Regrowth:IsReady(unitID, true) and UnitGUID(getmembersAll[i].Unit) ~= guid then
                        HealingEngine.SetTarget(getmembersAll[i].Unit)
                        return A.Regrowth:Show(icon)
                    end
                end
            end
            -- if not IsUnitEnemy("target") then
            --     return A:Show(icon, ACTION_CONST_AUTOTARGET)
            -- end
        end

        if GetNumGroupMembers() >= 2 and Unit("target"):IsDead() and IsUnitEnemy("target") and Unit("player"):CombatTime() >= 1 then
            if Unit("party1"):Role("TANK") and not UnitIsUnit("target", "party1") then
                HealingEngine.SetTarget("party1")
            elseif Unit("party2"):Role("TANK") and not UnitIsUnit("target", "party2") then
                HealingEngine.SetTarget("party2")
            elseif Unit("party3"):Role("TANK") and not UnitIsUnit("target", "party3") then
                HealingEngine.SetTarget("party3")
            elseif Unit("party4"):Role("TANK") and not UnitIsUnit("target", "party4") then
                HealingEngine.SetTarget("party4")
            elseif Unit("party5"):Role("TANK") and not UnitIsUnit("target", "party5") then
                HealingEngine.SetTarget("party5")
            elseif IsInRaid() and not UnitIsUnit("target", "raid1") and not Unit("party1"):Role("TANK") and not Unit("party2"):Role("TANK") and not Unit("party3"):Role("TANK") and not Unit("party4"):Role("TANK") and not Unit("party5"):Role("TANK") then
                HealingEngine.SetTarget("raid1")
            end
        end

        if SelfHealing() and not (Unit(player):HasDeBuffs(A.Quake.ID) <= 2 and Unit(player):HasDeBuffs(A.Quake.ID) > 0) then
            return true
        end
        
        if HealingRotation() and not (Unit(player):HasDeBuffs(A.Quake.ID) <= 2 and Unit(player):HasDeBuffs(A.Quake.ID) > 0) then
            return true
        end
        
        -- GiftofNaaru
        if A.GiftofNaaru:AutoRacial(player) and Unit(player):TimeToDie() < 10 then 
            return A.GiftofNaaru:Show(icon)
        end            
    end

    if A.Rejuvenation:IsReady(unitID, true) and Unit("player"):HealthPercent() ~= 100 and Unit("player"):HasBuffs(A.Rejuvenation.ID) == 0 and inCombat == 0 and not IsMounted() and Unit("player"):HasBuffs(A.TravelForm.ID) == 0 then
        return A.Rejuvenation:Show(icon)
    end

    if A.TravelForm:IsReady(unitID, true) and IsOutdoors() and inCombat <= 0 and Unit(player):HasBuffs(A.TravelForm.ID) == 0 and not IsMounted() and GetCurrentGCD() == 0 and IsPlayerMoving() and not (A.Zone == "arena" or A.Zone == "pvp") and not Player:IsStealthed() then
        return A.TravelForm:Show(icon)
    end

    local _, _, _, notInterruptable, spellID, _ = A.Unit(player):IsCasting() 
    -- healing


        if FriendlyRotation("target")  then
            return true 
        end

    -- Target     
    if IsUnitEnemy("target") and EnemyRotation("target")  then 
        return true 
    end

end 

A[4] = nil