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
local UnitCooldown                                    = A.UnitCooldown
local Unit                                            = A.Unit 
local Player                                        = A.Player 
local Pet                                            = A.Pet
local LoC                                            = A.LossOfControl
local MultiUnits                                    = A.MultiUnits
local EnemyTeam                                        = A.EnemyTeam
local FriendlyTeam                                    = A.FriendlyTeam
local TeamCache                                        = A.TeamCache
local InstanceInfo                                    = A.InstanceInfo
local TR                                            = Action.TasteRotation
local select, setmetatable                            = select, setmetatable

local ACTION_CONST_DEATHKNIGHT_BLOOD             = CONST.DEATHKNIGHT_BLOOD
local ACTION_CONST_DEATHKNIGHT_FROST             = CONST.DEATHKNIGHT_FROST
local ACTION_CONST_DEATHKNIGHT_UNHOLY             = CONST.DEATHKNIGHT_UNHOLY

local S                                                = {
    StormBolt                                        = (GetSpellInfo(107570)),
    Disarm                                            = (GetSpellInfo(236077)),
    AntiMagicShell                                        = (GetSpellInfo(48707)),
    AntiMagicZone                                        = (GetSpellInfo(51052)),
    DeathStrike                                        = (GetSpellInfo(49998)),
    Lichborne                                        = (GetSpellInfo(50397)),
    DeathPact                                        = (GetSpellInfo(48743)),
    SacrificialPact                                        = (GetSpellInfo(327574)),
    VampiricBlood                                        = (GetSpellInfo(55233)),
    RuneTap                                        = (GetSpellInfo(194679)),
    IceboundFortitude                                        = (GetSpellInfo(48792)),
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
L.selfDefence                                            = {
    enUS = "Self Defence",
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
L.LOC_TT                                            = {
    enUS = "It will be used in the desired rotation order to remove the available effects of loss of control over the character", 
    ruRU = "Будет использовано в нужном порядке ротации для снятия доступных эффектов потери контроля над персонажем", 
}
L.AntiMagicShell = {
    enUS = S.AntiMagicShell .. "\nHealth Percent (Self)",
    ruRU = S.AntiMagicShell .. "\nЗдоровье Процент (Свое)",
}
L.AntiMagicZone = {
    enUS = S.AntiMagicZone .. "\nHealth Percent (Self)",
    ruRU = S.AntiMagicZone .. "\nЗдоровье Процент (Свое)",
}
L.DeathStrike = {
    enUS = S.DeathStrike .. "\nHealth Percent (Self)",
    ruRU = S.DeathStrike .. "\nЗдоровье Процент (Свое)",
}
L.Lichborne = {
    enUS = S.Lichborne .. "\nHealth Percent (Self)",
    ruRU = S.Lichborne .. "\nЗдоровье Процент (Свое)",
}
L.DeathPact = {
    enUS = S.DeathPact .. "\nHealth Percent (Self)",
    ruRU = S.DeathPact .. "\nЗдоровье Процент (Свое)",
}
L.SacrificialPact = {
    enUS = S.SacrificialPact .. "\nHealth Percent (Self)",
    ruRU = S.SacrificialPact .. "\nЗдоровье Процент (Свое)",
}
L.VampiricBlood = {
    enUS = S.VampiricBlood .. "\nHealth Percent (Self)",
    ruRU = S.VampiricBlood .. "\nЗдоровье Процент (Свое)",
}
L.IceboundFortitude = {
    enUS = S.IceboundFortitude .. "\nHealth Percent (Self)",
    ruRU = S.IceboundFortitude .. "\nЗдоровье Процент (Свое)",
}
L.RuneTap = {
    enUS = S.RuneTap .. "\nHealth Percent (Self)",
    ruRU = S.RuneTap .. "\nЗдоровье Процент (Свое)",
}
L.TRINKETDEFENSIVE                                    = {
    enUS = "Protection Trinkets\nHealth Percent (Self)",
    ruRU = "Аксессуары Защиты\nЗдоровье Процент (Свое)",
}

local SliderMarginOptions = { margin = { top = 10 } }
local LayoutConfigOptions = { gutter = 4, padding = { left = 5, right = 5 } }
A.Data.ProfileEnabled[A.CurrentProfile]             = true
A.Data.ProfileUI                                     = {    
    DateTime = "v1.00 (07.02.2021)",
    [2] = {
        [ACTION_CONST_DEATHKNIGHT_BLOOD] = { 
            LayoutOptions = { gutter = 4, padding = { left = 5, right = 5 } },            
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- General -- ",
                    },
                },
            },            
            { -- [1] 1st Row
                
                {
                    E = "Checkbox", 
                    DB = "mouseover",
                    DBV = true,
                    L = { 
                        enUS = "Use @mouseover", 
                        ruRU = "Использовать @mouseover", 
                        frFR = "Utiliser les fonctions @mouseover",
                    }, 
                    TT = { 
                        enUS = "Will unlock use actions for @mouseover units\nExample: Resuscitate, Healing", 
                        ruRU = "Разблокирует использование действий для @mouseover юнитов\nНапример: Воскрешение, Хилинг", 
                        frFR = "Activera les actions via @mouseover\n Exemple: Ressusciter, Soigner",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        enUS = "Use AoE", 
                        ruRU = "Использовать AoE", 
                        frFR = "Utiliser l'AoE",
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                        ruRU = "Включает действия для нескольких целей", 
                        frFR = "Activer les actions multi-unités",
                    }, 
                    M = {
                        Custom = "/run Action.AoEToggleMode()",
                        -- It does call func CraftMacro(L[CL], macro above, 1) -- 1 means perCharacter tab in MacroUI, if nil then will be used allCharacters tab in MacroUI
                        Value = value or nil, 
                        -- Very Very Optional, no idea why it will be need however.. 
                        TabN = '@number' or nil,                                
                        Print = '@string' or nil,
                    },
                }, 
                {
                    E = "Checkbox", 
                    DB = "SnSInterruptList",
                    DBV = true,
                    L = { 
                        enUS = "Use SL Mythic+ & Raid\nsmart interrupt list", 
                        ruRU = "использование BFA Mythic+ & Raid\nумный список прерываний", 
                        frFR = "Liste d'interrupts intelligente\nBFA Mythic+ & Raid",
                    }, 
                    TT = { 
                        enUS = "If Enabled : Will force a special interrupt list containing all the BFA Mythic+ and Raid stuff WHEN YOU ARE IN MYTHIC+ OR RAID ZONE.\nYou can edit this list in the Interrupts tab\nand customize it as you want",
                        ruRU = "Если включено : Запустит специальный список прерываний, содержащий все BFA Mythic+ и Raid stuff КОГДА ВЫ НАХОДИТЕСЬ В МИФИЧЕСКОЙ + ИЛИ ЗОНЕ RAID.\nВы можете редактировать этот список на вкладке Прерывания\nи настраивай как хочешь",
                        frFR = "Si activé : Force une liste d'interruption spéciale contenant tous les éléments BFA Mythic + et Raid QUAND VOUS ETES EN MYTHIC+ OU EN RAID.\nVous pouvez modifier cette liste dans l'onglet Interruptions\net la personnaliser comme vous le souhaitez", 
                    }, 
                    M = {},
                },                
            },  
            { -- [7] Spell Status Frame
                {
                    E = "Header",
                    L = {
                        ANY = " -- Spell Status Frame -- ",
                    },
                },
            },    
            {
                {
                    E         = "Button",
                    H         = 35,
                    OnClick = function(self, button, down)     
                        if button == "LeftButton" then 
                            TR.ToggleStatusFrame() 
                        else                
                            Action.CraftMacro("Status Frame", [[/run Action.TasteRotation.ToggleStatusFrame()]], 1, true, true)   
                        end 
                    end, 
                    L = { 
                        ANY = "Status Frame\nMacro Creator",
                    }, 
                    TT = { 
                        enUS = "Click this button to create the special status frame macro.\nStatus Frame is a new windows that allow user to track blocked spells during fight. So you don't have to check your chat anymore.", 
                        ruRU = "Нажмите эту кнопку, чтобы создать специальный макрос статуса.\nStatus Frame - это новые окна, которые позволяют пользователю отслеживать заблокированные заклинания во время боя. Так что вам больше не нужно проверять свой чат.",  
                        frFR = "Cliquez sur ce bouton pour créer la macro de cadre d'état spécial.\nLe cadre d'état est une nouvelle fenêtre qui permet à l'utilisateur de suivre les sorts bloqués pendant le combat. Vous n'avez donc plus besoin de vérifier votre chat.", 
                    },                           
                },
                {
                    E = "Checkbox", 
                    DB = "ChangelogOnStartup",
                    DBV = true,
                    L = { 
                        enUS = "Changelog On Startup", 
                        ruRU = "Журнал изменений при запуске", 
                        frFR = "Journal des modifications au démarrage",
                    }, 
                    TT = { 
                        enUS = "Will show latest changelog of the current rotation when you enter in game.\nDisable this option to block the popup when you enter the game.", 
                        ruRU = "При входе в игру будет отображаться последний список изменений текущего вращения.\nОтключить эту опцию, чтобы заблокировать всплывающее окно при входе в игру.", 
                        frFR = "Affiche le dernier journal des modifications de la rotation actuelle lorsque vous entrez dans le jeu.\nDésactivez cette option pour bloquer la fenêtre contextuelle lorsque vous entrez dans le jeu..", 
                    }, 
                    M = {},
                }, 
            },    
            { -- [2] 2nd Row 
                {
                    E = "Checkbox", 
                    DB = "ConsumptionSuggested",
                    DBV = true,
                    L = { 
                        enUS = "Suggested: Consumption", 
                        ruRU = "Suggested: Consumption", 
                        frFR = "Suggested: Consumption",
                    }, 
                    TT = { 
                        enUS = "Suggest (Left Top icon) Consumption if Consumption is not enabled.", 
                        ruRU = "Suggest (Left Top icon) Consumption if Consumption is not enabled.", 
                        frFR = "Suggest (Left Top icon) Consumption if Consumption is not enabled.", 
                    }, 
                    M = {},
                }, 
                {
                    E = "Checkbox", 
                    DB = "Consumption",
                    DBV = true,
                    L = { 
                        enUS = "Force Use: Consumption", 
                        ruRU = "Force Use: Consumption", 
                        frFR = "Force Use: Consumption",
                    }, 
                    TT = { 
                        enUS = "Enable use of Consumption if not enabled.", 
                        ruRU = "Enable use of Consumption if not enabled.", 
                        frFR = "Enable use of Consumption if not enabled.", 
                    }, 
                    M = {},
                }, 
                {
                    E = "Checkbox", 
                    DB = "PoolDuringBlooddrinker",
                    DBV = true,
                    L = { 
                        enUS = "Pool: Blooddrinker", 
                        ruRU = "Pool: Blooddrinker", 
                        frFR = "Pool: Blooddrinker",
                    }, 
                    TT = { 
                        enUS = "Display the 'Pool' icon whenever you're channeling Blooddrinker as long as you shouldn't interrupt it (supports Quaking).", 
                        ruRU = "Display the 'Pool' icon whenever you're channeling Blooddrinker as long as you shouldn't interrupt it (supports Quaking).", 
                        frFR = "Display the 'Pool' icon whenever you're channeling Blooddrinker as long as you shouldn't interrupt it (supports Quaking).",
                    }, 
                    M = {},
                },                
            },
            { -- [4] 4th Row
                
                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [2] 2nd Row 
                {
                    E = "Checkbox", 
                    DB = "ArcaneTorrent",
                    DBV = true,
                    L = { 
                        enUS = "Force Use: ArcaneTorrent", 
                        ruRU = "Force Use: ArcaneTorrent", 
                        frFR = "Force Use: ArcaneTorrent", 
                    }, 
                    TT = { 
                        enUS = "Enable use of ArcaneTorrent if not enabled.", 
                        ruRU = "Enable use of ArcaneTorrent if not enabled.", 
                        frFR = "Enable use of ArcaneTorrent if not enabled.", 
                    }, 
                    M = {},
                }, 
                {
                    E = "Checkbox", 
                    DB = "DancingRuneWeapon",
                    DBV = true,
                    L = { 
                        enUS = "Force Use: DancingRuneWeapon", 
                        ruRU = "Force Use: DancingRuneWeapon", 
                        frFR = "Force Use: DancingRuneWeapon",
                    }, 
                    TT = { 
                        enUS = "Enable use of DancingRuneWeapon if not enabled.", 
                        ruRU = "Enable use of DancingRuneWeapon if not enabled.", 
                        frFR = "Enable use of DancingRuneWeapon if not enabled.", 
                    }, 
                    M = {},
                },                 
            },
            -- Death grip
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. GetSpellInfo(49576) .. " -- ",
                    },
                },
            },
            {
                {
                    E = "Checkbox", 
                    DB = "UseDeathGrip",
                    DBV = true,
                    L = { 
                        enUS = "Auto " .. GetSpellInfo(49576), 
                        ruRU = "Авто " .. GetSpellInfo(49576), 
                        frFR = "Auto " .. GetSpellInfo(49576), 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. GetSpellInfo(49576) .. " if enemy try to move out.", 
                        ruRU = "Автоматически использовать " .. GetSpellInfo(49576) .. " если враг попытается выйти.", 
                        frFR = "Utiliser automatiquement " .. GetSpellInfo(49576) .. " si l'ennemi essaie de partir.",  
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "DeathGripInterrupt",
                    DBV = true,
                    L = { 
                        enUS = GetSpellInfo(49576) .. " interrupt", 
                        ruRU = GetSpellInfo(49576) .. " прерывание", 
                        frFR = GetSpellInfo(49576) .. " interrupt", 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. GetSpellInfo(49576) .. " as interrupt.", 
                        ruRU = "Автоматически использовать " .. GetSpellInfo(49576) .. " как прерывание.", 
                        frFR = "Utiliser automatiquement " .. GetSpellInfo(49576) .. " comme interrupt.", 
                    }, 
                    M = {},
                },
            },
            {
                {
                    E = "Checkbox", 
                    DB = "DeathGripLowHealth",
                    DBV = true,
                    L = { 
                        enUS = GetSpellInfo(49576) .. " low HP(%)", 
                        ruRU = GetSpellInfo(49576) .. " low HP(%)", 
                        frFR = GetSpellInfo(49576) .. " low HP(%)",
                    }, 
                    TT = { 
                        enUS = "Enable this to option to automatically cast " .. GetSpellInfo(49576) .. " when enemy if running out and under specified percent life value.", 
                        ruRU = "Enable this to option to automatically cast " .. GetSpellInfo(49576) .. " when enemy if running out and under specified percent life value.", 
                        frFR = "Enable this to option to automatically cast " .. GetSpellInfo(49576) .. " when enemy if running out and under specified percent life value.", 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "DeathGripHealthPercent",
                    DBV = 30, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = GetSpellInfo(49576) .. " HP(%)",
                    }, 
                    M = {},
                },                
            },
            {
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. GetSpellInfo(48792) .. " -- ",
                    },
                },
            },
            { -- [1] 1st Row  
                RowOptions = { margin = { top = 10 } },            
                {
                    E = "Checkbox", 
                    DB = "IceboundFortitudeIgnoreBigDeff",
                    DBV = true,
                    L = { 
                        enUS = GetSpellInfo(48792) .. "\nSkip if " .. GetSpellInfo(49028) .. " used",
                        ruRU = GetSpellInfo(48792) .. "\nSkip if " .. GetSpellInfo(49028) .. " used",  
                        frFR = GetSpellInfo(48792) .. "\nSkip if " .. GetSpellInfo(49028) .. " used", 
                    }, 
                    M = {},
                },     
                {
                    E       = "Slider",                                                     
                    MIN     = -1, 
                    MAX     = 20,                            
                    DB      = "IceboundFortitudeTTD",
                    DBV     = 6,
                    ONLYOFF    = true,
                    L = { 
                        enUS = GetSpellInfo(48792) .. "\n<= time to die (sec)", 
                        ruRU = GetSpellInfo(48792) .. "\n<= time to die (sec)",  
                        frFR = GetSpellInfo(48792) .. "\n<= time to die (sec)",  
                    }, 
                    TT = { 
                        enUS = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition", 
                        ruRU = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",  
                        frFR = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",  
                    },
                    M = {},
                },                
            },
            {    
                RowOptions = { margin = { top = 10 } },            
                {
                    E = "Checkbox", 
                    DB = "IceboundFortitudeCatchKillStrike",
                    DBV = true,
                    L = { 
                        enUS = GetSpellInfo(48792) .. "\nCatch death hit",
                        ruRU = GetSpellInfo(48792) .. "\nCatch death hit",  
                        frFR = GetSpellInfo(48792) .. "\nCatch death hit", 
                    }, 
                    TT = { 
                        enUS = "Try to manage to use ability before receiving a fatal strike\nThis option is not related to other triggers!", 
                        ruRU = "Try to manage to use ability before receiving a fatal strike\nThis option is not related to other triggers!",
                        frFR = "Try to manage to use ability before receiving a fatal strike\nThis option is not related to other triggers!",  
                    },
                    M = {},
                },
                {
                    E       = "Slider",                                                     
                    MIN     = -1, 
                    MAX     = 100,                            
                    DB      = "IceboundFortitudeHP",
                    DBV     = 20,
                    ONLYOFF = true,
                    L = { 
                        enUS = GetSpellInfo(48792) .. "\n<= health (%)", 
                        ruRU = GetSpellInfo(48792) .. "\n<= health (%)",  
                        frFR = GetSpellInfo(48792) .. "\n<= health (%)", 
                    }, 
                    TT = { 
                        enUS = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",
                        ruRU = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",  
                        frFR = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",  
                    },
                    M = {},
                }, 
            }, 
            -- Rune Tap
            {
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. GetSpellInfo(194679) .. " -- ",
                    },
                },
            },
            { -- [1] 1st Row  
                RowOptions = { margin = { top = 10 } },            
                {
                    E = "Checkbox", 
                    DB = "RuneTapIgnoreBigDeff",
                    DBV = true,
                    L = { 
                        enUS = GetSpellInfo(194679) .. "\nSkip if " .. GetSpellInfo(55233) .. " used",
                        ruRU = GetSpellInfo(194679) .. "\nSkip if " .. GetSpellInfo(55233) .. " used",  
                        frFR = GetSpellInfo(194679) .. "\nSkip if " .. GetSpellInfo(55233) .. " used", 
                    }, 
                    M = {},
                },     
                {
                    E         = "Slider",                                                     
                    MIN     = -1, 
                    MAX     = 20,                            
                    DB         = "RuneTapTTD",
                    DBV     = 3,
                    ONLYOFF    = true,
                    L = { 
                        enUS = GetSpellInfo(194679) .. "\n<= time to die (sec)", 
                        ruRU = GetSpellInfo(194679) .. "\n<= time to die (sec)",  
                        frFR = GetSpellInfo(194679) .. "\n<= time to die (sec)",  
                    }, 
                    TT = { 
                        enUS = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition", 
                        ruRU = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",  
                        frFR = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",  
                    },
                    M = {},
                },                
            },
            {    
                RowOptions = { margin = { top = 10 } },            
                {
                    E = "Checkbox", 
                    DB = "RuneTapCatchKillStrike",
                    DBV = true,
                    L = { 
                        enUS = GetSpellInfo(194679) .. "\nCatch death hit",
                        ruRU = GetSpellInfo(194679) .. "\nCatch death hit",  
                        frFR = GetSpellInfo(194679) .. "\nCatch death hit", 
                    }, 
                    TT = { 
                        enUS = "Try to manage to use ability before receiving a fatal strike\nThis option is not related to other triggers!", 
                        ruRU = "Try to manage to use ability before receiving a fatal strike\nThis option is not related to other triggers!",
                        frFR = "Try to manage to use ability before receiving a fatal strike\nThis option is not related to other triggers!",  
                    },
                    M = {},
                },
                {
                    E       = "Slider",                                                     
                    MIN     = -1, 
                    MAX     = 100,                            
                    DB      = "RuneTapHP",
                    DBV     = 50,
                    ONLYOFF    = true,
                    L = { 
                        enUS = GetSpellInfo(194679) .. "\n<= health (%)", 
                        ruRU = GetSpellInfo(194679) .. "\n<= health (%)",  
                        frFR = GetSpellInfo(194679) .. "\n<= health (%)", 
                    }, 
                    TT = { 
                        enUS = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",
                        ruRU = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",  
                        frFR = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",  
                    },
                    M = {},
                }, 
                {
                    E       = "Slider",                                                     
                    MIN     = 1, 
                    MAX     = 20,                            
                    DB      = "RuneTapUnits",
                    DBV     = 5,
                    ONLYOFF    = true,
                    L = { 
                        enUS = GetSpellInfo(194679) .. "\nmin units", 
                        ruRU = GetSpellInfo(194679) .. "\nmin units",   
                        frFR = GetSpellInfo(194679) .. "\nmin units",  
                    }, 
                    TT = { 
                        enUS = "Minimum number of enemies around to use " .. GetSpellInfo(194679) .. ".\nRotation will try to always use it if we got 2 charges.",
                        ruRU = "Minimum number of enemies around to use " .. GetSpellInfo(194679) .. ".\nRotation will try to always use it if we got 2 charges.",
                        frFR = "Minimum number of enemies around to use " .. GetSpellInfo(194679) .. ".\nRotation will try to always use it if we got 2 charges.", 
                    },
                    M = {},
                }, 
            }, 
            -- Vampiric Blood
            {
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. GetSpellInfo(55233) .. " -- ",
                    },
                },
            },
            { -- [1] 1st Row  
                RowOptions = { margin = { top = 10 } },            
                {
                    E = "Checkbox", 
                    DB = "VampiricBloodIgnoreBigDeff",
                    DBV = true,
                    L = { 
                        enUS = GetSpellInfo(55233) .. "\nSkip if " .. GetSpellInfo(49028) .. " used",
                        ruRU = GetSpellInfo(55233) .. "\nSkip if " .. GetSpellInfo(49028) .. " used",  
                        frFR = GetSpellInfo(55233) .. "\nSkip if " .. GetSpellInfo(49028) .. " used", 
                    }, 
                    M = {},
                },     
                {
                    E         = "Slider",                                                     
                    MIN     = -1, 
                    MAX     = 20,                            
                    DB         = "VampiricBloodTTD",
                    DBV     = 6,
                    ONLYOFF    = true,
                    L = { 
                        enUS = GetSpellInfo(55233) .. "\n<= time to die (sec)", 
                        ruRU = GetSpellInfo(55233) .. "\n<= time to die (sec)",  
                        frFR = GetSpellInfo(55233) .. "\n<= time to die (sec)",  
                    }, 
                    TT = { 
                        enUS = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition", 
                        ruRU = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",  
                        frFR = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",  
                    },
                    M = {},
                },                
            },
            {    
                RowOptions = { margin = { top = 10 } },            
                {
                    E = "Checkbox", 
                    DB = "VampiricBloodCatchKillStrike",
                    DBV = true,
                    L = { 
                        enUS = GetSpellInfo(55233) .. "\nCatch death hit",
                        ruRU = GetSpellInfo(55233) .. "\nCatch death hit",  
                        frFR = GetSpellInfo(55233) .. "\nCatch death hit", 
                    }, 
                    TT = { 
                        enUS = "Try to manage to use ability before receiving a fatal strike\nThis option is not related to other triggers!", 
                        ruRU = "Try to manage to use ability before receiving a fatal strike\nThis option is not related to other triggers!",
                        frFR = "Try to manage to use ability before receiving a fatal strike\nThis option is not related to other triggers!",  
                    },
                    M = {},
                },
                {
                    E       = "Slider",                                                     
                    MIN     = -1, 
                    MAX     = 100,                            
                    DB      = "VampiricBloodHP",
                    DBV     = 45,
                    ONLYOFF    = true,
                    L = { 
                        enUS = GetSpellInfo(55233) .. "\n<= health (%)", 
                        ruRU = GetSpellInfo(55233) .. "\n<= health (%)",  
                        frFR = GetSpellInfo(55233) .. "\n<= health (%)", 
                    }, 
                    TT = { 
                        enUS = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",
                        ruRU = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",  
                        frFR = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",  
                    },
                    M = {},
                }, 
            }, 
            -- Dancing Rune Weapon
            {
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. GetSpellInfo(49028) .. " -- ",
                    },
                },
            },
            { -- [1] 1st Row  
                RowOptions = { margin = { top = 10 } },            
                {
                    E = "Checkbox", 
                    DB = "DancingRuneWeaponIgnoreBigDeff",
                    DBV = true,
                    L = { 
                        enUS = GetSpellInfo(49028) .. "\nSkip if " .. GetSpellInfo(55233) .. " used",
                        ruRU = GetSpellInfo(49028) .. "\nSkip if " .. GetSpellInfo(55233) .. " used",  
                        frFR = GetSpellInfo(49028) .. "\nSkip if " .. GetSpellInfo(55233) .. " used", 
                    }, 
                    M = {},
                },     
                {
                    E       = "Slider",                                                     
                    MIN     = -1, 
                    MAX     = 20,                            
                    DB      = "DancingRuneWeaponTTD",
                    DBV     = 5,
                    ONLYOFF    = true,
                    L = { 
                        enUS = GetSpellInfo(49028) .. "\n<= time to die (sec)", 
                        ruRU = GetSpellInfo(49028) .. "\n<= time to die (sec)",  
                        frFR = GetSpellInfo(49028) .. "\n<= time to die (sec)",  
                    }, 
                    TT = { 
                        enUS = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition", 
                        ruRU = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",  
                        frFR = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",  
                    },
                    M = {},
                },                
            },
            {    
                RowOptions = { margin = { top = 10 } },            
                {
                    E = "Checkbox", 
                    DB = "DancingRuneWeaponCatchKillStrike",
                    DBV = true,
                    L = { 
                        enUS = GetSpellInfo(49028) .. "\nCatch death hit",
                        ruRU = GetSpellInfo(49028) .. "\nCatch death hit",  
                        frFR = GetSpellInfo(49028) .. "\nCatch death hit", 
                    }, 
                    TT = { 
                        enUS = "Try to manage to use ability before receiving a fatal strike\nThis option is not related to other triggers!", 
                        ruRU = "Try to manage to use ability before receiving a fatal strike\nThis option is not related to other triggers!",
                        frFR = "Try to manage to use ability before receiving a fatal strike\nThis option is not related to other triggers!",  
                    },
                    M = {},
                },
                {
                    E       = "Slider",                                                     
                    MIN     = -1, 
                    MAX     = 100,                            
                    DB      = "DancingRuneWeaponHP",
                    DBV     = 35,
                    ONLYOFF    = true,
                    L = { 
                        enUS = GetSpellInfo(49028) .. "\n<= health (%)", 
                        ruRU = GetSpellInfo(49028) .. "\n<= health (%)",  
                        frFR = GetSpellInfo(49028) .. "\n<= health (%)", 
                    }, 
                    TT = { 
                        enUS = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",
                        ruRU = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",  
                        frFR = "OFF - The trigger is disabled\n0->100 Less than or equal to the specified percentage of your health\nWARNING: There must be at least one of several triggers turned on\nWhen selecting multiple triggers, they will be synchronized as one general condition",  
                    },
                    M = {},
                }, 
            }, 
            -- Bonestorm
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. GetSpellInfo(194844) .. " -- ",
                    },
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 100,                            
                    DB = "BonestormHP",
                    DBV = 80, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        enUS = GetSpellInfo(194844) .. " (%)",
                        ruRU = GetSpellInfo(194844) .. " (%)",
                        frFR = GetSpellInfo(194844) .. " (%)",
                    },
                    TT = { 
                        enUS = "Set the HP percent value before using " .. GetSpellInfo(194844) .. ".",
                        ruRU = "Set the HP percent value before using " .. GetSpellInfo(194844) .. ".",
                        frFR = "Set the HP percent value before using " .. GetSpellInfo(194844) .. ".", 
                    }, 
                    M = {},
                },        
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 100,                            
                    DB = "BonestormRunicPower",
                    DBV = 40, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        enUS = GetSpellInfo(194844) .. " \nRunic Power",
                        ruRU = GetSpellInfo(194844) .. " \nRunic Power",
                        frFR = GetSpellInfo(194844) .. " \nRunic Power",
                    },
                    TT = { 
                        enUS = "Set the Runic Power value before using " .. GetSpellInfo(194844) .. ".",
                        ruRU = "Set the Runic Power value before using " .. GetSpellInfo(194844) .. ".",
                        frFR = "Set the Runic Power value before using " .. GetSpellInfo(194844) .. ".",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 100,                            
                    DB = "BonestormRunicPowerWithVampiricBlood",
                    DBV = 20, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        enUS = GetSpellInfo(194844) .. " \nRunic Power with " .. GetSpellInfo(55233),
                        ruRU = GetSpellInfo(194844) .. " \nRunic Power with " .. GetSpellInfo(55233),
                        frFR = GetSpellInfo(194844) .. " \nRunic Power with " .. GetSpellInfo(55233),
                    },
                    TT = { 
                        enUS = "Set the Runic Power value before using " .. GetSpellInfo(194844) .. " IF " .. GetSpellInfo(55233) .. " is active.",
                        ruRU = "Set the Runic Power value before using " .. GetSpellInfo(194844) .. " IF " .. GetSpellInfo(55233) .. " is active.",
                        frFR = "Set the Runic Power value before using " .. GetSpellInfo(194844) .. " IF " .. GetSpellInfo(55233) .. " is active.",
                    }, 
                    M = {},
                },                
            },
            -- AntiMagicShell
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- " .. GetSpellInfo(48707) .. " -- ",
                    },
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 100,                            
                    DB = "AntiMagicShellHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        enUS = GetSpellInfo(48707) .. " (%)",
                        ruRU = GetSpellInfo(48707) .. " (%)",
                        frFR = GetSpellInfo(48707) .. " (%)",
                    },
                    TT = { 
                        enUS = "Set the HP percent value before using " .. GetSpellInfo(48707) .. ".\nIf set on AUTO, then will use custom logic inside rotation.",
                        ruRU = "Set the HP percent value before using " .. GetSpellInfo(48707) .. ".\nIf set on AUTO, then will use custom logic inside rotation.",
                        frFR = "Set the HP percent value before using " .. GetSpellInfo(48707) .. ".\nIf set on AUTO, then will use custom logic inside rotation.",
                    }, 
                    M = {},
                },        
                {
                    E = "Slider",                                                     
                    MIN = 2, 
                    MAX = 30,                            
                    DB = "AntiMagicShellTTDMagic",
                    DBV = 3, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        enUS = GetSpellInfo(48707) .. " TTD",
                        ruRU = GetSpellInfo(48707) .. " TTD",
                        frFR = GetSpellInfo(48707) .. " TTD",
                    },
                    TT = { 
                        enUS = "Set the Time To Die value by magic damage before using " .. GetSpellInfo(48707) .. ".",
                        ruRU = "Set the Time To Die value by magic damage before using " .. GetSpellInfo(48707) .. ".",
                        frFR = "Set the Time To Die value by magic damage before using " .. GetSpellInfo(48707) .. ".",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 100,                            
                    DB = "AntiMagicShellTTDMagicHP",
                    DBV = 40, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        enUS = GetSpellInfo(48707) .. " TTD(%)",
                        ruRU = GetSpellInfo(48707) .. " TTD(%)",
                        frFR = GetSpellInfo(48707) .. " TTD(%)",
                    },
                    TT = { 
                        enUS = "Set the Time To Die Health Percent value by magic damage before using " .. GetSpellInfo(48707) .. ".",
                        ruRU = "Set the Time To Die Health Percent value by magic damage before using " .. GetSpellInfo(48707) .. ".",
                        frFR = "Set the Time To Die Health Percent value by magic damage before using " .. GetSpellInfo(48707) .. ".",
                    }, 
                    M = {},
                },                
            },    
            { -- [4] 4th Row
                
                {
                    E = "LayoutSpace",                                                                         
                },
            },            
            {
                {
                    E = "Checkbox", 
                    DB = "AutoTaunt",
                    DBV = false,
                    L = { 
                        enUS = "Automatic Taunt", 
                        ruRU = "Автоматическая Насмешка", 
                        frFR = "Raillerie automatique",
                    }, 
                    TT = { 
                        enUS = "If activated, will use automatically use Growl whenever available.", 
                        ruRU = "Если активирован, будет автоматически использовать Growl при любой возможности.",  
                        frFR = "S'il est activé, utilisera automatiquement Growl dès qu'il sera disponible.", 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "ThreatDamagerLimit",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        enUS = "Only 'Damager'\nThreat limit(agro,>= %)",
                        ruRU = "Только 'Урон'\nЛимит угрозы(агро,>= %)", 
                        frFR = "Seulement 'DPS'\nLimite de menace(аggrо,>= %)", 
                    }, 
                    TT = { 
                        enUS = "OFF - No limit\nIf the percentage of the threat (agro) is greater than\nor equal to the specified one, then the\n'safe' rotation will be performed. As far as possible, the\nabilities causing too many threats will be stopped until the\nthreat level (agro) is normalized", 
                        ruRU = "OFF - Нет лимита\nЕсли процент угрозы (агро) больше или равен указанному,\nто будет выполняться 'безопасная' ротация\nПо мере возможности перестанут использоваться способности\nвызывающие слишком много угрозы пока\nуровень угрозы (агро) не нормализуется",  
                        frFR = "OFF - Aucune limite\nSi le pourcentage de la menace (agro) est supérieur ou égal à celui spécifié, alors la rotation\n'safe' sera effectuée. Dans la mesure du possible, les \nabilités causant trop de menaces seront arrêtées jusqu'à ce que le\n niveau de menace (agro) soit normalisé",
                    },    
                    M = {},
                },                
            },             
            { -- [4] 4th Row
                
                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- General Defensives -- ",
                    },
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "DeathStrikeHP",
                    DBV = 80, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = GetSpellInfo(49998) .. " (%)",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "DeathPactHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = GetSpellInfo(48743) .. " (%)",
                    }, 
                    M = {},
                },
            },
            { -- [6]
                {
                    E = "Header",
                    L = {
                        ANY = " -- Party -- ",
                    },
                },
            }, 
            { -- [7]
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "@party1", value = 1 },
                        { text = "@party2", value = 2 },
                    },
                    MULT = true,
                    DB = "PartyUnits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                    }, 
                    L = { 
                        ANY = "Party Units",
                    }, 
                    TT = { 
                        enUS = "Enable/Disable relative party passive rotation", 
                    }, 
                    M = {},
                },
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "Tank", value = 1 },
                        { text = "Healer", value = 2 },
                        { text = "Damager", value = 3 },
                        { text = "Mouseover", value = 4 },
                    },
                    MULT = true,
                    DB = "RaiseAllyUnits",
                    DBV = {
                        [1] = true, 
                        [2] = false,
                        [3] = false,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = GetSpellInfo(61999) .. " units",
                    }, 
                    TT = { 
                        enUS = "Tank: Will only use if current tank is dead.\nHealer: Will only use if current healer is dead.\nDamager: Will only use if one of friendly damager is dead.\nMouseover: Will only use if you are mouseovering a dead target.", 
                        ruRU = "Tank: Will only use if current tank is dead.\nHealer: Will only use if current healer is dead.\nDamager: Will only use if one of friendly damager is dead.\nMouseover: Will only use if you are mouseovering a dead target.",  
                    }, 
                    M = {},
                },                
            }, 
            
            { -- [7] 
                {
                    E = "Header",
                    L = {
                        ANY = " -- Utilities -- ",
                    },
                },
            },
            { -- [3] 3rd Row 
                {
                    E = "Checkbox", 
                    DB = "UseWraithWalk",
                    DBV = true,
                    L = { 
                        enUS = "Auto" .. GetSpellInfo(212552), 
                        ruRU = "Авто" .. GetSpellInfo(212552), 
                        frFR = "Auto" .. GetSpellInfo(212552), 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. GetSpellInfo(212552), 
                        ruRU = "Автоматически использовать " .. GetSpellInfo(212552), 
                        frFR = "Utiliser automatiquement " .. GetSpellInfo(212552), 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 7,                            
                    DB = "WraithWalkTime",
                    DBV = 3, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        enUS = GetSpellInfo(212552) .. " if moving for",
                        ruRU = GetSpellInfo(212552) .. " если переехать",
                        frFR = GetSpellInfo(212552) .. " si vous bougez pendant",
                    },
                    TT = { 
                        enUS = "If " .. GetSpellInfo(212552) .. " is talented and ready, will use it if moving for set value.", 
                        ruRU = "Если " .. GetSpellInfo(212552) .. " изучен и готов, будет использовать его при переходе на заданное значение.", 
                        frFR = "Si " .. GetSpellInfo(212552) .. " est prêt, l'utilisera s'il se déplace pour la valeur définie.", 
                    }, 
                    M = {},
                },            
            },
            { -- [3] 3rd Row 
                {
                    E = "Checkbox", 
                    DB = "UseDeathsAdvance",
                    DBV = true,
                    L = { 
                        enUS = "Auto " .. GetSpellInfo(48265), 
                        ruRU = "Авто " .. GetSpellInfo(48265), 
                        frFR = "Auto " .. GetSpellInfo(48265), 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. GetSpellInfo(48265), 
                        ruRU = "Автоматически использовать " .. GetSpellInfo(48265), 
                        frFR = "Utiliser automatiquement " .. GetSpellInfo(48265), 
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 7,                            
                    DB = "DeathsAdvanceTime",
                    DBV = 3, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        enUS = GetSpellInfo(48265) .. " if moving for",
                        ruRU = GetSpellInfo(48265) .. " если переехать",
                        frFR = GetSpellInfo(48265) .. " si vous bougez pendant",
                    },
                    TT = { 
                        enUS = "If " .. GetSpellInfo(48265) .. " is talented and ready, will use it if moving for set value.", 
                        ruRU = "Если " .. GetSpellInfo(48265) .. " изучен и готов, будет использовать его при переходе на заданное значение.", 
                        frFR = "Si " .. GetSpellInfo(48265) .. " est prêt, l'utilisera s'il se déplace pour la valeur définie.", 
                    }, 
                    M = {},
                },            
            },
            { -- [3] 3rd Row 
                {
                    E = "Checkbox", 
                    DB = "UseDeathGrip",
                    DBV = true,
                    L = { 
                        enUS = "Auto " .. GetSpellInfo(49576), 
                        ruRU = "Авто " .. GetSpellInfo(49576), 
                        frFR = "Auto " .. GetSpellInfo(49576), 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. GetSpellInfo(49576) .. " if enemy try to move out.", 
                        ruRU = "Автоматически использовать " .. GetSpellInfo(49576) .. " если враг попытается выйти.", 
                        frFR = "Utiliser automatiquement " .. GetSpellInfo(49576) .. " si l'ennemi essaie de partir.",  
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "DeathGripInterrupt",
                    DBV = true,
                    L = { 
                        enUS = GetSpellInfo(49576) .. " interrupt", 
                        ruRU = GetSpellInfo(49576) .. " прерывание", 
                        frFR = GetSpellInfo(49576) .. " interrupt", 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. GetSpellInfo(49576) .. " as interrupt.", 
                        ruRU = "Автоматически использовать " .. GetSpellInfo(49576) .. " как прерывание.", 
                        frFR = "Utiliser automatiquement " .. GetSpellInfo(49576) .. " comme interrupt.", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "GorefiendsGraspInterrupt",
                    DBV = true,
                    L = { 
                        enUS = GetSpellInfo(108199) .. " interrupt", 
                        ruRU = GetSpellInfo(108199) .. " прерывание", 
                        frFR = GetSpellInfo(108199) .. " interrupt", 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. GetSpellInfo(108199) .. " as interrupt.", 
                        ruRU = "Автоматически использовать " .. GetSpellInfo(108199) .. " как прерывание.", 
                        frFR = "Utiliser automatiquement " .. GetSpellInfo(108199) .. " comme interrupt.", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "UseChainsofIce",
                    DBV = true,
                    L = { 
                        enUS = "Auto " .. GetSpellInfo(45524), 
                        ruRU = "Авто " .. GetSpellInfo(45524), 
                        frFR = "Auto " .. GetSpellInfo(45524), 
                    }, 
                    TT = { 
                        enUS = "Automatically use " .. GetSpellInfo(45524), 
                        ruRU = "Автоматически использовать " .. GetSpellInfo(45524), 
                        frFR = "Utiliser automatiquement " .. GetSpellInfo(45524), 
                    }, 
                    M = {},
                },                
            },
            { -- [4] 4th Row
                
                {
                    E = "LayoutSpace",                                                                         
                },
            }, 
            { -- [7]
                {
                    E = "Header",
                    L = {
                        ANY = " -- PvP -- ",
                    },
                },
            },
            { -- [5] 5th Row     
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "ON MELEE BURST", value = "ON MELEE BURST" },
                        { text = "ON COOLDOWN", value = "ON COOLDOWN" },                    
                        { text = "OFF", value = "OFF" },
                    },
                    DB = "AsphyxiatePvP",
                    DBV = "ON MELEE BURST",
                    L = { 
                        ANY = "PvP " .. GetSpellInfo(221562),
                    }, 
                    TT = { 
                        enUS = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Only if melee player has damage buffs\nON COOLDOWN - means will use always on melee players\nOFF - Cut out from rotation but still allow work through Queue and MSG systems\nIf you want fully turn it OFF then you should make SetBlocker in 'Actions' tab", 
                        ruRU = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Только если игрок ближнего боя имеет бафы на урон\nON COOLDOWN - значит будет использовано по игрокам ближнего боя по восстановлению способности\nOFF - Выключает из ротации, но при этом позволяет Очередь и MSG системам работать\nЕсли нужно полностью выключить, тогда установите блокировку во вкладке 'Действия'", 
                        frFR = "@arena1-3, @target, @mouseover, @targettarget\nON MELEE BURST - Seulement si le joueur de mêlée a des buffs de dégâts\nON COOLDOWN - les moyens seront toujours utilisés sur les joueurs de mêlée\nOFF - Coupé de la rotation mais autorisant toujours le travail dans la file d'attente et Systèmes MSG\nSi vous souhaitez l'éteindre complètement, vous devez définir SetBlocker dans l'onglet 'Actions'", 
                    }, 
                    M = {},
                },
                {
                    E = "Dropdown",                                                         
                    OT = {
                        { text = "@arena1", value = 1 },
                        { text = "@arena2", value = 2 },
                        { text = "@arena3", value = 3 },
                        { text = "primary", value = 4 },
                    },
                    MULT = true,
                    DB = "AsphyxiatePvPUnits",
                    DBV = {
                        [1] = true, 
                        [2] = true,
                        [3] = true,
                        [4] = true,
                    }, 
                    L = { 
                        ANY = "PvP " .. GetSpellInfo(221562) .. " units",
                    }, 
                    TT = { 
                        enUS = "primary - is @target, @mouseover, @targettarget (these units are depend on toggles above)", 
                        ruRU = "primary - это @target, @mouseover, @targettarget (эти юниты зависят от чекбоксов наверху)", 
                    }, 
                    M = {},
                },
            },
        },
        [ACTION_CONST_DEATHKNIGHT_UNHOLY] = {
            LayoutOptions = { gutter = 4, padding = { left = 5, right = 5 } },            
            { -- GENERAL HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " l><><>< GENERAL ><><><l ",
                    },
                },
            },            
            {--Army Usage
                {
                    E = "Dropdown",
                    OT = {
                        { text = "Boss / Players",        value = "BOSS" },
                        { text = "AoE",                value = "AoE" },
                        { text = "Both",            value = "BOTH" },
                        { text = "Everyone",        value = "EVERYONE" },
                    },
                    DB = "ArmyUsage",
                    DBV = "BOSS",
                    L = { 
                        ANY = A.GetSpellInfo(42650) .. " usage",
                    }, 
                    TT = { 
                        ANY = "Target for usage Army of the Dead.", 
                    }, 
                    M = {},
                },
            },
            { -- GENERAL OPTIONS
                { -- MOUSEOVER CHECKBOX
                    E = "Checkbox", 
                    DB = "mouseover",
                    DBV = true,
                    L = { 
                        enUS = "Use @mouseover", 
                        ruRU = "Использовать @mouseover", 
                        frFR = "Utiliser les fonctions @mouseover",
                    }, 
                    TT = { 
                        enUS = "Will unlock use actions for @mouseover units\nExample: Resuscitate, Healing", 
                        ruRU = "Разблокирует использование действий для @mouseover юнитов\nНапример: Воскрешение, Хилинг", 
                        frFR = "Activera les actions via @mouseover\n Exemple: Ressusciter, Soigner",
                    }, 
                    M = {},
                },
                { -- AOE CHECKBOX
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        enUS = "Use AoE", 
                        ruRU = "Использовать AoE", 
                        frFR = "Utiliser l'AoE",
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                        ruRU = "Включает действия для нескольких целей", 
                        frFR = "Activer les actions multi-unités",
                    }, 
                    M = {
                        Custom = "/run Action.AoEToggleMode()",
                        -- It does call func CraftMacro(L[CL], macro above, 1) -- 1 means perCharacter tab in MacroUI, if nil then will be used allCharacters tab in MacroUI
                        Value = value or nil, 
                        -- Very Very Optional, no idea why it will be need however.. 
                        TabN = '@number' or nil,                                
                        Print = '@string' or nil,
                    },
                },
                { -- Soul Reaper MOUSEOVER
                    E = "Checkbox", 
                    DB = "SoulReaperMouseover",
                    DBV = true,
                    L = { 
                        ANY = "Soul Reaper @mouseover", 
                    }, 
                    TT = { 
                        ANY = "/cast [@mouseover, harm]Soul Reaper; Soul Reaper"
                    }, 
                    M = {},
                },
            },
            {
                { -- DEATHGRIP INTERRUPT
                    E = "Checkbox", 
                    DB = "DeathGripInterrupt",
                    DBV = true,
                    L = { 
                        ANY = "Use Death Grip for Interrupt"
                    }, 
                    TT = { 
                        ANY = "Use Death Grip to Interrupt if Mind Freeze is on cooldown."
                    },
                    M = {},
                },
                { -- ASPHYXIATE INTERRUPT
                    E = "Checkbox", 
                    DB = "AsphyxiateInterrupt",
                    DBV = true,
                    L = { 
                        ANY = "Use Asphyxiate for Interrupt"
                    }, 
                    TT = { 
                        ANY = "Use Asphyxiate to Interrupt if Mind Freeze is on cooldown."
                    },
                    M = {},
                },  
                { -- Slow Spiteful @ MouseOver
                    E = "Checkbox", 
                    DB = "SlowSpiteful",
                    DBV = true,
                    L = { 
                        ANY = "Slow Spiteful with Chains @mouseover"
                    }, 
                    TT = { 
                        ANY = "/cast [@mouseover, harm]Chains of Ice; Chains of Ice"
                    },
                    M = {},
                },                    
            },    
            {
                { -- FocusTunnel
                    E = "Checkbox", 
                    DB = "FocusTunnel",
                    DBV = true,
                    L = { 
                        ANY = "Primary target /focus"
                    }, 
                    TT = { 
                        ANY = "/target focus bind to Rocket Jump"
                    },
                    M = {},
                }, 
				{
				    E                 = "Checkbox", 
                    DB                 = "ExplosiveMouseover",
                    DBV             = true,
                    L  = {
						ANY = "AutoTarget/Kill Explosives"
					},
                    TT = {
						ANY = "Make sure to bind Target MouseOver"
					},
                    M                 = {},
				},				
            },
            { -- LAYOUT SPACE
                {
                    E = "LayoutSpace",                                                                         
                },
            },            
            { -- AOE HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " l><><>< AOE ><><><l ",
                    },
                },
            },            
            { -- AOE SETTINGS
                {    -- AUTO SWITCH FESTERING STRIKE
                    E = "Checkbox", 
                    DB = "AutoSwitchFesteringStrike",
                    DBV = true,
                    L = { 
                        enUS = "AutoSwitch Festering Strike", 
                        ruRU = "AutoSwitch Festering Strike",  
                        frFR = "AutoSwitch Festering Strike", 
                    }, 
                    TT = { 
                        enUS = "Enable this to option to automatically switch between target to apply maximum Festering Strike debuff.", 
                        ruRU = "Enable this to option to automatically switch between target to apply maximum Festering Strike debuff.",
                        frFR = "Enable this to option to automatically switch between target to apply maximum Festering Strike debuff.",
                    }, 
                    M = {},
                },
                { -- AOE TARGETS
                    E = "Slider",                                                     
                    MIN = 2, 
                    MAX = 10,                            
                    DB = "AoETargets",
                    DBV = 2, -- Set healthpercentage @30% life. 
                    ONOFF = false,
                    L = { 
                        ANY = "Amount of targets to use AoE rotation",
                    }, 
                    M = {},
                },                
            },  
            { -- Row 2
                { -- DnD Slider
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "DnDSlider",
                    DBV = 2, 
                    ONOFF = false,
                    L = { 
                        ANY = "D&D Min Festering Wound",
                    }, 
					TT = {
						ANY = "How many targets to apply festering to before using DnD"
					},
                    M = {},
                },  
				{ -- AbomSlider
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 10,                            
                    DB = "AbomSlider",
                    DBV = 2, 
                    ONOFF = false,
                    L = { 
                        ANY = "Number of targets for Abom Limb",
                    },
                    TT = {
						ANY = "When in AoE scenerio, how many unit required for Abom Limb"			
					},
                    M = {},
                },   				
            },                
            { -- LAYOUT SPACE
                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- DEFENSIVES HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " l><><>< DEFENSIVES ><><><l ",
                    },
                },
            },
            { -- SLIDERS 1 
                { -- IceboundFortitudeHP SLIDER
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "IceboundFortitudeHP",
                    DBV = 100, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(48792) .. " (%)",
                    }, 
                    M = {},
                },
                { -- IceboundFortitudeAntiStun
                    E = "Checkbox", 
                    DB = "IceboundFortitudeAntiStun",
                    DBV = true,
                    L = { 
                        enUS = A.GetSpellInfo(48792) .. " AntiStun", 
                        ruRU = A.GetSpellInfo(48792) .. " AntiStun", 
                        frFR = A.GetSpellInfo(48792) .. " AntiStun",
                    }, 
                    TT = { 
                        enUS = "Enable this to option to automatically cast " .. A.GetSpellInfo(48792) .. " when you are stunned.", 
                        ruRU = "Enable this to option to automatically cast " .. A.GetSpellInfo(48792) .. " when you are stunned.",
                        frFR = "Enable this to option to automatically cast " .. A.GetSpellInfo(48792) .. " when you are stunned.",
                    }, 
                    M = {},
                },     
            },
            { -- SLIDERS 2 
                { -- Lichborne SLIDER
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "LichborneHP",
                    DBV = 100, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(49039) .. " (%)",
                    }, 
                    M = {},
                },
                { -- LichborneAntiStun
                    E = "Checkbox", 
                    DB = "LichborneAntiStun",
                    DBV = true,
                    L = { 
                        enUS = A.GetSpellInfo(49039) .. " AntiStun", 
                        ruRU = A.GetSpellInfo(49039) .. " AntiStun", 
                        frFR = A.GetSpellInfo(49039) .. " AntiStun",
                    }, 
                    TT = { 
                        enUS = "Enable this to option to automatically cast " .. A.GetSpellInfo(49039) .. " when you are stunned.", 
                        ruRU = "Enable this to option to automatically cast " .. A.GetSpellInfo(49039) .. " when you are stunned.",
                        frFR = "Enable this to option to automatically cast " .. A.GetSpellInfo(49039) .. " when you are stunned.",
                    }, 
                    M = {},
                },     
            },
            { -- SLIDERS 3
                { -- DEATHPACTHP SLIDER
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "DeathPactHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(48743) .. " (%)",
                    }, 
                    M = {},
                },
                { -- ANTIMAGICSHELL SLIDER
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "AntiMagicShellHP",
                    DBV = 100, -- Set healthpercentage @30% life. 
                    ONOFF = true,
                    L = { 
                        ANY = A.GetSpellInfo(48707) .. " (%)",
                    }, 
                    M = {},
                },
            },
            { -- SLIDERS 4
                { -- HEALING POTION 
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 100,                            
                    DB = "SpiritualHealingPotionHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "Spiritual Healing Potion HP (%)",
                    }, 
                    M = {},
                },    
                { -- DeathStrikeHP
                    E = "Slider",                                                     
                    MIN = -1, 
                    MAX = 99,                            
                    DB = "DeathStrikeHP",
                    DBV = 30, -- Set healthpercentage @30% life. 
                    ONOFF = false,
                    L = { 
                        ANY = "Death Strike HP (%)",
                    },                  
                    M = {},
                },
            },
            { -- LAYOUTSPACE
                {
                    E = "LayoutSpace",                                                                         
                },
            },
            { -- PVP HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " l><><>< PVP ><><><l ",
                    },
                },
            },
            {--Chains of Ice
                {
                    E = "Dropdown",
                    OT = {
                        { text = "Target",        value = "TARGET" },
                        { text = "Focus",                value = "FOCUS" },
                        { text = "Both",            value = "BOTH" },
                    },
                    DB = "ChainsPvPUsage",
                    DBV = "TARGET",
                    L = { 
                        ANY = A.GetSpellInfo(45524) .. " usage",
                    }, 
                    TT = { 
                        ANY = "Target for usage Chains of Ice in PvP.", 
                    }, 
                    M = {},
                },
            },
            { -- LAYOUTSPACE
                {
                    E = "LayoutSpace",                                                                         
                },
            },
        },
        [ACTION_CONST_DEATHKNIGHT_FROST] = {             
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
            { -- [2] Self Defensives 
                {
                    E                 = "Header",
                    L                 = L.selfDefence,
                },
            },
            {
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "AntiMagicShell",
                    DBV             = 50,
                    ONOFF             = true,
                    L                 = L.AntiMagicShell,                
                    M                 = {},
                },
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "AntiMagicZone",
                    DBV             = 30,
                    ONOFF             = true,
                    L                 = L.AntiMagicZone,                
                    M                 = {},
                },
            },
            {
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "DeathStrike",
                    DBV             = 55,
                    ONOFF             = true,
                    L                 = L.DeathStrike,                
                    M                 = {},
                },
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "Lichborne",
                    DBV             = 25,
                    ONOFF             = true,
                    L                 = L.Lichborne,                
                    M                 = {},
                },
            },
            {
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "DeathPact",
                    DBV             = 20,
                    ONOFF             = true,
                    L                 = L.DeathPact,                
                    M                 = {},
                },
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "SacrificialPact",
                    DBV             = 10,
                    ONOFF             = true,
                    L                 = L.SacrificialPact,                
                    M                 = {},
                },
                {
                    E                = "Slider",                                                     
                    MIN             = -1, 
                    MAX                = 100,                            
                    DB                 = "IceboundFortitude",
                    DBV             = 50,
                    ONOFF             = true,
                    L                 = L.IceboundFortitude,                
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

