-- ============================================================================
-- DungeonOptimizer - Data.lua
-- BIS lists (from Icy Veins) and Dungeon Loot Tables for WoW Midnight M+ S1
-- AUTO-GENERATED from Icy Veins on 2026-03-20
-- ============================================================================

local ADDON_NAME, NS = ...

-- ============================================================================
-- SLOT CONSTANTS
-- ============================================================================
NS.SLOT_IDS = { HEAD = 1, NECK = 2, SHOULDER = 3, BACK = 15, CHEST = 5, WRIST = 9, HANDS = 10, WAIST = 6, LEGS = 7, FEET = 8, FINGER1 = 11, FINGER2 = 12, TRINKET1 = 13, TRINKET2 = 14, MAINHAND = 16, OFFHAND = 17,
}

-- Slot names resolved via locale (NS.L loaded from Locales.lua)
local SLOT_LOCALE_KEYS = {
    [1] = "SLOT_HEAD", [2] = "SLOT_NECK", [3] = "SLOT_SHOULDERS",
    [5] = "SLOT_CHEST", [6] = "SLOT_WAIST", [7] = "SLOT_LEGS",
    [8] = "SLOT_FEET", [9] = "SLOT_WRIST", [10] = "SLOT_HANDS",
    [11] = "SLOT_RING1", [12] = "SLOT_RING2",
    [13] = "SLOT_TRINKET1", [14] = "SLOT_TRINKET2",
    [15] = "SLOT_BACK", [16] = "SLOT_MAINHAND", [17] = "SLOT_OFFHAND",
}
NS.SLOT_NAMES = setmetatable({}, {
    __index = function(_, slotId)
        local key = SLOT_LOCALE_KEYS[slotId]
        if key and NS.L then return NS.L[key] end
        return "Slot " .. tostring(slotId)
    end,
})

-- Canonical slot display order: weapons first, then top-to-bottom armor, jewelry
NS.SLOT_DISPLAY_ORDER = {16, 17, 1, 2, 3, 15, 5, 9, 10, 6, 7, 8, 11, 12, 13, 14}

-- ============================================================================
-- DUNGEON LIST - Midnight Season 1 M+ Pool
-- ============================================================================
NS.DUNGEONS = {
    { id = "MAGISTER", name = "Magisters' Terrace", icon = "Interface\\Icons\\achievement_dungeon_magistersterrace_heroic" },
    { id = "SEAT", name = "The Seat of the Triumvirate", icon = "Interface\\Icons\\achievement_dungeon_seatofthetriumvirate" },
    { id = "SKYREACH", name = "Skyreach", icon = "Interface\\Icons\\achievement_dungeon_skyreach" },
    { id = "ALGETHAR", name = "Algeth'ar Academy", icon = "Interface\\Icons\\achievement_dungeon_algetharacademy" },
    { id = "PIT_OF_SARON", name = "Pit of Saron", icon = "Interface\\Icons\\achievement_dungeon_pitofsaron" },
    { id = "WINDRUNNER", name = "Windrunner Spire", icon = "Interface\\Icons\\inv_misc_tournaments_banner_bloodelf" },
    { id = "MAISARA", name = "Maisara Caverns", icon = "Interface\\Icons\\achievement_dungeon_utgardekeep" },
    { id = "NEXUS_XENAS", name = "Nexus-Point Xenas", icon = "Interface\\Icons\\achievement_dungeon_nexus70" },
}

-- ============================================================================
-- RAID LIST - Midnight Season 1
-- ============================================================================
NS.RAIDS = {
    { id = "THE_VOIDSPIRE", name = "The Voidspire", icon = "Interface\\Icons\\achievement_raid_thevoidspire" },
    { id = "THE_DREAMRIFT", name = "The Dreamrift", icon = "Interface\\Icons\\achievement_raid_thedreamrift" },
    { id = "MARCH_ON_QUELDANAS", name = "March on Quel'Danas", icon = "Interface\\Icons\\achievement_raid_marchonqueldanas" },
}


-- ============================================================================
-- #39: AFFIX STRATEGY TIPS
-- Tips per affix ID, with optional per-dungeon overrides
-- Affix IDs: https://wowpedia.fandom.com/wiki/Mythic%2B#Affixes
-- ============================================================================
NS.AFFIX_TIPS = {
    -- Fortified (affix ID 10)
    [10] = {
        general = "Trash hits harder. Use cooldowns on large pulls.",
        dungeons = {
            MAGISTER = "Watch the big arcane packs before second boss.",
            WINDRUNNER = "Ranger packs need interrupts; save CDs for hallway pulls.",
            PIT_OF_SARON = "Frostborn patrols hit very hard; pull carefully.",
        },
    },
    -- Tyrannical (affix ID 9)
    [9] = {
        general = "Bosses hit harder and have more HP. Save CDs for boss fights.",
        dungeons = {
            SEAT = "Last boss has extended phases; plan healer CDs.",
            SKYREACH = "Ranjit's wind phases are longer; stay mobile.",
            NEXUS_XENAS = "Final boss soft enrage is tight; lust early.",
        },
    },
    -- Xal'atath's Bargain: Ascendant (affix ID 148)
    [148] = {
        general = "Void orbs spawn during combat. Dodge them or they explode.",
    },
    -- Challenger's Peril (affix ID 152)
    [152] = {
        general = "Deaths remove time from the timer. Play safe.",
    },
}

