---------------------------------------------------
---------------- CUSTOM PVE FUNCTIONS -------------
---------------------------------------------------
local _G, type, error, time     			= _G, type, error, time
local A                         			= _G.Action
local TMW                                   = _G.TMW
local TeamCache								= Action.TeamCache
local EnemyTeam								= Action.EnemyTeam
local FriendlyTeam							= Action.FriendlyTeam
local LoC									= Action.LossOfControl
local Player								= Action.Player 
local MultiUnits							= Action.MultiUnits
local UnitCooldown							= Action.UnitCooldown
local next, pairs, type, print              = next, pairs, type, print
local IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo = IsActionInRange, GetActionInfo, PetHasActionBar, GetPetActionsUsable, GetSpellInfo
local UnitIsPlayer, UnitExists, UnitGUID    = UnitIsPlayer, UnitExists, UnitGUID
local PetLib                                = LibStub("PetLibrary")
local Unit                                  = Action.Unit 
local huge                                  = math.huge
local UnitBuff                              = _G.UnitBuff
local UnitIsUnit                            = UnitIsUnit
-- Lua
local error                                 = error
local setmetatable                          = setmetatable
local stringformat                          = string.format
local tableinsert                           = table.insert
local _G, math, setmetatable                = _G, math, setmetatable
local GameLocale                            = A.FormatGameLocale(_G.GetLocale())
local StdUi                                 = A.StdUi -- Custom StdUI with Action shared settings
local Factory                               = StdUi.Factory
local math_random                           = math.random
local Listener                                 = Action.Listener
local Create                                 = Action.Create
local GetToggle                                = Action.GetToggle

