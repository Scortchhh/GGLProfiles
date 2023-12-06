---------------------------------------------------
-------------- CUSTOM STUFF FUNCTIONS -------------
---------------------------------------------------
local TMW                                   = TMW
local _G, type, error, time                 = _G, type, error, time
local A                                     = _G.Action
local TeamCache                                = Action.TeamCache
local EnemyTeam                                = Action.EnemyTeam
local FriendlyTeam                            = Action.FriendlyTeam
local LoC                                    = Action.LossOfControl
local Player                                = Action.Player 
local MultiUnits                            = Action.MultiUnits
local UnitCooldown                            = Action.UnitCooldown
local ActiveUnitPlates                        = MultiUnits:GetActiveUnitPlates()
local toStr                                 = A.toStr
local toNum                                 = A.toNum
local next, pairs, type, print              = next, pairs, type, print
local IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo = IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo
local UnitLevel, UnitPower, UnitPowerMax, UnitStagger, UnitAttackSpeed, UnitRangedDamage, UnitDamage, UnitAura = UnitLevel, UnitPower, UnitPowerMax, UnitStagger, UnitAttackSpeed, UnitRangedDamage, UnitDamage, UnitAura
local UnitIsPlayer, UnitExists, UnitGUID    = UnitIsPlayer, UnitExists, UnitGUID
--local Pet                                 = LibStub("PetLibrary") Don't work. Too fast loading snippets ?
local Unit                                  = Action.Unit 
local huge                                  = math.huge
local UnitBuff                              = _G.UnitBuff
local EventFrame                            = CreateFrame("Frame", "Taste_EventFrame", UIParent)
local UnitIsUnit                            = UnitIsUnit
local StdUi                                 = Action.StdUi -- Custom StdUI with Action shared settings
-- Lua methods
local error                                 = error
local setmetatable                             = setmetatable
local stringformat                             = string.format
local stringfind                            = string.find
local stringsub                             = string.sub
local tableinsert                             = table.insert
local tableremove                            = table.remove 
-- Local Tables
local Events = {} -- All Events
local CombatEvents = {} -- Combat Log Unfiltered
local SelfCombatEvents = {} -- Combat Log Unfiltered with SourceGUID == PlayerGUID filter
local PetCombatEvents = {} -- Combat Log Unfiltered with SourceGUID == PetGUID filter
local PrefixCombatEvents = {}
local SuffixCombatEvents = {}
local CombatLogPrefixes = {
    "ENVIRONMENTAL",
    "RANGE",
    "SPELL_BUILDING",
    "SPELL_PERIODIC",
    "SPELL",
    "SWING"
}
local CombatLogPrefixesCount = #CombatLogPrefixes
local restoreDB = {}
local overrideDB = {}
-- Global TasteRotation Table
Action.TasteRotation = {}
local TR                                    = Action.TasteRotation
-- Global Tables
TR.Enum = {}
TR.Lists = {}
TR.storedTables = {}

