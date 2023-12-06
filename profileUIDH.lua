local _G, select, setmetatable                        = _G, select, setmetatable

local TMW                                             = _G.TMW 

local A                                             = _G.Action

local CONST                                            = A.Const
local toNum                                         = A.toNum
local Print                                            = A.Print
local GetSpellInfo                                    = A.GetSpellInfo
local GetToggle                                        = A.GetToggle
local GetLatency                                    = A.GetLatency
local InterruptIsValid                                = A.InterruptIsValid
local Unit                                            = A.Unit 

local ACTION_CONST_DEMONHUNTER_HAVOC             = CONST.DEMONHUNTER_HAVOC

local S                                                = {
    Disarm                                            = (GetSpellInfo(236077)),
    StormBolt                                        = (GetSpellInfo(107570)),
    RallyingCry                                        = (GetSpellInfo(97462)),
    EnragedRegeneration                                = (GetSpellInfo(184364)),
    Stoneform                                        = (GetSpellInfo(20594)),
    BerserkerRage                                    = (GetSpellInfo(18499)),
    IgnorePain                                        = (GetSpellInfo(190456)),
    VictoryRush                                        = (GetSpellInfo(34428)),
}

local L                                             = {}
L.AUTO                                                = {
    enUS = "Auto",
    ruRU = "Авто ",
}
L.OFF                                                = {
    enUS = "Off",
    ruRU = "Выкл.",
}
L.PVP                                                 = {
    ANY = "PvP",
}
L.MOUSEOVER                                            = {
    enUS = "Use\n@mouseover", 
    ruRU = "Использовать\n@mouseover", 
}
L.MOUSEOVERTT                                        = {
    enUS = "Will unlock use actions for @mouseover units\nExample: Resuscitate, Healing\n\nRight click: Create macro", 
    ruRU = "Разблокирует использование действий для @mouseover юнитов\nНапример: Воскрешение, Хилинг\n\nПравая кнопка мышки: Создать макрос", 
}
L.AOE                                                = {
    enUS = "Use\nAoE", 
    ruRU = "Использовать\nAoE", 
}
L.AOETT                                                = {
    enUS = "Enable multiunits rotation\n\nRight click: Create macro", 
    ruRU = "Включает ротацию для нескольких целей\n\nПравая кнопка мышки: Создать макрос", 
}
L.DEFENSIVE                                            = {
    enUS = "Self Defensive",
    ruRU = "Своя Оборона",
}
L.ROTATION                                            = {
    enUS = "Rotation",
    ruRU = "Ротация",
}
L.CATCHINVISIBLE                                    = {
    enUS = "Catch Invisible (arena)",
    ruRU = "Поймать Невидимок (арена)",
}
L.CATCHINVISIBLETT                                    = {
    enUS = "Cast when combat around has been begin and enemy team still has unit in invisible\nDoesn't work if you're mounted or in combat!\n\nRight click: Create macro",
    ruRU = "Применять когда бой поблизости начат и команда противника до сих пор имеет юнита в невидимости\nНе работает, когда вы на транспорте или в бою!\n\nПравая кнопка мышки: Создать макрос",
}
L.STORMBOLTPVP                                        = {
    ANY = "PvP " .. S.StormBolt,
}
L.STORMBOLTPVPTT                                    = {
    enUS = "@arena1-3 interrupt PvP list from 'Interrupts' tab by " .. S.StormBolt .. "\nMore custom config you can find in group by open /tmw\n\nRight click: Create macro", 
    ruRU = "@arena1-3 прерывание Параличом PvP списка из вкладки 'Прерывания'\nБольше кастомизации вы найдете в группе открыв /tmw\n\nПравая кнопка мышки: Создать макрос", 
}
L.STORMBOLTPVP_ONLYHEAL                                = {
    enUS = "Only Heal Casts",
    ruRU = "Только Исцел. Заклинания",
}
L.STORMBOLTPVP_ONLYPVP                                = {
    enUS = "Only PvP Casts",
    ruRU = "Только PvP Заклинания",
}
L.STORMBOLTPVP_BOTH                                    = {
    enUS = "Heal + PvP Casts",
    ruRU = "Исцел. + PvP Заклинания",
}
L.DISARMPVP                                            = {
    enUS = "PvP " .. S.Disarm .. "\nTriggers",
    ruRU = "PvP " .. S.Disarm .. "\nТриггеры",
}
L.DISARMPVPTT                                        = {
    enUS = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Only if melee player has damage buffs\nON COOLDOWN - means will use always on melee players\nOFF - Cut out from rotation but still allow work through Queue and MSG systems\nIf you want fully turn it OFF then you should make SetBlocker in 'Actions' tab\n\nRight click: Create macro", 
    ruRU = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Только если игрок ближнего боя имеет бафы на урон\nON COOLDOWN - значит будет использовано по игрокам ближнего боя по восстановлению способности\nOFF - Выключает из ротации, но при этом позволяет Очередь и MSG системам работать\nЕсли нужно полностью выключить, тогда установите блокировку во вкладке 'Действия'\n\nПравая кнопка мышки: Создать макрос", 
}
L.DISARMPVP_MELEEBURST                                = {
    enUS = "On melee burst",
    ruRU = "На бурст ближ. боя",
}
L.DISARMPVP_ONCD                                    = {
    enUS = "On cooldown",
    ruRU = "По восстановлению",
}
L.DISARMPVPUNITS                                    = {
    enUS = "PvP " .. S.Disarm .. "\nDestinations",
    ruRU = "PvP " .. S.Disarm .. "\nЦели",
}
L.DISARMPVPUNITSTT                                    = {
    enUS = "@primary - is @target, @mouseover, @focustarget, @targettarget (these units are depend on toggles above)\n\nRight click: Create macro", 
    ruRU = "@primary - это @target, @mouseover, @focustarget, @targettarget (эти юниты зависят от чекбоксов наверху)\n\nПравая кнопка мышки: Создать макрос", 
}
L.USEBERSERKERRAGE_LOC                                = {
    enUS = S.BerserkerRage .. "\nLoss of Control", 
    ruRU = S.BerserkerRage .. "\nПотеря контроля", 
}
L.LOC_TT                                            = {
    enUS = "It will be used in the desired rotation order to remove the available effects of loss of control over the character", 
    ruRU = "Будет использовано в нужном порядке ротации для снятия доступных эффектов потери контроля над персонажем", 
}
L.IGNOREPAIN                                        = {
    enUS = S.IgnorePain .. "\nHealth Percent (Self)",
    ruRU = S.IgnorePain .. "\nЗдоровье Процент (Свое)",
}
L.VICTORYRUSH                                        = {
    enUS = S.VictoryRush .. "\nHealth Percent (Self)",
    ruRU = S.VictoryRush .. "\nЗдоровье Процент (Свое)",
}
L.ENRAGEDREGENERATION                                = {
    enUS = S.EnragedRegeneration .. "\nHealth Percent (Self)",
    ruRU = S.EnragedRegeneration .. "\nЗдоровье Процент (Свое)",
}
L.RALLYINGCRY                                        = {
    enUS = S.RallyingCry .. "\nHealth Percent (Self)",
    ruRU = S.RallyingCry .. "\nЗдоровье Процент (Свое)",
}
L.TRINKETDEFENSIVE                                    = {
    enUS = "Protection Trinkets\nHealth Percent (Self)",
    ruRU = "Аксессуары Защиты\nЗдоровье Процент (Свое)",
}
L.STONEFORM                                            = {
    enUS = S.Stoneform .. "\nHealth Percent",
    ruRU = S.Stoneform .. "\nПроцент Здоровья",
}

