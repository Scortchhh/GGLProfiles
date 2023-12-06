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

local ACTION_CONST_MONK_BREWMASTER                    = CONST.MONK_BREWMASTER
local ACTION_CONST_MONK_MISTWEAVER                    = CONST.MONK_MISTWEAVER
local ACTION_CONST_MONK_WINDWALKER                    = CONST.MONK_WINDWALKER

local S                                                = {
    PurifyingBrew                                    = (GetSpellInfo(119582)),
    ZenMeditation                                    = (GetSpellInfo(115176)),
    CelestialBrew                                    = (GetSpellInfo(322507)),
    HealingElixir                                    = (GetSpellInfo(122281)),
    Stoneform                                        = (GetSpellInfo(20594)),
    DampenHarm                                        = (GetSpellInfo(122278)),
    FortifyingBrew                                    = (GetSpellInfo(115203)),
    DiffuseMagic                                    = (GetSpellInfo(122783)),
    RenewingMist                                    = (GetSpellInfo(115151)),
    SoothingMist                                    = (GetSpellInfo(115175)),
    LifeCocoon                                        = (GetSpellInfo(116849)),
    SpinningCraneKick                                = (GetSpellInfo(101546)),
    TigerPalm                                        = (GetSpellInfo(100780)),
    RisingSunKick                                    = (GetSpellInfo(107428)),
    RenewingMist                                    = (GetSpellInfo(115151)),
    EnvelopingMist                                    = (GetSpellInfo(124682)),
    SurgingMist                                        = (GetSpellInfo(227344)),
    Vivify                                            = (GetSpellInfo(116670)),
    EssenceFont                                        = (GetSpellInfo(191837)),
    Revival                                            = (GetSpellInfo(115310)),
    ThunderFocusTea                                    = (GetSpellInfo(116680)),
    ZenFocusTea                                        = (GetSpellInfo(209584)),
    RefreshingJadeWind                                = (GetSpellInfo(196725)),
    HealingSphere                                    = (GetSpellInfo(205234)),
    Paralysis                                        = (GetSpellInfo(115078)),
    GrappleWeapon                                    = (GetSpellInfo(233759)),
    ReverseHarm                                        = (GetSpellInfo(287771)),
    TouchofKarma                                    = (GetSpellInfo(122470)),
    TouchofDeath                                    = (GetSpellInfo(115080)),
    StormEarthAndFire                                = (GetSpellInfo(137639)),
    SolarBeam                                        = (GetSpellInfo(78675)),
    FlyingSerpentKick                                = (GetSpellInfo(101545)),
    LegSweep                                        = (GetSpellInfo(119381)),
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
L.SHOULDPURIFY                                        = {
    ANY = S.PurifyingBrew,
}
L.PURIFYINGBREW                                        = {
    enUS = S.PurifyingBrew .. " Level",
    ruRU = S.PurifyingBrew .. " Уровень",
}
L.PURIFYINGBREWTT                                    = {
    enUS = "Stagger level on which need\n'" .. S.PurifyingBrew .. "' (5 super high, 1 very low)\n\nRight click: Create macro", 
    ruRU = "Уровень пошатывания на котором\nнужно '" .. S.PurifyingBrew .. "' (5 супер много, 1 очень мало)\n\nПравая кнопка мышки: Создать макрос", 
}
L.SHOULDPURIFY_LEVEL2                                = {
    enUS = "Level 2",
    ruRU = "Уровень 2",
}
L.SHOULDPURIFY_LEVEL3                                = {
    enUS = "Level 3",
    ruRU = "Уровень 3",
}
L.SHOULDPURIFY_LEVEL4                                = {
    enUS = "Level 4",
    ruRU = "Уровень 4",
}
L.SHOULDPURIFY_LEVEL5                                = {
    enUS = "Level 5",
    ruRU = "Уровень 5",
}
L.ZENMEDITATION                                        = {
    enUS = S.ZenMeditation .. "\nHealth Percent",
    ruRU = S.ZenMeditation .. "\nПроцент Здоровья",
}
L.CelestialBrew                                                = {
    enUS = S.CelestialBrew .. "\nHealth Percent",
    ruRU = S.CelestialBrew .. "\nПроцент Здоровья",
}
L.ADDITIONALTAUNT                                    = {
    enUS = "Additional Taunt",
    ruRU = "Дополнительный Таунт",
}
L.ADDITIONALTAUNT_INVOKENIUZAOTHEBLACKOX            = {
    enUS = "Invoke Niuzao the BlackOx",
    ruRU = "Призыв Нюцзао, Черного Быка",
}
L.ADDITIONALTAUNT_SUMMONBLACKOXSTATUE                = {
    enUS = "Summon BlackOx Statue",
    ruRU = "Призыв статуи Черного Быка",
}
L.ADDITIONALTAUNT_PROVOKEONBLACKOXSTATUE            = {
    enUS = "'Provoke' On BlackOx Statue",
    ruRU = "'Вызов' на статую Черного Быка",
}
L.MOUSEOVER                                            = {
    enUS = "Use\n@mouseover", 
    ruRU = "Использовать\n@mouseover", 
}
L.MOUSEOVERTT                                        = {
    enUS = "Will unlock use actions for @mouseover units\nExample: Resuscitate, Healing\n\nRight click: Create macro", 
    ruRU = "Разблокирует использование действий для @mouseover юнитов\nНапример: Воскрешение, Хилинг\n\nПравая кнопка мышки: Создать макрос", 
}
L.FOCUSTARGET                                        = {
    enUS = "Use\n@focustarget", 
    ruRU = "Использовать\n@focustarget",  
}
L.FOCUSTARGETTT                                        = {
    enUS = "Will unlock use actions\nfor enemy @focustarget units\n\nRight click: Create macro", 
    ruRU = "Разблокирует использование\nдействий для вражеских @focustarget юнитов\n\nПравая кнопка мышки: Создать макрос", 
}
L.TARGETTARGET                                        = {
    enUS = "Use\n@targettarget", 
    ruRU = "Использовать\n@targettarget",  
}
L.TARGETTARGETTT                                    = {
    enUS = "Will unlock use actions\nfor enemy @targettarget units\n\nRight click: Create macro", 
    ruRU = "Разблокирует использование\nдействий для вражеских @targettarget юнитов\n\nПравая кнопка мышки: Создать макрос",  
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
L.DPS                                            = {
    ANY = "DPS Options",
}
L.HEALINGELIXIR                                        = {
    enUS = S.HealingElixir .. "\nHealth Percent",
    ruRU = S.HealingElixir .. "\nПроцент Здоровья",
}
L.STONEFORM                                            = {
    enUS = S.Stoneform .. "\nHealth Percent",
    ruRU = S.Stoneform .. "\nПроцент Здоровья",
}
L.DAMPENHARM                                        = {
    enUS = S.DampenHarm .. "\nHealth Percent",
    ruRU = S.DampenHarm .. "\nПроцент Здоровья",
}
L.FORTIFYINGBREW                                    = {
    enUS = S.FortifyingBrew .. "\nHealth Percent",
    ruRU = S.FortifyingBrew .. "\nПроцент Здоровья",
}
L.DIFFUSEMAGIC                                        = {
    enUS = S.DiffuseMagic .. "\nHealth Percent",
    ruRU = S.DiffuseMagic .. "\nПроцент Здоровья",
}
L.MANA_POTION                                        = {
    enUS = "Mana Potion\nMana Percent",
    ruRU = "Мана Зелье\nПроцент Маны",
}
L.HEALINGSYSTEM                                        = {
    enUS = "Healing System",
    ruRU = "Система Исцеления",
}
L.HEALINGENGINEAUTOHOT                                = {
    enUS = "Auto HoTs",
    ruRU = "Авто ХоТы",
}
L.HEALINGENGINEAUTOHOTTT                            = {
    enUS = "Will select in @target a member\nwhich hasn't applied '" .. S.RenewingMist .. "'\n\nRight click: Create macro",
    ruRU = "Будет выбирать в @target участника\nкоторый не имеет наложенного '" .. S.RenewingMist .. "'\n\nПравая кнопка мышки: Создать макрос",
}
L.HEALINGENGINEPREVENTSUGGEST                        = {
    enUS = S.SoothingMist .. "\nNext @target - Difference HP",
    ruRU = S.SoothingMist .. "\nСлед. @target - Разница ХП",
}
L.HEALINGENGINEPREVENTSUGGESTTT                        = {
    enUS = "If " .. S.SoothingMist .. "' is channeling,\nthen before choosing a new @target condition will be checked,\nthat difference in health percent between current unit and next unit >= value of slider\nIf condition is true, then next @target will be selected, otherwise we will continue healing current unit\n\nCondition will skip if next unit require dispel or utils\n\nRight click: Create macro",
    ruRU = "Если '" .. S.SoothingMist .. "' произносится,\nто прежде чем выбрать новый @target будет проверяться условие,\nчто разница в процентах здоровья между текущим юнитом и след. юнитом >= значению ползунка\nЕсли условие соблюдено, то след. @target будет выбран, в ином случае мы продолжаем исцеление текущего юнита\n\nУсловие будет пропускаться если след. юнит требует диспела или утилит\n\nПравая кнопка мышки: Создать макрос",
}
L.ROTATION                                            = {
    enUS = "Rotation",
    ruRU = "Ротация",
}
L.EMERGENCYSINGLEROTATION                            = {
    enUS = "Emergency Single Rotation",
    ruRU = "Экстренная Одиноч. Ротация",
}
L.EMERGENCYSINGLEROTATIONTT                            = {
    enUS = "Changes priority of rotation if unit is in an emergency\nEmergency rotation has own logic, nor depended by settings below!\n\nRight click: Create macro",
    ruRU = "Меняет приоритет ротации если юнит находится в критическом положении\nЭкстренная ротация имеет свою логику, не зависящая от настроек ниже!\n\nПравая кнопка мышки: Создать макрос",
}
L.MAINTAINSTATUECAST                                = {
    enUS = "Jade Serpent Statue\nMaintain Cast",
    ruRU = "Статуя Нефритовой Змеи\nПоддерживать Произнесение",
}
L.MAINTAINSTATUECASTTT                                = {
    enUS = "PvP: Prioritization by most inc. damage\nPvE: Prioritization by active tank\n\nRight click: Create macro",
    ruRU = "PvP: Приоритезация по наиболее вход. урону\nPvE: Приоритезация по активному танку\n\nПравая кнопка мышки: Создать макрос",
}
L.LIFECOCOON                                        = {
    enUS = S.LifeCocoon .. " - Health Percent",
    ruRU = S.LifeCocoon .. " - Процент Здоровья",
}
L.THUNDERFOCUSTEAOPTIONS                            = {
    enUS = S.ThunderFocusTea .. "\nOptions",
    ruRU = S.ThunderFocusTea .. "\nОпции",
}
L.THUNDERFOCUSTEAOPTIONS_VIVIFY_MANA_SAVE            = {
    enUS = S.Vivify .. " (On Mana Save)",
    ruRU = S.Vivify .. " (На Сохр. Маны)",
}
L.THUNDERFOCUSTEAOPTIONS_VIVIFY_ON_CD                = {
    enUS = S.Vivify .. " (On CD)",
    ruRU = S.Vivify .. " (По КД)",
}
L.ZENFOCUSTEAOPTIONS                                = {
    enUS = S.ZenFocusTea .. "\nOptions",
    ruRU = S.ZenFocusTea .. "\nОпции",
}
L.ZENFOCUSTEAOPTIONS_ROOTED                            = {
    enUS = "While rooted to catch " .. S.SolarBeam,
    ruRU = "Пока в рутах, чтобы поймать " .. S.SolarBeam,
}
L.SOOTHINGMIST_STOPCAST_OPTIONS_PRIMARY                = {
    enUS = "/stopcasting - @primary unit changed",
    ruRU = "/stopcasting - @главный юнит сменился",
}
L.SOOTHINGMIST_STOPCAST_OPTIONS_MAXHP                = {
    enUS = "/stopcasting - @primary unit at full health",
    ruRU = "/stopcasting - @главный юнит на полном здоровье",
}
L.SOOTHINGMIST_STOPCAST_OPTIONS                        = {
    enUS = S.SoothingMist .. "\nOptions",
    ruRU = S.SoothingMist .. "\nОпции",
}
L.SOOTHINGMIST_STOPCAST_OPTIONSTT                    = {
    enUS = "/stopcasting options works if 'Stop Cast' is enabled in 'General' tab\n\nRight click: Create macro",
    ruRU = "/stopcasting опции работают если 'Стоп Каст' включен в вкладке 'Общее'\n\nПравая кнопка мышки: Создать макрос",
}
L.SOOTHINGMIST_WORKOPTIONS_ANY                        = {
    enUS = "Any Units",
    ruRU = "Любые Юниты",
}
L.SOOTHINGMIST_WORKOPTIONS_TANKING                    = {
    enUS = "Tanking Units",
    ruRU = "Танкующие Юниты",
}
L.SOOTHINGMIST_WORKOPTIONS_FOCUSED                    = {
    enUS = "Focused Units (PvP)",
    ruRU = "Нацеленные Юниты (PvP)",
}
L.SOOTHINGMIST_WORKOPTIONS_MOSTINC                    = {
    enUS = "Mostly Inc. Damage Units",
    ruRU = "Наибол. Вход. Урон Юниты",
}
L.SOOTHINGMIST_WORKOPTIONS_HPSINCDMG                = {
    enUS = "HPS Deficit Units",
    ruRU = "ХПС Дефицит Юниты",
}
L.SOOTHINGMIST_WORKOPTIONS                            = {
    enUS = S.SoothingMist .. " (filler)\nWork Mode",
    ruRU = S.SoothingMist .. " (филлер)\nРежим Работы",
}
L.SOOTHINGMISTHP                                    = {
    enUS = S.SoothingMist .. " (filler)\nHealth Percent",
    ruRU = S.SoothingMist .. " (филлер)\nПроцент Здоровья",
}
L.SOOTHINGMISTHPTT                                    = {
    enUS = "Health Percent on which casting '" .. S.SoothingMist .. "' (as filler!)\n\nRight click: Create macro", 
    ruRU = "Процент Здоровья на котором произносить '" .. S.SoothingMist .. "' (как филлер!)\n\nПравая кнопка мышки: Создать макрос", 
}
L.LIMITTT                                            = {
    enUS = "The limit means that the ability only works when <= values\nThis is only a limit so as not to go above the value, not a fixed condition!\n\nRight click: Create macro",
    ruRU = "Лимит означает, что способность работает только когда <= значения\nЭто только лимит, чтобы не идти выше значения, а не фиксированное условие!\n\nПравая кнопка мышки: Создать макрос",
}
L.VIVIFYHP                                            = {
    enUS = S.Vivify .. " (limit)\nHealth Percent",
    ruRU = S.Vivify .. " (лимит)\nПроцент Здоровья",
}
L.SURGINGMISTHP                                        = {
    enUS = S.SurgingMist .. " (limit)\nHealth Percent",
    ruRU = S.SurgingMist .. " (лимит)\nПроцент Здоровья",
}
L.ENVELOPINGMISTHP                                    = {
    enUS = S.EnvelopingMist .. " (limit)\nHealth Percent",
    ruRU = S.EnvelopingMist .. " (лимит)\nПроцент Здоровья",
}
L.REVIVALDISPELUNITS                                = {
    enUS = S.Revival .. "\nMass Dispel Units",
    ruRU = S.Revival .. "\nМасс Диспел Юнитов",
}
L.REVIVALDISPELUNITSTT                                = {
    enUS = "Count of units which must be dispeled at same time\nCan not be higher than maximum of select able members\n\nRight click: Create macro",
    ruRU = "Кол-во юнитов, которые должны быть задиспелены сразу\nНе может быть выше чем максимум доступных по выбору участников\n\nПравая кнопка мышки: Создать макрос",
}
L.EACHUNITTT                                        = {
    enUS = "Health in percent per each unit <= value\n\nRight click: Create macro",
    ruRU = "Здоровье в процентах по каждому юниту <= значение\n\nПравая кнопка мышки: Создать макрос",
}
L.TOTALUNITSTT                                        = {
    enUS = "Total number of units\n\nRight click: Create macro",
    ruRU = "Суммарное количество юнитов\n\nПравая кнопка мышки: Создать макрос",
}
L.REVIVALHP                                            = {
    enUS = S.Revival .. "\nEach Unit HP",
    ruRU = S.Revival .. "\nКаждый Юнит ХП",
}
L.REVIVALUNITS                                        = {
    enUS = S.Revival .. "\nTotal Units",
    ruRU = S.Revival .. "\nКол-во Юнитов",
}
L.ESSENCEFONTHP                                        = {
    enUS = S.EssenceFont .. "\nEach Unit HP",
    ruRU = S.EssenceFont .. "\nКаждый Юнит ХП",
}
L.ESSENCEFONTUNITS                                    = {
    enUS = S.EssenceFont .. "\nTotal Units",
    ruRU = S.EssenceFont .. "\nКол-во Юнитов",
}
L.REFRESHINGJADEWINDHP                                = {
    enUS = S.RefreshingJadeWind .. "\nEach Unit HP",
    ruRU = S.RefreshingJadeWind .. "\nКаждый Юнит ХП",
}
L.REFRESHINGJADEWINDUNITS                            = {
    enUS = S.RefreshingJadeWind .. "\nTotal Units",
    ruRU = S.RefreshingJadeWind .. "\nКол-во Юнитов",
}
L.BURSTTT                                            = {
    enUS = "The percentage of enemy health on which to use actions\n\nRight click: Create macro", 
    ruRU = "Процент здоровья противника на котором использовать действия\n\nПравая кнопка мышки: Создать макрос", 
}
L.BURSTHEALINGRACIAL                                = {
    enUS = "Racial Burst Heal\nHealth Percent",                        
    ruRU = "Расовая Бурст Исцел.\nПроцент Здоровья",    
}
L.BURSTDAMAGE                                        = {
    enUS = "Burst Damage\nHealth Percent",                        
    ruRU = "Бурст Урон\nПроцент Здоровья",    
}
L.BURSTHEALINGTRINKETS                                = {
    enUS = "Heal Trinkets\nHealth Percent",                        
    ruRU = "Исцел. Акссесуары\nПроцент Здоровья",    
}
L.BURSTDAMAGETRINKETS                                = {
    enUS = "Damage Trinkets\nHealth Percent",                        
    ruRU = "Урон Акссесуары\nПроцент Здоровья",    
}
L.MOUSEBUTTONSCHECK                                    = {
    enUS = S.HealingSphere .. "\nCheck Mouse Buttons", 
    ruRU = S.HealingSphere .. "\nПроверять Кнопки Мышки", 
}
L.MOUSEBUTTONSCHECKTT                                = {
    enUS = "Prevents use if the camera is currently spinning with the mouse button held down\n\nRight click: Create macro", 
    ruRU = "Предотвращает использование если камера в текущий момент крутится с помощью зажатой кнопки мыши\n\nПравая кнопка мышки: Создать макрос", 
}
L.PARALYSISPVP                                        = {
    ANY = "PvP " .. S.Paralysis,
}
L.PARALYSISPVPTT                                    = {
    enUS = "@arena1-3 interrupt PvP list from 'Interrupts' tab by Paralysis\nMore custom config you can find in group by open /tmw\n\nRight click: Create macro", 
    ruRU = "@arena1-3 прерывание Параличом PvP списка из вкладки 'Прерывания'\nБольше кастомизации вы найдете в группе открыв /tmw\n\nПравая кнопка мышки: Создать макрос", 
}
L.PARALYSISPVP_ONLYHEAL                                = {
    enUS = "Only Heal Casts",
    ruRU = "Только Исцел. Заклинания",
}
L.PARALYSISPVP_ONLYPVP                                = {
    enUS = "Only PvP Casts",
    ruRU = "Только PvP Заклинания",
}
L.PARALYSISPVP_BOTH                                    = {
    enUS = "Heal + PvP Casts",
    ruRU = "Исцел. + PvP Заклинания",
}
L.GRAPPLEWEAPONPVP                                    = {
    enUS = "PvP " .. S.GrappleWeapon .. "\nTriggers",
    ruRU = "PvP " .. S.GrappleWeapon .. "\nТриггеры",
}
L.GRAPPLEWEAPONPVPTT                                = {
    enUS = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Only if melee player has damage buffs\nON COOLDOWN - means will use always on melee players\nOFF - Cut out from rotation but still allow work through Queue and MSG systems\nIf you want fully turn it OFF then you should make SetBlocker in 'Actions' tab\n\nRight click: Create macro", 
    ruRU = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Только если игрок ближнего боя имеет бафы на урон\nON COOLDOWN - значит будет использовано по игрокам ближнего боя по восстановлению способности\nOFF - Выключает из ротации, но при этом позволяет Очередь и MSG системам работать\nЕсли нужно полностью выключить, тогда установите блокировку во вкладке 'Действия'\n\nПравая кнопка мышки: Создать макрос", 
}
L.GRAPPLEWEAPONPVP_MELEEBURST                        = {
    enUS = "On melee burst",
    ruRU = "На бурст ближ. боя",
}
L.GRAPPLEWEAPONPVP_ONCD                                = {
    enUS = "On cooldown",
    ruRU = "По восстановлению",
}
L.GRAPPLEWEAPONPVPUNITS                                = {
    enUS = "PvP " .. S.GrappleWeapon .. "\nDestinations",
    ruRU = "PvP " .. S.GrappleWeapon .. "\nЦели",
}
L.GRAPPLEWEAPONPVPUNITSTT                            = {
    enUS = "@primary - is @target, @mouseover, @focustarget, @targettarget (these units are depend on toggles above)\n\nRight click: Create macro", 
    ruRU = "@primary - это @target, @mouseover, @focustarget, @targettarget (эти юниты зависят от чекбоксов наверху)\n\nПравая кнопка мышки: Создать макрос", 
}
L.CATCHINVISIBLE                                    = {
    enUS = "Catch Invisible (arena)",
    ruRU = "Поймать Невидимок (арена)",
}
L.CATCHINVISIBLETT                                    = {
    enUS = "Cast " .. S.SpinningCraneKick .. " when combat around has been begin and enemy team still has unit in invisible\nDoesn't work if you're mounted or in combat!\n\nRight click: Create macro",
    ruRU = "Применять " .. S.SpinningCraneKick .. " когда бой поблизости начат и команда противника до сих пор имеет юнита в невидимости\nНе работает, когда вы на транспорте или в бою!\n\nПравая кнопка мышки: Создать макрос",
}
L.PARTY                                             = {
    enUS = "Party",
    ruRU = "Группа",
}
L.PARTYUNITS                                        = {
    enUS = "Party Units",
    ruRU = "Юниты Группы",
}
L.PARTYUNITSTT                                        = {
    enUS = "Enable/Disable relative party passive rotation\n\nRight click: Create macro", 
    ruRU = "Включить/Выключить относительно группы пассивную ротацию\n\nПравая кнопка мышки: Создать макрос", 
}
L.TOUCHOFKARMA                                        = {
    enUS = S.TouchofKarma .. "\nHealth Percent (Self)",
    ruRU = S.TouchofKarma .. "\nЗдоровье Процент (Свое)",
}
L.TRINKETDEFENSIVE                                    = {
    enUS = "Protection Trinkets\nHealth Percent (Self)",
    ruRU = "Аксессуары Защиты\nЗдоровье Процент (Свое)",
}
L.REVERSEHARM                                        = {
    enUS = S.ReverseHarm .. "\nHealth Percent (Self)",
    ruRU = S.ReverseHarm .. "\nЗдоровье Процент (Свое)",
}
L.SEFOUTBURST                                        = {
    enUS = "PvE SEF \nOut of Burst",
    ruRU = "PvE " .. S.StormEarthAndFire .. "\nВне Бурста",
}
L.SEFOUTBURSTTT                                        = {
    enUS = "PvE: Enable this setting to allow you\nto use SEF outside 'Burst Mode' conditions\nat 2+ charges or between '" .. S.TouchofDeath .. "'\n\nRight click: Create macro",
    ruRU = "PvE: Включенная настройка позволит вам\nиспользовать " .. S.StormEarthAndFire .. " вне условий 'Режима Бурстов'\nна 2+ зарядах или между '" .. S.TouchofDeath .. "'\n\nПравая кнопка мышки: Создать макрос",
}
L.TOGGLEFLYING                                            = {
    ANY = " " .. S.FlyingSerpentKick .. "\ for DPS",
}
L.TOGGLEFLYINGTT                                        = {
    ANY = "PvE: Enable this setting to allow you\nto use " .. S.FlyingSerpentKick .. " for DPS\n\nRight click: Create macro",
}
L.InterruptList                                            = {
    ANY = "Check to use Scortch/Spiken Interrupt list, uncheck to use your own custom list",
}
L.InterruptListTT                                        = {
    ANY = "Select which interrupt list to use",
}
L.RyanInterruptList                                        ={
    ANY = "Ryan's M+"
}
L.Scortch_SpikenInterruptList                                    ={
    ANY = "Scortch/Spiken's M+/Raid"
}
L.CustomInterruptList                                    ={
    ANY = "Custom"
}
L.ParalysisInterrupt                                           = {
    ANY = "Use " .. S.Paralysis .. " to Interrupt",
}
L.ParalysisInterruptTT                                        = {
    ANY = "Use " .. S.Paralysis .. "  CC to interrupt",
}
L.LegSweepInterrupt                                           = {
    ANY = "Use " .. S.LegSweep .. "  to Interrupt",
}
L.LegSweepInterruptTT                                        = {
    ANY = "Use " .. S.LegSweep .. "  CC to interrupt",
}
L.ExplosiveMouseover                                           = {
    ANY = "Auto Target/Kill Explosives",
}
L.ExplosiveMouseoverTT                                        = {
    ANY = "Auto Target/Kill Explosives using /target mouseover",
}
L.FillerPriority                                          = {
    ANY = "AoE Filler Spell Priority",
}
L.FillerPriorityTT                                        = {
    ANY = "".. S.TigerPalm .. " for Surviability or " .. S.SpinningCraneKick .." for  DPS",
}
L.PriorityTigerPalm                                        = {
    ANY = "" .. S.TigerPalm .. "",
}
L.PrioritySCK                                       = {
    ANY = "" .. S.SpinningCraneKick .. "",
}
L.NiuzaoHoldBrew                                        = {
    ANY = "Niuzao Hold Brews",
}
L.NiuzaoHoldBrewTT                                       = {
    ANY = "Hold Brews when Niuzao is up for more DPS",
}
L.AdvancedFeatures                                      = {
    ANY = "AdvancedFeatures",
}

local SliderMarginOptions = { margin = { top = 10 } }
local LayoutConfigOptions = { gutter = 4, padding = { left = 5, right = 5 } }
A.Data.ProfileEnabled[A.CurrentProfile]             = true
A.Data.ProfileUI                                     = {    
    DateTime = "v2 (06.02.2021)",
    [2] = { 
        [ACTION_CONST_MONK_BREWMASTER] = {             
            LayoutOptions = LayoutConfigOptions,
            { -- [1]                            
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
                {
                    E                 = "Checkbox", 
                    DB                 = "SwapExplosives",
                    DBV             = true,
                    L = { 
                        enUS = "Autoswap to explosives m+ affix", 
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will make it so you auto swap to explosive, require mouseover enable",
                    }, 
                    M                 = {},
                },    
            },
            { -- [1] Row 2
                {
                    E                 = "Checkbox", 
                    DB                 = "ParalysisInterrupt",
                    DBV             = true,
                    L                 = L.ParalysisInterrupt, 
                    TT                 = L.ParalysisInterruptTT, 
                    M                 = {},
                },
                {
                    E                 = "Checkbox", 
                    DB                 = "LegSweepInterrupt",
                    DBV             = true,
                    L                 = L.LegSweepInterrupt, 
                    TT                 = L.LegSweepInterruptTT, 
                    M                 = {},
                },
            },                                    
            { -- [2]
                {
                    E                 = "Dropdown",                                                         
                    OT                 = {
                        { text = L.SHOULDPURIFY_LEVEL2, value = 2 },
                        { text = L.SHOULDPURIFY_LEVEL3, value = 3 },
                        { text = L.SHOULDPURIFY_LEVEL4, value = 4 },
                        { text = L.SHOULDPURIFY_LEVEL5, value = 5 },
                        { text = L.AUTO,                 value = 0 },
                    },
                    DB                 = "ShouldPurify",
                    DBV             = 0, 
                    L                 = L.PURIFYINGBREW, 
                    TT                 = L.PURIFYINGBREWTT,
                    M                 = {},                                    
                },        
                {
                    E                 = "Slider",                                                     
                    MIN             = -1, 
                    MAX             = 100,                            
                    DB                 = "ZenMeditation",
                    DBV             = 100,
                    ONOFF             = true,                
                    L                 = L.ZENMEDITATION,
                    M                 = {},
                },
            },
            { -- [3]    
                {
                    E                 = "Slider",                                                     
                    MIN             = -1, 
                    MAX                 = 85,                            
                    DB                 = "HealingElixir",
                    DBV             = 85,
                    ONOFF             = true,
                    L                 = L.HEALINGELIXIR, 
                    M                 = {},
                },
                {
                    E                 = "Slider",                                                     
                    MIN             = -1, 
                    MAX             = 100,                            
                    DB                 = "CelestialBrew",
                    DBV             = 100,
                    ONOFF             = true,
                    L                 = L.CelestialBrew,                    
                    M                 = {},
                },
            }, 
            { -- [4]     
                {
                    E                 = "Slider",                                                     
                    MIN             = -1, 
                    MAX             = 100,                            
                    DB                 = "DampenHarm",
                    DBV             = 100,
                    ONOFF             = true,
                    L                 = L.DAMPENHARM,
                    M                 = {},
                },
                {
                    E                 = "Slider",                                                     
                    MIN                = -1, 
                    MAX                = 100,                            
                    DB                 = "FortifyingBrew",
                    DBV                = 100,
                    ONOFF             = true,
                    L                 = L.FORTIFYINGBREW,
                    M                 = {},
                },
            },
            { -- [6]    
                {
                    E                 = "Slider",                                                     
                    MIN             = -1, 
                    MAX                 = 100,                            
                    DB                 = "Stoneform",
                    DBV             = 100,
                    ONOFF             = true,
                    L                 = L.STONEFORM,
                    M                 = {},
                },
                { -- HEALING Pot 
                    E = "Slider",
                    MIN = -1, 
                    MAX = 99,
                    DB = "SpiritualHealingPotionHP",
                    DBV = 20, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Spiritual Healing Potion HP (%)",
                    }, 
                    M = {},
                },
            },
            { -- [5] Advanced Features
                {
                    E = "Header",
                    L = L.AdvancedFeatures,
                },
            },    
            { -- [6]    
                {
                    E                 = "Checkbox", 
                    DB                 = "NiuzaoHoldBrew",
                    DBV             = false,
                    L                 = L.NiuzaoHoldBrew, 
                    TT                 = L.NiuzaoHoldBrewTT, 
                    M                 = {},
                },
                {
                    E                 = "Dropdown",                                                         
                    OT                 = {
                        { text = L.PriorityTigerPalm, value = 1 },
                        { text = L.PrioritySCK, value = 2 },
                    },
                    DB                 = "FillerPriority",
                    DBV             = 1, 
                    L                 = L.FillerPriority, 
                    TT                 = L.FillerPriorityTT,
                    M                 = {},                                    
                },    
            },
			{
                { -- POTION SELECTION
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Hardened Shadows", value = "HardenedShadowsPot" },
                        { text = "Stamina", value = "SpectralStaminaPot" },                        
                        { text = "Agility", value = "SpectralAgilityPot" },
						{ text = "Phantom Fire", value = "PhantomFirePot" },
                        { text = "Empowered Exorcisms", value = "EmpoweredExorcismsPot" },
                        { text = "Deathly Fixation", value = "DeathlyFixationPot" },                        
                    },
                    MULT = false,
                    DB = "AutoPotionSelect",
                    DBV = "HardenedShadowsPot", 
                    L = { 
                        ANY = "Potion Slection",
                    }, 
                    TT = { 
                        ANY = "Select the prepot to use"
                    }, 
                    M = {},
                },
			},
            { -- [7] PvP 
                {
                    E = "Header",
                    L = L.PVP,
                },
            },
            { -- [8] 
                {
                    M                 = {},   
                    E                = "Checkbox",                                                                               
                    DB                 = "UseParalysisInPvP",
                    DBV             = true,
                    L = { 
                        enUS = "Use Paralysis in PvP", 
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will use Paralysis in PvP, will try and focus healers when healing if in range",
                    },
                },
                {
                    M                 = {},   
                    E                = "Checkbox",                                                                               
                    DB                 = "LegSweepInPvP",
                    DBV             = true,
                    L = { 
                        enUS = "Use LegSweep in PvP", 
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will use LegSweep in PvP, will try and focus healers when healing if in range",
                    },
                },
                {
                    E                 = "Dropdown",                                                         
                    OT                 = {
                        { text = L.PARALYSISPVP_ONLYHEAL,     value = "Heal"     },
                        { text = L.PARALYSISPVP_ONLYPVP,     value = "PvP"     },
                        { text = L.PARALYSISPVP_BOTH,         value = "BOTH"     },
                        { text = L.OFF,                     value = "OFF"     },
                    },
                    DB                 = "ParalysisPvP",
                    DBV             = "BOTH",
                    L                 = L.PARALYSISPVP, 
                    TT                 = L.PARALYSISPVPTT,
                    M                 = {},
                },
            },
        },
        [ACTION_CONST_MONK_WINDWALKER] = {
            { -- General -- Header
                {
                    E = "Header",
                    L = {ANY = " -- Nothing here -- ",},
                },
            },		
        },	
        [ACTION_CONST_MONK_BREWMASTER] = { 
            ["stun"]         = { Enabled = true,     Key = "LegSweep",             LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_MONK_BREWMASTER]
                return     Unit("player"):HasBuffs(A.ZenMeditation.ID, true) == 0 and 
                        A.LegSweep:IsReadyM(thisunit, true) and 
                        (
                            ( 
                                not Unit(thisunit):IsEnemy() and 
                                (
                                    (
                                        not IsInPvP and 
                                        MultiUnits:GetByRange(5, 1) >= 1    
                                    ) or 
                                    (
                                        IsInPvP and 
                                        EnemyTeam():PlayersInRange(1, 5)
                                    ) 
                                )
                            ) or 
                            ( 
                                Unit(thisunit):IsEnemy() and 
                                Unit(thisunit):GetRange() <= 5 and 
                                Unit(thisunit):IsControlAble("stun", 0) and
                                Unit(thisunit):HasDeBuffs("Stuned") <= GetCurrentGCD() and 
                                A.LegSweep:AbsentImun(thisunit, {"StunImun", "TotalImun", "DamagePhysImun", "CCTotalImun"}, true) 
                            )                
                        ) 
            ]] },
            ["kick"]         = { Enabled = true,     Key = "SpearHandStrike",     LUAVER = 6, LUA = [[
                local A = Action[ACTION_CONST_MONK_BREWMASTER]
                return     Unit("player"):HasBuffs(A.ZenMeditation.ID, true) == 0 and
                        A.SpearHandStrike:IsReadyM(thisunit) and 
                        A.SpearHandStrike:AbsentImun(thisunit, {"KickImun", "TotalImun", "DamagePhysImun"}, true) and 
                        Unit(thisunit):IsCastingRemains() > 0  
            ]] },
            ["freedom"]     = { Enabled = true,     Key = "TigersLust",         LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_MONK_BREWMASTER]
                return     Unit("player"):HasBuffs(A.ZenMeditation.ID, true) == 0 and 
                        A.TigersLust:IsReadyM(thisunit) and 
                        A.TigersLust:AbsentImun(thisunit) and 
                        LossOfControl:IsMissed("SILENCE") and 
                        LossOfControl:Get("SCHOOL_INTERRUPT", "NATURE") == 0    
            ]] },
            ["dispel"]         = { Enabled = true,     Key = "Detox",                 LUAVER = 5, LUA = [[
                local A = Action[ACTION_CONST_MONK_BREWMASTER]
                return     Unit("player"):HasBuffs(A.ZenMeditation.ID, true) == 0 and 
                        A.Detox:IsReadyM(thisunit) and 
                        A.Detox:AbsentImun(thisunit) and 
                        AuraIsValid(thisunit, "UseDispel", "Dispel") and                                                 
                        LossOfControl:IsMissed("SILENCE") and 
                        LossOfControl:Get("SCHOOL_INTERRUPT", "NATURE") == 0            
            ]] },
        },
    },
}

