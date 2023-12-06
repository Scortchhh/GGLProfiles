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
local HealingEngine                           = Action.HealingEngine

local DisarmIsReady                            = Action.DisarmIsReady

local Azerite                                 = LibStub("AzeriteTraits")

local ACTION_CONST_PRIEST_HOLY             = CONST.PRIEST_HOLY
local ACTION_CONST_AUTOTARGET                = CONST.AUTOTARGET
local ACTION_CONST_SPELLID_FREEZING_TRAP    = CONST.SPELLID_FREEZING_TRAP
local ActiveUnitPlates                          = MultiUnits:GetActiveUnitPlates()
local IsIndoors, UnitIsUnit                    = _G.IsIndoors, _G.UnitIsUnit
local getmembersAll = HealingEngine.Data.SortedUnitIDs

Action[ACTION_CONST_PRIEST_HOLY] = {
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
    --passives
    PowerWordFortitude                                 = Create({ Type = "Spell", ID = 21562     }),
    --healing cds
    DesperatePrayer                                 = Create({ Type = "Spell", ID = 19236     }),
    --healing
    PowerWordShield                                 = Create({ Type = "Spell", ID = 17     }),
    FlashHeal                                 = Create({ Type = "Spell", ID = 2061     }),
    HolyWordSerenity                                 = Create({ Type = "Spell", ID = 2050     }),
    Renew                                 = Create({ Type = "Spell", ID = 44174     }),
    --dispell
    PurifySpirit                                 = Create({ Type = "Spell", ID = 77130     }),
    WindShear                                = Create({ Type = "Spell", ID = 57994                                               }),
    Purge                                = Create({ Type = "Spell", ID = 370                                               }),
    --dmg
    ShadowWordPain                                = Create({ Type = "Spell", ID = 589                                               }),
    MindBlast                                = Create({ Type = "Spell", ID = 8092                                               }),
    Smite                                = Create({ Type = "Spell", ID = 585                                               }),
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

Action:CreateEssencesFor(ACTION_CONST_PRIEST_HOLY)
local A = setmetatable(Action[ACTION_CONST_PRIEST_HOLY], { __index = Action })

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
    for key, val in pairs(Action[ACTION_CONST_PRIEST_HOLY]) do 
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
            if UnitCanAttack("player", unit) and UnitAffectingCombat("target") and IsItemInRange(10645, unit) and UnitIsUnit("player", unit) then
                rangeCheckCount = rangeCheckCount + 1
                
            end
        end
    
    if rangeCheckCount > 1 then return true else return false end
end

local function EnemiesCount()
    
    local enemiesCheckCount = 0     
        
        for ienemiesCheckCount in pairs(ActiveUnitPlates) do    
            local unit = "nameplate"..ienemiesCheckCount
            if UnitCanAttack("player", unit) and UnitAffectingCombat("target") and IsItemInRange(10645, unit) and UnitIsUnit("player", unit) then
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

local function Purge(unitID)
    local usePurge = AuraIsValid(unitID, "UsePurge", "PurgeHigh")    
    if usePurge and A.Purge:IsReady(unitID) then 
        return A.Purge
    end         
end
local guid = UnitGUID("player")

local function Cleanse(unitID)
    if A.PurifySpirit:IsReady(unitID, true) then
        for i = 1, #getmembersAll do 
            if UnitGUID(getmembersAll[i].Unit) ~= guid then
                if Unit(getmembersAll[i].Unit):HasDeBuffs({
                    --The Necrotic Wake
                    328664,
                    320788,
                    323347,
                    324293,
                    --Plaguefall
                    329110,
                    322410,
                    328180,
                    --Mists of Tirna Scithe
                    323137,
                    328756,
                    322557,
                    325224,
                    321968,
                    322968,
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
                })>2 then
                    local delay = math.random(0.7, 1.25)
                    HealingEngine.SetTarget(getmembersAll[i].Unit, delay)
                    return true
                end
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
    -- local ability,covenant = Player:GetCovenant()
    -- if A.ConvoketheSpirits:IsReady(unitID, true) and covenant == "NightFae" and Unit("player"):HasBuffs(A.CelestialAlignment.ID) ~= 0 then
    --     return A.ConvoketheSpirits:Show(icon)
    -- end
end

local shouldTab = true
local timeSinceLastTab = 0
local delayTabTime = 1.5
local shieldDelay = 0
-- [3] Single Rotation
A[3] = function(icon)
    --local EnemyRotation, FriendlyRotation
    local isMoving             = Player:IsMoving()                    -- @boolean 
    local inCombat = Unit("player"):CombatTime()          -- @number 
    local inAoE                = GetToggle(2, "AoE")                -- @boolean 
    local inDisarm            = LoC:Get("DISARM") > 0                -- @boolean 
    local inMelee             = false                                -- @boolean 
    local stealthed = false
    	--------------------
	---  ENEMIES   ---
	--------------------
    -- Rotations 
    function EnemyRotation(unitID)
        -- local purge = Purge(unitID)
        -- if purge then
        --     return A.Purge:Show(icon)
        -- end
        if Unit("player"):CombatTime() > 0 then
            if Unit("target"):CombatTime() > 0 and UnitAffectingCombat("target") and (UnitDetailedThreatSituation("player", unitID) ~= nil) and UnitCanAttack("player", "target") then
                if A.ShadowWordPain:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.ShadowWordPain.ID) <= 2 then
                    return A.ShadowWordPain:Show(icon)
                end
                local activeEnemies = MultiUnits:GetByRangeInCombat(40)
                if MultiUnits:GetByRangeAppliedDoTs(40, activeEnemies, A.ShadowWordPain.ID) < activeEnemies then
                    if timeSinceLastTab == 0 then
                        timeSinceLastTab = TMW.time + delayTabTime
                        return A:Show(icon, ACTION_CONST_AUTOTARGET)
                    end
                    if TMW.time > timeSinceLastTab then
                        timeSinceLastTab = TMW.time + delayTabTime
                        return A:Show(icon, ACTION_CONST_AUTOTARGET)
                    end
                end
                -- if A.MindBlast:IsReady(unitID, true) then
                --     return A.MindBlast:Show(icon)
                -- end
                if A.Smite:IsReady(unitID, true) then
                    return A.Smite:Show(icon)
                end
            end
        end
    end

    function FriendlyRotation(unitID)    
        -- local typhoon = Interrupts(unitID)
        -- if typhoon and A.Typhoon:IsReady(unitID, true) then
        --     return A.Typhoon:Show(icon)
        -- end
        -- local purify = Cleanse()
        -- if purify and A.PurifySpirit:IsReady(unitID, true) then
        --     return A.PurifySpirit:Show(icon)
        -- end
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
            if Unit("player"):HealthPercent() <= 50 and A.DesperatePrayer:IsReady(unitID, true) then
                HealingEngine.SetTarget("player")
                return A.DesperatePrayer:Show(icon)
            end
            if Unit("player"):HealthPercent() <= 70 and A.FlashHeal:IsReady(unitID, true) then
                HealingEngine.SetTarget("player")
                return A.FlashHeal:Show(icon)
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
        end

        -- local whenToDealDmgValue = GetToggle(2, "whenToDealDamage")
        local whenToDealDmgValue = 75
        -- [[ Single Target ]]
        local function HealingRotation()
            local covSpell = GetCovenantAbility(unitID, icon)
            if covSpell then
                return covSpell
            end

            for i = 1, #getmembersAll do 

                -- if A.PowerWordFortitude:IsReady(unitID, true) and Unit(getmembersAll[i].Unit):HasBuffs(A.PowerWordFortitude.ID) == 0 then
                --     return A.PowerWordFortitude:Show(icon)
                -- end

                if HealingEngine.GetBelowHealthPercentUnits(whenToDealDmgValue) == 0 and shouldTab and Unit("player"):CombatTime() > 0 and not IsUnitEnemy("target") and TMW.time > timeSinceLastTab then
                    timeSinceLastTab = TMW.time + 2
                    shouldTab = false
                    return A:Show(icon, ACTION_CONST_AUTOTARGET)    
                end

                if HealingEngine.GetBelowHealthPercentUnits(whenToDealDmgValue) == 0 and not shouldTab then   
                    shouldTab = true
                end 

                if HealingEngine.GetBelowHealthPercentUnits(whenToDealDmgValue) ~= 0 then   
                    shouldTab = false
                end

                if Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):IsTank() then
                    if A.PowerWordShield:IsReady(unitID, true) and Unit(getmembersAll[i].Unit):HasBuffs(A.PowerWordShield.ID) == 0 and TMW.time > shieldDelay then
                        shieldDelay = TMW.time + 7.5
                        HealingEngine.SetTarget(getmembersAll[i].Unit)
                        return A.PowerWordShield:Show(icon)
                    end
                end

                if Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):HealthPercent() <= 90 then
                    if A.Renew:IsReady(unitID, true) and Unit(getmembersAll[i].Unit):HasBuffs(A.Renew.ID) <= 3 then
                        HealingEngine.SetTarget(getmembersAll[i].Unit)
                        return A.Renew:Show(icon)
                    end
                end

                if Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):HealthPercent() <= 35 then
                    if A.HolyWordSerenity:IsReady(unitID, true) then
                        HealingEngine.SetTarget(getmembersAll[i].Unit)
                        return A.HolyWordSerenity:Show(icon)
                    end
                end

                if Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):HealthPercent() <= 70 then
                    if A.FlashHeal:IsReady(unitID, true) then
                        HealingEngine.SetTarget(getmembersAll[i].Unit)
                        return A.FlashHeal:Show(icon)
                    end
                end
            end
        end

        if SelfHealing() then
            return true
        end
        
        if HealingRotation() then
            return true
        end
        
        -- GiftofNaaru
        if A.GiftofNaaru:AutoRacial(player) and Unit(player):TimeToDie() < 10 then 
            return A.GiftofNaaru:Show(icon)
        end            
    end

    -- healing
    if FriendlyRotation("target") then 
        return true 
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