local SliderMarginOptions = { margin = { top = 10 } }
local LayoutConfigOptions = { gutter = 4, padding = { left = 5, right = 5 } }
A.Data.ProfileEnabled[A.CurrentProfile]             = true
A.Data.ProfileUI                                     = {    
    DateTime = "v1.00 (14.10.2020)",
    [2] = {
        [ACTION_CONST_DEMONHUNTER_HAVOC] = {             
            LayoutOptions = LayoutConfigOptions,
            {
                {
                    E                 = "Checkbox", 
                    DB                 = "mouseover",
                    DBV             = true,
                    L                 = L.MOUSEOVER, 
                    TT                 = L.MOUSEOVERTT, 
                    M                 = {},
                },
                {
                    E                 = "Checkbox", 
                    DB                 = "AoE",
                    DBV             = true,
                    L                 = L.AOE,
                    TT                 = L.AOETT,
                    M                 = {},
                },
            },
        }
    }
}
-----------------------------------------
--                   PvP  
-----------------------------------------
local DisarmPvPunits     = setmetatable({}, { __index = function(t, v)
            t[v] = GetToggle(2, "DisarmPvPunits")
            return t[v]
end})
local ImunBuffsCC              = {"CCTotalImun", "DamagePhysImun", "TotalImun"}
local ImunBuffsInterrupt     = {"KickImun", "TotalImun", "DamagePhysImun"}