-----------------------------------------
--                   PvP  
-----------------------------------------
function A.Main_CastBars(unit, list)
    if not A.IsInitialized or A.IamHealer or (A.Zone ~= "arena" and A.Zone ~= "pvp") then 
        return false 
    end 
    
    if A[A.PlayerSpec] and A[A.PlayerSpec].SpearHandStrike and A[A.PlayerSpec].SpearHandStrike:IsReadyP(unit, nil, true) and A[A.PlayerSpec].SpearHandStrike:AbsentImun(unit, {"KickImun", "TotalImun", "DamagePhysImun"}, true) and A.InterruptIsValid(unit, list) then 
        return true         
    end 
end 

function A.Second_CastBars(unit)
    if not A.IsInitialized or (A.Zone ~= "arena" and A.Zone ~= "pvp") then 
        return false 
    end 
    
    local Toggle = A.GetToggle(2, "ParalysisPvP")    
    if Toggle and Toggle ~= "OFF" and A[A.PlayerSpec] and A[A.PlayerSpec].Paralysis and A[A.PlayerSpec].Paralysis:IsReadyP(unit, nil, true) and A[A.PlayerSpec].Paralysis:AbsentImun(unit, {"CCTotalImun", "TotalImun", "DamagePhysImun"}, true) and Unit(unit):IsControlAble("incapacitate", 0) then 
        if Toggle == "BOTH" then 
            return select(2, A.InterruptIsValid(unit, "Heal", true)) or select(2, A.InterruptIsValid(unit, "PvP", true)) 
        else
            return select(2, A.InterruptIsValid(unit, Toggle, true))         
        end 
    end 
