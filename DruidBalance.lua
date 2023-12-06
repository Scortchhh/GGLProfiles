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

local ACTION_CONST_DRUID_BALANCE             = CONST.DRUID_BALANCE
local ACTION_CONST_AUTOTARGET                = CONST.AUTOTARGET
local ACTION_CONST_SPELLID_FREEZING_TRAP    = CONST.SPELLID_FREEZING_TRAP
local ActiveUnitPlates                          = MultiUnits:GetActiveUnitPlates()
local IsIndoors, UnitIsUnit                    = _G.IsIndoors, _G.UnitIsUnit

FirstTarget = {"FirstTarget"}
SwappedTarget = {"SwappedTarget"}
Swapped = false
DotRotation = false
DotRotationCount = 0
isFirstUnit = true
currentActiveEclipse = nil
local previousEclipse

Action[ACTION_CONST_DRUID_BALANCE] = {
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
    Ironfur                                = Create({ Type = "Spell", ID = 192081                                               }),
    FrenziedRegeneration                                = Create({ Type = "Spell", ID = 22842                                               }),
    Barkskin                                = Create({ Type = "Spell", ID = 327993                                               }),
    SurvivalInstincts                                = Create({ Type = "Spell", ID = 61336                                               }),
    -- Healing
    Renewal                                = Create({ Type = "Spell", ID = 108238                                               }),
    Rejuvenation                                = Create({ Type = "Spell", ID = 774                                               }),
    Swiftmend                                = Create({ Type = "Spell", ID = 18562                                               }),
    -- CDS
    TigerFury                                = Create({ Type = "Spell", ID = 5217                                               }),
    Berserk                                = Create({ Type = "Spell", ID = 106951                                               }),
    CelestialAlignment                                = Create({ Type = "Spell", ID = 194223                                               }),
    --kick
    SkullBash                                = Create({ Type = "Spell", ID = 106839                                               }),
    SolarBeam                                = Create({ Type = "Spell", ID = 78675                                               }),
    Soothe                                = Create({ Type = "Spell", ID = 2908                                               }),
    --Passives
    MoonKinForm                                = Create({ Type = "Spell", ID = 24858                                               }),
    BearForm                                = Create({ Type = "Spell", ID = 5487                                               }),
    TravelForm                                = Create({ Type = "Spell", ID = 783                                               }), 
    Starfall                                = Create({ Type = "Spell", ID = 191034                                               }),
    FuryofElune                                = Create({ Type = "Spell", ID = 202770                                               }),
    EclipseLunar                                = Create({ Type = "Spell", ID = 48518                                               }),
    EclipseSolar                                = Create({ Type = "Spell", ID = 48517                                               }),
    SouloftheForest                                = Create({ Type = "Spell", ID = 158478                                               }),
    OwlkinFrenzy                                = Create({ Type = "Spell", ID = 157228                                               }),
    --stealth
    Prowl                                = Create({ Type = "Spell", ID = 102547                                               }),
    --taunt
    Growl                                = Create({ Type = "Spell", ID = 6795                                               }),
    -- Rotation       
    Wrath                                = Create({ Type = "Spell", ID = 190984                                               }),
    StarFire                                = Create({ Type = "Spell", ID = 194153                                               }),
    SunFire                                = Create({ Type = "Spell", ID = 164815                                               }),
    StarSurge                                = Create({ Type = "Spell", ID = 78674                                               }),
    Eclipse                                = Create({ Type = "Spell", ID = 79577                                               }),
    MoonFire                                = Create({ Type = "Spell", ID = 8921                                               }),
    StellarFire                                = Create({ Type = "Spell", ID = 202347                                               }),
    Typhoon                                = Create({ Type = "Spell", ID = 132469                                               }),
    --covenant
    ConvoketheSpirits                                = Create({ Type = "Spell", ID = 323764                                               }),
    --legendary
    BalanceofAllThings                                = Create({ Type = "Spell", ID = 339942                                               }),
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

Action:CreateEssencesFor(ACTION_CONST_DRUID_BALANCE)
local A = setmetatable(Action[ACTION_CONST_DRUID_BALANCE], { __index = Action })

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
    for key, val in pairs(Action[ACTION_CONST_DRUID_BALANCE]) do 
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
            if not notKickAble and A.SolarBeam:IsReady(unitID, nil, nil, true) and A.SolarBeam:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then
                return A.SolarBeam:Show(icon)                                                  
            end                   
        end 
    end                                                                                 
end

local function countInterruptGCD(unitID)
    if not A.SolarBeam:IsReadyByPassCastGCD(unitID) or not A.SolarBeam:AbsentImun(unitID, Temp.TotalAndPhysKick, true) then 
        return true 
    end 
end 

local function Interrupts(unitID)
    local useKick, useCC, useRacial, notInterruptable, castRemainsTime = InterruptIsValid(unitID,  nil, nil, countInterruptGCD(unitID))    
    
    -- Can waste interrupt action due delays caused by ping, interface input 
    if castRemainsTime < GetLatency() then 
        return 
    end 
    
    if useKick and not notInterruptable and A.SolarBeam:IsReady(unitID) then 
        return A.SolarBeam
    end     
    if useKick and not notInterruptable and A.Typhoon:IsReady(unitID, true) and Unit(unitID):GetRange() <= 20 then
        return A.Typhoon
    end    
end

local function Purge(unitID)
    local usePurge = AuraIsValid(unitID, "UsePurge", "PurgeHigh")    
    if usePurge and A.Soothe:IsReady(unitID) then 
        return A.Soothe
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
    if A.ConvoketheSpirits:IsReady(unitID, true) and covenant == "NightFae" and Unit("player"):HasBuffs(A.CelestialAlignment.ID) ~= 0 and Unit(unitID):CombatTime() > 0 then
        return A.ConvoketheSpirits:Show(icon)
    end
end

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
local arrySize = 1
local RememberTargetGuid = {}
local isInArray = false
DotRotationDot = Unit("target"):HasDeBuffs(A.MoonFire.ID, true)

    -- Rotations 
    function EnemyRotation(unitID)    
        if not IsUnitEnemy(unitID) then return end
        if Unit(unitID):IsDead() then return end
        if UnitCanAttack(player, unitID) == false then return end
        local solarbeam = Interrupts(unitID)
        if solarbeam and A.SolarBeam:IsReady(unitID, true) then
            return A.SolarBeam:Show(icon)
        end
        local typhoon = Interrupts(unitID)
        if typhoon and A.Typhoon:IsReady(unitID, true) then
            return A.Typhoon:Show(icon)
        end
        local soothe = Purge(unitID)
        if soothe then
            return A.Soothe:Show(icon)
        end
        local isBurst            = BurstIsON(unitID)
        
        -- inMelee                 = A.LavaLash:IsInRange(unitID)    
        
        -- Purge
        if A.ArcaneTorrent:AutoRacial(unitID) then 
            return A.ArcaneTorrent:Show(icon)
        end             

        if A.Swiftmend:IsReady(unitID, true) and Unit(player):HasBuffs(A.Rejuvenation.ID) ~= 0 and Unit("player"):HealthPercent() <= 50 then
            return A.Swiftmend:Show(icon)
        end

        if A.Rejuvenation:IsReady(unitID, true) and Unit("player"):HealthPercent() < 100 and A.Swiftmend:GetCooldown() >= 12 and Unit(player):HasBuffs(A.Rejuvenation.ID) == 0 then
            return A.Rejuvenation:Show(icon)
        end

        if A.MoonKinForm:IsReady(unitID, true) and Unit(player):HasBuffs(A.MoonKinForm.ID) == 0 and Unit(player):HasBuffs(A.BearForm.ID) == 0 and not IsMounted() then
            return A.MoonKinForm:Show(icon)
        end

        if Unit(player):HasBuffs(A.MoonKinForm.ID) == 0 then return end
        
        -- [[ finishers ]]
        local function Finishers()

            

        end

        local function Mitigation()
            if A.Renewal:IsReady(unitID, true) and Unit(player):HealthPercent() <= 55 then
                return A.Renewal:Show(icon)
            end
            if A.Barkskin:IsReady(unitID, true) and Unit(player):HealthPercent() <= 40 then
                return A.Barkskin:Show(icon)
            end
        end
        
        -- [[ CDs ]]
        local function CDs()  
            local Item = UseItems(unitID)
            if Item and inCombat > 2 then
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
            if A.FuryofElune:IsReady(unitID, true) then
                return A.FuryofElune:Show(icon)
            end
            if A.CelestialAlignment:IsReady(unitID, true) then
                return A.CelestialAlignment:Show(icon)
            end
        end

        local function checkEclipse()
            local hasEclipse
            if Unit(player):HasBuffs(A.EclipseLunar.ID) ~= 0 and Unit(player):HasBuffs(A.EclipseSolar.ID) == 0 then
                currentActiveEclipse = "Lunar"
                return true
            end
            if Unit(player):HasBuffs(A.EclipseSolar.ID) ~= 0 and Unit(player):HasBuffs(A.EclipseLunar.ID) == 0 then
                currentActiveEclipse = "Solar"
                return true
            end
            if Unit(player):HasBuffs(A.EclipseLunar.ID) ~= 0 and Unit(player):HasBuffs(A.EclipseSolar.ID) ~= 0 then
                previousEclipse = nil
                currentActiveEclipse = "Reset"
                return true
            end
            return false
        end

        -- [[ Single Target ]]
        local function ST()
                local covSpell = GetCovenantAbility(unitID, icon)
                if covSpell then
                    return covSpell
                end
                if (Unit("player"):CombatTime() > 15 and DotRotationDot < 5) or (MultiUnits:GetActiveEnemies() <= 1 and UnitIsDead("target")) then
                    FirstTarget = {"FirstTarget"}
                    SwappedTarget = {"SwappedTarget"}
                    Swapped = false
                    DotRotation = false
                    DotRotationCount = 0
                    isFirstUnit = true  
                end
        
                if (EnemiesCount() >= 3 or MultiUnits:GetActiveEnemies() >= 3 or Unit("target"):IsDummy()) and inAoE then
                if DotRotation == false then
                    if isFirstUnit == true then
                        if DotRotationDot > 1 and UnitAffectingCombat("target") then
                            isFirstUnit = false
                            DotRotationCount = DotRotationCount+1
                            Swapped = true
                                if FirstTarget[1] == "FirstTarget" then
                                    FirstTarget[1] = UnitGUID("target")
                                end
                            return A:Show(icon, ACTION_CONST_AUTOTARGET)
                        end       
        
                        if DotRotationDot == 0 and UnitAffectingCombat("target") and (UnitDetailedThreatSituation("player", "target") ~= nil) then
                               return A.MoonFire:Show(icon)
                        elseif DotRotationDot == 0 and UnitAffectingCombat("target") and not (UnitDetailedThreatSituation("player", "target") ~= nil) then
                            return A:Show(icon, ACTION_CONST_AUTOTARGET)
                        end
                    elseif isFirstUnit == false then
                        SwappedTarget[1] = UnitGUID("target")
                            if UnitGUID("target") == FirstTarget[1] or DotRotationCount >= 5 then
                             DotRotation = true
                            end 
                            if DotRotationDot > 1 and UnitAffectingCombat("target") then
                                DotRotationCount = DotRotationCount+1
                                SwappedTarget[1] = UnitGUID("target")
                                Swapped = true
                                return A:Show(icon, ACTION_CONST_AUTOTARGET)
                            end           
                            if DotRotationDot == 0 and UnitAffectingCombat("target") and (UnitDetailedThreatSituation("player", "target") ~= nil) then
                                return A.MoonFire:Show(icon)
                            elseif DotRotationDot == 0 and UnitAffectingCombat("target") and not (UnitDetailedThreatSituation("player", "target") ~= nil) then
                            return A:Show(icon, ACTION_CONST_AUTOTARGET)
                           end
                    end
                end -- End DotRotation
            end
            if DotRotation == true or MultiUnits:GetActiveEnemies() <= 1 or EnemiesCount() <= 1 then

                if A.StarSurge:IsReady(unitID, true) and Player:AstralPower() >= 95 then
                    return A.StarSurge:Show(icon)
                end

                if MultiUnits:GetByRange(30) >= 2 then
                    if A.SouloftheForest:IsTalentLearned() and inCombat > 1 then
                        if A.Starfall:IsReady(unitID, true) and MultiUnits:GetByRange(30) >= 2 and Unit(player):TimeToDie() >= 4 then
                            return A.Starfall:Show(icon)
                        end
                    else
                        if A.Starfall:IsReady(unitID, true) and MultiUnits:GetByRange(30) >= 3 and Unit(player):TimeToDie() >= 4 then
                            return A.Starfall:Show(icon)
                        end
                    end
                end
                if A.Rejuvenation:IsReady(unitID, true) and Unit(player):HealthPercent() <= 80 and Unit(player):HasBuffs(A.Rejuvenation.ID) == 0 then
                    return A.Rejuvenation:Show(icon)
                end
                if MultiUnits:GetByRangeInCombat(40) == 1 then
                    if A.StarSurge:IsReady(unitID, true) and Unit("player"):HasBuffs(A.EclipseLunar.ID) >= 10 or A.StarSurge:IsReady(unitID, true) and Unit("player"):HasBuffs(A.EclipseSolar.ID) >= 10 or A.StarSurge:IsReady(unitID, true) and Player:AstralPower() >= 95 and Unit("player"):HasBuffs(A.EclipseLunar.ID) ~= 0 or A.StarSurge:IsReady(unitID, true) and Player:AstralPower() >= 95 and Unit("player"):HasBuffs(A.EclipseSolar.ID) ~= 0 then
                        return A.StarSurge:Show(icon)
                    end
                end
                if MultiUnits:GetByRangeInCombat(40) >= 2 and MultiUnits:GetByRangeInCombat(40) <= 4 then
                    if A.StarSurge:IsReady(unitID, true) and Unit("player"):HasBuffs(A.EclipseLunar.ID) >= 10 or A.StarSurge:IsReady(unitID, true) and Unit("player"):HasBuffs(A.EclipseSolar.ID) >= 10 then
                        return A.StarSurge:Show(icon)
                    end
                end
                if inCombat > 5 then
                    if Unit("player"):HasBuffs(A.CelestialAlignment.ID) >= 5 and Unit("player"):HasBuffs(A.BalanceofAllThings.ID) == 0 or Unit("player"):HasBuffs(A.CelestialAlignment.ID) == 0 and Unit("player"):HasBuffs(A.BalanceofAllThings.ID) == 0 then
                        if A.MoonFire:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.MoonFire.ID) <= 4 then
                            return A.MoonFire:Show(icon)
                        end
                        if A.SunFire:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.SunFire.ID) <= 5 then
                            return A.SunFire:Show(icon)
                        end
                        if A.StellarFire:IsTalentLearned() then
                            if A.StellarFire:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.StellarFire.ID) <= 3 then
                                return A.StellarFire:Show(icon)
                            end
                        end
                    end
                    if Unit("player"):HasBuffs(A.OwlkinFrenzy.ID) ~= 0 and A.StarFire:IsReady(unitID, true) then
                        return A.StarFire:Show(icon)
                    end
                end
                local hasEclipse = checkEclipse()
                if not hasEclipse then
                    if currentActiveEclipse == "Reset" then
                        if currentActiveEclipse == "Reset" then
                            if MultiUnits:GetByRangeInCombat(40) >= 2 then
                                if A.StarFire:IsReady(unitID, true) then
                                    return A.StarFire:Show(icon)
                                end
                            else
                                if A.Wrath:IsReady(unitID, true) then
                                    return A.Wrath:Show(icon)
                                end
                            end
                        end
                    end
                    if currentActiveEclipse == nil then
                        if previousEclipse == nil then
                            -- then the rotation will start with single target rotation, casting 2 starfires to enter solar eclipse, while the other way around should be the correct
                            -- changed GetByRangeInCombat to GetByRange() will need to see if its better for opener
                            if MultiUnits:GetByRange(40) >= 2 then
                                if A.Wrath:IsReady(unitID, true) then
                                    return A.Wrath:Show(icon)
                                end
                            else
                                if A.StarFire:IsReady(unitID, true) then
                                    return A.StarFire:Show(icon)
                                end
                            end
                        else
                            if previousEclipse == "Lunar" then
                                if A.StarFire:IsReady(unitID, true) and Unit(player):HasBuffs(A.EclipseSolar.ID) == 0 then
                                    return A.StarFire:Show(icon)
                                end
                            end
                            if previousEclipse == "Solar" then
                                if A.Wrath:IsReady(unitID, true) and Unit(player):HasBuffs(A.EclipseLunar.ID) == 0 then
                                    return A.Wrath:Show(icon)
                                end
                            end
                        end
                    end
                    if currentActiveEclipse == "Lunar" then
                        if A.StarFire:IsReady(unitID, true) and Unit(player):HasBuffs(A.EclipseSolar.ID) == 0 then
                            return A.StarFire:Show(icon)
                        end
                    end
                    if currentActiveEclipse == "Solar" then
                        if A.Wrath:IsReady(unitID, true) and Unit(player):HasBuffs(A.EclipseLunar.ID) == 0 then
                            return A.Wrath:Show(icon)
                        end
                    end
                else
                    if currentActiveEclipse == "Reset" then
                        if MultiUnits:GetByRangeInCombat(40) >= 2 then
                            if A.StarFire:IsReady(unitID, true) then
                                return A.StarFire:Show(icon)
                            end
                        else
                            if A.Wrath:IsReady(unitID, true) then
                                return A.Wrath:Show(icon)
                            end
                        end
                    end
                    if currentActiveEclipse == "Lunar" then
                        if A.StarFire:IsReady(unitID, true) then
                            previousEclipse = "Lunar"
                            return A.StarFire:Show(icon)
                        end
                    elseif currentActiveEclipse == "Solar" then
                        if A.Wrath:IsReady(unitID, true) then
                            previousEclipse = "Solar"
                            return A.Wrath:Show(icon)
                        end
                    end
                end
            end  -- End enemies +2
        end
        
        if Unit("player"):CombatTime() <= 0 then
            for irangeCheckCount in pairs(ActiveUnitPlates) do     
                    FirstTarget = {"FirstTarget"}
                    SwappedTarget = {"SwappedTarget"}
                    Swapped = false
                    DotRotation = false
                    DotRotationCount = 0
                    isFirstUnit = true  
                    currentActiveEclipse = nil
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

    if A.Rejuvenation:IsReady(unitID, true) and Unit("player"):HealthPercent() ~= 100 and Unit("player"):HasBuffs(A.Rejuvenation.ID) == 0 and inCombat == 0 and not IsMounted() and Unit("player"):HasBuffs(A.TravelForm.ID) == 0 then
        return A.Rejuvenation:Show(icon)
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

