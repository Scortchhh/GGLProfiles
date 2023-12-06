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

local DisarmIsReady                            = Action.DisarmIsReady

local Azerite                                 = LibStub("AzeriteTraits")

local ACTION_CONST_PALADIN_RETRIBUTION              = CONST.PALADIN_RETRIBUTION
local ACTION_CONST_AUTOTARGET                = CONST.AUTOTARGET
local ACTION_CONST_SPELLID_FREEZING_TRAP    = CONST.SPELLID_FREEZING_TRAP

local IsIndoors, UnitIsUnit                    = _G.IsIndoors, _G.UnitIsUnit

Action[ACTION_CONST_PALADIN_RETRIBUTION] = {
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
    -- CrownControl    
    IntimidatingShout                        = Create({ Type = "Spell", ID = 5246, isIntimidatingShout = true                                                }),
    StormBolt                                  = Create({ Type = "Spell", ID = 107570, isTalent = true, isStormBolt = true                                        }),
    StormBoltGreen                              = Create({ Type = "SpellSingleColor", ID = 107570, Color = "GREEN", Desc = "[1] CC", QueueForbidden = true         }),
    Pummel                                    = Create({ Type = "Spell", ID = 6552, isPummel = true                                                            }),
    PummelGreen                                = Create({ Type = "SpellSingleColor", ID = 6552, Color = "GREEN", Desc = "[2] Kick", QueueForbidden = true        }),
    Disarm                                    = Create({ Type = "Spell", ID = 236077, isTalent = true                                                         }),    -- PvP Talent
    -- Supportive     
    Taunt                                      = Create({ Type = "Spell", ID = 355, Desc = "[6] PvP Pets Taunt", QueueForbidden = true                            }),
    BattleShout                                = Create({ Type = "Spell", ID = 6673                                                                            }),
    -- Self Defensives
    RallyingCry                                = Create({ Type = "Spell", ID = 97462                                                                             }),
    BerserkerRage                            = Create({ Type = "Spell", ID = 18499                                                                             }),
    IgnorePain                                = Create({ Type = "Spell", ID = 19456                                                                             }),
    ShieldBlock                                = Create({ Type = "Spell", ID = 2565                                                                             }),
    SpellReflection                            = Create({ Type = "Spell", ID = 23920                                                                             }),
    EnragedRegeneration                        = Create({ Type = "Spell", ID = 184364                                                                             }),
    VictoryRush                                = Create({ Type = "Spell", ID = 34428                                                                            }),
    -- Finishers
    DivineStorm                            = Create({ Type = "Spell", ID = 53385                                                                            }),
    TemplarsVerdict                            = Create({ Type = "Spell", ID = 85256                                                                            }),
    -- CDS
    AvengingWrath                            = Create({ Type = "Spell", ID = 31884                                                                            }),
    Crusade                            = Create({ Type = "Spell", ID = 231895, isTalent = true                                                                            }),
    --kick
    Rebuke                            = Create({ Type = "Spell", ID = 96231                                                                           }),
	--covenant shit
	DivineToll                                = Create({ Type = "Spell", ID = 304971                                               }),
	VanquishersHammer                                = Create({ Type = "Spell", ID = 328204                                               }),
	AshenHallow                                = Create({ Type = "Spell", ID = 316958                                               }),
    -- Rotation       
    WakeOfAshes                                = Create({ Type = "Spell", ID = 255937                                               }),
    CrusaderStrike                                = Create({ Type = "Spell", ID = 35395                                               }),
    Judgement                                = Create({ Type = "Spell", ID = 20271                                               }),
    Consecration                                = Create({ Type = "Spell", ID = 26573                                               }),
	BladeofJustice                                = Create({ Type = "Spell", ID = 184575                                               }),
	HammerOfWrath                                = Create({ Type = "Spell", ID = 24275                                               }),
	Serapihm                                = Create({ Type = "Spell", ID = 152262                                               }),
	ExecutionSentence                                = Create({ Type = "Spell", ID = 343527                                               }),
	ShieldOfVengeance                                = Create({ Type = "Spell", ID = 184662                                               }),
	HolyAvenger                                = Create({ Type = "Spell", ID = 105809                                               }),
	FinalReckoning                                = Create({ Type = "Spell", ID = 343721                                               }),
    -- Movememnt    
    Charge                                    = Create({ Type = "Spell", ID = 100                                                                                }),
    Intervene                                = Create({ Type = "Spell", ID = 3411                                                                            }),
    --blessings
    BlessingofFreedom                                = Create({ Type = "Spell", ID = 1044                                                                            }),
    --cleanse
    CleanseToxins                                = Create({ Type = "Spell", ID = 213644                                               }),
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

Action:CreateEssencesFor(ACTION_CONST_PALADIN_RETRIBUTION)
local A = setmetatable(Action[ACTION_CONST_PALADIN_RETRIBUTION], { __index = Action })

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
    for key, val in pairs(Action[ACTION_CONST_PALADIN_RETRIBUTION]) do 
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
    if     A.StormBoltGreen:IsReady(nil, true, nil, true) and AntiFakeStun("target")
    then 
        return A.StormBoltGreen:Show(icon)         
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

local function countInterruptGCD(unitID)
    if not A.Rebuke:IsReadyByPassCastGCD(unitID) or not A.Rebuke:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then 
        return true 
    end 
end 

local function Interrupts(unitID)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime = InterruptIsValid(unitID,  nil, nil, countInterruptGCD(unitID))    
    
    -- Can waste interrupt action due delays caused by ping, interface input 
    if castRemainsTime < GetLatency() then 
        return 
    end 
    
    if not notInterruptable and A.Rebuke:IsReady(unitID) then 
        return A.Rebuke
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
        local rebuke = Interrupts(unitID)
        if rebuke then
            A.Rebuke:Show(icon) 
        end
        local cleanse = Cleanse(player)
        if cleanse then
            return A.CleanseToxins:Show(icon)
        end
        -- Variables        
        local isBurst            = BurstIsON(unitID)
        inMelee                 = A.CrusaderStrike:IsInRange(unitID)    
        
        -- Purge
        if A.ArcaneTorrent:AutoRacial(unitID) then 
            return A.ArcaneTorrent:Show(icon)
        end             
        
        local function Mitigation()
            if LoC:Get("SLOW") ~= 0 then
                if A.BlessingofFreedom:IsReady(unitID, true) then
                    return A.BlessingofFreedom:Show(icon)
                end
            end
        end

        -- [[ finishers ]]
        local function Finishers()
			
			if A.Serapihm:IsReady(unitID, true) then
				return A.Serapihm:Show(icon)
			end

			if A.VanquishersHammer:IsReady(unitID, true) then
				return A.VanquishersHammer:Show(icon)
			end

			if A.ExecutionSentence:IsReady(unitID, true) then
				return A.ExecutionSentence:Show(icon)
			end

			--actions.finishers+=/divine_storm,if=variable.ds_castable&!buff.vanquishers_hammer.up&((!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)&(!talent.execution_sentence.enabled|cooldown.execution_sentence.remains>gcd*3|spell_targets.divine_storm>=3)|spell_targets.divine_storm>=2&(talent.holy_avenger.enabled&cooldown.holy_avenger.remains<gcd*3|buff.crusade.up&buff.crusade.stack<10))
			
			if A.DivineStorm:IsReady(unitID, true) and Player:HolyPower() >= 3 and MultiUnits:GetByRange(8) >= 3 then
                return A.DivineStorm:Show(icon)
            end
            
            --actions.finishers+=/templars_verdict,if=(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)&(!talent.execution_sentence.enabled|cooldown.execution_sentence.remains>gcd*3&spell_targets.divine_storm<=3)&(!talent.final_reckoning.enabled|cooldown.final_reckoning.remains>gcd*3)&(!covenant.necrolord.enabled|cooldown.vanquishers_hammer.remains>gcd)|talent.holy_avenger.enabled&cooldown.holy_avenger.remains<gcd*3|buff.holy_avenger.up|buff.crusade.up&buff.crusade.stack<10|buff.vanquishers_hammer.up
            if A.TemplarsVerdict:IsReady(unitID, true) and Player:HolyPower() >= 3 then
                return A.TemplarsVerdict:Show(icon)
            end
            
        end
        
        -- [[ CDs ]]
        local function CDs()
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
			
			if A.ShieldOfVengeance:IsReady(unitID, true) then
				return A.ShieldOfVengeance:Show(icon)
			end

            if A.AvengingWrath:IsReady(unitID, true) and Player:HolyPower() >= 3 then
                return A.AvengingWrath:Show(icon)
			end
			
			if A.Crusade:IsReady(unitID, true) and Player:HolyPower() >= 4 then
				return A.Crusade:Show(icon)
			end

			if A.AshenHallow:IsReady(unitID, true) then
				return A.AshenHallow:Show(icon)
			end

			if A.HolyAvenger:IsReady(unitID, true) then
				return A.HolyAvenger:Show(icon)
			end

			if A.FinalReckoning:IsReady(unitID, true) and Player:HolyPower() >= 3 then
				return A.FinalReckoning:Show(icon)
			end
        end
        
        -- [[ Single Target ]]
        local function ST()
            --actions.generators+=/consecration,if=time_to_hpg>gcd
            if MultiUnits:GetByRangeInCombat(10) >= 3 then
                if A.Consecration:IsReady(unitID, true) and Unit(unitID):GetRange() < 5 then
                    return A.Consecration:Show(icon)
                end
            end
            if inMelee then
				if A.DivineToll:IsReady(unitID, true) then
					return A.DivineToll:Show(icon)
				end
                --actions.generators+=/wake_of_ashes,if=(holy_power=0|holy_power<=2&(cooldown.blade_of_justice.remains>gcd*2|debuff.execution_sentence.up|debuff.final_reckoning.up))&(!raid_event.adds.exists|raid_event.adds.in>20)&(!talent.execution_sentence.enabled|cooldown.execution_sentence.remains>15)&(!talent.final_reckoning.enabled|cooldown.final_reckoning.remains>15)
                if A.WakeOfAshes:IsReady(unitID, true) and A.BladeofJustice:GetCooldown() > (GetCurrentGCD()*2) and Player:HolyPower() <= 2 then
                    return A.WakeOfAshes:Show(icon)
                end
                --actions.generators+=/blade_of_justice,if=holy_power<=3
                if A.BladeofJustice:IsReady(unitID, true) and Player:HolyPower() <= 3 then
                    return A.BladeofJustice:Show(icon)
				end

				if A.HammerOfWrath:IsReady(unitID, true) and Player:HolyPower() <= 4 then
					return A.HammerOfWrath:Show(icon)
				end

				if A.Judgement:IsReady(unitID, true) and Player:HolyPower() <= 4 and Unit(unitID):HasDeBuffs(A.Judgement.ID) == 0 then
                    return A.Judgement:Show(icon)
                end
                --actions.generators+=/crusader_strike,if=holy_power<=4
                if A.CrusaderStrike:IsReady(unitID, true) and Player:HolyPower() <= 4 then
                    return A.CrusaderStrike:Show(icon)
                end
                if A.Consecration:IsReady(unitID, true) and Unit(unitID):GetRange() < 5 then
                    return A.Consecration:Show(icon)
                end
            end
        end
        
        -- CDs need to re enable isBurst once fixed
        if isBurst and CDs() then 
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