function A.DisarmIsReady(unitID, skipShouldStop, isMsg)
    if A.IsInPvP then 
        local isArena = unitID:match("arena")
        if     (
            (unitID == "arena1" and DisarmPvPunits[A.PlayerSpec][1]) or 
            (unitID == "arena2" and DisarmPvPunits[A.PlayerSpec][2]) or
            (unitID == "arena3" and DisarmPvPunits[A.PlayerSpec][3]) or
            (not isArena and DisarmPvPunits[A.PlayerSpec][4]) 
        ) 
        then 
            if (not isArena and Unit(unitID):IsEnemy() and Unit(unitID):IsPlayer()) or (isArena and not Unit(unitID):InLOS() and (A.Zone == "arena" or A.Zone == "pvp")) then 
                local Disarm = A[A.PlayerSpec].Disarm
                if  Disarm and 
                (
                    (
                        not isMsg and GetToggle(2, "DisarmPvP") ~= "OFF" and ((not isArena and Disarm:IsReady(unitID, nil, nil, skipShouldStop)) or (isArena and Disarm:IsReadyByPassCastGCD(unitID))) and                                 
                        Unit(unitID):IsMelee() and (GetToggle(2, "DisarmPvP") == "ON COOLDOWN" or Unit(unitID):HasBuffs("DamageBuffs") > 8)
                    ) or 
                    (
                        isMsg and Disarm:IsReadyM(unitID)
                    )
                ) and 
                Disarm:AbsentImun(unitID, ImunBuffsCC, true) and 
                Unit(unitID):IsControlAble("disarm") and 
                Unit(unitID):InCC() == 0 and 
                Unit(unitID):HasDeBuffs("Disarmed") == 0
                then 
                    return true 
                end 
            end 
        end 
    end 
end

function A:CanInterruptPassive(unitID, countGCD)
    if A.IsInPvP and (A.Zone == "arena" or A.Zone == "pvp") then         
        if self.isPummel then 
            local useKick, _, _, notInterruptable = InterruptIsValid(unitID, "Heal", nil, countGCD)
            if not useKick then 
                useKick, _, _, notInterruptable = InterruptIsValid(unitID, "PvP", nil, countGCD)
            end 
            if useKick and not notInterruptable and self:IsReadyByPassCastGCD(unitID) and self:AbsentImun(unitID, ImunBuffsInterrupt, true) then 
                return true 
            end 
        end 
        
        if self.isStormBolt then 
            local StormBoltPvP = GetToggle(2, "StormBoltPvP")
            if StormBoltPvP and StormBoltPvP ~= "OFF" and self:IsReadyByPassCastGCD(unitID) then 
                local _, useCC, castRemainsTime 
                if Toggle == "BOTH" then 
                    useCC, _, _, castRemainsTime = select(2, InterruptIsValid(unitID, "Heal", nil, countGCD))
                    if not useCC then 
                        useCC, _, _, castRemainsTime = select(2, InterruptIsValid(unitID, "PvP", nil, countGCD))
                    end 
                else 
                    useCC, _, _, castRemainsTime = select(2, InterruptIsValid(unitID, Toggle, nil, countGCD))
                end 
                if useCC and castRemainsTime >= GetLatency() and Unit(unitID):IsControlAble("stun") and not Unit(unitID):InLOS() and self:AbsentImun(unitID, ImunBuffsCC, true) then 
                    return true 
                end 
            end 
        end                     
    end 
end