end 

local unitIDtargets = setmetatable({}, { -- string cache for faster performance
        __index = function(t, v)
            t[v] = v .. "target"
            return t[v]
        end,
})

local GrappleWeaponPvPunits     = setmetatable({}, { __index = function(t, v)
            t[v] = GetToggle(2, "GrappleWeaponPvPunits")
            return t[v]
end})
local ImunBuffsCC              = {"CCTotalImun", "DamagePhysImun", "TotalImun"}
local ImunBuffsInterrupt     = {"KickImun", "TotalImun", "DamagePhysImun"}

function A.GrappleWeaponIsReady(unit, skipShouldStop, isMsg)
    if A.IsInPvP then 
        local isArena = unit:match("arena")
        if     (
            (unit == "arena1" and GrappleWeaponPvPunits[A.PlayerSpec][1]) or 
            (unit == "arena2" and GrappleWeaponPvPunits[A.PlayerSpec][2]) or
            (unit == "arena3" and GrappleWeaponPvPunits[A.PlayerSpec][3]) or
            (not isArena and GrappleWeaponPvPunits[A.PlayerSpec][4]) 
        ) 
        then 
            if (not isArena and Unit(unit):IsEnemy() and Unit(unit):IsPlayer()) or (isArena and not Unit(unit):InLOS() and (A.Zone == "arena" or A.Zone == "pvp")) then 
                local GrappleWeapon = A[A.PlayerSpec].GrappleWeapon
                if  GrappleWeapon and 
                (
                    (
                        not isMsg and GetToggle(2, "GrappleWeaponPvP") ~= "OFF" and ((not isArena and GrappleWeapon:IsReady(unit, nil, nil, skipShouldStop)) or (isArena and GrappleWeapon:IsReadyByPassCastGCD(unit))) and                                 
                        Unit(unit):IsMelee() and (GetToggle(2, "GrappleWeaponPvP") == "ON COOLDOWN" or Unit(unit):HasBuffs("DamageBuffs") > 3)
                    ) or 
                    (
                        isMsg and GrappleWeapon:IsReadyM(unit)
                    )
                ) and 
                GrappleWeapon:AbsentImun(unit, ImunBuffsCC, true) and 
                Unit(unit):IsControlAble("disarm") and 
                Unit(unit):InCC() == 0 and 
                Unit(unit):HasDeBuffs("Disarmed") == 0
                then 
                    return true 
                end 
            end 
        end 
    end 