-- ============================================================================
-- BIS LISTS - MYTHIC (from Icy Veins, Midnight Season 1)
-- ============================================================================
NS.BIS_MYTHIC = {
    DEATHKNIGHT_BLOOD = {
        [16] = 251168, -- Liferipper's Cutlass (Maisara Caverns)
        [1] = 151333, -- Crown of the Dark Envoy (Seat of the Triumvirate)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 258587, -- Spaulders of Scorching Ray (Skyreach)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [5] = 50272, -- Frost Wyrm Ribcage (Pit of Saron)
        [9] = 263193, -- Trollhunter's Bands (Maisara Caverns)
        [10] = 151332, -- Voidclaw Gauntlets (Seat of the Triumvirate)
        [6] = 49808, -- Bent Gold Belt (Pit of Saron)
        [7] = 251208, -- Lightscarred Cuisses (Nexus-Point Xenas)
        [8] = 251091, -- Sabatons of Furious Revenge (Windrunner Spire)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 250256, -- Heart of Wind (Windrunner Spire)
        [14] = 252420, -- Solarflare Prism (Skyreach)
    },
    DEATHKNIGHT_FROST = {
        [16] = 251168, -- Liferipper's Cutlass (Maisara Caverns)
        [17] = 251100, -- Malfeasance Mallet (Magister's Terrace)
        [1] = 249970, -- Relentless Rider's Crown (Matrix Catalyst)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 50234, -- Shoulderplates of Frozen Blood (Pit of Saron)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Leatherworking)
        [5] = 249973, -- Relentless Rider's Cuirass (Matrix Catalyst)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 249971, -- Relentless Rider's Bonegrasps (Matrix Catalyst)
        [6] = 49808, -- Bent Gold Belt (Pit of Saron)
        [7] = 249969, -- Relentless Rider's Legguards (Matrix Catalyst)
        [8] = 251107, -- Oathsworn Stompers (Magister's Terrace)
        [11] = 193708, -- Platinum Star Band (Algeth'ar Academy)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
        [14] = 252420, -- Solarflare Prism (Skyreach)
    },
    DEATHKNIGHT_UNHOLY = {
        [16] = 251168, -- Liferipper's Cutlass (Maisara Caverns)
        [1] = 249970, -- Relentless Rider's Crown (Matrix Catalyst)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 50234, -- Shoulderplates of Frozen Blood (Pit of Saron)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Leatherworking)
        [5] = 249973, -- Relentless Rider's Cuirass (Matrix Catalyst)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 249971, -- Relentless Rider's Bonegrasps (Matrix Catalyst)
        [6] = 49808, -- Bent Gold Belt (Pit of Saron)
        [7] = 249969, -- Relentless Rider's Legguards (Matrix Catalyst)
        [8] = 251107, -- Oathsworn Stompers (Magister's Terrace)
        [11] = 193708, -- Platinum Star Band (Algeth'ar Academy)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
        [14] = 252420, -- Solarflare Prism (Skyreach)
    },
    DEMONHUNTER_DEVOURER = {
        [16] = 193710, -- Spellboon Saber (Algeth'ar Academy)
        [17] = 237840, -- Spellbreaker's Warglaive (Blacksmithing)
        [1] = 250033, -- Devouring Reaver's Intake (Matrix Catalyst)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 250031, -- Devouring Reaver's Exhaustplates (Matrix Catalyst)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [5] = 250036, -- Devouring Reaver's Engine (Matrix Catalyst)
        [9] = 193714, -- Frenzyroot Cuffs (Matrix Catalyst)
        [10] = 250034, -- Devouring Reaver's Essence Grips (Matrix Catalyst)
        [6] = 244573, -- Silvermoon Agent's Utility Belt (Leatherworking)
        [7] = 49817, -- Shaggy Wyrmleather Leggings (Pit of Saron)
        [8] = 258577, -- Boots of Burning Focus (Skyreach)
        [11] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [12] = 251115, -- Bifurcation Band (Magister's Terrace)
        [13] = 250256, -- Heart of Wind (Windrunner Spire)
        [14] = 250144, -- Emberwing Feather (Windrunner Spire)
    },
    DEMONHUNTER_HAVOC = {
        [16] = 251175, -- Soulblight Cleaver (Maisara Caverns)
        [17] = 251175, -- Soulblight Cleaver (Maisara Caverns)
        [1] = 251109, -- Spellsnap Shadowmask (Magister's Terrace)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 250031, -- Devouring Reaver's Exhaustplates (Matrix Catalyst)
        [15] = 239656, -- Adherent's Silken Shroud (Tailoring)
        [5] = 250036, -- Devouring Reaver's Engine (Matrix Catalyst)
        [9] = 244576, -- Silvermoon Agent's Deflectors (Leatherworking)
        [10] = 250034, -- Devouring Reaver's Essence Grips (Matrix Catalyst)
        [6] = 251082, -- Snapvine Cinch (Windrunner Spire)
        [7] = 250032, -- Devouring Reaver's Pistons (Matrix Catalyst)
        [8] = 258577, -- Boots of Burning Focus (Skyreach)
        [11] = 193708, -- Platinum Star Band (Algeth'ar Academy)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 193701, -- Algeth'ar Puzzle Box (Windrunner Spire)
        [14] = 252420, -- Solarflare Prism (Skyreach)
    },
    DEMONHUNTER_VENGEANCE = {
        [16] = 193717, -- Mystakria's Harvester (Algeth'ar Academy)
        [17] = 237840, -- Spellbreaker's Warglaive (Crafted by Blacksmithing)
        [1] = 250033, -- Devouring Reaver's Intake (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 151309, -- Necklace of the Twisting Void (Seat of the Triumvirate)
        [3] = 250031, -- Devouring Reaver's Exhaustplates (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [5] = 251216, -- Maledict Vest (Nexus-Point Xenas)
        [9] = 244576, -- Silvermoon Agent's Deflectors (Crafted by Leatherworking)
        [10] = 250034, -- Devouring Reaver's Essence Grips (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 251166, -- Falconer's Cinch (Maisara Caverns)
        [7] = 250032, -- Devouring Reaver's Pistons (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 251210, -- Eclipse Espadrilles (Nexus-Point Xenas)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [12] = 49812, -- Purloined Wedding Ring (Pit of Saron)
        [13] = 250256, -- Heart of Wind (Windrunner Spire)
        [14] = 252420, -- Solarflare Prism (Skyreach)
    },
    DRUID_BALANCE = {
        [16] = 251201, -- Corespark Multitool (Nexus-Point Xenas)
        [17] = 251178, -- Ceremonial Hexblade (Maisara Caverns & Algeth'ar Academy)
        [1] = 250024, -- Branches of the Luminous Bloom (Lightblinded Vanguard in The Voidspire)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 250022, -- Seedpods of the Luminous Bloom (Fallen-King Salhadaar in The Voidspire)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [5] = 250027, -- Trunk of the Luminous Bloom (Chimaerus in The Dreamrift)
        [9] = 50264, -- Chewed Leather Wristguards (Pit of Saron)
        [10] = 244575, -- Silvermoon Agent's Handwraps (Leatherworking)
        [6] = 251082, -- Snapvine Cinch (Windrunner Spire)
        [7] = 250023, -- Phloemwraps of the Luminous Bloom (Vaelgor and Ezzorak in The Voidspire)
        [8] = 244569, -- Silvermoon Agent's Sneakers (Leatherworking)
        [11] = 251115, -- Bifurcation Band (Magister's Terrace)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 250144, -- Emberwing Feather (Windrunner Spire)
        [14] = 250223, -- Soulcatcher's Charm (Maisara Caverns)
    },
    DRUID_FERAL = {
        [16] = 251077, -- Roostwarden's Bough (Windrunner Spire)
        [1] = 250024, -- Branches of the Luminous Bloom (Matrix Catalyst)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 251092, -- Fallen Grunt's Mantle (Windrunner Spire)
        [15] = 239656, -- Adherent's Silken Shroud (Tailoring)
        [5] = 250027, -- Trunk of the Luminous Bloom (Matrix Catalyst)
        [9] = 244576, -- Silvermoon Agent's Deflectors (Leatherworking)
        [10] = 250025, -- Arbortenders of the Luminous Bloom (Vorasius)
        [6] = 49806, -- Flayer's Black Belt (Pit of Saron)
        [7] = 250023, -- Phloemwraps of the Luminous Bloom (Matrix Catalyst)
        [8] = 258577, -- Boots of Burning Focus (Skyreach)
        [11] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 193701, -- Algeth'ar Puzzle Box (Windrunner Spire)
        [14] = 250256, -- Heart of Wind (Windrunner Spire)
    },
    DRUID_GUARDIAN = {
        [16] = 251162, -- Traitor's Talon (Maisara Caverns)
        [1] = 151336, -- Voidlashed Hood (Seat of the Triumvirate)
        [2] = 251096, -- Pendant of Aching Grief (Windrunner Spire)
        [3] = 250022, -- Seedpods of the Luminous Bloom (Matrix Catalyst)
        [15] = 251161, -- Soulhunter's Mask (Maisara Caverns)
        [5] = 250027, -- Trunk of the Luminous Bloom (Matrix Catalyst)
        [9] = 244576, -- Silvermoon Agent's Deflectors (Crafted by Leatherworking)
        [10] = 250025, -- Arbortenders of the Luminous Bloom (Matrix Catalyst)
        [6] = 244573, -- Silvermoon Agent's Utility Belt (Crafted by Leatherworking)
        [7] = 250023, -- Phloemwraps of the Luminous Bloom (Matrix Catalyst)
        [8] = 251210, -- Eclipse Espadrilles (Nexus-Point Xenas)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 250144, -- Emberwing Feather (Windrunner Spire)
        [14] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
    },
    DRUID_RESTORATION = {
        [16] = 193707, -- Final Grade (Algeth'ar Academy)
        [17] = 249922, -- Tome of Alnscorned Regret (Chimaerus - Dreamrift)
        [1] = 250024, -- Branches of the Luminous Bloom (Lightblinded Vanguard - The Voidspire)
        [2] = 251096, -- Pendant of Aching Grief (Windrunner Spire)
        [3] = 250022, -- Seedpods of the Luminous Bloom (Fallen-King Salhadaar - The Voidspire)
        [15] = 193712, -- Potion-Stained Cloak (Algeth'ar Academy)
        [5] = 251216, -- Maledict Vest (Nexus-Point Xenas)
        [9] = 193714, -- Frenzyroot Cuffs (Algeth'ar Academy)
        [10] = 250025, -- Arbortenders of the Luminous Bloom (Vorasius - The Voidspire)
        [6] = 251166, -- Falconer's Cinch (Maisara Caverns)
        [7] = 250023, -- Phloemwraps of the Luminous Bloom (Vaelgor and Ezzorak - The Voidspire)
        [8] = 251121, -- Domanaar's Dire Treads (Magister's Terrace)
        [11] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [12] = 251115, -- Bifurcation Band (Magister's Terrace)
        [13] = 193718, -- Emerald Coach's Whistle (Algeth'ar Academy)
        [14] = 250256, -- Heart of Wind (Windrunner Spire)
    },
    EVOKER_AUGMENTATION = {
        [16] = 251178, -- Ceremonial Hexblade (Maisara Caverns Magister's Terrace Skyreach Algeth'ar Academy)
        [17] = 251111, -- Splitshroud Stinger (Maisara Caverns Magister's Terrace Skyreach Algeth'ar Academy)
        [1] = 49824, -- Horns of the Spurned Val'kyr (Pit of Saron)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 249995, -- Beacons of the Black Talon (Matrix Catalyst)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring Magister's Terrace)
        [5] = 250000, -- Frenzyward of the Black Talon (Matrix Catalyst)
        [9] = 244584, -- Farstrider's Plated Bracers (Crafted by Leatherworking Seat of the Triumvirate)
        [10] = 249998, -- Enforcer's Grips of the Black Talon (Matrix Catalyst)
        [6] = 49810, -- Scabrous Zombie Leather Belt (Pit of Saron)
        [7] = 249996, -- Greaves of the Black Talon (Matrix Catalyst)
        [8] = 193715, -- Boots of Explosive Growth (Algeth'ar Academy Matrix Catalyst)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas Pit of Saron Crafted by Jewelcrafting)
        [12] = 49812, -- Purloined Wedding Ring (Nexus-Point Xenas Pit of Saron Crafted by Jewelcrafting)
        [13] = 250223, -- Soulcatcher's Charm (Maisara Caverns Windrunner Spire Magister's Terrace Algeth'ar Academy)
        [14] = 250256, -- Heart of Wind (Maisara Caverns Windrunner Spire Magister's Terrace Algeth'ar Academy)
    },
    EVOKER_DEVASTATION = {
        [16] = 251201, -- Corespark Multitool (Nexus-Point Xenas)
        [17] = 249276, -- Grimoire of the Eternal Light (Vorasius in The Voidspire .)
        [1] = 249997, -- Hornhelm of the Black Talon (Matrix Catalyst)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 249995, -- Beacons of the Black Talon (Matrix Catalyst)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 250000, -- Frenzyward of the Black Talon (Matrix Catalyst)
        [9] = 251079, -- Amberfrond Bracers (Windrunner Spire)
        [10] = 249998, -- Enforcer's Grips of the Black Talon (Matrix Catalyst)
        [6] = 49810, -- Scabrous Zombie Leather Belt (Pit of Saron)
        [7] = 249996, -- Greaves of the Black Talon (Matrix Catalyst)
        [8] = 251084, -- Whipcoil Sabatons (Windrunner Spire)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 249809, -- Locus-Walker's Ribbon (Crown of the Cosmos in The Voidspire .)
        [14] = 250258, -- Vessel of Tortured Souls (Maisara Caverns)
    },
    EVOKER_PRESERVATION = {
        [16] = 258514, -- Umbral Spire of Zuraal (Seat of the Triumvirate)
        [1] = 251119, -- Vortex Visage (Magister's Terrace)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 249995, -- Beacons of the Black Talon (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 251206, -- Fluxweave Cloak (Nexus-Point Xenas)
        [5] = 250000, -- Frenzyward of the Black Talon (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 251079, -- Amberfrond Bracers (Windrunner Spire)
        [10] = 249998, -- Enforcer's Grips of the Black Talon (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 244611, -- World Tender's Barkclasp (Crafted by Leatherworking)
        [7] = 249996, -- Greaves of the Black Talon (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 244610, -- World Tender's Rootslippers (Crafted by Leatherworking)
        [11] = 251115, -- Bifurcation Band (Magister's Terrace)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 250256, -- Heart of Wind (Windrunner Spire)
        [14] = 250144, -- Emberwing Feather (Windrunner Spire)
    },
    HUNTER_BEASTMASTERY = {
        [16] = 251174, -- Deceiver's Rotbow (Maisara Caverns)
        [1] = 249988, -- Primal Sentry's Maw (Lightblinded Vanguard - Voidspire, or Matrix Catalyst)
        [2] = 151309, -- Necklace of the Twisting Void (Seat of the Triumvirate)
        [3] = 151323, -- Pauldrons of the Void Hunter (Seat of the Triumvirate)
        [15] = 258575, -- Rigid Scale Greatcloak (Skyreach)
        [5] = 249991, -- Primal Sentry's Scaleplate (Chimaerus - Dreamrift, or Matrix Catalyst)
        [9] = 251079, -- Amberfrond Bracers (Windrunner Spire)
        [10] = 249989, -- Primal Sentry's Talonguards (Vorasius - Voidspire, or Matrix Catalyst)
        [6] = 244611, -- World Tender's Barkclasp (Leatherworking)
        [7] = 249987, -- Primal Sentry's Legguards (Vaelgor and Ezzorak - Voidspire, or Matrix Catalyst)
        [8] = 244610, -- World Tender's Rootslippers (Leatherworking)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
        [14] = 250258, -- Vessel of Tortured Souls (Maisara Caverns)
    },
    HUNTER_MARKSMANSHIP = {
        [16] = 251095, -- Hurricane's Heart (Windrunner Spire)
        [1] = 249988, -- Primal Sentry's Maw (Lightblinded Vanguard - Voidspire, or Matrix Catalyst)
        [2] = 251096, -- Pendant of Aching Grief (Windrunner Spire)
        [3] = 151323, -- Pauldrons of the Void Hunter (Seat of the Triumvirate)
        [15] = 258575, -- Rigid Scale Greatcloak (Skyreach)
        [5] = 249991, -- Primal Sentry's Scaleplate (Chimaerus - Dreamrift, or Matrix Catalyst)
        [9] = 251079, -- Amberfrond Bracers (Windrunner Spire)
        [10] = 249989, -- Primal Sentry's Talonguards (Vorasius - Voidspire, or Matrix Catalyst)
        [6] = 244611, -- World Tender's Barkclasp (Leatherworking)
        [7] = 249987, -- Primal Sentry's Legguards (Vaelgor and Ezzorak - Voidspire, or Matrix Catalyst)
        [8] = 244610, -- World Tender's Rootslippers (Leatherworking)
        [11] = 193708, -- Platinum Star Band (Algeth'ar Academy)
        [12] = 151308, -- Eredath Seal of Nobility (Seat of the Triumvirate)
        [13] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
        [14] = 252420, -- Solarflare Prism (Skyreach)
    },
    HUNTER_SURVIVAL = {
        [16] = 251077, -- Roostwarden's Bough (Windrunner Spire)
        [17] = 251212, -- Radiant Slicer (Nexus-Point Xenas)
        [1] = 249988, -- Primal Sentry's Maw (Lightblinded Vanguard - Voidspire, or Matrix Catalyst)
        [2] = 251096, -- Pendant of Aching Grief (Windrunner Spire)
        [3] = 151323, -- Pauldrons of the Void Hunter (Seat of the Triumvirate)
        [15] = 258575, -- Rigid Scale Greatcloak (Skyreach)
        [5] = 249991, -- Primal Sentry's Scaleplate (Chimaerus - Dreamrift, or Matrix Catalyst)
        [9] = 251079, -- Amberfrond Bracers (Windrunner Spire)
        [10] = 249989, -- Primal Sentry's Talonguards (Vorasius - Voidspire, or Matrix Catalyst)
        [6] = 244611, -- World Tender's Barkclasp (Leatherworking)
        [7] = 249987, -- Primal Sentry's Legguards (Vaelgor and Ezzorak - Voidspire, or Matrix Catalyst)
        [8] = 244610, -- World Tender's Rootslippers (Leatherworking)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
        [14] = 252420, -- Solarflare Prism (Skyreach)
    },
    MAGE_ARCANE = {
        [16] = 258218, -- Skybreaker's Blade (Skyreach)
        [17] = 251094, -- Sigil of the Restless Heart (Windrunner Spire)
        [1] = 250060, -- Voidbreaker's Veil (Matrix Catalyst)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 250058, -- Voidbreaker's Leyline Nexi (Matrix Catalyst)
        [15] = 239661, -- Arcanoweave Cloak (Crafted by Tailoring)
        [5] = 250063, -- Voidbreaker's Robe (Matrix Catalyst)
        [9] = 239660, -- Arcanoweave Bracers (Crafted by Tailoring)
        [10] = 250061, -- Voidbreaker's Gloves (Matrix Catalyst)
        [6] = 251102, -- Clasp of Compliance (Magister's Terrace)
        [7] = 251090, -- Commander's Faded Breeches (The Great Vault / Windrunner Spire)
        [8] = 251167, -- Nightprey Stalkers (Maisara Caverns)
        [11] = 193708, -- Platinum Star Band (Algeth'ar Academy)
        [12] = 151308, -- Eredath Seal of Nobility (Seat of the Triumvirate)
        [13] = 250144, -- Emberwing Feather (Windrunner Spire)
        [14] = 250258, -- Vessel of Tortured Souls (Maisara Caverns)
    },
    MAGE_FIRE = {
        [16] = 193710, -- Spellboon Saber (Algeth'ar Academy)
        [17] = 258472, -- Rukhran's Solar Reliquary (Windrunner Spire)
        [1] = 250060, -- Voidbreaker's Veil (Matrix Catalyst)
        [2] = 151309, -- Necklace of the Twisting Void (Seat of the Triumvirate)
        [3] = 250058, -- Voidbreaker's Leyline Nexi (Matrix Catalyst)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring with Arcanoweave Lining and Haste + Mastery)
        [5] = 49825, -- Palebone Robes (Pit of Saron)
        [9] = 239648, -- Martyr's Bindings (Crafted by Tailoring with Arcanoweave Lining and Haste + Mastery)
        [10] = 250061, -- Voidbreaker's Gloves (Matrix Catalyst)
        [6] = 50263, -- Braid of Salt and Fire (Pit of Saron)
        [7] = 250059, -- Voidbreaker's Britches (Matrix Catalyst)
        [8] = 258584, -- Lightbinder Treads (Skyreach)
        [11] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 250144, -- Emberwing Feather (Windrunner Spire)
        [14] = 250256, -- Heart of Wind (Windrunner Spire)
    },
    MAGE_FROST = {
        [16] = 245770, -- Aln'hara Cane (Inscription)
        [17] = 245769, -- Aln'hara Lantern (Inscription)
        [1] = 250060, -- Voidbreaker's Veil (Matrix Catalyst)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 251085, -- Mantle of Dark Devotion (Windrunner Spire)
        [15] = 258575, -- Rigid Scale Greatcloak (Skyreach)
        [5] = 250063, -- Voidbreaker's Robe (Matrix Catalyst)
        [9] = 239648, -- Martyr's Bindings (Tailoring)
        [10] = 250061, -- Voidbreaker's Gloves (Matrix Catalyst)
        [6] = 250057, -- Voidbreaker's Sage Cord (Matrix Catalyst)
        [7] = 250059, -- Voidbreaker's Britches (Matrix Catalyst)
        [8] = 133489, -- Ice-Steeped Sandals (Pit of Saron)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 250144, -- Emberwing Feather (Windrunner Spire)
        [14] = 250256, -- Heart of Wind (Windrunner Spire)
    },
    MONK_BREWMASTER = {
        [16] = 193723, -- Obsidian Goaltending Spire (Algeth'ar Academy)
        [17] = 251207, -- Dreadflail Bludgeon (Nexus-Point Xenas Maisara Caverns)
        [1] = 250015, -- Fearsome Visage of Ra-den's Chosen (Matrix Catalyst)
        [2] = 240950, -- Masterwork Sin'dorei Amulet (Jewelcrafting ( see note ))
        [3] = 250013, -- Aurastones of Ra-den's Chosen (Matrix Catalyst)
        [15] = 251161, -- Soulhunter's Mask (Maisara Caverns)
        [5] = 250018, -- Battle Garb of Ra-den's Chosen (Matrix Catalyst)
        [9] = 50264, -- Chewed Leather Wristguards (Pit of Saron)
        [10] = 250016, -- Thunderfists of Ra-den's Chosen (Matrix Catalyst)
        [6] = 251082, -- Snapvine Cinch (Windrunner Spire)
        [7] = 151314, -- Shifting Stalker Hide Pants (Seat of the Triumvirate)
        [8] = 151317, -- Footpads of Seeping Dread (Seat of the Triumvirate)
        [11] = 151308, -- Eredath Seal of Nobility (Seat of the Triumvirate)
        [12] = 251513, -- Loa Worshiper's Band (Jewelcrafting)
        [13] = 252420, -- Solarflare Prism (Skyreach Seat of the Triumvirate Pit of Saron Seat of the Triumvirate)
        [14] = 151307, -- Void Stalker's Contract (Skyreach Seat of the Triumvirate Pit of Saron Seat of the Triumvirate)
    },
    MONK_MISTWEAVER = {
        [16] = 258050, -- Arcanic of the High Sage (Skyreach)
        [17] = 193709, -- Vexamus' Expulsion Rod (Algeth'ar Academy)
        [1] = 151336, -- Voidlashed Hood (Seat of the Triumvirate)
        [2] = 251096, -- Pendant of Aching Grief (Windrunner Spire)
        [3] = 250013, -- Aurastones of Ra-den's Chosen (Matrix Catalyst)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 250018, -- Battle Garb of Ra-den's Chosen (Matrix Catalyst)
        [9] = 244576, -- Silvermoon Agent's Deflectors (Crafted by Leatherworking)
        [10] = 250016, -- Thunderfists of Ra-den's Chosen (Matrix Catalyst)
        [6] = 251166, -- Falconer's Cinch (Maisara Caverns)
        [7] = 250014, -- Swiftsweepers of Ra-den's Chosen (Matrix Catalyst)
        [8] = 251210, -- Eclipse Espadrilles (Nexus-Point Xenas)
        [11] = 151308, -- Eredath Seal of Nobility (Seat of the Triumvirate)
        [12] = 151311, -- Band of the Triumvirate (Seat of the Triumvirate)
        [13] = 250256, -- Heart of Wind (Windrunner Spire)
        [14] = 250144, -- Emberwing Feather (Windrunner Spire)
    },
    MONK_WINDWALKER = {
        [16] = 251162, -- Traitor's Talon (Maisara Caverns)
        [17] = 251122, -- Shadowslash Slicer (Magister's Terrace)
        [1] = 250015, -- Fearsome Visage of Ra-den's Chosen (Matrix Catalyst , or Lightblinded Vanguard - The Voidspire)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 250013, -- Aurastones of Ra-den's Chosen (Matrix Catalyst , or Fallen-King Salhadaar - The Voidspire)
        [15] = 250010, -- Windwrap of Ra-den's Chosen (Matrix Catalyst)
        [5] = 250018, -- Battle Garb of Ra-den's Chosen (Matrix Catalyst , or Chimaerus - The Dreamrift)
        [9] = 193714, -- Frenzyroot Cuffs (Algeth'ar Academy)
        [10] = 151318, -- Gloves of the Dark Shroud (Seat of the Triumvirate)
        [6] = 251082, -- Snapvine Cinch (Windrunner Spire)
        [7] = 250014, -- Swiftsweepers of Ra-den's Chosen (Matrix Catalyst , or Vaelgor and Ezzorak - The Voidspire)
        [8] = 250017, -- Storm Crashers of Ra-den's Chosen (Matrix Catalyst)
        [11] = 251513, -- Loa Worshiper's Band (Jewelcrafting)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 250256, -- Heart of Wind (Windrunner Spire)
        [14] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
    },
    PALADIN_HOLY = {
        [16] = 193710, -- Spellboon Saber (Algeth'ar Academy)
        [17] = 258049, -- Viryx's Indomitable Bulwark (Skyreach)
        [1] = 249961, -- Luminant Verdict's Unwavering Gaze (Matrix Catalyst)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 249959, -- Luminant Verdict's Providence Watch (Matrix Catalyst)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 249964, -- Luminant Verdict's Divine Warplate (Matrix Catalyst)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 249962, -- Luminant Verdict's Gauntlets (Matrix Catalyst)
        [6] = 151327, -- Girdle of the Shadowguard (Seat of the Triumvirate)
        [7] = 251118, -- Legplates of Lingering Dusk (Magister's Terrace)
        [8] = 251107, -- Oathsworn Stompers (Magister's Terrace)
        [11] = 251115, -- Bifurcation Band (Magister's Terrace)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 250256, -- Heart of Wind (Windrunner Spire)
        [14] = 250144, -- Emberwing Feather (Windrunner Spire)
    },
    PALADIN_PROTECTION = {
        [16] = 193711, -- Spellbane Cutlass (Algeth'ar Academy)
        [17] = 251105, -- Ward of the Spellbreaker (Magister's Terrace)
        [1] = 249961, -- Luminant Verdict's Unwavering Gaze (Matrix Catalyst)
        [2] = 251096, -- Pendant of Aching Grief (Windrunner Spire)
        [3] = 249959, -- Luminant Verdict's Providence Watch (Matrix Catalyst)
        [15] = 49823, -- Cloak of the Fallen Cardinal (Pit of Saron)
        [5] = 249964, -- Luminant Verdict's Divine Warplate (Matrix Catalyst)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 151332, -- Voidclaw Gauntlets (Seat of the Triumvirate)
        [6] = 251112, -- Shadowsplit Girdle (Magister's Terrace)
        [7] = 249960, -- Luminant Verdict's Greaves (Matrix Catalyst)
        [8] = 251169, -- Footwraps of Ill-Fate (Maisara Caverns)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [12] = 251513, -- Loa Worshiper's Band (Crafted by Jewelcrafting)
        [13] = 252420, -- Solarflare Prism (Skyreach)
        [14] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
    },
    PALADIN_RETRIBUTION = {
        [16] = 251168, -- Liferipper's Cutlass (Maisara Caverns)
        [1] = 249961, -- Luminant Verdict's Unwavering Gaze (Matrix Catalyst)
        [2] = 50228, -- Barbed Ymirheim Choker (Midnight Falls in March on Quel'Danas)
        [3] = 249959, -- Luminant Verdict's Providence Watch (Matrix Catalyst)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 249964, -- Luminant Verdict's Divine Warplate (Matrix Catalyst)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 151332, -- Voidclaw Gauntlets (Seat of the Triumvirate)
        [6] = 151327, -- Girdle of the Shadowguard (Seat of the Triumvirate)
        [7] = 249960, -- Luminant Verdict's Greaves (Matrix Catalyst)
        [8] = 251107, -- Oathsworn Stompers (Magister's Terrace)
        [11] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 252420, -- Solarflare Prism (Skyreach)
        [14] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
    },
    PRIEST_DISCIPLINE = {
        [16] = 251178, -- Ceremonial Hexblade (Maisara Caverns)
        [17] = 245769, -- Aln'hara Lantern (Crafted by Inscription)
        [1] = 250051, -- Blind Oath's Winged Crest (Matrix Catalyst)
        [2] = 151309, -- Necklace of the Twisting Void (Seat of the Triumvirate)
        [3] = 251213, -- Nysarra's Mantle (Nexus-Point Xenas)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [5] = 250054, -- Blind Oath's Raiment (Matrix Catalyst)
        [9] = 133493, -- Wristguards of Subterranean Moss (Pit of Saron)
        [10] = 250052, -- Blind Oath's Touch (Matrix Catalyst)
        [6] = 239664, -- Arcanoweave Cord (Crafted by Tailoring)
        [7] = 250050, -- Blind Oath's Leggings (Matrix Catalyst)
        [8] = 258584, -- Lightbinder Treads (Skyreach)
        [11] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [12] = 151311, -- Band of the Triumvirate (Seat of the Triumvirate)
        [13] = 250256, -- Heart of Wind (Windrunner Spire)
        [14] = 193718, -- Emerald Coach's Whistle (Algeth'ar Academy)
    },
    PRIEST_HOLY = {
        [16] = 245770, -- Aln'hara Cane (Crafted with Inscription Pit of Saron Seat of the Triumvirate Windrunner Spire)
        [17] = 249276, -- Grimoire of the Eternal Light (Vorasius in The Voidspire)
        [1] = 250051, -- Blind Oath's Winged Crest (Matrix Catalyst)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 250049, -- Blind Oath's Seraphguards (Matrix Catalyst)
        [15] = 49823, -- Cloak of the Fallen Cardinal (Pit of Saron)
        [5] = 250054, -- Blind Oath's Raiment (Matrix Catalyst)
        [9] = 258580, -- Bracers of Blazing Light (Skyreach)
        [10] = 250052, -- Blind Oath's Touch (Matrix Catalyst)
        [6] = 239664, -- Arcanoweave Cord (Crafted with Tailoring)
        [7] = 250050, -- Blind Oath's Leggings (Matrix Catalyst)
        [8] = 251167, -- Nightprey Stalkers (Maisara Caverns)
        [11] = 151308, -- Eredath Seal of Nobility (Seat of the Triumvirate)
        [12] = 193708, -- Platinum Star Band (Algeth'ar Academy)
        [13] = 193718, -- Emerald Coach's Whistle (Algeth'ar Academy)
        [14] = 250256, -- Heart of Wind (Windrunner Spire)
    },
    PRIEST_SHADOW = {
        [16] = 251111, -- Splitshroud Stinger (Magister's Terrace Skyreach Nexus-Point Xenas Skyreach)
        [17] = 258472, -- Rukhran's Solar Reliquary (Magister's Terrace Skyreach Nexus-Point Xenas Skyreach)
        [1] = 250051, -- Blind Oath's Winged Crest (Matrix Catalyst)
        [2] = 151309, -- Necklace of the Twisting Void (Seat of the Triumvirate)
        [3] = 250049, -- Blind Oath's Seraphguards (Matrix Catalyst)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [5] = 250054, -- Blind Oath's Raiment (Matrix Catalyst)
        [9] = 151305, -- Entropic Wristwraps (Seat of the Triumvirate)
        [10] = 251172, -- Vilehex Bonds (Maisara Caverns)
        [6] = 151302, -- Cord of Unraveling Reality (Seat of the Triumvirate)
        [7] = 250050, -- Blind Oath's Leggings (Matrix Catalyst)
        [8] = 258584, -- Lightbinder Treads (Skyreach)
        [11] = 251093, -- Omission of Light (Nexus-Point Xenas Magister's Terrace)
        [12] = 251115, -- Bifurcation Band (Nexus-Point Xenas Magister's Terrace)
        [13] = 250223, -- Soulcatcher's Charm (Maisara Caverns The Blinding Vale Windrunner Spire Windrunner Spire)
        [14] = 250214, -- Lightspire Core (Maisara Caverns The Blinding Vale Windrunner Spire Windrunner Spire)
    },
    ROGUE_ASSASSINATION = {
        [16] = 258436, -- Edge of the Burning Sun (Skyreach)
        [17] = 237837, -- Farstrider's Mercy (Crafted by Blacksmithing)
        [1] = 250006, -- Masquerade of the Grim Jest (Matrix Catalyst)
        [2] = 151309, -- Necklace of the Twisting Void (Seat of the Triumvirate)
        [3] = 250004, -- Venom Casks of the Grim Jest (Matrix Catalyst)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [5] = 250009, -- Fantastic Finery of the Grim Jest (Matrix Catalyst)
        [9] = 244576, -- Silvermoon Agent's Deflectors (Crafted by Leatherworking)
        [10] = 250007, -- Sleight of Hand of the Grim Jest (Matrix Catalyst)
        [6] = 251082, -- Snapvine Cinch (Windrunner Spire)
        [7] = 251087, -- Legwraps of Lingering Legacies (Windrunner Spire)
        [8] = 258577, -- Boots of Burning Focus (Skyreach)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
        [14] = 252420, -- Solarflare Prism (Skyreach)
    },
    ROGUE_OUTLAW = {
        [16] = 251207, -- Dreadflail Bludgeon (Nexus-Point Xenas)
        [17] = 133491, -- Krick's Beetle Stabber (Pit of Saron)
        [1] = 151336, -- Voidlashed Hood (Seat of the Triumvirate)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 250004, -- Venom Casks of the Grim Jest (Matrix Catalyst)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [5] = 250009, -- Fantastic Finery of the Grim Jest (Matrix Catalyst)
        [9] = 50264, -- Chewed Leather Wristguards (Pit of Saron)
        [10] = 250007, -- Sleight of Hand of the Grim Jest (Matrix Catalyst)
        [6] = 251166, -- Falconer's Cinch (Maisara Caverns)
        [7] = 250005, -- Blade Holsters of the Grim Jest (Matrix Catalyst)
        [8] = 244569, -- Silvermoon Agent's Sneakers (Crafted by Leatherworking)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [12] = 240949, -- Masterwork Sin'dorei Band (Crafted by Jewelcrafting)
        [13] = 250256, -- Heart of Wind (Windrunner Spire)
        [14] = 252420, -- Solarflare Prism (Skyreach)
    },
    ROGUE_SUBTLETY = {
        [16] = 258436, -- Edge of the Burning Sun (Skyreach)
        [17] = 258436, -- Edge of the Burning Sun (Skyreach)
        [1] = 250006, -- Masquerade of the Grim Jest (Matrix Catalyst)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 250004, -- Venom Casks of the Grim Jest (Matrix Catalyst)
        [15] = 258575, -- Rigid Scale Greatcloak (Skyreach)
        [5] = 250009, -- Fantastic Finery of the Grim Jest (Matrix Catalyst)
        [9] = 193714, -- Frenzyroot Cuffs (Algeth'ar Academy)
        [10] = 250007, -- Sleight of Hand of the Grim Jest (Matrix Catalyst)
        [6] = 49806, -- Flayer's Black Belt (Pit of Saron)
        [7] = 49817, -- Shaggy Wyrmleather Leggings (Pit of Saron)
        [8] = 258577, -- Boots of Burning Focus (Skyreach)
        [11] = 193708, -- Platinum Star Band (Algeth'ar Academy)
        [12] = 251115, -- Bifurcation Band (Magister's Terrace)
        [13] = 250144, -- Emberwing Feather (Windrunner Spire)
        [14] = 252420, -- Solarflare Prism (Skyreach)
    },
    SHAMAN_ELEMENTAL = {
        [16] = 251083, -- Excavating Cudgel (Windrunner Spire)
        [17] = 251105, -- Ward of the Spellbreaker (Magister's Terrace)
        [1] = 249979, -- Locus of the Primal Core (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 249977, -- Tempests of the Primal Core (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 258575, -- Rigid Scale Greatcloak (Skyreach)
        [5] = 249982, -- Embrace of the Primal Core (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 251079, -- Amberfrond Bracers (Windrunner Spire)
        [10] = 249980, -- Earthgrips of the Primal Core (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 244611, -- World Tender's Barkclasp (Crafted by Leatherworking)
        [7] = 251215, -- Greaves of the Divine Guile (Nexus-Point Xenas)
        [8] = 244610, -- World Tender's Rootslippers (Crafted by Leatherworking)
        [11] = 193708, -- Platinum Star Band (Algeth'ar Academy)
        [12] = 251115, -- Bifurcation Band (Magister's Terrace)
        [13] = 250144, -- Emberwing Feather (Windrunner Spire)
        [14] = 250256, -- Heart of Wind (Windrunner Spire)
    },
    SHAMAN_ENHANCEMENT = {
        [16] = 258438, -- Blazing Sunclaws (Skyreach)
        [17] = 237850, -- Farstrider's Chopper (Blacksmithing)
        [1] = 249979, -- Locus of the Primal Core (Matrix Catalyst)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 249977, -- Tempests of the Primal Core (Matrix Catalyst)
        [15] = 239656, -- Adherent's Silken Shroud (Tailoring)
        [5] = 249982, -- Embrace of the Primal Core (Matrix Catalyst)
        [9] = 251079, -- Amberfrond Bracers (Windrunner Spire)
        [10] = 249980, -- Earthgrips of the Primal Core (Matrix Catalyst)
        [6] = 49810, -- Scabrous Zombie Leather Belt (Pit of Saron)
        [7] = 251215, -- Greaves of the Divine Guile (Nexus-Point Xenas)
        [8] = 251084, -- Whipcoil Sabatons (Windrunner Spire)
        [11] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [12] = 251217, -- Occlusion of Void (Algeth'ar Academy)
        [13] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
        [14] = 252420, -- Solarflare Prism (Skyreach)
    },
    SHAMAN_RESTORATION = {
        [16] = 251178, -- Ceremonial Hexblade (Maisara Caverns)
        [17] = 258049, -- Viryx's Indomitable Bulwark (Skyreach)
        [1] = 258585, -- Sharpeye Gleam (Skyreach)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 249977, -- Tempests of the Primal Core (Matrix Catalyst)
        [15] = 258575, -- Rigid Scale Greatcloak (Skyreach)
        [5] = 249982, -- Embrace of the Primal Core (Matrix Catalyst)
        [9] = 151321, -- Darkfang Scale Wristguards (Seat of the Triumvirate)
        [10] = 249980, -- Earthgrips of the Primal Core (Matrix Catalyst)
        [6] = 244611, -- World Tender's Barkclasp (Crafted by Leatherworking)
        [7] = 249978, -- Leggings of the Primal Core (Matrix Catalyst)
        [8] = 244610, -- World Tender's Rootslippers (Crafted by Leatherworking)
        [11] = 151308, -- Eredath Seal of Nobility (Seat of the Triumvirate)
        [12] = 151311, -- Band of the Triumvirate (Seat of the Triumvirate)
        [13] = 193718, -- Emerald Coach's Whistle (Algeth'ar Academy)
        [14] = 250253, -- Whisper of the Duskwraith (Nexus-Point Xenas)
    },
    WARLOCK_AFFLICTION = {
        [16] = 251111, -- Splitshroud Stinger (Magister's Terrace)
        [17] = 251094, -- Sigil of the Restless Heart (Windrunner Spire)
        [1] = 250042, -- Abyssal Immolator's Smoldering Flames (Matrix Catalyst)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 251085, -- Mantle of Dark Devotion (Windrunner Spire)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 250045, -- Abyssal Immolator's Dreadrobe (Matrix Catalyst)
        [9] = 239648, -- Martyr's Bindings (Crafted by Tailoring)
        [10] = 250043, -- Abyssal Immolator's Grasps (Matrix Catalyst)
        [6] = 251102, -- Clasp of Compliance (Magister's Terrace)
        [7] = 250041, -- Abyssal Immolator's Pillars (Matrix Catalyst)
        [8] = 251167, -- Nightprey Stalkers (Maisara Caverns)
        [11] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 250144, -- Emberwing Feather (Windrunner Spire)
        [14] = 250256, -- Heart of Wind (Windrunner Spire)
    },
    WARLOCK_DEMONOLOGY = {
        [16] = 258047, -- Spire of the Furious Construct (Skyreach)
        [1] = 250042, -- Abyssal Immolator's Smoldering Flames (Matrix Catalyst)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 251085, -- Mantle of Dark Devotion (Windrunner Spire)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 250045, -- Abyssal Immolator's Dreadrobe (Matrix Catalyst)
        [9] = 239648, -- Martyr's Bindings (Crafted by Tailoring)
        [10] = 250043, -- Abyssal Immolator's Grasps (Matrix Catalyst)
        [6] = 151302, -- Cord of Unraveling Reality (Seat of the Triumvirate)
        [7] = 250041, -- Abyssal Immolator's Pillars (Matrix Catalyst)
        [8] = 251167, -- Nightprey Stalkers (Maisara Caverns)
        [11] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 250144, -- Emberwing Feather (Windrunner Spire)
        [14] = 250258, -- Vessel of Tortured Souls (Maisara Caverns)
    },
    WARLOCK_DESTRUCTION = {
        [16] = 258047, -- Spire of the Furious Construct (Skyreach)
        [1] = 250042, -- Abyssal Immolator's Smoldering Flames (Matrix Catalyst)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 251085, -- Mantle of Dark Devotion (Windrunner Spire)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 250045, -- Abyssal Immolator's Dreadrobe (Matrix Catalyst)
        [9] = 239648, -- Martyr's Bindings (Crafted by Tailoring)
        [10] = 250043, -- Abyssal Immolator's Grasps (Matrix Catalyst)
        [6] = 151302, -- Cord of Unraveling Reality (Seat of the Triumvirate)
        [7] = 250041, -- Abyssal Immolator's Pillars (Matrix Catalyst)
        [8] = 251167, -- Nightprey Stalkers (Maisara Caverns)
        [11] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 250256, -- Heart of Wind (Windrunner Spire)
        [14] = 250258, -- Vessel of Tortured Souls (Maisara Caverns)
    },
    WARRIOR_ARMS = {
        [16] = 49802, -- Garfrost's Two-Ton Hammer (Pit of Saron)
        [1] = 249952, -- Night Ender's Tusks (Matrix Catalyst)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 249950, -- Night Ender's Pauldrons (Matrix Catalyst)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 249955, -- Night Ender's Breastplate (Matrix Catalyst)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 151332, -- Voidclaw Gauntlets (Seat of the Triumvirate)
        [6] = 49808, -- Bent Gold Belt (Pit of Saron)
        [7] = 249951, -- Night Ender's Chausses (Matrix Catalyst)
        [8] = 251107, -- Oathsworn Stompers (Magister's Terrace)
        [11] = 49812, -- Purloined Wedding Ring (Pit of Saron)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
        [14] = 252420, -- Solarflare Prism (Skyreach)
    },
    WARRIOR_FURY = {
        [16] = 251117, -- Whirling Voidcleaver (Magister's Terrace)
        [17] = 237847, -- Blood Knight's Impetus (Crafted by Blacksmithing)
        [1] = 251098, -- Fletcher's Faded Faceplate (Windrunner Spire)
        [2] = 151309, -- Necklace of the Twisting Void (Seat of the Triumvirate)
        [3] = 251164, -- Amalgamation's Harness (Maisara Caverns)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [5] = 151329, -- Breastplate of the Dark Touch (Seat of the Triumvirate)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 151332, -- Voidclaw Gauntlets (Seat of the Triumvirate)
        [6] = 151327, -- Girdle of the Shadowguard (Seat of the Triumvirate)
        [7] = 251118, -- Legplates of Lingering Dusk (Magister's Terrace)
        [8] = 251107, -- Oathsworn Stompers (Magister's Terrace)
        [11] = 251115, -- Bifurcation Band (Magister's Terrace)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
        [14] = 252420, -- Solarflare Prism (Skyreach)
    },
    WARRIOR_PROTECTION = {
        [16] = 258525, -- Scepter of the Endless Night (Seat of the Triumvirate)
        [17] = 251105, -- Ward of the Spellbreaker (Magister's Terrace)
        [1] = 249952, -- Night Ender's Tusks (Matrix Catalyst)
        [2] = 151309, -- Necklace of the Twisting Void (Seat of the Triumvirate)
        [3] = 249950, -- Night Ender's Pauldrons (Matrix Catalyst)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted — Tailoring)
        [5] = 249955, -- Night Ender's Breastplate (Matrix Catalyst)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted — Blacksmithing)
        [10] = 151332, -- Voidclaw Gauntlets (Seat of the Triumvirate)
        [6] = 251086, -- Riphook Defender (Windrunner Spire)
        [7] = 249951, -- Night Ender's Chausses (Matrix Catalyst)
        [8] = 249954, -- Night Ender's Greatboots (Matrix Catalyst)
        [11] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
        [14] = 250256, -- Heart of Wind (Windrunner Spire)
    },
}

-- ============================================================================
-- BIS LISTS - RAID (from Icy Veins, Midnight Season 1)
-- ============================================================================
NS.BIS_RAID = {
    DEATHKNIGHT_BLOOD = {
        [16] = 251168, -- Liferipper's Cutlass (Maisara Caverns)
        [1] = 249970, -- Relentless Rider's Crown (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 249968, -- Relentless Rider's Dreadthorns (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [5] = 249973, -- Relentless Rider's Cuirass (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 151332, -- Voidclaw Gauntlets (Seat of the Triumvirate)
        [6] = 49808, -- Bent Gold Belt (Pit of Saron)
        [7] = 249969, -- Relentless Rider's Legguards (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249381, -- Greaves of the Unformed (Chimaerus in The Dreamrift)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 251513, -- Loa Worshiper's Band (Crafted by Jewelcrafting)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 249344, -- Light Company Guidon (Imperator Averzian in The Voidspire)
    },
    DEATHKNIGHT_FROST = {
        [16] = 249277, -- Bellamy's Final Judgement (Lightblinded Vanguard in The Voidspire)
        [17] = 249281, -- Blade of the Final Twilight (Fallen-King Salhadaar in The Voidspire)
        [1] = 249970, -- Relentless Rider's Crown (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 249337, -- Ribbon of Coiled Malice (Fallen-King Salhadaar in The Voidspire)
        [3] = 249313, -- Light-Judged Spaulders (Imperator Averzian in The Voidspire)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Leatherworking)
        [5] = 249973, -- Relentless Rider's Cuirass (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 249971, -- Relentless Rider's Bonegrasps (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 249380, -- Hate-Tied Waistchain (Crown of the Cosmos in The Voidspire)
        [7] = 249969, -- Relentless Rider's Legguards (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249381, -- Greaves of the Unformed (Chimaerus in The Dreamrift)
        [11] = 249336, -- Signet of the Starved Beast (Vorasius in The Voidspire)
        [12] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 249344, -- Light Company Guidon (Imperator Averzian in The Voidspire)
    },
    DEATHKNIGHT_UNHOLY = {
        [16] = 249277, -- Bellamy's Final Judgement (Lightblinded Vanguard in The Voidspire)
        [1] = 249970, -- Relentless Rider's Crown (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 249337, -- Ribbon of Coiled Malice (Fallen-King Salhadaar in The Voidspire)
        [3] = 249313, -- Light-Judged Spaulders (Imperator Averzian in The Voidspire)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Leatherworking)
        [5] = 249973, -- Relentless Rider's Cuirass (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 249971, -- Relentless Rider's Bonegrasps (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 249380, -- Hate-Tied Waistchain (Crown of the Cosmos in The Voidspire)
        [7] = 249969, -- Relentless Rider's Legguards (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249381, -- Greaves of the Unformed (Chimaerus in The Dreamrift)
        [11] = 249336, -- Signet of the Starved Beast (Vorasius in The Voidspire)
        [12] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 249344, -- Light Company Guidon (Imperator Averzian in The Voidspire)
    },
    DEMONHUNTER_DEVOURER = {
        [16] = 260408, -- Lightless Lament (Midnight Falls)
        [17] = 237840, -- Spellbreaker's Warglaive (Blacksmithing)
        [1] = 250033, -- Devouring Reaver's Intake (Lightblinded Vanguard)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos)
        [3] = 250031, -- Devouring Reaver's Exhaustplates (Fallen-King Salhadaar)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak)
        [5] = 250036, -- Devouring Reaver's Engine (Chimaerus)
        [9] = 249327, -- Void-Skinned Bracers (Vorasius)
        [10] = 250034, -- Devouring Reaver's Essence Grips (Vorasius)
        [6] = 244573, -- Silvermoon Agent's Utility Belt (Leatherworking)
        [7] = 249312, -- Nightblade's Pantaloons (Crown of the Cosmos)
        [8] = 249382, -- Canopy Walker's Footwraps (Crown of the Cosmos)
        [11] = 249369, -- Bond of Light (Lightblinded Vanguard)
        [12] = 249920, -- Eye of Midnight (Midnight Falls)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus)
        [14] = 249346, -- Vaelgor's Final Stare (Vaelgor and Ezzorak)
    },
    DEMONHUNTER_HAVOC = {
        [16] = 260408, -- Lightless Lament (Midnight Falls)
        [17] = 249280, -- Emblazoned Sunglaive (Vaelgor and Ezzorak)
        [1] = 249306, -- Devouring Night's Visage (Imperator Averzian)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Crown of the Cosmos)
        [3] = 250031, -- Devouring Reaver's Exhaustplates (Fallen-King Salhadaar)
        [15] = 239656, -- Adherent's Silken Shroud (Tailoring)
        [5] = 250036, -- Devouring Reaver's Engine (Chimaerus)
        [9] = 244576, -- Silvermoon Agent's Deflectors (Leatherworking)
        [10] = 250034, -- Devouring Reaver's Essence Grips (Vorasius)
        [6] = 249314, -- Twisted Twilight Sash (Fallen-King Salhadaar)
        [7] = 250032, -- Devouring Reaver's Pistons (Vaelgor and Ezzorak)
        [8] = 249382, -- Canopy Walker's Footwraps (Crown of the Cosmos)
        [11] = 249919, -- Sin'dorei Band of Hope (Belo'ren)
        [12] = 249336, -- Signet of the Starved Beast (Vorasius)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus)
        [14] = 260235, -- Umbral Plume (Belo'ren)
    },
    DEMONHUNTER_VENGEANCE = {
        [16] = 260408, -- Lightless Lament (Midnight Falls)
        [17] = 237840, -- Spellbreaker's Warglaive (Crafted by Blacksmithing)
        [1] = 250033, -- Devouring Reaver's Intake (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 250031, -- Devouring Reaver's Exhaustplates (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 249335, -- Imperator's Banner (Vaelgor and Ezzorak in The Voidspire)
        [5] = 249322, -- Radiant Clutchtender's Jerkin (Belo'ren in March on Quel'Danas)
        [9] = 244576, -- Silvermoon Agent's Deflectors (Crafted by Leatherworking)
        [10] = 250034, -- Devouring Reaver's Essence Grips (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 249374, -- Scorn-Scarred Shul'ka's Belt (Chimaerus in The Dreamrift)
        [7] = 250032, -- Devouring Reaver's Pistons (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249334, -- Void-Claimed Shinkickers (Imperator Averzian in The Voidspire)
        [11] = 249336, -- Signet of the Starved Beast (Vorasius in The Voidspire)
        [12] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [13] = 249344, -- Light Company Guidon (Imperator Averzian in The Voidspire)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
    },
    DRUID_BALANCE = {
        [16] = 249286, -- Brazier of the Dissonant Dirge (Midnight Falls in March on Quel'Danas)
        [17] = 249283, -- Belo'melorn, the Shattered Talon (Belo'ren & Vorasius)
        [1] = 250024, -- Branches of the Luminous Bloom (Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 250022, -- Seedpods of the Luminous Bloom (Fallen-King Salhadaar in The Voidspire)
        [15] = 250019, -- Leafdrape of the Luminous Bloom (Creation Catalyst)
        [5] = 250027, -- Trunk of the Luminous Bloom (Chimaerus in The Dreamrift)
        [9] = 249327, -- Void-Skinned Bracers (Vorasius in The Voidspire)
        [10] = 244575, -- Silvermoon Agent's Handwraps (Leatherworking)
        [6] = 249374, -- Scorn-Scarred Shul'ka's Belt (Chimaerus in The Dreamrift)
        [7] = 250023, -- Phloemwraps of the Luminous Bloom (Vaelgor and Ezzorak in The Voidspire)
        [8] = 244569, -- Silvermoon Agent's Sneakers (Leatherworking)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 249369, -- Bond of Light (Lightblinded Vanguard in The Voidspire)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 249346, -- Vaelgor's Final Stare (Vaelgor and Ezzorak)
    },
    DRUID_FERAL = {
        [16] = 249302, -- Inescapable Reach (Midnight Falls)
        [1] = 250024, -- Branches of the Luminous Bloom (Lightblinded Vanguard)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls)
        [3] = 250022, -- Seedpods of the Luminous Bloom (Fallen-King Salhadaar)
        [15] = 239656, -- Adherent's Silken Shroud (Tailoring)
        [5] = 250027, -- Trunk of the Luminous Bloom (Chimaerus)
        [9] = 244576, -- Silvermoon Agent's Deflectors (Leatherworking)
        [10] = 250025, -- Arbortenders of the Luminous Bloom (Vorasius)
        [6] = 249374, -- Scorn-Scarred Shul'ka's Belt (Chimaerus)
        [7] = 250023, -- Phloemwraps of the Luminous Bloom (Vaelgor and Ezzorak)
        [8] = 249382, -- Canopy Walker's Footwraps (Crown of the Cosmos)
        [11] = 249920, -- Eye of Midnight (Midnight Falls)
        [12] = 249369, -- Bond of Light (Lightblinded Vanguard)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus)
        [14] = 249806, -- Radiant Plume (Belo'ren)
    },
    DRUID_GUARDIAN = {
        [16] = 249278, -- Alnscorned Spire (Chimaerus in The Dreamrift)
        [1] = 249913, -- Mask of Darkest Intent (Midnight Falls)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 250022, -- Seedpods of the Luminous Bloom (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak in The Voidspire)
        [5] = 250027, -- Trunk of the Luminous Bloom (Chimaerus in The Dreamrift)
        [9] = 244576, -- Silvermoon Agent's Deflectors (Crafted by Leatherworking)
        [10] = 250025, -- Arbortenders of the Luminous Bloom (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 244573, -- Silvermoon Agent's Utility Belt (Crafted by Leatherworking)
        [7] = 250023, -- Phloemwraps of the Luminous Bloom (Vaelgor and Ezzorak in The Voidspire)
        [8] = 249334, -- Void-Claimed Shinkickers (Imperator Averzian in The Voidspire)
        [11] = 249920, -- Eye of Midnight (Midnight Falls)
        [12] = 249336, -- Signet of the Starved Beast (Vorasius in The Voidspire)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 249807, -- The Eternal Egg (Belo'ren)
    },
    DRUID_RESTORATION = {
        [16] = 249283, -- Belo'melorn, the Shattered Talon (Belo'ren - March on Quel'Danas)
        [17] = 249922, -- Tome of Alnscorned Regret (Chimaerus - Dreamrift)
        [1] = 249913, -- Mask of Darkest Intent (Midnight Falls - March on Quel'Danas)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls - March on Quel'Danas)
        [3] = 250022, -- Seedpods of the Luminous Bloom (Fallen-King Salhadaar - The Voidspire)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak - The Voidspire)
        [5] = 250027, -- Trunk of the Luminous Bloom (Chimaerus - Dreamrift)
        [9] = 250020, -- Bindings of the Luminous Bloom (Lightblinded Vanguard - The Voidspire)
        [10] = 250025, -- Arbortenders of the Luminous Bloom (Vorasius - The Voidspire)
        [6] = 249314, -- Twisted Twilight Sash (Fallen-King Salhadaar - The Voidspire)
        [7] = 250023, -- Phloemwraps of the Luminous Bloom (Vaelgor and Ezzorak - The Voidspire)
        [8] = 249334, -- Void-Claimed Shinkickers (Imperator Averzian - The Voidspire)
        [11] = 249369, -- Bond of Light (Lightblinded Vanguard - The Voidspire)
        [12] = 249920, -- Eye of Midnight (Midnight Falls - March on Quel'Danas)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus - Dreamrift)
        [14] = 249809, -- Locus-Walker's Ribbon (Crown of the Cosmos - The Voidspire)
    },
    EVOKER_AUGMENTATION = {
        [16] = 249283, -- Belo'melorn, the Shattered Talon (Belo'ren in March on Quel'Danas Lightblinded Vanguard in The Voidspire Vorasius in The Voidspire)
        [17] = 249294, -- Blade of the Blind Verdict (Belo'ren in March on Quel'Danas Lightblinded Vanguard in The Voidspire Vorasius in The Voidspire)
        [1] = 249914, -- Oblivion Guise (Midnight Falls in March on Quel'Danas Vorasius in The Voidspire)
        [2] = 249337, -- Ribbon of Coiled Malice (Fallen-King Salhadaar in The Voidspire)
        [3] = 249995, -- Beacons of the Black Talon (Matrix Catalyst , Fallen-King Salhadaar in The Voidspire .)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 250000, -- Frenzyward of the Black Talon (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 244584, -- Farstrider's Plated Bracers (Crafted by Leatherworking)
        [10] = 249998, -- Enforcer's Grips of the Black Talon (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 244581, -- Farstrider's Trophy Belt (Crafted by Leatherworking Chimaerus in The Dreamrift Lightblinded Vanguard in The Voidspire)
        [7] = 249996, -- Greaves of the Black Talon (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249377, -- Darkstrider Treads (Belo'ren in March on Quel'Danas)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas Crafted by Jewelcrafting Lightblinded Vanguard in The Voidspire Belo'ren in March on Quel'Danas)
        [12] = 240949, -- Masterwork Sin'dorei Band (Midnight Falls in March on Quel'Danas Crafted by Jewelcrafting Lightblinded Vanguard in The Voidspire Belo'ren in March on Quel'Danas)
        [13] = 249810, -- Shadow of the Empyrean Requiem (Midnight Falls in March on Quel'Danas Vaelgor and Ezzorak in The Voidspire)
        [14] = 249346, -- Vaelgor's Final Stare (Midnight Falls in March on Quel'Danas Vaelgor and Ezzorak in The Voidspire)
    },
    EVOKER_DEVASTATION = {
        [16] = 249294, -- Blade of the Blind Verdict (Lightblinded Vanguard in The Voidspire .)
        [17] = 249276, -- Grimoire of the Eternal Light (Vorasius in The Voidspire .)
        [1] = 249997, -- Hornhelm of the Black Talon (Matrix Catalyst , Lightblinded Vanguard in The Voidspire .)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas .)
        [3] = 249995, -- Beacons of the Black Talon (Matrix Catalyst , Fallen-King Salhadaar in The Voidspire .)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 250000, -- Frenzyward of the Black Talon (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 244584, -- Farstrider's Plated Bracers (Crafted by Leatherworking)
        [10] = 249325, -- Untethered Berserker's Grips (Crown of the Cosmos in The Voidspire)
        [6] = 249371, -- Scornbane Waistguard (Chimaerus in The Dreamrift)
        [7] = 249996, -- Greaves of the Black Talon (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249999, -- Spelltreads of the Black Talon (Matrix Catalyst .)
        [11] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas .)
        [12] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas .)
        [13] = 249809, -- Locus-Walker's Ribbon (Crown of the Cosmos in The Voidspire .)
        [14] = 249346, -- Vaelgor's Final Stare (Vaelgor and Ezzorak in The Voidspire .)
    },
    EVOKER_PRESERVATION = {
        [16] = 249286, -- Brazier of the Dissonant Dirge (Midnight Falls in The Voidspire)
        [1] = 249914, -- Oblivion Guise (Midnight Falls in March on Quel'Danas)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 249995, -- Beacons of the Black Talon (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak in The Voidspire)
        [5] = 250000, -- Frenzyward of the Black Talon (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 249304, -- Fallen King's Cuffs (Fallen-King Salhadaar in The Voidspire)
        [10] = 249998, -- Enforcer's Grips of the Black Talon (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 244611, -- World Tender's Barkclasp (Crafted by Leatherworking)
        [7] = 249996, -- Greaves of the Black Talon (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 244610, -- World Tender's Rootslippers (Crafted by Leatherworking)
        [11] = 249369, -- Bond of Light (Lightblinded Vanguard in The Voidspire)
        [12] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [13] = 249346, -- Vaelgor's Final Stare (Vaelgor and Ezzorak in The Voidspire)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
    },
    HUNTER_BEASTMASTERY = {
        [16] = 249279, -- Sunstrike Rifle (Imperator Averzian - Voidspire)
        [1] = 249988, -- Primal Sentry's Maw (Lightblinded Vanguard - Voidspire, or Matrix Catalyst)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls - March on Quel'Danas)
        [3] = 249318, -- Nullwalker's Dread Epaulettes (Vaelgor and Ezzorak - Voidspire)
        [15] = 249335, -- Imperator's Banner (Imperator Averzian - Voidspire)
        [5] = 249991, -- Primal Sentry's Scaleplate (Chimaerus - Dreamrift, or Matrix Catalyst)
        [9] = 249304, -- Fallen King's Cuffs (Fallen-King Salhadaar - Voidspire)
        [10] = 249989, -- Primal Sentry's Talonguards (Vorasius - Voidspire, or Matrix Catalyst)
        [6] = 244611, -- World Tender's Barkclasp (Leatherworking)
        [7] = 249987, -- Primal Sentry's Legguards (Vaelgor and Ezzorak - Voidspire, or Matrix Catalyst)
        [8] = 244610, -- World Tender's Rootslippers (Leatherworking)
        [11] = 249920, -- Eye of Midnight (Midnight Falls - March on Quel'Danas)
        [12] = 249369, -- Bond of Light (Lightblinded Vanguard - Voidspire)
        [13] = 249806, -- Radiant Plume (Belo'ren - March on Quel'Danas)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus - The Dreamrift)
    },
    HUNTER_MARKSMANSHIP = {
        [16] = 249288, -- Ranger-Captain's Lethal Recurve (Crown of the Cosmos - Voidspire)
        [1] = 249988, -- Primal Sentry's Maw (Lightblinded Vanguard - Voidspire, or Matrix Catalyst)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls - March on Quel'Danas)
        [3] = 249318, -- Nullwalker's Dread Epaulettes (Vaelgor and Ezzorak - Voidspire)
        [15] = 249335, -- Imperator's Banner (Imperator Averzian - Voidspire)
        [5] = 249991, -- Primal Sentry's Scaleplate (Chimaerus - Dreamrift, or Matrix Catalyst)
        [9] = 249304, -- Fallen King's Cuffs (Fallen-King Salhadaar - Voidspire)
        [10] = 249989, -- Primal Sentry's Talonguards (Vorasius - Voidspire, or Matrix Catalyst)
        [6] = 244611, -- World Tender's Barkclasp (Leatherworking)
        [7] = 249987, -- Primal Sentry's Legguards (Vaelgor and Ezzorak - Voidspire, or Matrix Catalyst)
        [8] = 244610, -- World Tender's Rootslippers (Leatherworking)
        [11] = 249336, -- Signet of the Starved Beast (Vorasius - Voidspire)
        [12] = 249919, -- Sin'dorei Band of Hope (Belo'ren - March on Quel'Danas)
        [13] = 260235, -- Umbral Plume (Belo'ren - March on Quel'Danas)
        [14] = 249344, -- Light Company Guidon (Imperator Averzian - Voidspire)
    },
    HUNTER_SURVIVAL = {
        [16] = 249302, -- Inescapable Reach (Vorasius - Voidspire)
        [17] = 249925, -- Hungering Victory (Vorasius - Voidspire)
        [1] = 249988, -- Primal Sentry's Maw (Lightblinded Vanguard - Voidspire, or Matrix Catalyst)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls - March on Quel'Danas)
        [3] = 249318, -- Nullwalker's Dread Epaulettes (Vaelgor and Ezzorak - Voidspire)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak - Voidspire)
        [5] = 249991, -- Primal Sentry's Scaleplate (Chimaerus - Dreamrift, or Matrix Catalyst)
        [9] = 244584, -- Farstrider's Plated Bracers (Leatherworking)
        [10] = 249989, -- Primal Sentry's Talonguards (Vorasius - Voidspire, or Matrix Catalyst)
        [6] = 244611, -- World Tender's Barkclasp (Leatherworking)
        [7] = 249987, -- Primal Sentry's Legguards (Vaelgor and Ezzorak - Voidspire, or Matrix Catalyst)
        [8] = 244610, -- World Tender's Rootslippers (Leatherworking)
        [11] = 249920, -- Eye of Midnight (Midnight Falls - March on Quel'Danas)
        [12] = 249369, -- Bond of Light (Lightblinded Vanguard - Voidspire, or Matrix Catalyst)
        [13] = 249806, -- Radiant Plume (Belo'ren - March on Quel'Danas)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus - The Dreamdrift)
    },
    MAGE_ARCANE = {
        [16] = 249286, -- Brazier of the Dissonant Dirge (Midnight Falls in March on Quel'Danas)
        [17] = 251094, -- Sigil of the Restless Heart (The Great Vault / Windrunner Spire)
        [1] = 250060, -- Voidbreaker's Veil (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 250058, -- Voidbreaker's Leyline Nexi (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 239661, -- Arcanoweave Cloak (Crafted by Tailoring)
        [5] = 250063, -- Voidbreaker's Robe (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 239660, -- Arcanoweave Bracers (Crafted by Tailoring)
        [10] = 250061, -- Voidbreaker's Gloves (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 249376, -- Whisper-Inscribed Sash (Belo'ren in March on Quel'Danas)
        [7] = 249323, -- Leggings of the Devouring Advance (Imperator Averzian in The Voidspire)
        [8] = 249373, -- Dream-Scorched Striders (Chimaerus in The Dreamrift)
        [11] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [12] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 249346, -- Vaelgor's Final Stare (Vaelgor and Ezzorak in The Voidspire)
    },
    MAGE_FIRE = {
        [16] = 249286, -- Brazier of the Dissonant Dirge (Midnight Falls in March on Quel'Danas)
        [17] = 258472, -- Rukhran's Solar Reliquary (Windrunner Spire)
        [1] = 250060, -- Voidbreaker's Veil (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 250058, -- Voidbreaker's Leyline Nexi (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring with Arcanoweave Lining and Haste + Mastery)
        [5] = 249912, -- Robes of Endless Oblivion (Midnight Falls in March on Quel'Danas)
        [9] = 239648, -- Martyr's Bindings (Crafted by Tailoring with Arcanoweave Lining and Haste + Mastery)
        [10] = 250061, -- Voidbreaker's Gloves (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 249376, -- Whisper-Inscribed Sash (Belo'ren in March on Quel'Danas)
        [7] = 250059, -- Voidbreaker's Britches (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 250062, -- Voidbreaker's Treads (Matrix Catalyst on any pair of boots, or The Great Vault)
        [11] = 249369, -- Bond of Light (Lightblinded Vanguard in The Voidspire)
        [12] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [13] = 249809, -- Locus-Walker's Ribbon (Crown of the Cosmos in The Voidspire)
        [14] = 249346, -- Vaelgor's Final Stare (Vaelgor and Ezzorak in The Voidspire)
    },
    MAGE_FROST = {
        [16] = 245770, -- Aln'hara Cane (Inscription)
        [17] = 245769, -- Aln'hara Lantern (Inscription)
        [1] = 250060, -- Voidbreaker's Veil (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 249328, -- Echoing Void Mantle (Belo'ren in March on Quel'Danas)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak in The Voidspire)
        [5] = 250063, -- Voidbreaker's Robe (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 239648, -- Martyr's Bindings (Tailoring)
        [10] = 250061, -- Voidbreaker's Gloves (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 250057, -- Voidbreaker's Sage Cord (Matrix Catalyst)
        [7] = 250059, -- Voidbreaker's Britches (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249373, -- Dream-Scorched Striders (Chimaerus in The Dreamrift)
        [11] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [12] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [13] = 249346, -- Vaelgor's Final Stare (Vaelgor and Ezzorak in The Voidspire)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
    },
    MONK_BREWMASTER = {
        [16] = 249302, -- Inescapable Reach (Vorasius ( The Voidspire ))
        [17] = 260423, -- Arator's Swift Remembrance (Crown of the Cosmos ( The Voidspire ) Vaelgor and Ezzorak ( The Voidspire ))
        [1] = 250015, -- Fearsome Visage of Ra-den's Chosen (Lightblinded Vanguard ( March on Quel'Danas ))
        [2] = 240950, -- Masterwork Sin'dorei Amulet (Jewelcrafting ( see note ))
        [3] = 250013, -- Aurastones of Ra-den's Chosen (Fallen-King Salhadaar ( The Voidspire ))
        [15] = 249335, -- Imperator's Banner (Imperator Averzian ( The Voidspire ))
        [5] = 250018, -- Battle Garb of Ra-den's Chosen (Chimaerus ( The Dreamrift ))
        [9] = 249327, -- Void-Skinned Bracers (Vorasius ( The Voidspire ))
        [10] = 250016, -- Thunderfists of Ra-den's Chosen (> Vorasius ( The Voidspire ))
        [6] = 249314, -- Twisted Twilight Sash (Fallen-King Salhadaar ( The Voidspire ))
        [7] = 249312, -- Nightblade's Pantaloons (Crown of the Cosmos ( The Voidspire ))
        [8] = 249382, -- Canopy Walker's Footwraps (Crown of the Cosmos ( The Voidspire ))
        [11] = 249336, -- Signet of the Starved Beast (Vorasius ( The Voidspire ))
        [12] = 251513, -- Loa Worshiper's Band (Jewelcrafting)
        [13] = 249806, -- Radiant Plume (Belo'ren ( March on Quel'Danas ) Chimaerus ( The Dreamrift ) Vaelgor and Ezzorak ( The Voidspire ) Belo'ren ( March on Quel'Danas ))
        [14] = 249343, -- Gaze of the Alnseer (Belo'ren ( March on Quel'Danas ) Chimaerus ( The Dreamrift ) Vaelgor and Ezzorak ( The Voidspire ) Belo'ren ( March on Quel'Danas ))
    },
    MONK_MISTWEAVER = {
        [16] = 249293, -- Weight of Command (Imperator Averzian in The Voidspire)
        [17] = 249276, -- Grimoire of the Eternal Light (Vorasius in The Voidspire)
        [1] = 249913, -- Mask of Darkest Intent (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 249337, -- Ribbon of Coiled Malice (Fallen-King Salhadaar in The Voidspire)
        [3] = 250013, -- Aurastones of Ra-den's Chosen (Fallen-King Salhadaar in The Voidspire)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 250018, -- Battle Garb of Ra-den's Chosen (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 244576, -- Silvermoon Agent's Deflectors (Crafted by Leatherworking)
        [10] = 250016, -- Thunderfists of Ra-den's Chosen (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 249374, -- Scorn-Scarred Shul'ka's Belt (Chimaerus in The Dreamrift)
        [7] = 250014, -- Swiftsweepers of Ra-den's Chosen (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249334, -- Void-Claimed Shinkickers (Imperator Averzian in The Voidspire)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 249336, -- Signet of the Starved Beast (Vorasius in The Voidspire)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 249341, -- Volatile Void Suffuser (Fallen-King Salhadaar in The Voidspire)
    },
    MONK_WINDWALKER = {
        [16] = 249302, -- Inescapable Reach (Vorasius)
        [17] = 260423, -- Arator's Swift Remembrance (Crown of the Cosmos)
        [1] = 250015, -- Fearsome Visage of Ra-den's Chosen (Matrix Catalyst , or Lightblinded Vanguard - The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls)
        [3] = 250013, -- Aurastones of Ra-den's Chosen (Matrix Catalyst , or Fallen-King Salhadaar - The Voidspire)
        [15] = 250010, -- Windwrap of Ra-den's Chosen (Matrix Catalyst)
        [5] = 250018, -- Battle Garb of Ra-den's Chosen (Matrix Catalyst , or Chimaerus - The Dreamrift)
        [9] = 249327, -- Void-Skinned Bracers (Vorasius)
        [10] = 249321, -- Vaelgor's Fearsome Grasp (Vaelgor and Ezzorak)
        [6] = 249374, -- Scorn-Scarred Shul'ka's Belt (Chimaerus)
        [7] = 250014, -- Swiftsweepers of Ra-den's Chosen (Matrix Catalyst , or Vaelgor and Ezzorak - The Voidspire)
        [8] = 250017, -- Storm Crashers of Ra-den's Chosen (Matrix Catalyst)
        [11] = 251513, -- Loa Worshiper's Band (Jewelcrafting)
        [12] = 249920, -- Eye of Midnight (Midnight Falls)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus)
        [14] = 249806, -- Radiant Plume (Belo'ren)
    },
    PALADIN_HOLY = {
        [16] = 249294, -- Blade of the Blind Verdict (Lightblinded Vanguard in The Voidspire)
        [17] = 249921, -- Thalassian Dawnguard (Belo'ren in March on Quel'Danas)
        [1] = 249961, -- Luminant Verdict's Unwavering Gaze (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 249959, -- Luminant Verdict's Providence Watch (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 249964, -- Luminant Verdict's Divine Warplate (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 249962, -- Luminant Verdict's Gauntlets (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 249331, -- Ezzorak's Gloombind (Vaelgor and Ezzorak in The Voidspire)
        [7] = 249915, -- Extinction Guards (Midnight Falls in March on Quel'Danas)
        [8] = 249332, -- Parasite Stompers (Vorasius in The Voidspire)
        [11] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [12] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [13] = 249346, -- Vaelgor's Final Stare (Vaelgor and Ezzorak in The Voidspire)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
    },
    PALADIN_PROTECTION = {
        [16] = 249295, -- Turalyon's False Echo (Crown of the Cosmos in The Voidspire)
        [17] = 249275, -- Bulwark of Noble Resolve (Imperator Averzian in The Voidspire)
        [1] = 249961, -- Luminant Verdict's Unwavering Gaze (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 249337, -- Ribbon of Coiled Malice (Fallen-King Salhadaar in The Voidspire)
        [3] = 249959, -- Luminant Verdict's Providence Watch (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 249335, -- Imperator's Banner (Imperator Averzian in The Voidspire)
        [5] = 249309, -- Sunbound Breastplate (Crown of the Cosmos in The Voidspire)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 249962, -- Luminant Verdict's Gauntlets (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 249331, -- Ezzorak's Gloombind (Vaelgor and Ezzorak in The Voidspire)
        [7] = 249960, -- Luminant Verdict's Greaves (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249332, -- Parasite Stompers (Vorasius in The Voidspire)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 251513, -- Loa Worshiper's Band (Crafted by Jewelcrafting)
        [13] = 260235, -- Umbral Plume (Belo'ren in March on Quel'Danas)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
    },
    PALADIN_RETRIBUTION = {
        [16] = 249277, -- Bellamy's Final Judgement (Lightblinded Vanguard in The Voidspire)
        [1] = 249961, -- Luminant Verdict's Unwavering Gaze (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 249959, -- Luminant Verdict's Providence Watch (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 249964, -- Luminant Verdict's Divine Warplate (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 249307, -- Emberborn Grasps (Belo'ren in March on Quel'Danas)
        [6] = 249380, -- Hate-Tied Waistchain (Crown of the Cosmos in The Voidspire)
        [7] = 249960, -- Luminant Verdict's Greaves (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249381, -- Greaves of the Unformed (Chimaerus in The Dreamrift)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 249806, -- Radiant Plume (Belo'ren in March on Quel'Danas)
    },
    PRIEST_DISCIPLINE = {
        [16] = 249283, -- Belo'melorn, the Shattered Talon (Belo'ren in March on Quel'Danas)
        [17] = 245769, -- Aln'hara Lantern (Crafted by Inscription)
        [1] = 250051, -- Blind Oath's Winged Crest (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 250049, -- Blind Oath's Seraphguards (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak in The Voidspire)
        [5] = 249912, -- Robes of Endless Oblivion (Midnight Falls in March on Quel'Danas)
        [9] = 249315, -- Voracious Wristwraps (Vorasius in The Voidspire)
        [10] = 250052, -- Blind Oath's Touch (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 239664, -- Arcanoweave Cord (Crafted by Tailoring)
        [7] = 250050, -- Blind Oath's Leggings (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249305, -- Slippers of the Midnight Flame (Vaelgor and Ezzorak in The Voidspire)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 249369, -- Bond of Light (Lightblinded Vanguard in The Voidspire)
        [13] = 249346, -- Vaelgor's Final Stare (Vaelgor and Ezzorak in The Voidspire)
        [14] = 249341, -- Volatile Void Suffuser (Fallen-King Salhadaar in The Voidspire)
    },
    PRIEST_HOLY = {
        [16] = 245770, -- Aln'hara Cane (Crafted with Inscription Imperator Averzian in The Voidspire)
        [17] = 249276, -- Grimoire of the Eternal Light (Vorasius in The Voidspire)
        [1] = 250051, -- Blind Oath's Winged Crest (Lightblinded Vanguard in The Voidspire / Matrix Catalyst)
        [2] = 249337, -- Ribbon of Coiled Malice (Fallen-King Salhadaar in The Voidspire Midnight Falls in March on Quel'Danas)
        [3] = 250049, -- Blind Oath's Seraphguards (Fallen-King Salhadaar in The Voidspire / Matrix Catalyst)
        [15] = 249335, -- Imperator's Banner (Imperator Averzian in The Voidspire)
        [5] = 250054, -- Blind Oath's Raiment (Chimaerus in The Dreamrift / Matrix Catalyst)
        [9] = 250047, -- Blind Oath's Wraps (Matrix Catalyst any bracer)
        [10] = 250052, -- Blind Oath's Touch (Vorasius in The Voidspire / Matrix Catalyst)
        [6] = 239664, -- Arcanoweave Cord (Crafted with Tailoring)
        [7] = 249323, -- Leggings of the Devouring Advance (Imperator Averzian in The Voidspire)
        [8] = 249373, -- Dream-Scorched Striders (Chimaerus in The Dreamrift)
        [11] = 249336, -- Signet of the Starved Beast (Vorasius in The Voidspire)
        [12] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [13] = 249808, -- Litany of Lightblind Wrath (Lightblinded Vanguard in The Voidspire Crown of the Cosmos in The Voidspire)
        [14] = 249809, -- Locus-Walker's Ribbon (Lightblinded Vanguard in The Voidspire Crown of the Cosmos in The Voidspire)
    },
    PRIEST_SHADOW = {
        [16] = 249283, -- Belo'melorn, the Shattered Talon (Belo'ren in March on Quel'Danas Chimaerus in The Dreamrift Midnight Falls in March on Quel'Danas)
        [17] = 249922, -- Tome of Alnscorned Regret (Belo'ren in March on Quel'Danas Chimaerus in The Dreamrift Midnight Falls in March on Quel'Danas)
        [1] = 250051, -- Blind Oath's Winged Crest (Lightblinded Vanguard in The Voidspire)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 250049, -- Blind Oath's Seraphguards (Fallen-King Salhadaar in The Voidspire)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak in Voidspire)
        [5] = 250054, -- Blind Oath's Raiment (Chimaerus in The Dreamrift)
        [9] = 249315, -- Voracious Wristwraps (Vorasius in Voidspire)
        [10] = 249330, -- War Chaplain's Grips (Lightblinded Vanguard in Voidspire)
        [6] = 249376, -- Whisper-Inscribed Sash (Belo'ren in March on Quel'Danas)
        [7] = 250050, -- Blind Oath's Leggings (Vaelgor and Ezzorak in Voidspire)
        [8] = 249373, -- Dream-Scorched Striders (Chimaerus in The Dreamrift)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas Lightblinded Vanguard in Voidspire)
        [12] = 249369, -- Bond of Light (Midnight Falls in March on Quel'Danas Lightblinded Vanguard in Voidspire)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift Vaelgor and Ezzorak in The Voidspire Midnight Falls in March on Quel'Danas)
        [14] = 249346, -- Vaelgor's Final Stare (Chimaerus in The Dreamrift Vaelgor and Ezzorak in The Voidspire Midnight Falls in March on Quel'Danas)
    },
    ROGUE_ASSASSINATION = {
        [16] = 249925, -- Hungering Victory (Vorasius in The Voidspire)
        [17] = 237837, -- Farstrider's Mercy (Crafted by Blacksmithing)
        [1] = 250006, -- Masquerade of the Grim Jest (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 249337, -- Ribbon of Coiled Malice (Fallen-King Salhadaar in The Voidspire)
        [3] = 250004, -- Venom Casks of the Grim Jest (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak in The Voidspire)
        [5] = 250009, -- Fantastic Finery of the Grim Jest (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 244576, -- Silvermoon Agent's Deflectors (Crafted by Leatherworking)
        [10] = 250007, -- Sleight of Hand of the Grim Jest (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 249374, -- Scorn-Scarred Shul'ka's Belt (Chimaerus in The Dreamrift)
        [7] = 249312, -- Nightblade's Pantaloons (Crown of the Cosmos in The Voidspire)
        [8] = 249382, -- Canopy Walker's Footwraps (Crown of the Cosmos in The Voidspire)
        [11] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [12] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [13] = 249806, -- Radiant Plume (Belo'ren in March on Quel'Danas)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
    },
    ROGUE_OUTLAW = {
        [16] = 260423, -- Arator's Swift Remembrance (Crown of the Cosmos in The Voidspire)
        [17] = 249284, -- Belo'ren's Swift Talon (Belo'ren in March on Quel'Danas)
        [1] = 249913, -- Mask of Darkest Intent (Midnight Falls in March on Quel'Danas)
        [2] = 249337, -- Ribbon of Coiled Malice (Fallen-King Salhadaar in The Voidspire)
        [3] = 250004, -- Venom Casks of the Grim Jest (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 249335, -- Imperator's Banner (Imperator Averzian in The Voidspire)
        [5] = 250009, -- Fantastic Finery of the Grim Jest (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 249327, -- Void-Skinned Bracers (Vorasius in The Voidspire)
        [10] = 250007, -- Sleight of Hand of the Grim Jest (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 249374, -- Scorn-Scarred Shul'ka's Belt (Chimaerus in The Dreamrift)
        [7] = 250005, -- Blade Holsters of the Grim Jest (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 244569, -- Silvermoon Agent's Sneakers (Crafted by Leatherworking)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 240949, -- Masterwork Sin'dorei Band (Crafted by Jewelcrafting)
        [13] = 260235, -- Umbral Plume (Belo'ren in March on Quel'Danas)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
    },
    ROGUE_SUBTLETY = {
        [16] = 249925, -- Hungering Victory (Vorasius in The Voidspire)
        [17] = 249925, -- Hungering Victory (Vorasius in The Voidspire)
        [1] = 250006, -- Masquerade of the Grim Jest (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 250004, -- Venom Casks of the Grim Jest (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak in The Voidspire)
        [5] = 250009, -- Fantastic Finery of the Grim Jest (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 249327, -- Void-Skinned Bracers (Vorasius in The Voidspire)
        [10] = 250007, -- Sleight of Hand of the Grim Jest (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 249374, -- Scorn-Scarred Shul'ka's Belt (Chimaerus in The Dreamrift)
        [7] = 249312, -- Nightblade's Pantaloons (Crown of the Cosmos in The Voidspire)
        [8] = 249382, -- Canopy Walker's Footwraps (Crown of the Cosmos in The Voidspire)
        [11] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [12] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [13] = 249344, -- Light Company Guidon (Imperator Averzian in The Voidspire)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
    },
    SHAMAN_ELEMENTAL = {
        [16] = 249283, -- Belo'melorn, the Shattered Talon (Belo'ren in March on Quel'Danas)
        [17] = 251105, -- Ward of the Spellbreaker (Magister's Terrace)
        [1] = 249979, -- Locus of the Primal Core (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 249977, -- Tempests of the Primal Core (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak in The Voidspire)
        [5] = 249982, -- Embrace of the Primal Core (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 249304, -- Fallen King's Cuffs (Fallen-King Salhadaar in The Voidspire)
        [10] = 249980, -- Earthgrips of the Primal Core (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 244611, -- World Tender's Barkclasp (Crafted by Leatherworking)
        [7] = 249324, -- Eternal Flame Scaleguards (Belo'ren March on Quel'Danas)
        [8] = 244610, -- World Tender's Rootslippers (Crafted by Leatherworking)
        [11] = 249369, -- Bond of Light (Lightblinded Vanguard in The Voidspire)
        [12] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [13] = 249346, -- Vaelgor's Final Stare (Vaelgor and Ezzorak in The Voidspire)
        [14] = 249809, -- Locus-Walker's Ribbon (Crown of the Cosmos in The Voidspire)
    },
    SHAMAN_ENHANCEMENT = {
        [16] = 249287, -- Clutchmates' Caress (Vaelgor and Ezzorak)
        [17] = 237850, -- Farstrider's Chopper (Blacksmithing)
        [1] = 249979, -- Locus of the Primal Core (Lightblinded Vanguard)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls)
        [3] = 249977, -- Tempests of the Primal Core (Fallen-King Salhadaar)
        [15] = 239656, -- Adherent's Silken Shroud (Tailoring)
        [5] = 249982, -- Embrace of the Primal Core (Chimaerus)
        [9] = 249304, -- Fallen King's Cuffs (Fallen-King Salhadaar)
        [10] = 249980, -- Earthgrips of the Primal Core (Vorasius)
        [6] = 249976, -- Ceinture of the Primal Core (Matrix Catalyst)
        [7] = 249324, -- Eternal Flame Scaleguards (Belo'ren)
        [8] = 249981, -- Sollerets of the Primal Core (Matrix Catalyst)
        [11] = 249920, -- Eye of Midnight (Midnight Falls)
        [12] = 249369, -- Bond of Light (Lightblinded Vanguard)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus)
        [14] = 249806, -- Radiant Plume (Belo'ren)
    },
    SHAMAN_RESTORATION = {
        [16] = 249293, -- Weight of Command (Imperator Averzian in The Voidspire)
        [17] = 249921, -- Thalassian Dawnguard (Belo'ren in March on Quel'Danas)
        [1] = 249914, -- Oblivion Guise (Midnight Falls in March on Quel'Danas)
        [2] = 249337, -- Ribbon of Coiled Malice (Fallen-King Salhadaar in The Voidspire)
        [3] = 249977, -- Tempests of the Primal Core (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 249974, -- Guardian of the Primal Core (Matrix Catalyst)
        [5] = 249982, -- Embrace of the Primal Core (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 249975, -- Cuffs of the Primal Core (Matrix Catalyst)
        [10] = 249980, -- Earthgrips of the Primal Core (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 244611, -- World Tender's Barkclasp (Crafted by Leatherworking)
        [7] = 249978, -- Leggings of the Primal Core (Matrix Catalyst , or Vaelgor and Ezzorak in The Dreamrift)
        [8] = 244610, -- World Tender's Rootslippers (Crafted by Leatherworking)
        [11] = 151308, -- Eredath Seal of Nobility (Seat of the Triumvirate)
        [12] = 151311, -- Band of the Triumvirate (Seat of the Triumvirate)
        [13] = 249808, -- Litany of Lightblind Wrath (Lightblinded Vanguard in The Voidspire)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
    },
    WARLOCK_AFFLICTION = {
        [16] = 249283, -- Belo'melorn, the Shattered Talon (Belo'ren in March on Quel'Danas)
        [17] = 249276, -- Grimoire of the Eternal Light (Vorasius in The Voidspire)
        [1] = 250042, -- Abyssal Immolator's Smoldering Flames (Lightblinded Vanguard in The Voidspire or Matrix Catalyst)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 249328, -- Echoing Void Mantle (Belo'ren in March on Quel'Danas)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 250045, -- Abyssal Immolator's Dreadrobe (Chimaerus in The Dreamrift or Matrix Catalyst)
        [9] = 239648, -- Martyr's Bindings (Crafted by Tailoring)
        [10] = 250043, -- Abyssal Immolator's Grasps (Vorasius in The Voidspire or Matrix Catalyst)
        [6] = 249319, -- Endless March Waistwrap (Imperator Averzian in The Voidspire)
        [7] = 250041, -- Abyssal Immolator's Pillars (Vaelgor and Ezzorak in The Voidspire or Matrix Catalyst)
        [8] = 249305, -- Slippers of the Midnight Flame (Vaelgor and Ezzorak in The Voidspire)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [13] = 249810, -- Shadow of the Empyrean Requiem (Midnight Falls in March on Quel'Danas)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
    },
    WARLOCK_DEMONOLOGY = {
        [16] = 249286, -- Brazier of the Dissonant Dirge (Midnight Falls in March on Quel'Danas)
        [1] = 250042, -- Abyssal Immolator's Smoldering Flames (Lightblinded Vanguard in The Voidspire or Matrix Catalyst)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 250040, -- Abyssal Immolator's Fury (Fallen-King Salhadaar in The Voidspire or Matrix Catalyst)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 250045, -- Abyssal Immolator's Dreadrobe (Chimaerus in The Dreamrift or Matrix Catalyst)
        [9] = 239648, -- Martyr's Bindings (Crafted by Tailoring)
        [10] = 250043, -- Abyssal Immolator's Grasps (Vorasius in The Voidspire or Matrix Catalyst)
        [6] = 249319, -- Endless March Waistwrap (Imperator Averzian in The Voidspire)
        [7] = 250041, -- Abyssal Immolator's Pillars (Vaelgor and Ezzorak in The Voidspire or Matrix Catalyst)
        [8] = 249373, -- Dream-Scorched Striders (Chimaerus in The Dreamrift)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 249336, -- Signet of the Starved Beast (Vorasius in The Voidspire)
        [13] = 249346, -- Vaelgor's Final Stare (Vaelgor and Ezzorak in The Voidspire)
        [14] = 249809, -- Locus-Walker's Ribbon (Crown of the Cosmos in The Voidspire)
    },
    WARLOCK_DESTRUCTION = {
        [16] = 249286, -- Brazier of the Dissonant Dirge (Midnight Falls in March on Quel'Danas)
        [1] = 250042, -- Abyssal Immolator's Smoldering Flames (Lightblinded Vanguard in The Voidspire or Matrix Catalyst)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 250040, -- Abyssal Immolator's Fury (Fallen-King Salhadaar in The Voidspire or Matrix Catalyst)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 250045, -- Abyssal Immolator's Dreadrobe (Chimaerus in The Dreamrift or Matrix Catalyst)
        [9] = 239648, -- Martyr's Bindings (Crafted by Tailoring)
        [10] = 250043, -- Abyssal Immolator's Grasps (Vorasius in The Voidspire or Matrix Catalyst)
        [6] = 249319, -- Endless March Waistwrap (Imperator Averzian in The Voidspire)
        [7] = 250041, -- Abyssal Immolator's Pillars (Vaelgor and Ezzorak in The Voidspire or Matrix Catalyst)
        [8] = 249305, -- Slippers of the Midnight Flame (Vaelgor and Ezzorak in The Voidspire)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 249336, -- Signet of the Starved Beast (Vorasius in The Voidspire)
        [13] = 249346, -- Vaelgor's Final Stare (Vaelgor and Ezzorak in The Voidspire)
        [14] = 249810, -- Shadow of the Empyrean Requiem (Midnight Falls in March on Quel'Danas)
    },
    WARRIOR_ARMS = {
        [16] = 249296, -- Alah'endal, the Dawnsong (Midnight Falls in March on Quel'Danas)
        [1] = 249952, -- Night Ender's Tusks (Lightblinded Vanguard in The Voidspire)
        [2] = 249337, -- Ribbon of Coiled Malice (Fallen-King Salhadaar in The Voidspire)
        [3] = 249950, -- Night Ender's Pauldrons (Fallen-King Salhadaar in The Voidspire)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 249955, -- Night Ender's Breastplate (Chimaerus in The Dreamrift)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 249307, -- Emberborn Grasps (Belo'ren in March on Quel'Danas)
        [6] = 249949, -- Night Ender's Girdle (Matrix Catalyst)
        [7] = 249951, -- Night Ender's Chausses (Vaelgor and Ezzorak in The Voidspire)
        [8] = 249381, -- Greaves of the Unformed (Chimaerus in The Dreamrift)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 249342, -- Heart of Ancient Hunger (Vorasius in The Voidspire)
    },
    WARRIOR_FURY = {
        [16] = 249277, -- Bellamy's Final Judgement (Lightblinded Vanguard in The Voidspire)
        [17] = 237847, -- Blood Knight's Impetus (Crafted by Blacksmithing)
        [1] = 249952, -- Night Ender's Tusks (Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 249950, -- Night Ender's Pauldrons (Fallen-King Salhadaar in The Voidspire)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak in The Voidspire)
        [5] = 249955, -- Night Ender's Breastplate (Chimaerus in The Dreamrift)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 251081, -- Embergrove Grasps (Windrunner Spire)
        [6] = 249949, -- Night Ender's Girdle (Matrix Catalyst)
        [7] = 249951, -- Night Ender's Chausses (Vaelgor and Ezzorak in The Voidspire)
        [8] = 249954, -- Night Ender's Greatboots (Matrix Catalyst)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 249342, -- Heart of Ancient Hunger (Vorasius in The Voidspire)
    },
    WARRIOR_PROTECTION = {
        [16] = 249295, -- Turalyon's False Echo (Crown of the Cosmos in The Voidspire)
        [17] = 249275, -- Bulwark of Noble Resolve (Imperator Averzian in The Voidspire)
        [1] = 249952, -- Night Ender's Tusks (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 249950, -- Night Ender's Pauldrons (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted — Tailoring)
        [5] = 249955, -- Night Ender's Breastplate (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted — Blacksmithing)
        [10] = 249307, -- Emberborn Grasps (Belo'ren in March on Quel'Danas)
        [6] = 249949, -- Night Ender's Girdle (Matrix Catalyst / Vaelgor and Ezzorak in The Voidspire)
        [7] = 249951, -- Night Ender's Chausses (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249954, -- Night Ender's Greatboots (Matrix Catalyst)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 249369, -- Bond of Light (Lightblinded Vanguard in The Voidspire)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 249806, -- Radiant Plume (Belo'ren in March on Quel'Danas)
    },
}

-- ============================================================================
-- #37: TIER SET CONSTANTS
-- Standard 5 tier set slots: Head, Shoulders, Chest, Hands, Legs
-- ============================================================================
NS.TIER_SET_SLOTS = { 1, 3, 5, 10, 7 } -- head, shoulders, chest, hands, legs

-- Catalyst currency ID (Renascent Shadowflame for Midnight Season 1)
-- Update this for each season as needed
NS.CATALYST_CURRENCY_ID = 2813

-- Note: NS.BIS_RAID is defined above with actual data.
-- Populated by: python scrape_bis.py --output Data.lua

-- ============================================================================
-- DUNGEON LOOT TABLES
-- Extracted from BIS lists: items whose source is a M+ dungeon
-- ============================================================================
NS.DUNGEON_LOOT = {
    -- Algeth'ar Academy (22 items)
    ALGETHAR = {
        { itemId = 193720, itemName = "Bronze Challenger's Robe", boss = "Crawth" },
        { itemId = 193722, itemName = "Azure Belt of Competition", boss = "Crawth" },
        { itemId = 193721, itemName = "Ruby Contestant's Gloves", boss = "Crawth" },
        { itemId = 193718, itemName = "Emerald Coach's Whistle", boss = "Crawth" },
        { itemId = 193719, itemName = "Dragon Games Equipment", boss = "Crawth" },
        { itemId = 193723, itemName = "Obsidian Goaltending Spire", boss = "Crawth" },
        { itemId = 193703, itemName = "Organized Pontificator's Mask", boss = "Echo of Doragosa" },
        { itemId = 193704, itemName = "Scaled Commencement Spaulders", boss = "Echo of Doragosa" },
        { itemId = 193705, itemName = "Breastplate of Proven Knowledge", boss = "Echo of Doragosa" },
        { itemId = 193706, itemName = "Venerated Professor's Greaves", boss = "Echo of Doragosa" },
        { itemId = 193701, itemName = "Algeth'ar Puzzle Box", boss = "Echo of Doragosa" },
        { itemId = 193707, itemName = "Final Grade", boss = "Echo of Doragosa" },
        { itemId = 193715, itemName = "Boots of Explosive Growth", boss = "Overgrown Ancient" },
        { itemId = 193714, itemName = "Frenzyroot Cuffs", boss = "Overgrown Ancient" },
        { itemId = 193713, itemName = "Experimental Safety Gloves", boss = "Overgrown Ancient" },
        { itemId = 193712, itemName = "Potion-Stained Cloak", boss = "Overgrown Ancient" },
        { itemId = 193716, itemName = "Algeth'ar Hedgecleaver", boss = "Overgrown Ancient" },
        { itemId = 193717, itemName = "Mystakra's Harvester", boss = "Overgrown Ancient" },
        { itemId = 193708, itemName = "Platinum Star Band", boss = "Vexamus" },
        { itemId = 193710, itemName = "Spellboon Saber", boss = "Vexamus" },
        { itemId = 193711, itemName = "Spellbane Cutlass", boss = "Vexamus" },
        { itemId = 193709, itemName = "Vexamus' Expulsion Rod", boss = "Vexamus" },
    },
    -- Magisters' Terrace (26 items)
    MAGISTER = {
        { itemId = 251101, itemName = "Arcane Guardian's Shell", boss = "Arcanotron" },
        { itemId = 251102, itemName = "Clasp of Compliance", boss = "Arcanotron" },
        { itemId = 251104, itemName = "Leggings of Orderly Conduct", boss = "Arcanotron" },
        { itemId = 251103, itemName = "Custodial Cuffs", boss = "Arcanotron" },
        { itemId = 250246, itemName = "Refueling Orb", boss = "Arcanotron" },
        { itemId = 251100, itemName = "Malfeasance Mallet", boss = "Arcanotron" },
        { itemId = 251119, itemName = "Vortex Visage", boss = "Degentrius" },
        { itemId = 251120, itemName = "Wraps of Umbral Descent", boss = "Degentrius" },
        { itemId = 251118, itemName = "Legplates of Lingering Dusk", boss = "Degentrius" },
        { itemId = 251121, itemName = "Domanaar's Dire Treads", boss = "Degentrius" },
        { itemId = 250257, itemName = "Eye of the Drowning Void", boss = "Degentrius" },
        { itemId = 251117, itemName = "Whirling Voidcleaver", boss = "Degentrius" },
        { itemId = 251122, itemName = "Shadowslash Slicer", boss = "Degentrius" },
        { itemId = 251114, itemName = "Voidwarped Oozemail", boss = "Gemellus" },
        { itemId = 251112, itemName = "Shadowsplit Girdle", boss = "Gemellus" },
        { itemId = 251113, itemName = "Gloves of Viscous Goo", boss = "Gemellus" },
        { itemId = 251115, itemName = "Bifurcation Band", boss = "Gemellus" },
        { itemId = 250242, itemName = "Jelly Replicator", boss = "Gemellus" },
        { itemId = 251111, itemName = "Splitshroud Stinger", boss = "Gemellus" },
        { itemId = 251109, itemName = "Spellsnap Shadowmask", boss = "Seranel Sunlash" },
        { itemId = 251110, itemName = "Sunlash's Sunsash", boss = "Seranel Sunlash" },
        { itemId = 251107, itemName = "Oathsworn Stompers", boss = "Seranel Sunlash" },
        { itemId = 251108, itemName = "Wraps of Watchful Wrath", boss = "Seranel Sunlash" },
        { itemId = 260312, itemName = "Defiant Defender's Drape", boss = "Seranel Sunlash" },
        { itemId = 251106, itemName = "Resolute Runeglaive", boss = "Seranel Sunlash" },
        { itemId = 251105, itemName = "Ward of the Spellbreaker", boss = "Seranel Sunlash" },
    },
    -- Maisara Caverns (20 items)
    MAISARA = {
        { itemId = 251176, itemName = "Reanimator's Weight", boss = "Muro'jin and Nekraxx" },
        { itemId = 251166, itemName = "Falconer's Cinch", boss = "Muro'jin and Nekraxx" },
        { itemId = 251167, itemName = "Nightprey Stalkers", boss = "Muro'jin and Nekraxx" },
        { itemId = 263193, itemName = "Trollhunter's Bands", boss = "Muro'jin and Nekraxx" },
        { itemId = 251162, itemName = "Traitor's Talon", boss = "Muro'jin and Nekraxx" },
        { itemId = 251174, itemName = "Deceiver's Rotbow", boss = "Muro'jin and Nekraxx" },
        { itemId = 251177, itemName = "Fetid Vilecrown", boss = "Rak'tul, Vessel of Souls" },
        { itemId = 251164, itemName = "Amalgamation's Harness", boss = "Rak'tul, Vessel of Souls" },
        { itemId = 251179, itemName = "Decaying Cuirass", boss = "Rak'tul, Vessel of Souls" },
        { itemId = 250258, itemName = "Vessel of Tortured Souls", boss = "Rak'tul, Vessel of Souls" },
        { itemId = 251163, itemName = "Berserker's Hexclaws", boss = "Rak'tul, Vessel of Souls" },
        { itemId = 251168, itemName = "Liferipper's Cutlass", boss = "Rak'tul, Vessel of Souls" },
        { itemId = 251175, itemName = "Soulblight Cleaver", boss = "Rak'tul, Vessel of Souls" },
        { itemId = 251171, itemName = "Enthralled Bonespines", boss = "Vordaza" },
        { itemId = 251170, itemName = "Wickedweave Trousers", boss = "Vordaza" },
        { itemId = 251169, itemName = "Footwraps of Ill-Fate", boss = "Vordaza" },
        { itemId = 251172, itemName = "Vilehex Bonds", boss = "Vordaza" },
        { itemId = 250223, itemName = "Soulcatcher's Charm", boss = "Vordaza" },
        { itemId = 251161, itemName = "Soulhunter's Mask", boss = "Vordaza" },
        { itemId = 251178, itemName = "Ceremonial Hexblade", boss = "Vordaza" },
    },
    -- Nexus-Point Xenas (20 items)
    NEXUS_XENAS = {
        { itemId = 251205, itemName = "Leyline Leggings", boss = "Chief Corewright Kasreth" },
        { itemId = 251203, itemName = "Kasreth's Bindings", boss = "Chief Corewright Kasreth" },
        { itemId = 251204, itemName = "Corewright's Zappers", boss = "Chief Corewright Kasreth" },
        { itemId = 251206, itemName = "Fluxweave Cloak", boss = "Chief Corewright Kasreth" },
        { itemId = 251201, itemName = "Corespark Multitool", boss = "Chief Corewright Kasreth" },
        { itemId = 251202, itemName = "Reflux Reflector", boss = "Chief Corewright Kasreth" },
        { itemId = 251213, itemName = "Nysarra's Mantle", boss = "Corewarden Nysarra" },
        { itemId = 251208, itemName = "Lightscarred Cuisses", boss = "Corewarden Nysarra" },
        { itemId = 251210, itemName = "Eclipse Espadrilles", boss = "Corewarden Nysarra" },
        { itemId = 251209, itemName = "Corewarden Cuffs", boss = "Corewarden Nysarra" },
        { itemId = 251093, itemName = "Omission of Light", boss = "Corewarden Nysarra" },
        { itemId = 250253, itemName = "Whisper of the Duskwraith", boss = "Corewarden Nysarra" },
        { itemId = 251207, itemName = "Dreadflail Bludgeon", boss = "Corewarden Nysarra" },
        { itemId = 251157, itemName = "Searing Spaulders", boss = "Lothraxion" },
        { itemId = 251216, itemName = "Maledict Vest", boss = "Lothraxion" },
        { itemId = 251215, itemName = "Greaves of the Divine Guile", boss = "Lothraxion" },
        { itemId = 251211, itemName = "Fractured Fingerguards", boss = "Lothraxion" },
        { itemId = 251217, itemName = "Occlusion of Void", boss = "Lothraxion" },
        { itemId = 250241, itemName = "Mark of Light", boss = "Lothraxion" },
        { itemId = 251212, itemName = "Radiant Slicer", boss = "Lothraxion" },
    },
    -- Pit of Saron (23 items)
    PIT_OF_SARON = {
        { itemId = 50228, itemName = "Barbed Ymirheim Choker", boss = "Forgemaster Garfrost" },
        { itemId = 50233, itemName = "Spurned Val'kyr Shoulderguards", boss = "Forgemaster Garfrost" },
        { itemId = 50234, itemName = "Shoulderplates of Frozen Blood", boss = "Forgemaster Garfrost" },
        { itemId = 49806, itemName = "Flayer's Black Belt", boss = "Forgemaster Garfrost" },
        { itemId = 133489, itemName = "Ice-Steeped Sandals", boss = "Forgemaster Garfrost" },
        { itemId = 49802, itemName = "Garfrost's Two-Ton Hammer", boss = "Forgemaster Garfrost" },
        { itemId = 50227, itemName = "Surgeon's Needle", boss = "Forgemaster Garfrost" },
        { itemId = 49808, itemName = "Bent Gold Belt", boss = "Ick and Krick" },
        { itemId = 49810, itemName = "Scabrous Zombie Leather Belt", boss = "Ick and Krick" },
        { itemId = 50263, itemName = "Braid of Salt and Fire", boss = "Ick and Krick" },
        { itemId = 50264, itemName = "Chewed Leather Wristguards", boss = "Ick and Krick" },
        { itemId = 133493, itemName = "Wristguards of Subterranean Moss", boss = "Ick and Krick" },
        { itemId = 49812, itemName = "Purloined Wedding Ring", boss = "Ick and Krick" },
        { itemId = 252421, itemName = "Rotting Globule", boss = "Ick and Krick" },
        { itemId = 133491, itemName = "Krick's Beetle Stabber", boss = "Ick and Krick" },
        { itemId = 49819, itemName = "Skeleton Lord's Cranium", boss = "Scourgelord Tyrannus" },
        { itemId = 49824, itemName = "Horns of the Spurned Val'kyr", boss = "Scourgelord Tyrannus" },
        { itemId = 49825, itemName = "Palebone Robes", boss = "Scourgelord Tyrannus" },
        { itemId = 50272, itemName = "Frost Wyrm Ribcage", boss = "Scourgelord Tyrannus" },
        { itemId = 49817, itemName = "Shaggy Wyrmleather Leggings", boss = "Scourgelord Tyrannus" },
        { itemId = 50259, itemName = "Nevermelting Ice Crystal", boss = "Scourgelord Tyrannus" },
        { itemId = 49823, itemName = "Cloak of the Fallen Cardinal", boss = "Scourgelord Tyrannus" },
        { itemId = 49813, itemName = "Rimebane Rifle", boss = "Scourgelord Tyrannus" },
    },
    -- The Seat of the Triumvirate (31 items)
    SEAT = {
        { itemId = 151319, itemName = "Twilight's Edge Spaulders", boss = "L'ura" },
        { itemId = 151313, itemName = "Vest of the Void's Embrace", boss = "L'ura" },
        { itemId = 151301, itemName = "Slippers of Growing Despair", boss = "L'ura" },
        { itemId = 151328, itemName = "Vambraces of Lost Hope", boss = "L'ura" },
        { itemId = 151322, itemName = "Void-Touched Grips", boss = "L'ura" },
        { itemId = 151340, itemName = "Echo of L'ura", boss = "L'ura" },
        { itemId = 258525, itemName = "Scepter of the Endless Night", boss = "L'ura" },
        { itemId = 151337, itemName = "Shadow-Weaver's Crown", boss = "Saprish" },
        { itemId = 151323, itemName = "Pauldrons of the Void Hunter", boss = "Saprish" },
        { itemId = 151303, itemName = "Voidbender Robe", boss = "Saprish" },
        { itemId = 151327, itemName = "Girdle of the Shadowguard", boss = "Saprish" },
        { itemId = 151330, itemName = "Trap Jammers", boss = "Saprish" },
        { itemId = 151321, itemName = "Darkfang Scale Wristguards", boss = "Saprish" },
        { itemId = 151318, itemName = "Gloves of the Dark Shroud", boss = "Saprish" },
        { itemId = 258516, itemName = "Wand of Saprish's Gaze", boss = "Saprish" },
        { itemId = 151333, itemName = "Crown of the Dark Envoy", boss = "Viceroy Nezhar" },
        { itemId = 151309, itemName = "Necklace of the Twisting Void", boss = "Viceroy Nezhar" },
        { itemId = 151325, itemName = "Void-Linked Robe", boss = "Viceroy Nezhar" },
        { itemId = 151317, itemName = "Footpads of Seeping Dread", boss = "Viceroy Nezhar" },
        { itemId = 151305, itemName = "Entropic Wristwraps", boss = "Viceroy Nezhar" },
        { itemId = 151332, itemName = "Voidclaw Gauntlets", boss = "Viceroy Nezhar" },
        { itemId = 151310, itemName = "Reality Breacher", boss = "Viceroy Nezhar" },
        { itemId = 258524, itemName = "Grips of the Dark Viceroy", boss = "Viceroy Nezhar" },
        { itemId = 258523, itemName = "Nezhar's Netherclaw", boss = "Viceroy Nezhar" },
        { itemId = 151336, itemName = "Voidlashed Hood", boss = "Zuraal the Ascended" },
        { itemId = 151329, itemName = "Breastplate of the Dark Touch", boss = "Zuraal the Ascended" },
        { itemId = 151320, itemName = "Void-Coated Stompers", boss = "Zuraal the Ascended" },
        { itemId = 151300, itemName = "Handwraps of the Ascended", boss = "Zuraal the Ascended" },
        { itemId = 151308, itemName = "Eredath Seal of Nobility", boss = "Zuraal the Ascended" },
        { itemId = 151312, itemName = "Ampoule of Pure Void", boss = "Zuraal the Ascended" },
        { itemId = 258514, itemName = "Umbral Spire of Zuraal", boss = "Zuraal the Ascended" },
    },
    -- Skyreach (28 items)
    SKYREACH = {
        { itemId = 258579, itemName = "Gutcrusher Greathelm", boss = "Araknath" },
        { itemId = 258578, itemName = "Lightbinder Shoulderguards", boss = "Araknath" },
        { itemId = 258576, itemName = "Sharpeye Chestguard", boss = "Araknath" },
        { itemId = 258577, itemName = "Boots of Burning Focus", boss = "Araknath" },
        { itemId = 252418, itemName = "Solar Core Igniter", boss = "Araknath" },
        { itemId = 258047, itemName = "Spire of the Furious Construct", boss = "Araknath" },
        { itemId = 258436, itemName = "Edge of the Burning Sun", boss = "Araknath" },
        { itemId = 258585, itemName = "Sharpeye Gleam", boss = "High Sage Viryx" },
        { itemId = 258587, itemName = "Spaulders of Scorching Ray", boss = "High Sage Viryx" },
        { itemId = 258586, itemName = "Bloodfeather Chestguard", boss = "High Sage Viryx" },
        { itemId = 258584, itemName = "Lightbinder Treads", boss = "High Sage Viryx" },
        { itemId = 252420, itemName = "Solarflare Prism", boss = "High Sage Viryx" },
        { itemId = 258050, itemName = "Arcanic of the High Sage", boss = "High Sage Viryx" },
        { itemId = 258484, itemName = "Sunlance of Viryx", boss = "High Sage Viryx" },
        { itemId = 258049, itemName = "Viryx's Indomitable Bulwark", boss = "High Sage Viryx" },
        { itemId = 258574, itemName = "Legwraps of Swirling Light", boss = "Ranjit" },
        { itemId = 258575, itemName = "Rigid Scale Greatcloak", boss = "Ranjit" },
        { itemId = 258046, itemName = "Chakram-Breaker Greatsword", boss = "Ranjit" },
        { itemId = 258218, itemName = "Skybreaker's Blade", boss = "Ranjit" },
        { itemId = 258412, itemName = "Stormshaper's Crossbow", boss = "Ranjit" },
        { itemId = 258581, itemName = "Bloodfeather Mantle", boss = "Rukhran" },
        { itemId = 258582, itemName = "Rigid Scale Boots", boss = "Rukhran" },
        { itemId = 258580, itemName = "Bracers of Blazing Light", boss = "Rukhran" },
        { itemId = 258583, itemName = "Incarnadine Gauntlets", boss = "Rukhran" },
        { itemId = 252411, itemName = "Radiant Sunstone", boss = "Rukhran" },
        { itemId = 258048, itemName = "Beakbreaker Scimitar", boss = "Rukhran" },
        { itemId = 258438, itemName = "Blazing Sunclaws", boss = "Rukhran" },
        { itemId = 258472, itemName = "Rukhran's Solar Reliquary", boss = "Rukhran" },
    },
    -- Windrunner Spire (26 items)
    WINDRUNNER = {
        { itemId = 251092, itemName = "Fallen Grunt's Mantle", boss = "Commander Kroluk" },
        { itemId = 251090, itemName = "Commander's Faded Breeches", boss = "Commander Kroluk" },
        { itemId = 251091, itemName = "Sabatons of Furious Revenge", boss = "Commander Kroluk" },
        { itemId = 251089, itemName = "Grips of Forgotten Honor", boss = "Commander Kroluk" },
        { itemId = 250227, itemName = "Kroluk's Warbanner", boss = "Commander Kroluk" },
        { itemId = 251088, itemName = "Warworn Cleaver", boss = "Commander Kroluk" },
        { itemId = 251085, itemName = "Mantle of Dark Devotion", boss = "Derelict Duo" },
        { itemId = 251086, itemName = "Riphook Defender", boss = "Derelict Duo" },
        { itemId = 251087, itemName = "Legwraps of Lingering Legacies", boss = "Derelict Duo" },
        { itemId = 251084, itemName = "Whipcoil Sabatons", boss = "Derelict Duo" },
        { itemId = 250226, itemName = "Latch's Crooked Hook", boss = "Derelict Duo" },
        { itemId = 251083, itemName = "Excavating Cudgel", boss = "Derelict Duo" },
        { itemId = 251080, itemName = "Brambledawn Halo", boss = "Emberdawn" },
        { itemId = 251082, itemName = "Snapvine Cinch", boss = "Emberdawn" },
        { itemId = 251079, itemName = "Amberfrond Bracers", boss = "Emberdawn" },
        { itemId = 251081, itemName = "Embergrove Grasps", boss = "Emberdawn" },
        { itemId = 250144, itemName = "Emberwing Feather", boss = "Emberdawn" },
        { itemId = 251077, itemName = "Roostwarden's Bough", boss = "Emberdawn" },
        { itemId = 251078, itemName = "Emberdawn Defender", boss = "Emberdawn" },
        { itemId = 251098, itemName = "Fletcher's Faded Faceplate", boss = "The Restless Heart" },
        { itemId = 251096, itemName = "Pendant of Aching Grief", boss = "The Restless Heart" },
        { itemId = 251097, itemName = "Spaulders of Arrow's Flight", boss = "The Restless Heart" },
        { itemId = 251099, itemName = "Vest of the Howling Gale", boss = "The Restless Heart" },
        { itemId = 250256, itemName = "Heart of Wind", boss = "The Restless Heart" },
        { itemId = 251095, itemName = "Hurricane's Heart", boss = "The Restless Heart" },
        { itemId = 251094, itemName = "Sigil of the Restless Heart", boss = "The Restless Heart" },
    },
}

-- ============================================================================
-- RAID LOOT TABLES
-- Populated by: python scrape_loot.py --raids --output Data.lua
-- ============================================================================
NS.RAID_LOOT = {
    -- The Voidspire (99 items)
    THE_VOIDSPIRE = {
        { itemId = 249288, itemName = "Ranger-Captain's Lethal Recurve", boss = "Crown of the Cosmos" },
        { itemId = 249295, itemName = "Turalyon's False Echo", boss = "Crown of the Cosmos" },
        { itemId = 249309, itemName = "Sunbound Breastplate", boss = "Crown of the Cosmos" },
        { itemId = 249312, itemName = "Nightblade's Pantaloons", boss = "Crown of the Cosmos" },
        { itemId = 249325, itemName = "Untethered Berserker's Grips", boss = "Crown of the Cosmos" },
        { itemId = 249368, itemName = "Eternal Voidsong Chain", boss = "Crown of the Cosmos" },
        { itemId = 249380, itemName = "Hate-Tied Waistchain", boss = "Crown of the Cosmos" },
        { itemId = 249382, itemName = "Canopy Walker's Footwraps", boss = "Crown of the Cosmos" },
        { itemId = 249809, itemName = "Locus-Walker's Ribbon", boss = "Crown of the Cosmos" },
        { itemId = 250247, itemName = "Amulet of the Abyssal Hymn", boss = "Crown of the Cosmos" },
        { itemId = 260423, itemName = "Arator's Swift Remembrance", boss = "Crown of the Cosmos" },
        { itemId = 249281, itemName = "Blade of the Final Twilight", boss = "Fallen-King Salhadaar" },
        { itemId = 249304, itemName = "Fallen King's Cuffs", boss = "Fallen-King Salhadaar" },
        { itemId = 249314, itemName = "Twisted Twilight Sash", boss = "Fallen-King Salhadaar" },
        { itemId = 249337, itemName = "Ribbon of Coiled Malice", boss = "Fallen-King Salhadaar" },
        { itemId = 249341, itemName = "Volatile Void Suffuser", boss = "Fallen-King Salhadaar" },
        { itemId = 249950, itemName = "Night Ender's Pauldrons", boss = "Fallen-King Salhadaar" },
        { itemId = 249959, itemName = "Luminant Verdict's Providence Watch", boss = "Fallen-King Salhadaar" },
        { itemId = 249968, itemName = "Relentless Rider's Dreadthorns", boss = "Fallen-King Salhadaar" },
        { itemId = 249977, itemName = "Tempests of the Primal Core", boss = "Fallen-King Salhadaar" },
        { itemId = 249995, itemName = "Beacons of the Black Talon", boss = "Fallen-King Salhadaar" },
        { itemId = 250004, itemName = "Venom Casks of the Grim Jest", boss = "Fallen-King Salhadaar" },
        { itemId = 250013, itemName = "Aurastones of Ra-den's Chosen", boss = "Fallen-King Salhadaar" },
        { itemId = 250022, itemName = "Seedpods of the Luminous Bloom", boss = "Fallen-King Salhadaar" },
        { itemId = 250031, itemName = "Devouring Reaver's Exhaustplates", boss = "Fallen-King Salhadaar" },
        { itemId = 250040, itemName = "Abyssal Immolator's Fury", boss = "Fallen-King Salhadaar" },
        { itemId = 250049, itemName = "Blind Oath's Seraphguards", boss = "Fallen-King Salhadaar" },
        { itemId = 250058, itemName = "Voidbreaker's Leyline Nexi", boss = "Fallen-King Salhadaar" },
        { itemId = 249275, itemName = "Bulwark of Noble Resolve", boss = "Imperator Averzian" },
        { itemId = 249279, itemName = "Sunstrike Rifle", boss = "Imperator Averzian" },
        { itemId = 249293, itemName = "Weight of Command", boss = "Imperator Averzian" },
        { itemId = 249306, itemName = "Devouring Night's Visage", boss = "Imperator Averzian" },
        { itemId = 249313, itemName = "Light-Judged Spaulders", boss = "Imperator Averzian" },
        { itemId = 249319, itemName = "Endless March Waistwrap", boss = "Imperator Averzian" },
        { itemId = 249323, itemName = "Leggings of the Devouring Advance", boss = "Imperator Averzian" },
        { itemId = 249334, itemName = "Void-Claimed Shinkickers", boss = "Imperator Averzian" },
        { itemId = 249344, itemName = "Light Company Guidon", boss = "Imperator Averzian" },
        { itemId = 244581, itemName = "Farstrider's Trophy Belt", boss = "Lightblinded Vanguard" },
        { itemId = 249277, itemName = "Bellamy's Final Judgement", boss = "Lightblinded Vanguard" },
        { itemId = 249294, itemName = "Blade of the Blind Verdict", boss = "Lightblinded Vanguard" },
        { itemId = 249330, itemName = "War Chaplain's Grips", boss = "Lightblinded Vanguard" },
        { itemId = 249369, itemName = "Bond of Light", boss = "Lightblinded Vanguard" },
        { itemId = 249952, itemName = "Night Ender's Tusks", boss = "Lightblinded Vanguard" },
        { itemId = 249961, itemName = "Luminant Verdict's Unwavering Gaze", boss = "Lightblinded Vanguard" },
        { itemId = 249970, itemName = "Relentless Rider's Crown", boss = "Lightblinded Vanguard" },
        { itemId = 249979, itemName = "Locus of the Primal Core", boss = "Lightblinded Vanguard" },
        { itemId = 249988, itemName = "Primal Sentry's Maw", boss = "Lightblinded Vanguard" },
        { itemId = 249997, itemName = "Hornhelm of the Black Talon", boss = "Lightblinded Vanguard" },
        { itemId = 250006, itemName = "Masquerade of the Grim Jest", boss = "Lightblinded Vanguard" },
        { itemId = 250015, itemName = "Fearsome Visage of Ra-den's Chosen", boss = "Lightblinded Vanguard" },
        { itemId = 250020, itemName = "Bindings of the Luminous Bloom", boss = "Lightblinded Vanguard" },
        { itemId = 250024, itemName = "Branches of the Luminous Bloom", boss = "Lightblinded Vanguard" },
        { itemId = 250033, itemName = "Devouring Reaver's Intake", boss = "Lightblinded Vanguard" },
        { itemId = 250042, itemName = "Abyssal Immolator's Smoldering Flames", boss = "Lightblinded Vanguard" },
        { itemId = 250051, itemName = "Blind Oath's Winged Crest", boss = "Lightblinded Vanguard" },
        { itemId = 250060, itemName = "Voidbreaker's Veil", boss = "Lightblinded Vanguard" },
        { itemId = 249280, itemName = "Emblazoned Sunglaive", boss = "Vaelgor and Ezzorak" },
        { itemId = 249287, itemName = "Clutchmates' Caress", boss = "Vaelgor and Ezzorak" },
        { itemId = 249305, itemName = "Slippers of the Midnight Flame", boss = "Vaelgor and Ezzorak" },
        { itemId = 249318, itemName = "Nullwalker's Dread Epaulettes", boss = "Vaelgor and Ezzorak" },
        { itemId = 249321, itemName = "Vaelgor's Fearsome Grasp", boss = "Vaelgor and Ezzorak" },
        { itemId = 249331, itemName = "Ezzorak's Gloombind", boss = "Vaelgor and Ezzorak" },
        { itemId = 249335, itemName = "Imperator's Banner", boss = "Vaelgor and Ezzorak" },
        { itemId = 249346, itemName = "Vaelgor's Final Stare", boss = "Vaelgor and Ezzorak" },
        { itemId = 249370, itemName = "Draconic Nullcape", boss = "Vaelgor and Ezzorak" },
        { itemId = 249810, itemName = "Shadow of the Empyrean Requiem", boss = "Vaelgor and Ezzorak" },
        { itemId = 249949, itemName = "Night Ender's Girdle", boss = "Vaelgor and Ezzorak" },
        { itemId = 249951, itemName = "Night Ender's Chausses", boss = "Vaelgor and Ezzorak" },
        { itemId = 249960, itemName = "Luminant Verdict's Greaves", boss = "Vaelgor and Ezzorak" },
        { itemId = 249969, itemName = "Relentless Rider's Legguards", boss = "Vaelgor and Ezzorak" },
        { itemId = 249987, itemName = "Primal Sentry's Legguards", boss = "Vaelgor and Ezzorak" },
        { itemId = 249996, itemName = "Greaves of the Black Talon", boss = "Vaelgor and Ezzorak" },
        { itemId = 250005, itemName = "Blade Holsters of the Grim Jest", boss = "Vaelgor and Ezzorak" },
        { itemId = 250014, itemName = "Swiftsweepers of Ra-den's Chosen", boss = "Vaelgor and Ezzorak" },
        { itemId = 250023, itemName = "Phloemwraps of the Luminous Bloom", boss = "Vaelgor and Ezzorak" },
        { itemId = 250032, itemName = "Devouring Reaver's Pistons", boss = "Vaelgor and Ezzorak" },
        { itemId = 250041, itemName = "Abyssal Immolator's Pillars", boss = "Vaelgor and Ezzorak" },
        { itemId = 250050, itemName = "Blind Oath's Leggings", boss = "Vaelgor and Ezzorak" },
        { itemId = 250059, itemName = "Voidbreaker's Britches", boss = "Vaelgor and Ezzorak" },
        { itemId = 249276, itemName = "Grimoire of the Eternal Light", boss = "Vorasius" },
        { itemId = 249283, itemName = "Belo'melorn, the Shattered Talon", boss = "Vorasius" },
        { itemId = 249315, itemName = "Voracious Wristwraps", boss = "Vorasius" },
        { itemId = 249327, itemName = "Void-Skinned Bracers", boss = "Vorasius" },
        { itemId = 249332, itemName = "Parasite Stompers", boss = "Vorasius" },
        { itemId = 249336, itemName = "Signet of the Starved Beast", boss = "Vorasius" },
        { itemId = 249342, itemName = "Heart of Ancient Hunger", boss = "Vorasius" },
        { itemId = 249925, itemName = "Hungering Victory", boss = "Vorasius" },
        { itemId = 249962, itemName = "Luminant Verdict's Gauntlets", boss = "Vorasius" },
        { itemId = 249971, itemName = "Relentless Rider's Bonegrasps", boss = "Vorasius" },
        { itemId = 249980, itemName = "Earthgrips of the Primal Core", boss = "Vorasius" },
        { itemId = 249989, itemName = "Primal Sentry's Talonguards", boss = "Vorasius" },
        { itemId = 249998, itemName = "Enforcer's Grips of the Black Talon", boss = "Vorasius" },
        { itemId = 250007, itemName = "Sleight of Hand of the Grim Jest", boss = "Vorasius" },
        { itemId = 250016, itemName = "Thunderfists of Ra-den's Chosen", boss = "Vorasius" },
        { itemId = 250025, itemName = "Arbortenders of the Luminous Bloom", boss = "Vorasius" },
        { itemId = 250034, itemName = "Devouring Reaver's Essence Grips", boss = "Vorasius" },
        { itemId = 250043, itemName = "Abyssal Immolator's Grasps", boss = "Vorasius" },
        { itemId = 250052, itemName = "Blind Oath's Touch", boss = "Vorasius" },
        { itemId = 250061, itemName = "Voidbreaker's Gloves", boss = "Vorasius" },
    },
    -- The Dreamrift (20 items)
    THE_DREAMRIFT = {
        { itemId = 249278, itemName = "Alnscorned Spire", boss = "Chimaerus" },
        { itemId = 249343, itemName = "Gaze of the Alnseer", boss = "Chimaerus" },
        { itemId = 249371, itemName = "Scornbane Waistguard", boss = "Chimaerus" },
        { itemId = 249373, itemName = "Dream-Scorched Striders", boss = "Chimaerus" },
        { itemId = 249374, itemName = "Scorn-Scarred Shul'ka's Belt", boss = "Chimaerus" },
        { itemId = 249381, itemName = "Greaves of the Unformed", boss = "Chimaerus" },
        { itemId = 249922, itemName = "Tome of Alnscorned Regret", boss = "Chimaerus" },
        { itemId = 249955, itemName = "Night Ender's Breastplate", boss = "Chimaerus" },
        { itemId = 249964, itemName = "Luminant Verdict's Divine Warplate", boss = "Chimaerus" },
        { itemId = 249973, itemName = "Relentless Rider's Cuirass", boss = "Chimaerus" },
        { itemId = 249982, itemName = "Embrace of the Primal Core", boss = "Chimaerus" },
        { itemId = 249991, itemName = "Primal Sentry's Scaleplate", boss = "Chimaerus" },
        { itemId = 250000, itemName = "Frenzyward of the Black Talon", boss = "Chimaerus" },
        { itemId = 250009, itemName = "Fantastic Finery of the Grim Jest", boss = "Chimaerus" },
        { itemId = 250018, itemName = "Battle Garb of Ra-den's Chosen", boss = "Chimaerus" },
        { itemId = 250027, itemName = "Trunk of the Luminous Bloom", boss = "Chimaerus" },
        { itemId = 250036, itemName = "Devouring Reaver's Engine", boss = "Chimaerus" },
        { itemId = 250045, itemName = "Abyssal Immolator's Dreadrobe", boss = "Chimaerus" },
        { itemId = 250054, itemName = "Blind Oath's Raiment", boss = "Chimaerus" },
        { itemId = 250063, itemName = "Voidbreaker's Robe", boss = "Chimaerus" },
    },
    -- March on Quel'Danas (21 items)
    MARCH_ON_QUELDANAS = {
        { itemId = 249284, itemName = "Belo'ren's Swift Talon", boss = "Belo'ren" },
        { itemId = 249307, itemName = "Emberborn Grasps", boss = "Belo'ren" },
        { itemId = 249322, itemName = "Radiant Clutchtender's Jerkin", boss = "Belo'ren" },
        { itemId = 249324, itemName = "Eternal Flame Scaleguards", boss = "Belo'ren" },
        { itemId = 249328, itemName = "Echoing Void Mantle", boss = "Belo'ren" },
        { itemId = 249376, itemName = "Whisper-Inscribed Sash", boss = "Belo'ren" },
        { itemId = 249377, itemName = "Darkstrider Treads", boss = "Belo'ren" },
        { itemId = 249806, itemName = "Radiant Plume", boss = "Belo'ren" },
        { itemId = 249807, itemName = "The Eternal Egg", boss = "Belo'ren" },
        { itemId = 249919, itemName = "Sin'dorei Band of Hope", boss = "Belo'ren" },
        { itemId = 249921, itemName = "Thalassian Dawnguard", boss = "Belo'ren" },
        { itemId = 260235, itemName = "Umbral Plume", boss = "Belo'ren" },
        { itemId = 249286, itemName = "Brazier of the Dissonant Dirge", boss = "Midnight Falls" },
        { itemId = 249296, itemName = "Alah'endal, the Dawnsong", boss = "Midnight Falls" },
        { itemId = 249302, itemName = "Inescapable Reach", boss = "Midnight Falls" },
        { itemId = 249912, itemName = "Robes of Endless Oblivion", boss = "Midnight Falls" },
        { itemId = 249913, itemName = "Mask of Darkest Intent", boss = "Midnight Falls" },
        { itemId = 249914, itemName = "Oblivion Guise", boss = "Midnight Falls" },
        { itemId = 249915, itemName = "Extinction Guards", boss = "Midnight Falls" },
        { itemId = 249920, itemName = "Eye of Midnight", boss = "Midnight Falls" },
        { itemId = 260408, itemName = "Lightless Lament", boss = "Midnight Falls" },
    },
}

-- ============================================================================
-- SPEC ID MAPPING (WoW API specID -> our key format)
-- ============================================================================
NS.SPEC_MAP = {
    [62] = "MAGE_ARCANE",
    [63] = "MAGE_FIRE",
    [64] = "MAGE_FROST",
    [65] = "PALADIN_HOLY",
    [66] = "PALADIN_PROTECTION",
    [70] = "PALADIN_RETRIBUTION",
    [71] = "WARRIOR_ARMS",
    [72] = "WARRIOR_FURY",
    [73] = "WARRIOR_PROTECTION",
    [102] = "DRUID_BALANCE",
    [103] = "DRUID_FERAL",
    [104] = "DRUID_GUARDIAN",
    [105] = "DRUID_RESTORATION",
    [250] = "DEATHKNIGHT_BLOOD",
    [251] = "DEATHKNIGHT_FROST",
    [252] = "DEATHKNIGHT_UNHOLY",
    [253] = "HUNTER_BEASTMASTERY",
    [254] = "HUNTER_MARKSMANSHIP",
    [255] = "HUNTER_SURVIVAL",
    [256] = "PRIEST_DISCIPLINE",
    [257] = "PRIEST_HOLY",
    [258] = "PRIEST_SHADOW",
    [259] = "ROGUE_ASSASSINATION",
    [260] = "ROGUE_OUTLAW",
    [261] = "ROGUE_SUBTLETY",
    [262] = "SHAMAN_ELEMENTAL",
    [263] = "SHAMAN_ENHANCEMENT",
    [264] = "SHAMAN_RESTORATION",
    [265] = "WARLOCK_AFFLICTION",
    [266] = "WARLOCK_DEMONOLOGY",
    [267] = "WARLOCK_DESTRUCTION",
    [268] = "MONK_BREWMASTER",
    [269] = "MONK_WINDWALKER",
    [270] = "MONK_MISTWEAVER",
    [577] = "DEMONHUNTER_HAVOC",
    [581] = "DEMONHUNTER_VENGEANCE",
    [1456] = "DEMONHUNTER_DEVOURER",
    [1467] = "EVOKER_DEVASTATION",
    [1468] = "EVOKER_PRESERVATION",
    [1473] = "EVOKER_AUGMENTATION",
}

-- ============================================================================
-- CLASS_SPECS: Reverse mapping class -> list of specs (built from SPEC_MAP)
-- { WARRIOR = { {specID=71, key="WARRIOR_ARMS"}, ... }, ... }
-- ============================================================================
NS.CLASS_SPECS = {}
for specID, specKey in pairs(NS.SPEC_MAP) do
    local className = specKey:match("^([^_]+)")
    if className then
        if not NS.CLASS_SPECS[className] then
            NS.CLASS_SPECS[className] = {}
        end
        table.insert(NS.CLASS_SPECS[className], { specID = specID, key = specKey })
    end
end
-- Sort each class's specs by specID for consistent ordering
for _, specs in pairs(NS.CLASS_SPECS) do
    table.sort(specs, function(a, b) return a.specID < b.specID end)
end

-- Returns the short spec name from a spec key (e.g. "WARRIOR_FURY" -> "Fury")
function NS.GetSpecShortName(specKey)
    if not specKey then return nil end
    local suffix = specKey:match("_(.+)$")
    if not suffix then return specKey end
    -- Title case: FURY -> Fury, BEASTMASTERY -> Beastmastery
    return suffix:sub(1, 1):upper() .. suffix:sub(2):lower()
end

-- ============================================================================
-- BUILD DUNGEON ITEM INDEX (computed at load time)
-- Maps itemId -> list of dungeon keys where it drops
-- ============================================================================
NS.ITEM_TO_DUNGEONS = {}
for dungeonKey, lootTable in pairs(NS.DUNGEON_LOOT) do
    for _, drop in ipairs(lootTable) do
        if not NS.ITEM_TO_DUNGEONS[drop.itemId] then
            NS.ITEM_TO_DUNGEONS[drop.itemId] = {}
        end
        -- Avoid duplicate dungeon entries
        local found = false
        for _, dk in ipairs(NS.ITEM_TO_DUNGEONS[drop.itemId]) do
            if dk == dungeonKey then found = true; break end
        end
        if not found then
            table.insert(NS.ITEM_TO_DUNGEONS[drop.itemId], dungeonKey)
        end
    end
end

-- Returns true if an item drops from any dungeon
function NS.IsFromDungeon(itemId)
    return NS.ITEM_TO_DUNGEONS[itemId] ~= nil
end

-- ============================================================================
-- BUILD RAID ITEM INDEX (computed at load time)
-- Maps itemId -> list of raid keys where it drops
-- ============================================================================
NS.ITEM_TO_RAIDS = {}
for raidKey, lootTable in pairs(NS.RAID_LOOT) do
    for _, drop in ipairs(lootTable) do
        if not NS.ITEM_TO_RAIDS[drop.itemId] then
            NS.ITEM_TO_RAIDS[drop.itemId] = {}
        end
        local found = false
        for _, rk in ipairs(NS.ITEM_TO_RAIDS[drop.itemId]) do
            if rk == raidKey then found = true; break end
        end
        if not found then
            table.insert(NS.ITEM_TO_RAIDS[drop.itemId], raidKey)
        end
    end
end

-- Returns true if an item drops from any raid
function NS.IsFromRaid(itemId)
    return NS.ITEM_TO_RAIDS[itemId] ~= nil
end

-- Returns true if an item drops from any content (dungeon or raid)
function NS.IsFromContent(itemId)
    return NS.ITEM_TO_DUNGEONS[itemId] ~= nil or NS.ITEM_TO_RAIDS[itemId] ~= nil
end

NS.BIS_OVERALL = {
    DEATHKNIGHT_BLOOD = {
        [16] = 249296, -- Alah'endal, the Dawnsong (Midnight Falls in March on Quel'Danas)
        [1] = 249970, -- Relentless Rider's Crown (Lightblinded Vanguard in The Voidspire)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 249968, -- Relentless Rider's Dreadthorns (Fallen-King Salhadaar in The Voidspire)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak in The Voidspire)
        [5] = 249973, -- Relentless Rider's Cuirass (Chimaerus in The Dreamrift)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 249971, -- Relentless Rider's Bonegrasps (Vorasius in The Voidspire)
        [6] = 249331, -- Ezzorak's Gloombind (Vaelgor and Ezzorak in The Voidspire)
        [7] = 249969, -- Relentless Rider's Legguards (Vaelgor and Ezzorak in The Voidspire)
        [8] = 249381, -- Greaves of the Unformed (Chimaerus in The Dreamrift)
        [11] = 249369, -- Bond of Light (Lightblinded Vanguard in The Voidspire)
        [12] = 251513, -- Loa Worshiper's Band (Crafted by Jewelcrafting)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 249806, -- Radiant Plume (Belo'ren in March on Quel'Danas)
    },
    DEATHKNIGHT_FROST = {
        [16] = 249277, -- Bellamy's Final Judgement (Lightblinded Vanguard in The Voidspire)
        [17] = 249281, -- Blade of the Final Twilight (Fallen-King Salhadaar in The Voidspire)
        [1] = 249970, -- Relentless Rider's Crown (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Seat of the Triumvirate)
        [3] = 50234, -- Shoulderplates of Frozen Blood (Pit of Saron)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Leatherworking)
        [5] = 249973, -- Relentless Rider's Cuirass (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 249971, -- Relentless Rider's Bonegrasps (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 249380, -- Hate-Tied Waistchain (Crown of the Cosmos in The Voidspire)
        [7] = 249969, -- Relentless Rider's Legguards (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249381, -- Greaves of the Unformed (Chimaerus in The Dreamrift)
        [11] = 193708, -- Platinum Star Band (Algeth'ar Academy)
        [12] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 249344, -- Light Company Guidon (Imperator Averzian in The Voidspire)
    },
    DEATHKNIGHT_UNHOLY = {
        [16] = 249277, -- Bellamy's Final Judgement (Lightblinded Vanguard in The Voidspire)
        [1] = 249970, -- Relentless Rider's Crown (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Seat of the Triumvirate)
        [3] = 50234, -- Shoulderplates of Frozen Blood (Pit of Saron)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Leatherworking)
        [5] = 249973, -- Relentless Rider's Cuirass (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 249971, -- Relentless Rider's Bonegrasps (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 249380, -- Hate-Tied Waistchain (Crown of the Cosmos in The Voidspire)
        [7] = 249969, -- Relentless Rider's Legguards (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249381, -- Greaves of the Unformed (Chimaerus in The Dreamrift)
        [11] = 193708, -- Platinum Star Band (Algeth'ar Academy)
        [12] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 249344, -- Light Company Guidon (Imperator Averzian in The Voidspire)
    },
    DEMONHUNTER_DEVOURER = {
        [16] = 260408, -- Lightless Lament (Midnight Falls)
        [17] = 237840, -- Spellbreaker's Warglaive (Blacksmithing)
        [1] = 250033, -- Devouring Reaver's Intake (Lightblinded Vanguard)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos)
        [3] = 250031, -- Devouring Reaver's Exhaustplates (Fallen-King Salhadaar)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak)
        [5] = 250036, -- Devouring Reaver's Engine (Chimaerus)
        [9] = 193714, -- Frenzyroot Cuffs (Algeth'ar Academy)
        [10] = 250034, -- Devouring Reaver's Essence Grips (Vorasius)
        [6] = 244573, -- Silvermoon Agent's Utility Belt (Leatherworking)
        [7] = 49817, -- Shaggy Wyrmleather Leggings (Pit of Saron)
        [8] = 250035, -- Devouring Reaver's Soul Flatteners (Matrix Catalyst)
        [11] = 249369, -- Bond of Light (Lightblinded Vanguard)
        [12] = 249920, -- Eye of Midnight (Midnight Falls)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus)
        [14] = 249346, -- Vaelgor's Final Stare (Vaelgor and Ezzorak)
    },
    DEMONHUNTER_HAVOC = {
        [16] = 260408, -- Lightless Lament (Midnight Falls)
        [17] = 251175, -- Soulblight Cleaver (Maisara Caverns)
        [1] = 251109, -- Spellsnap Shadowmask (Magister's Terrace)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls)
        [3] = 250031, -- Devouring Reaver's Exhaustplates (Fallen-King Salhadaar)
        [15] = 239656, -- Adherent's Silken Shroud (Tailoring)
        [5] = 250036, -- Devouring Reaver's Engine (Chimaerus)
        [9] = 244576, -- Silvermoon Agent's Deflectors (Leatherworking)
        [10] = 250034, -- Devouring Reaver's Essence Grips (Vorasius)
        [6] = 251082, -- Snapvine Cinch (Windrunner Spire)
        [7] = 250032, -- Devouring Reaver's Pistons (Vaelgor and Ezzorak)
        [8] = 258577, -- Boots of Burning Focus (Skyreach)
        [11] = 249919, -- Sin'dorei Band of Hope (Belo'ren)
        [12] = 193708, -- Platinum Star Band (Algeth'ar Academy)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus)
        [14] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
    },
    DEMONHUNTER_VENGEANCE = {
        [16] = 260408, -- Lightless Lament (Midnight Falls)
        [17] = 237840, -- Spellbreaker's Warglaive (Crafted by Blacksmithing)
        [1] = 250033, -- Devouring Reaver's Intake (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 250031, -- Devouring Reaver's Exhaustplates (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [5] = 251216, -- Maledict Vest (Nexus-Point Xenas)
        [9] = 244576, -- Silvermoon Agent's Deflectors (Crafted by Leatherworking)
        [10] = 250034, -- Devouring Reaver's Essence Grips (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 249374, -- Scorn-Scarred Shul'ka's Belt (Chimaerus in The Dreamrift)
        [7] = 250032, -- Devouring Reaver's Pistons (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249334, -- Void-Claimed Shinkickers (Imperator Averzian in The Voidspire)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [12] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [13] = 250256, -- Heart of Wind (Windrunner Spire)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
    },
    DRUID_BALANCE = {
        [16] = 249286, -- Brazier of the Dissonant Dirge (Midnight Falls in March on Quel'Danas)
        [17] = 249283, -- Belo'melorn, the Shattered Talon (Belo'ren & Vorasius)
        [1] = 250024, -- Branches of the Luminous Bloom (Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 250022, -- Seedpods of the Luminous Bloom (Fallen-King Salhadaar in The Voidspire)
        [15] = 250019, -- Leafdrape of the Luminous Bloom (Creation Catalyst)
        [5] = 250027, -- Trunk of the Luminous Bloom (Chimaerus in The Dreamrift)
        [9] = 249327, -- Void-Skinned Bracers (Vorasius in The Voidspire)
        [10] = 244575, -- Silvermoon Agent's Handwraps (Leatherworking)
        [6] = 249374, -- Scorn-Scarred Shul'ka's Belt (Chimaerus in The Dreamrift)
        [7] = 250023, -- Phloemwraps of the Luminous Bloom (Vaelgor and Ezzorak in The Voidspire)
        [8] = 244569, -- Silvermoon Agent's Sneakers (Leatherworking)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 249346, -- Vaelgor's Final Stare (Vaelgor and Ezzorak)
    },
    DRUID_FERAL = {
        [16] = 251077, -- Roostwarden's Bough (Windrunner Spire)
        [1] = 250024, -- Branches of the Luminous Bloom (Lightblinded Vanguard)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls)
        [3] = 251092, -- Fallen Grunt's Mantle (Windrunner Spire)
        [15] = 239656, -- Adherent's Silken Shroud (Tailoring)
        [5] = 250027, -- Trunk of the Luminous Bloom (Chimaerus)
        [9] = 244576, -- Silvermoon Agent's Deflectors (Leatherworking)
        [10] = 250025, -- Arbortenders of the Luminous Bloom (Vorasius)
        [6] = 249374, -- Scorn-Scarred Shul'ka's Belt (Chimaerus)
        [7] = 250023, -- Phloemwraps of the Luminous Bloom (Vaelgor and Ezzorak)
        [8] = 249382, -- Canopy Walker's Footwraps (Crown of the Cosmos)
        [11] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus)
        [14] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
    },
    DRUID_GUARDIAN = {
        [16] = 249278, -- Alnscorned Spire (Chimaerus in The Dreamrift)
        [1] = 151336, -- Voidlashed Hood (Seat of the Triumvirate)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 250022, -- Seedpods of the Luminous Bloom (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak in The Voidspire)
        [5] = 250027, -- Trunk of the Luminous Bloom (Chimaerus in The Dreamrift)
        [9] = 244576, -- Silvermoon Agent's Deflectors (Crafted by Leatherworking)
        [10] = 250025, -- Arbortenders of the Luminous Bloom (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 244573, -- Silvermoon Agent's Utility Belt (Crafted by Leatherworking)
        [7] = 250023, -- Phloemwraps of the Luminous Bloom (Vaelgor and Ezzorak in The Voidspire)
        [8] = 249334, -- Void-Claimed Shinkickers (Imperator Averzian in The Voidspire)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
    },
    DRUID_RESTORATION = {
        [16] = 249283, -- Belo'melorn, the Shattered Talon (Belo'ren - March on Quel'Danas)
        [17] = 249922, -- Tome of Alnscorned Regret (Chimaerus - Dreamrift)
        [1] = 250024, -- Branches of the Luminous Bloom (Lightblinded Vanguard - The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls - March on Quel'Danas)
        [3] = 250022, -- Seedpods of the Luminous Bloom (Fallen-King Salhadaar - The Voidspire)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak - The Voidspire)
        [5] = 251216, -- Maledict Vest (Nexus-Point Xenas)
        [9] = 193714, -- Frenzyroot Cuffs (Algeth'ar Academy)
        [10] = 250025, -- Arbortenders of the Luminous Bloom (Vorasius - The Voidspire)
        [6] = 249314, -- Twisted Twilight Sash (Fallen-King Salhadaar - The Voidspire)
        [7] = 250023, -- Phloemwraps of the Luminous Bloom (Vaelgor and Ezzorak - The Voidspire)
        [8] = 251210, -- Eclipse Espadrilles (Nexus-Point Xenas)
        [11] = 249920, -- Eye of Midnight (Midnight Falls - March on Quel'Danas)
        [12] = 251115, -- Bifurcation Band (Magister's Terrace)
        [13] = 249809, -- Locus-Walker's Ribbon (Crown of the Cosmos - The Voidspire)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus - Dreamrift)
    },
    EVOKER_AUGMENTATION = {
        [16] = 251178, -- Ceremonial Hexblade (Maisara Caverns Magister's Terrace Skyreach Vorasius in The Voidspire Algeth'ar Academy)
        [17] = 251111, -- Splitshroud Stinger (Maisara Caverns Magister's Terrace Skyreach Vorasius in The Voidspire Algeth'ar Academy)
        [1] = 249914, -- Oblivion Guise (Midnight Falls in March on Quel'Danas Vorasius in The Voidspire Pit of Saron)
        [2] = 249337, -- Ribbon of Coiled Malice (Fallen-King Salhadaar in The Voidspire Pit of Saron)
        [3] = 249995, -- Beacons of the Black Talon (Matrix Catalyst , Fallen-King Salhadaar in The Voidspire .)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 250000, -- Frenzyward of the Black Talon (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 244584, -- Farstrider's Plated Bracers (Crafted by Leatherworking)
        [10] = 249998, -- Enforcer's Grips of the Black Talon (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 49810, -- Scabrous Zombie Leather Belt (Pit of Saron)
        [7] = 249996, -- Greaves of the Black Talon (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249377, -- Darkstrider Treads (Belo'ren in March on Quel'Danas Matrix Catalyst Algeth'ar Academy)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas Midnight Falls in March on Quel'Danas Pit of Saron Crafted by Jewelcrafting)
        [12] = 249920, -- Eye of Midnight (Nexus-Point Xenas Midnight Falls in March on Quel'Danas Pit of Saron Crafted by Jewelcrafting)
        [13] = 249810, -- Shadow of the Empyrean Requiem (Midnight Falls in March on Quel'Danas Vaelgor and Ezzorak in The Voidspire Maisara Caverns)
        [14] = 249346, -- Vaelgor's Final Stare (Midnight Falls in March on Quel'Danas Vaelgor and Ezzorak in The Voidspire Maisara Caverns)
    },
    EVOKER_DEVASTATION = {
        [16] = 249294, -- Blade of the Blind Verdict (Lightblinded Vanguard in The Voidspire .)
        [17] = 249276, -- Grimoire of the Eternal Light (Vorasius in The Voidspire .)
        [1] = 249997, -- Hornhelm of the Black Talon (Matrix Catalyst , Lightblinded Vanguard in The Voidspire .)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas .)
        [3] = 249995, -- Beacons of the Black Talon (Matrix Catalyst , Fallen-King Salhadaar in The Voidspire .)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 250000, -- Frenzyward of the Black Talon (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 244584, -- Farstrider's Plated Bracers (Crafted by Leatherworking)
        [10] = 249325, -- Untethered Berserker's Grips (Crown of the Cosmos in The Voidspire)
        [6] = 49810, -- Scabrous Zombie Leather Belt (Pit of Saron)
        [7] = 249996, -- Greaves of the Black Talon (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249999, -- Spelltreads of the Black Talon (Matrix Catalyst .)
        [11] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas .)
        [12] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas .)
        [13] = 249809, -- Locus-Walker's Ribbon (Crown of the Cosmos in The Voidspire .)
        [14] = 249346, -- Vaelgor's Final Stare (Vaelgor and Ezzorak in The Voidspire .)
    },
    EVOKER_PRESERVATION = {
        [16] = 258514, -- Umbral Spire of Zuraal (Seat of the Triumvirate)
        [1] = 249914, -- Oblivion Guise (Midnight Falls in March on Quel'Danas)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 249995, -- Beacons of the Black Talon (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 251206, -- Fluxweave Cloak (Nexus-Point Xenas)
        [5] = 250000, -- Frenzyward of the Black Talon (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 251079, -- Amberfrond Bracers (Windrunner Spire)
        [10] = 249998, -- Enforcer's Grips of the Black Talon (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 244611, -- World Tender's Barkclasp (Crafted by Leatherworking)
        [7] = 249996, -- Greaves of the Black Talon (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 244610, -- World Tender's Rootslippers (Crafted by Leatherworking)
        [11] = 249369, -- Bond of Light (Lightblinded Vanguard in The Voidspire)
        [12] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [13] = 249346, -- Vaelgor's Final Stare (Vaelgor and Ezzorak in The Voidspire)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
    },
    HUNTER_BEASTMASTERY = {
        [16] = 249279, -- Sunstrike Rifle (Imperator Averzian - Voidspire)
        [1] = 249988, -- Primal Sentry's Maw (Lightblinded Vanguard - Voidspire, or Matrix Catalyst)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls - March on Quel'Danas)
        [3] = 151323, -- Pauldrons of the Void Hunter (Seat of the Triumvirate)
        [15] = 249335, -- Imperator's Banner (Imperator Averzian - Voidspire)
        [5] = 249991, -- Primal Sentry's Scaleplate (Chimaerus - Dreamrift, or Matrix Catalyst)
        [9] = 249304, -- Fallen King's Cuffs (Fallen-King Salhadaar - Voidspire)
        [10] = 249989, -- Primal Sentry's Talonguards (Vorasius - Voidspire, or Matrix Catalyst)
        [6] = 244611, -- World Tender's Barkclasp (Leatherworking)
        [7] = 249987, -- Primal Sentry's Legguards (Vaelgor and Ezzorak - Voidspire, or Matrix Catalyst)
        [8] = 244610, -- World Tender's Rootslippers (Leatherworking)
        [11] = 249920, -- Eye of Midnight (Midnight Falls - March on Quel'Danas)
        [12] = 249369, -- Bond of Light (Lightblinded Vanguard - Voidspire)
        [13] = 249806, -- Radiant Plume (Belo'ren - March on Quel'Danas)
        [14] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
    },
    HUNTER_MARKSMANSHIP = {
        [16] = 249288, -- Ranger-Captain's Lethal Recurve (Crown of the Cosmos - Voidspire)
        [1] = 249988, -- Primal Sentry's Maw (Lightblinded Vanguard - Voidspire, or Matrix Catalyst)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls - March on Quel'Danas)
        [3] = 151323, -- Pauldrons of the Void Hunter (Seat of the Triumvirate)
        [15] = 249335, -- Imperator's Banner (Imperator Averzian - Voidspire)
        [5] = 249991, -- Primal Sentry's Scaleplate (Chimaerus - Dreamrift, or Matrix Catalyst)
        [9] = 249304, -- Fallen King's Cuffs (Fallen-King Salhadaar - Voidspire)
        [10] = 249989, -- Primal Sentry's Talonguards (Vorasius - Voidspire, or Matrix Catalyst)
        [6] = 244611, -- World Tender's Barkclasp (Leatherworking)
        [7] = 249987, -- Primal Sentry's Legguards (Vaelgor and Ezzorak - Voidspire, or Matrix Catalyst)
        [8] = 244610, -- World Tender's Rootslippers (Leatherworking)
        [11] = 249336, -- Signet of the Starved Beast (Vorasius - Voidspire)
        [12] = 249919, -- Sin'dorei Band of Hope (Belo'ren - March on Quel'Danas)
        [13] = 260235, -- Umbral Plume (Belo'ren - March on Quel'Danas)
        [14] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
    },
    HUNTER_SURVIVAL = {
        [16] = 249302, -- Inescapable Reach (Vorasius - Voidspire)
        [17] = 249925, -- Hungering Victory (Vorasius - Voidspire)
        [1] = 249988, -- Primal Sentry's Maw (Lightblinded Vanguard - Voidspire, or Matrix Catalyst)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls - March on Quel'Danas)
        [3] = 151323, -- Pauldrons of the Void Hunter (Seat of the Triumvirate)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak - Voidspire)
        [5] = 249991, -- Primal Sentry's Scaleplate (Chimaerus - Dreamrift, or Matrix Catalyst)
        [9] = 244584, -- Farstrider's Plated Bracers (Leatherworking)
        [10] = 249989, -- Primal Sentry's Talonguards (Vorasius - Voidspire, or Matrix Catalyst)
        [6] = 244611, -- World Tender's Barkclasp (Leatherworking)
        [7] = 249987, -- Primal Sentry's Legguards (Vaelgor and Ezzorak - Voidspire, or Matrix Catalyst)
        [8] = 244610, -- World Tender's Rootslippers (Leatherworking)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 249806, -- Radiant Plume (Belo'ren - March on Quel'Danas)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus - The Dreamdrift)
    },
    MAGE_ARCANE = {
        [16] = 258218, -- Skybreaker's Blade (The Great Vault / Skyreach)
        [17] = 251094, -- Sigil of the Restless Heart (The Great Vault / Windrunner Spire)
        [1] = 250060, -- Voidbreaker's Veil (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 250058, -- Voidbreaker's Leyline Nexi (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 239661, -- Arcanoweave Cloak (Crafted by Tailoring)
        [5] = 250063, -- Voidbreaker's Robe (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 239660, -- Arcanoweave Bracers (Crafted by Tailoring)
        [10] = 250061, -- Voidbreaker's Gloves (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 249376, -- Whisper-Inscribed Sash (Belo'ren in March on Quel'Danas)
        [7] = 251090, -- Commander's Faded Breeches (The Great Vault / Windrunner Spire)
        [8] = 249373, -- Dream-Scorched Striders (Chimaerus in The Dreamrift)
        [11] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [12] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [13] = 249343, -- Gaze of the Alnseer (Vaelgor and Ezzorak in The Voidspire)
        [14] = 249346, -- Vaelgor's Final Stare (Chimaerus in The Dreamrift)
    },
    MAGE_FIRE = {
        [16] = 249286, -- Brazier of the Dissonant Dirge (Midnight Falls in March on Quel'Danas)
        [17] = 258472, -- Rukhran's Solar Reliquary (Windrunner Spire)
        [1] = 250060, -- Voidbreaker's Veil (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 250058, -- Voidbreaker's Leyline Nexi (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring with Arcanoweave Lining and Haste + Mastery)
        [5] = 249912, -- Robes of Endless Oblivion (Midnight Falls in March on Quel'Danas)
        [9] = 239648, -- Martyr's Bindings (Crafted by Tailoring with Arcanoweave Lining and Haste + Mastery)
        [10] = 250061, -- Voidbreaker's Gloves (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 249376, -- Whisper-Inscribed Sash (Belo'ren in March on Quel'Danas)
        [7] = 250059, -- Voidbreaker's Britches (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 250062, -- Voidbreaker's Treads (Matrix Catalyst on any pair of boots, or The Great Vault)
        [11] = 249369, -- Bond of Light (Lightblinded Vanguard in The Voidspire)
        [12] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [13] = 250144, -- Emberwing Feather (The Great Vault / Windrunner Spire)
        [14] = 249346, -- Vaelgor's Final Stare (Vaelgor and Ezzorak in The Voidspire)
    },
    MAGE_FROST = {
        [16] = 258218, -- Skybreaker's Blade (Skyreach)
        [17] = 245769, -- Aln'hara Lantern (Inscription)
        [1] = 250060, -- Voidbreaker's Veil (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 251085, -- Mantle of Dark Devotion (Windrunner Spire)
        [15] = 258575, -- Rigid Scale Greatcloak (Skyreach)
        [5] = 250063, -- Voidbreaker's Robe (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 239648, -- Martyr's Bindings (Tailoring)
        [10] = 250061, -- Voidbreaker's Gloves (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 250057, -- Voidbreaker's Sage Cord (Matrix Catalyst)
        [7] = 250059, -- Voidbreaker's Britches (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249373, -- Dream-Scorched Striders (Chimaerus in The Dreamrift)
        [11] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [12] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [13] = 249346, -- Vaelgor's Final Stare (Vaelgor and Ezzorak in The Voidspire)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
    },
    MONK_BREWMASTER = {
        [16] = 249302, -- Inescapable Reach (Vorasius ( The Voidspire ))
        [17] = 251207, -- Dreadflail Bludgeon (Nexus-Point Xenas Maisara Caverns)
        [1] = 250015, -- Fearsome Visage of Ra-den's Chosen (Lightblinded Vanguard ( March on Quel'Danas ))
        [2] = 240950, -- Masterwork Sin'dorei Amulet (Jewelcrafting ( see note ))
        [3] = 250013, -- Aurastones of Ra-den's Chosen (Fallen-King Salhadaar ( The Voidspire ))
        [15] = 249335, -- Imperator's Banner (Imperator Averzian ( The Voidspire ))
        [5] = 250018, -- Battle Garb of Ra-den's Chosen (Chimaerus ( The Dreamrift ))
        [9] = 250011, -- Strikeguards of Ra-den's Chosen (Matrix Catalyst)
        [10] = 250016, -- Thunderfists of Ra-den's Chosen (Vorasius ( The Voidspire ))
        [6] = 251082, -- Snapvine Cinch (Windrunner Spire)
        [7] = 151314, -- Shifting Stalker Hide Pants (Seat of the Triumvirate)
        [8] = 151317, -- Footpads of Seeping Dread (Seat of the Triumvirate)
        [11] = 249336, -- Signet of the Starved Beast (Vorasius ( The Voidspire ))
        [12] = 251513, -- Loa Worshiper's Band (Jewelcrafting)
        [13] = 249806, -- Radiant Plume (Belo'ren ( March on Quel'Danas ) Chimaerus ( The Dreamrift ) Vaelgor and Ezzorak ( The Voidspire ) Seat of the Triumvirate)
        [14] = 249343, -- Gaze of the Alnseer (Belo'ren ( March on Quel'Danas ) Chimaerus ( The Dreamrift ) Vaelgor and Ezzorak ( The Voidspire ) Seat of the Triumvirate)
    },
    MONK_MISTWEAVER = {
        [16] = 258050, -- Arcanic of the High Sage (Skyreach)
        [17] = 249276, -- Grimoire of the Eternal Light (Vorasius in The Voidspire)
        [1] = 249913, -- Mask of Darkest Intent (Midnight Falls in March on Quel'Danas)
        [2] = 249337, -- Ribbon of Coiled Malice (Fallen-King Salhadaar in The Voidspire)
        [3] = 250013, -- Aurastones of Ra-den's Chosen (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 250018, -- Battle Garb of Ra-den's Chosen (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 244576, -- Silvermoon Agent's Deflectors (Crafted by Leatherworking)
        [10] = 250016, -- Thunderfists of Ra-den's Chosen (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 249374, -- Scorn-Scarred Shul'ka's Belt (Chimaerus in The Dreamrift)
        [7] = 250014, -- Swiftsweepers of Ra-den's Chosen (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 251210, -- Eclipse Espadrilles (Nexus-Point Xenas)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 151311, -- Band of the Triumvirate (Seat of the Triumvirate)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 250144, -- Emberwing Feather (Windrunner Spire)
    },
    MONK_WINDWALKER = {
        [16] = 251162, -- Traitor's Talon (Maisara Caverns)
        [17] = 260423, -- Arator's Swift Remembrance (Crown of the Cosmos)
        [1] = 250015, -- Fearsome Visage of Ra-den's Chosen (Matrix Catalyst , or Lightblinded Vanguard - The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls)
        [3] = 250013, -- Aurastones of Ra-den's Chosen (Matrix Catalyst , or Fallen-King Salhadaar - The Voidspire)
        [15] = 250010, -- Windwrap of Ra-den's Chosen (Matrix Catalyst)
        [5] = 250018, -- Battle Garb of Ra-den's Chosen (Matrix Catalyst , or Chimaerus - The Dreamrift)
        [9] = 249327, -- Void-Skinned Bracers (Vorasius)
        [10] = 249321, -- Vaelgor's Fearsome Grasp (Vaelgor and Ezzorak)
        [6] = 251082, -- Snapvine Cinch (Windrunner Spire)
        [7] = 250014, -- Swiftsweepers of Ra-den's Chosen (Matrix Catalyst , or Vaelgor and Ezzorak - The Voidspire)
        [8] = 250017, -- Storm Crashers of Ra-den's Chosen (Matrix Catalyst)
        [11] = 251513, -- Loa Worshiper's Band (Jewelcrafting)
        [12] = 249920, -- Eye of Midnight (Midnight Falls)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus)
        [14] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
    },
    PALADIN_HOLY = {
        [16] = 193710, -- Spellboon Saber (Algeth'ar Academy)
        [17] = 258049, -- Viryx's Indomitable Bulwark (Skyreach)
        [1] = 249961, -- Luminant Verdict's Unwavering Gaze (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 249959, -- Luminant Verdict's Providence Watch (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 249964, -- Luminant Verdict's Divine Warplate (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 249962, -- Luminant Verdict's Gauntlets (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 249331, -- Ezzorak's Gloombind (Vaelgor and Ezzorak in The Voidspire)
        [7] = 249915, -- Extinction Guards (Midnight Falls in March on Quel'Danas)
        [8] = 249332, -- Parasite Stompers (Vorasius in The Voidspire)
        [11] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [12] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [13] = 249346, -- Vaelgor's Final Stare (Vaelgor and Ezzorak in The Voidspire)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
    },
    PALADIN_PROTECTION = {
        [16] = 249295, -- Turalyon's False Echo (Crown of the Cosmos in The Voidspire)
        [17] = 249275, -- Bulwark of Noble Resolve (Imperator Averzian in The Voidspire)
        [1] = 249961, -- Luminant Verdict's Unwavering Gaze (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 251096, -- Pendant of Aching Grief (Windrunner Spire)
        [3] = 249959, -- Luminant Verdict's Providence Watch (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 249335, -- Imperator's Banner (Imperator Averzian in The Voidspire)
        [5] = 249964, -- Luminant Verdict's Divine Warplate (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 151332, -- Voidclaw Gauntlets (Seat of the Triumvirate)
        [6] = 249331, -- Ezzorak's Gloombind (Vaelgor and Ezzorak in The Voidspire)
        [7] = 249960, -- Luminant Verdict's Greaves (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249332, -- Parasite Stompers (Vorasius in The Voidspire)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [12] = 251513, -- Loa Worshiper's Band (Crafted by Jewelcrafting)
        [13] = 260235, -- Umbral Plume (Belo'ren in March on Quel'Danas)
        [14] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
    },
    PALADIN_RETRIBUTION = {
        [16] = 249277, -- Bellamy's Final Judgement (Lightblinded Vanguard in The Voidspire)
        [1] = 249961, -- Luminant Verdict's Unwavering Gaze (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 249959, -- Luminant Verdict's Providence Watch (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 249964, -- Luminant Verdict's Divine Warplate (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 151332, -- Voidclaw Gauntlets (Seat of the Triumvirate)
        [6] = 249380, -- Hate-Tied Waistchain (Crown of the Cosmos in The Voidspire)
        [7] = 249960, -- Luminant Verdict's Greaves (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249381, -- Greaves of the Unformed (Chimaerus in The Dreamrift)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [13] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
        [14] = 260235, -- Umbral Plume (Belo'ren in March on Quel'Danas)
    },
    PRIEST_DISCIPLINE = {
        [16] = 249283, -- Belo'melorn, the Shattered Talon (Belo'ren in March on Quel'Danas)
        [17] = 245769, -- Aln'hara Lantern (Crafted by Inscription)
        [1] = 250051, -- Blind Oath's Winged Crest (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 250049, -- Blind Oath's Seraphguards (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak in The Voidspire)
        [5] = 249912, -- Robes of Endless Oblivion (Midnight Falls in March on Quel'Danas)
        [9] = 249315, -- Voracious Wristwraps (Vorasius in The Voidspire)
        [10] = 250052, -- Blind Oath's Touch (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 239664, -- Arcanoweave Cord (Crafted by Tailoring)
        [7] = 250050, -- Blind Oath's Leggings (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 258584, -- Lightbinder Treads (Skyreach)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 249346, -- Vaelgor's Final Stare (Vaelgor and Ezzorak in The Voidspire)
        [14] = 193718, -- Emerald Coach's Whistle (Algeth'ar Academy)
    },
    PRIEST_HOLY = {
        [16] = 245770, -- Aln'hara Cane (Crafted by Inscription)
        [17] = 249276, -- Grimoire of the Eternal Light (Vorasius in The Voidspire)
        [1] = 250051, -- Blind Oath's Winged Crest (Lightblinded Vanguard in The Voidspire / Matrix Catalyst)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 250049, -- Blind Oath's Seraphguards (Fallen-King Salhadaar in The Voidspire / Matrix Catalyst)
        [15] = 249335, -- Imperator's Banner (Imperator Averzian in The Voidspire)
        [5] = 250054, -- Blind Oath's Raiment (Chimaerus in The Dreamrift / Matrix Catalyst)
        [9] = 250047, -- Blind Oath's Wraps (Matrix Catalyst any bracer)
        [10] = 250052, -- Blind Oath's Touch (Vorasius in The Voidspire / Matrix Catalyst)
        [6] = 239664, -- Arcanoweave Cord (Crafted with Tailoring)
        [7] = 249323, -- Leggings of the Devouring Advance (Imperator Averzian in The Voidspire)
        [8] = 251167, -- Nightprey Stalkers (Maisara Caverns)
        [11] = 249336, -- Signet of the Starved Beast (Vorasius in The Voidspire)
        [12] = 151308, -- Eredath Seal of Nobility (Seat of the Triumvirate)
        [13] = 193718, -- Emerald Coach's Whistle (Algeth'ar Academy Lightblinded Vanguard in The Voidspire Crown of the Cosmos in The Voidspire)
        [14] = 249808, -- Litany of Lightblind Wrath (Algeth'ar Academy Lightblinded Vanguard in The Voidspire Crown of the Cosmos in The Voidspire)
    },
    PRIEST_SHADOW = {
        [16] = 249283, -- Belo'melorn, the Shattered Talon (Belo'ren in March on Quel'Danas Chimaerus in The Dreamrift Midnight Falls in March on Quel'Danas)
        [17] = 249922, -- Tome of Alnscorned Regret (Belo'ren in March on Quel'Danas Chimaerus in The Dreamrift Midnight Falls in March on Quel'Danas)
        [1] = 250051, -- Blind Oath's Winged Crest (Lightblinded Vanguard in The Voidspire)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 250049, -- Blind Oath's Seraphguards (Fallen-King Salhadaar in The Voidspire)
        [15] = 239661, -- Arcanoweave Cloak (Tailoring)
        [5] = 250054, -- Blind Oath's Raiment (Chimaerus in The Dreamrift)
        [9] = 239660, -- Arcanoweave Bracers (Tailoring)
        [10] = 251172, -- Vilehex Bonds (Maisara Caverns)
        [6] = 249376, -- Whisper-Inscribed Sash (Belo'ren in March on Quel'Danas)
        [7] = 250050, -- Blind Oath's Leggings (Vaelgor and Ezzorak in Voidspire)
        [8] = 258584, -- Lightbinder Treads (Skyreach)
        [11] = 251093, -- Omission of Light (Nexus-Point Xenas Midnight Falls in March on Quel'Danas Magister's Terrace)
        [12] = 249920, -- Eye of Midnight (Nexus-Point Xenas Midnight Falls in March on Quel'Danas Magister's Terrace)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift Maisara Caverns Vaelgor and Ezzorak in The Voidspire Midnight Falls in March on Quel'Danas)
        [14] = 250223, -- Soulcatcher's Charm (Chimaerus in The Dreamrift Maisara Caverns Vaelgor and Ezzorak in The Voidspire Midnight Falls in March on Quel'Danas)
    },
    ROGUE_ASSASSINATION = {
        [16] = 249925, -- Hungering Victory (Vorasius in The Voidspire)
        [17] = 237837, -- Farstrider's Mercy (Crafted by Blacksmithing)
        [1] = 250006, -- Masquerade of the Grim Jest (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 249337, -- Ribbon of Coiled Malice (Fallen-King Salhadaar in The Voidspire)
        [3] = 250004, -- Venom Casks of the Grim Jest (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [5] = 250009, -- Fantastic Finery of the Grim Jest (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 244576, -- Silvermoon Agent's Deflectors (Crafted by Leatherworking)
        [10] = 250007, -- Sleight of Hand of the Grim Jest (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 249374, -- Scorn-Scarred Shul'ka's Belt (Chimaerus in The Dreamrift)
        [7] = 251087, -- Legwraps of Lingering Legacies (Windrunner Spire)
        [8] = 249382, -- Canopy Walker's Footwraps (Crown of the Cosmos in The Voidspire)
        [11] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [12] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [13] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
    },
    ROGUE_OUTLAW = {
        [16] = 260423, -- Arator's Swift Remembrance (Crown of the Cosmos in The Voidspire)
        [17] = 133491, -- Krick's Beetle Stabber (Pit of Saron)
        [1] = 151336, -- Voidlashed Hood (Seat of the Triumvirate)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 250004, -- Venom Casks of the Grim Jest (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 249335, -- Imperator's Banner (Imperator Averzian in The Voidspire)
        [5] = 250009, -- Fantastic Finery of the Grim Jest (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 50264, -- Chewed Leather Wristguards (Pit of Saron)
        [10] = 250007, -- Sleight of Hand of the Grim Jest (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 249374, -- Scorn-Scarred Shul'ka's Belt (Chimaerus in The Dreamrift)
        [7] = 250005, -- Blade Holsters of the Grim Jest (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 244569, -- Silvermoon Agent's Sneakers (Crafted by Leatherworking)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 240949, -- Masterwork Sin'dorei Band (Crafted by Jewelcrafting)
        [13] = 260235, -- Umbral Plume (Belo'ren in March on Quel'Danas)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
    },
    ROGUE_SUBTLETY = {
        [16] = 249925, -- Hungering Victory (Vorasius in The Voidspire)
        [17] = 237837, -- Farstrider's Mercy (Crafted by Blacksmithing)
        [1] = 250006, -- Masquerade of the Grim Jest (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 250004, -- Venom Casks of the Grim Jest (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 258575, -- Rigid Scale Greatcloak (Skyreach)
        [5] = 250009, -- Fantastic Finery of the Grim Jest (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 249327, -- Void-Skinned Bracers (Vorasius in The Voidspire)
        [10] = 250007, -- Sleight of Hand of the Grim Jest (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 244573, -- Silvermoon Agent's Utility Belt (Crafted by Leatherworking)
        [7] = 49817, -- Shaggy Wyrmleather Leggings (Pit of Saron)
        [8] = 250008, -- Balancing Boots of the Grim Jest (Matrix Catalyst)
        [11] = 193708, -- Platinum Star Band (Algeth'ar Academy)
        [12] = 251115, -- Bifurcation Band (Magister's Terrace)
        [13] = 249344, -- Light Company Guidon (Imperator Averzian in The Voidspire)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
    },
    SHAMAN_ELEMENTAL = {
        [16] = 251083, -- Excavating Cudgel (Windrunner Spire)
        [17] = 251105, -- Ward of the Spellbreaker (Magister's Terrace)
        [1] = 249979, -- Locus of the Primal Core (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 249977, -- Tempests of the Primal Core (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 249974, -- Guardian of the Primal Core (Matrix Catalyst)
        [5] = 249982, -- Embrace of the Primal Core (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 249304, -- Fallen King's Cuffs (Fallen-King Salhadaar in The Voidspire)
        [10] = 249980, -- Earthgrips of the Primal Core (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 244611, -- World Tender's Barkclasp (Crafted by Leatherworking)
        [7] = 251215, -- Greaves of the Divine Guile (Nexus-Point Xenas)
        [8] = 244610, -- World Tender's Rootslippers (Crafted by Leatherworking)
        [11] = 193708, -- Platinum Star Band (Algeth'ar Academy)
        [12] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [13] = 250144, -- Emberwing Feather (Windrunner Spire)
        [14] = 249809, -- Locus-Walker's Ribbon (Crown of the Cosmos in The Voidspire)
    },
    SHAMAN_ENHANCEMENT = {
        [16] = 249287, -- Clutchmates' Caress (Vaelgor and Ezzorak)
        [17] = 237850, -- Farstrider's Chopper (Blacksmithing)
        [1] = 249979, -- Locus of the Primal Core (Lightblinded Vanguard)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls)
        [3] = 249977, -- Tempests of the Primal Core (Fallen-King Salhadaar)
        [15] = 239656, -- Adherent's Silken Shroud (Tailoring)
        [5] = 249982, -- Embrace of the Primal Core (Chimaerus)
        [9] = 249304, -- Fallen King's Cuffs (Fallen-King Salhadaar)
        [10] = 249980, -- Earthgrips of the Primal Core (Vorasius)
        [6] = 249976, -- Ceinture of the Primal Core (Matrix Catalyst)
        [7] = 249324, -- Eternal Flame Scaleguards (Belo'ren)
        [8] = 251084, -- Whipcoil Sabatons (Windrunner Spire)
        [11] = 249920, -- Eye of Midnight (Midnight Falls)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus)
        [14] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
    },
    SHAMAN_RESTORATION = {
        [16] = 249293, -- Weight of Command (Imperator Averzian in The Voidspire)
        [17] = 249921, -- Thalassian Dawnguard (Belo'ren in March on Quel'Danas)
        [1] = 249914, -- Oblivion Guise (Midnight Falls in March on Quel'Danas)
        [2] = 249337, -- Ribbon of Coiled Malice (Fallen-King Salhadaar in The Voidspire)
        [3] = 249977, -- Tempests of the Primal Core (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 249974, -- Guardian of the Primal Core (Matrix Catalyst)
        [5] = 249982, -- Embrace of the Primal Core (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 249975, -- Cuffs of the Primal Core (Matrix Catalyst)
        [10] = 249980, -- Earthgrips of the Primal Core (Matrix Catalyst , or Vorasius in The Voidspire)
        [6] = 244611, -- World Tender's Barkclasp (Crafted by Leatherworking)
        [7] = 249978, -- Leggings of the Primal Core (Matrix Catalyst , or Vaelgor and Ezzorak in The Dreamrift)
        [8] = 244610, -- World Tender's Rootslippers (Crafted by Leatherworking)
        [11] = 151308, -- Eredath Seal of Nobility (Seat of the Triumvirate)
        [12] = 151311, -- Band of the Triumvirate (Seat of the Triumvirate)
        [13] = 249808, -- Litany of Lightblind Wrath (Lightblinded Vanguard in The Voidspire)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
    },
    WARLOCK_AFFLICTION = {
        [16] = 251111, -- Splitshroud Stinger (Magister's Terrace)
        [17] = 249276, -- Grimoire of the Eternal Light (Vorasius in The Voidspire)
        [1] = 250042, -- Abyssal Immolator's Smoldering Flames (Lightblinded Vanguard in The Voidspire or Matrix Catalyst)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 249328, -- Echoing Void Mantle (Belo'ren in March on Quel'Danas)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 250045, -- Abyssal Immolator's Dreadrobe (Chimaerus in The Dreamrift or Matrix Catalyst)
        [9] = 239648, -- Martyr's Bindings (Crafted by Tailoring)
        [10] = 250043, -- Abyssal Immolator's Grasps (Vorasius in The Voidspire or Matrix Catalyst)
        [6] = 251102, -- Clasp of Compliance (Magister's Terrace)
        [7] = 250041, -- Abyssal Immolator's Pillars (Vaelgor and Ezzorak in The Voidspire or Matrix Catalyst)
        [8] = 249305, -- Slippers of the Midnight Flame (Vaelgor and Ezzorak in The Voidspire)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 250144, -- Emberwing Feather (Windrunner Spire)
        [14] = 249810, -- Shadow of the Empyrean Requiem (Midnight Falls in March on Quel'Danas)
    },
    WARLOCK_DEMONOLOGY = {
        [16] = 258047, -- Spire of the Furious Construct (Skyreach)
        [1] = 250042, -- Abyssal Immolator's Smoldering Flames (Lightblinded Vanguard in The Voidspire or Matrix Catalyst)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 251085, -- Mantle of Dark Devotion (Windrunner Spire)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 250045, -- Abyssal Immolator's Dreadrobe (Chimaerus in The Dreamrift or Matrix Catalyst)
        [9] = 239648, -- Martyr's Bindings (Crafted by Tailoring)
        [10] = 250043, -- Abyssal Immolator's Grasps (Vorasius in The Voidspire or Matrix Catalyst)
        [6] = 250039, -- Abyssal Immolator's Blazing Core (Matrix Catalyst)
        [7] = 250041, -- Abyssal Immolator's Pillars (Vaelgor and Ezzorak in The Voidspire or Matrix Catalyst)
        [8] = 249373, -- Dream-Scorched Striders (Chimaerus in The Dreamrift)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 249336, -- Signet of the Starved Beast (Vorasius in The Voidspire)
        [13] = 250144, -- Emberwing Feather (Windrunner Spire)
        [14] = 249809, -- Locus-Walker's Ribbon (Crown of the Cosmos in The Voidspire)
    },
    WARLOCK_DESTRUCTION = {
        [16] = 258047, -- Spire of the Furious Construct (Skyreach)
        [1] = 250042, -- Abyssal Immolator's Smoldering Flames (Lightblinded Vanguard in The Voidspire or Matrix Catalyst)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 251085, -- Mantle of Dark Devotion (Windrunner Spire)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 250045, -- Abyssal Immolator's Dreadrobe (Chimaerus in The Dreamrift or Matrix Catalyst)
        [9] = 239648, -- Martyr's Bindings (Crafted by Tailoring)
        [10] = 250043, -- Abyssal Immolator's Grasps (Vorasius in The Voidspire or Matrix Catalyst)
        [6] = 250039, -- Abyssal Immolator's Blazing Core (Matrix Catalyst)
        [7] = 250041, -- Abyssal Immolator's Pillars (Vaelgor and Ezzorak in The Voidspire or Matrix Catalyst)
        [8] = 249305, -- Slippers of the Midnight Flame (Vaelgor and Ezzorak in The Voidspire)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 249336, -- Signet of the Starved Beast (Vorasius in The Voidspire)
        [13] = 249346, -- Vaelgor's Final Stare (Vaelgor and Ezzorak in The Voidspire)
        [14] = 249810, -- Shadow of the Empyrean Requiem (Midnight Falls in March on Quel'Danas)
    },
    WARRIOR_ARMS = {
        [16] = 249296, -- Alah'endal, the Dawnsong (Midnight Falls in March on Quel'Danas)
        [1] = 249952, -- Night Ender's Tusks (Lightblinded Vanguard in The Voidspire)
        [2] = 249337, -- Ribbon of Coiled Malice (Fallen-King Salhadaar in The Voidspire)
        [3] = 249950, -- Night Ender's Pauldrons (Fallen-King Salhadaar in The Voidspire)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 249955, -- Night Ender's Breastplate (Chimaerus in The Dreamrift)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 251081, -- Embergrove Grasps (Windrunner Spire)
        [6] = 249949, -- Night Ender's Girdle (Matrix Catalyst)
        [7] = 249951, -- Night Ender's Chausses (Vaelgor and Ezzorak in The Voidspire)
        [8] = 249381, -- Greaves of the Unformed (Chimaerus in The Dreamrift)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 249342, -- Heart of Ancient Hunger (Vorasius in The Voidspire)
    },
    WARRIOR_FURY = {
        [16] = 249277, -- Bellamy's Final Judgement (Lightblinded Vanguard in The Voidspire)
        [17] = 237847, -- Blood Knight's Impetus (Crafted by Blacksmithing)
        [1] = 249952, -- Night Ender's Tusks (Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 249950, -- Night Ender's Pauldrons (Fallen-King Salhadaar in The Voidspire)
        [15] = 258575, -- Rigid Scale Greatcloak (Skyreach)
        [5] = 249955, -- Night Ender's Breastplate (Chimaerus in The Dreamrift)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 151332, -- Voidclaw Gauntlets (Seat of the Triumvirate)
        [6] = 249949, -- Night Ender's Girdle (Matrix Catalyst)
        [7] = 249951, -- Night Ender's Chausses (Vaelgor and Ezzorak in The Voidspire)
        [8] = 249954, -- Night Ender's Greatboots (Matrix Catalyst)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 193708, -- Platinum Star Band (Algeth'ar Academy)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 249342, -- Heart of Ancient Hunger (Vorasius in The Voidspire)
    },
    WARRIOR_PROTECTION = {
        [16] = 249295, -- Turalyon's False Echo (Crown of the Cosmos in The Voidspire)
        [17] = 251105, -- Ward of the Spellbreaker (Magister's Terrace)
        [1] = 249952, -- Night Ender's Tusks (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 249950, -- Night Ender's Pauldrons (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted — Tailoring)
        [5] = 249955, -- Night Ender's Breastplate (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted — Blacksmithing)
        [10] = 151332, -- Voidclaw Gauntlets (Seat of the Triumvirate)
        [6] = 249949, -- Night Ender's Girdle (Matrix Catalyst)
        [7] = 249951, -- Night Ender's Chausses (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249954, -- Night Ender's Greatboots (Matrix Catalyst)
        [11] = 249920, -- Eye of Midnight (Midnight Falls)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy , only BiS if you can use it consistently.)
    },
}