end 

function A:CanInterruptPassive(unit, countGCD)
    if A.IsInPvP and (A.Zone == "arena" or A.Zone == "pvp") then         
        if self.isSpearHandStrike then 
            -- MW hasn't SpearHandStrike action 
            local useKick, _, _, notInterruptable = InterruptIsValid(unit, "Heal", nil, countGCD)
            if not useKick then 
                useKick, _, _, notInterruptable = InterruptIsValid(unit, "PvP", nil, countGCD)
            end 
            if useKick and not notInterruptable and self:IsReadyByPassCastGCD(unit) and self:AbsentImun(unit, ImunBuffsInterrupt, true) then 
                return true 
            end 
        end 
        
        if self.isParalysis then 
            local ParalysisPvP = GetToggle(2, "ParalysisPvP")
            if ParalysisPvP and ParalysisPvP ~= "OFF" and self:IsReadyByPassCastGCD(unit) then 
                local _, useCC, castRemainsTime 
                if Toggle == "BOTH" then 
                    useCC, _, _, castRemainsTime = select(2, InterruptIsValid(unit, "Heal", nil, countGCD))
                    if not useCC then 
                        useCC, _, _, castRemainsTime = select(2, InterruptIsValid(unit, "PvP", nil, countGCD))
                    end 
                else 
                    useCC, _, _, castRemainsTime = select(2, InterruptIsValid(unit, Toggle, nil, countGCD))
                end 
                if useCC and castRemainsTime >= GetLatency() and Unit(unit):IsControlAble("incapacitate") and not Unit(unit):InLOS() and self:AbsentImun(unit, ImunBuffsCC, true) then 
                    return true 
                end 
            end 
        end                     
    end 
end 



