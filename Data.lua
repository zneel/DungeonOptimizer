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
-- BIS LISTS - MYTHIC (from Icy Veins, Midnight Season 1)
-- ============================================================================
NS.BIS_MYTHIC = {
    DEATHKNIGHT_BLOOD = {
        [16] = 251168, -- Liferipper's Cutlass (Maisara Caverns)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [9] = 251203, -- Kasreth's Bindings (Nexus-Point Xenas)
        [10] = 151332, -- Voidclaw Gauntlets (Seat of the Triumvirate)
    },
    DEATHKNIGHT_FROST = {
        [16] = 251168, -- Liferipper's Cutlass (Maisara Caverns)
        [2] = 50228, -- Barbed Ymirheim Choker (Seat of the Triumvirate)
        [3] = 50234, -- Shoulderplates of Frozen Blood (Pit of Saron)
        [6] = 49808, -- Bent Gold Belt (Pit of Saron)
        [8] = 251107, -- Oathsworn Stompers (Magister's Terrace)
        [11] = 193708, -- Platinum Star Band (Algeth'ar Academy)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
        [14] = 252420, -- Solarflare Prism (Skyreach)
    },
    DEATHKNIGHT_UNHOLY = {
        [16] = 251168, -- Liferipper's Cutlass (Maisara Caverns)
        [2] = 50228, -- Barbed Ymirheim Choker (Seat of the Triumvirate)
        [3] = 50234, -- Shoulderplates of Frozen Blood (Pit of Saron)
        [6] = 49808, -- Bent Gold Belt (Pit of Saron)
        [8] = 251107, -- Oathsworn Stompers (Magister's Terrace)
        [11] = 193708, -- Platinum Star Band (Algeth'ar Academy)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
        [14] = 252420, -- Solarflare Prism (Skyreach)
    },
    DEMONHUNTER_DEVOURER = {
        [16] = 193710, -- Spellboon Saber (Algeth'ar Academy)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [9] = 193714, -- Frenzyroot Cuffs (Matrix Catalyst)
        [7] = 49817, -- Shaggy Wyrmleather Leggings (Pit of Saron)
        [8] = 258577, -- Boots of Burning Focus (Skyreach)
        [11] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [12] = 251115, -- Bifurcation Band (Magister's Terrace)
        [13] = 250256, -- Heart of Wind (Windrunner Spire)
        [14] = 250144, -- Emberwing Feather (Windrunner Spire)
    },
    DEMONHUNTER_HAVOC = {
        [1] = 251109, -- Spellsnap Shadowmask (Magister's Terrace)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [6] = 251082, -- Snapvine Cinch (Windrunner Spire)
        [8] = 258577, -- Boots of Burning Focus (Skyreach)
        [11] = 193708, -- Platinum Star Band (Algeth'ar Academy)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 193701, -- Algeth'ar Puzzle Box (Windrunner Spire)
        [14] = 252420, -- Solarflare Prism (Skyreach)
    
        [16] = 251106, -- Resolute Runeglaive (Magister's Terrace)
        [17] = 251122, -- Shadowslash Slicer (Magister's Terrace)
    },
    DEMONHUNTER_VENGEANCE = {
        [2] = 151309, -- Necklace of the Twisting Void (Seat of the Triumvirate)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [5] = 251216, -- Maledict Vest (Nexus-Point Xenas)
        [6] = 251166, -- Falconer's Cinch (Maisara Caverns)
        [8] = 251210, -- Eclipse Espadrilles (Nexus-Point Xenas)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [12] = 49812, -- Purloined Wedding Ring (Pit of Saron)
        [13] = 250256, -- Heart of Wind (Windrunner Spire)
        [14] = 252420, -- Solarflare Prism (Skyreach)
        [16] = 251106, -- Resolute Runeglaive (Magister's Terrace)
        [17] = 251162, -- Traitor's Talon (Maisara Caverns)
    },
    DRUID_BALANCE = {
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [9] = 50264, -- Chewed Leather Wristguards (Pit of Saron)
        [6] = 251082, -- Snapvine Cinch (Windrunner Spire)
        [11] = 251115, -- Bifurcation Band (Magister's Terrace)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 250144, -- Emberwing Feather (Windrunner Spire)
        [14] = 250223, -- Soulcatcher's Charm (Maisara Caverns)
    },
    DRUID_FERAL = {
        [16] = 251077, -- Roostwarden's Bough (Windrunner Spire)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 251092, -- Fallen Grunt's Mantle (Windrunner Spire)
        [6] = 49806, -- Flayer's Black Belt (Pit of Saron)
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
        [15] = 251161, -- Soulhunter's Mask (Maisara Caverns)
        [8] = 251210, -- Eclipse Espadrilles (Nexus-Point Xenas)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 250144, -- Emberwing Feather (Windrunner Spire)
        [14] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
    },
    DRUID_RESTORATION = {
        [16] = 193707, -- Final Grade (Algeth'ar Academy)
        [2] = 251096, -- Pendant of Aching Grief (Windrunner Spire)
        [15] = 193712, -- Potion-Stained Cloak (Algeth'ar Academy)
        [5] = 251216, -- Maledict Vest (Nexus-Point Xenas)
        [9] = 193714, -- Frenzyroot Cuffs (Algeth'ar Academy)
        [6] = 251166, -- Falconer's Cinch (Maisara Caverns)
        [8] = 251121, -- Domanaar's Dire Treads (Magister's Terrace)
        [11] = 251093, -- Omission of Light (Nexus-Point Xenas)
    },
    EVOKER_AUGMENTATION = {
        [1] = 49824, -- Horns of the Spurned Val'kyr (Pit of Saron)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [6] = 49810, -- Scabrous Zombie Leather Belt (Pit of Saron)
        [8] = 193715, -- Boots of Explosive Growth (Algeth'ar Academy Matrix Catalyst)
    },
    EVOKER_DEVASTATION = {
        [16] = 251201, -- Corespark Multitool (Nexus-Point Xenas)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [9] = 251079, -- Amberfrond Bracers (Windrunner Spire)
        [6] = 49810, -- Scabrous Zombie Leather Belt (Pit of Saron)
        [8] = 251084, -- Whipcoil Sabatons (Windrunner Spire)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [14] = 250258, -- Vessel of Tortured Souls (Maisara Caverns)
    },
    EVOKER_PRESERVATION = {
        [16] = 258514, -- Umbral Spire of Zuraal (Seat of the Triumvirate)
        [1] = 251119, -- Vortex Visage (Magister's Terrace)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [15] = 251206, -- Fluxweave Cloak (Nexus-Point Xenas)
        [9] = 251079, -- Amberfrond Bracers (Windrunner Spire)
        [11] = 251115, -- Bifurcation Band (Magister's Terrace)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 250256, -- Heart of Wind (Windrunner Spire)
        [14] = 250144, -- Emberwing Feather (Windrunner Spire)
    },
    HUNTER_BEASTMASTERY = {
        [16] = 251174, -- Deceiver's Rotbow (Maisara Caverns)
        [2] = 151309, -- Necklace of the Twisting Void (Seat of the Triumvirate)
        [3] = 151323, -- Pauldrons of the Void Hunter (Seat of the Triumvirate)
        [15] = 258575, -- Rigid Scale Greatcloak (Skyreach)
        [9] = 251079, -- Amberfrond Bracers (Windrunner Spire)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
        [14] = 250258, -- Vessel of Tortured Souls (Maisara Caverns)
    },
    HUNTER_MARKSMANSHIP = {
        [16] = 251095, -- Hurricane's Heart (Windrunner Spire)
        [2] = 151309, -- Necklace of the Twisting Void (Seat of the Triumvirate)
        [3] = 151323, -- Pauldrons of the Void Hunter (Seat of the Triumvirate)
        [15] = 251206, -- Fluxweave Cloak (Nexus-Point Xenas)
        [9] = 251079, -- Amberfrond Bracers (Windrunner Spire)
        [11] = 193708, -- Platinum Star Band (Algeth'ar Academy)
        [12] = 151308, -- Eredath Seal of Nobility (Seat of the Triumvirate)
        [13] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
        [14] = 252420, -- Solarflare Prism (Skyreach)
    },
    HUNTER_SURVIVAL = {
        [2] = 251096, -- Pendant of Aching Grief (Windrunner Spire)
        [3] = 151323, -- Pauldrons of the Void Hunter (Seat of the Triumvirate)
        [15] = 258575, -- Rigid Scale Greatcloak (Skyreach)
        [9] = 251079, -- Amberfrond Bracers (Windrunner Spire)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
        [14] = 252420, -- Solarflare Prism (Skyreach)
    },
    MAGE_ARCANE = {
        [16] = 258218, -- Skybreaker's Blade (Skyreach)
        [17] = 251094, -- Sigil of the Restless Heart (Windrunner Spire)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
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
        [2] = 151309, -- Necklace of the Twisting Void (Seat of the Triumvirate)
        [5] = 49825, -- Palebone Robes (Pit of Saron)
        [6] = 50263, -- Braid of Salt and Fire (Pit of Saron)
        [8] = 258584, -- Lightbinder Treads (Skyreach)
        [11] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 250144, -- Emberwing Feather (Windrunner Spire)
        [14] = 250256, -- Heart of Wind (Windrunner Spire)
    },
    MAGE_FROST = {
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 251085, -- Mantle of Dark Devotion (Windrunner Spire)
        [15] = 258575, -- Rigid Scale Greatcloak (Skyreach)
        [8] = 133489, -- Ice-Steeped Sandals (Pit of Saron)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 250144, -- Emberwing Feather (Windrunner Spire)
        [14] = 250256, -- Heart of Wind (Windrunner Spire)
    },
    MONK_BREWMASTER = {
        [15] = 251161, -- Soulhunter's Mask (Maisara Caverns)
        [9] = 50264, -- Chewed Leather Wristguards (Pit of Saron)
        [6] = 251082, -- Snapvine Cinch (Windrunner Spire)
        [8] = 151317, -- Footpads of Seeping Dread (Seat of the Triumvirate)
        [11] = 151308, -- Eredath Seal of Nobility (Seat of the Triumvirate)
    },
    MONK_MISTWEAVER = {
        [16] = 258050, -- Arcanic of the High Sage (Skyreach)
        [17] = 193709, -- Vexamus' Expulsion Rod (Algeth'ar Academy)
        [1] = 151336, -- Voidlashed Hood (Seat of the Triumvirate)
        [2] = 251096, -- Pendant of Aching Grief (Windrunner Spire)
        [6] = 251166, -- Falconer's Cinch (Maisara Caverns)
        [8] = 251210, -- Eclipse Espadrilles (Nexus-Point Xenas)
        [11] = 151308, -- Eredath Seal of Nobility (Seat of the Triumvirate)
        [13] = 250256, -- Heart of Wind (Windrunner Spire)
        [14] = 250144, -- Emberwing Feather (Windrunner Spire)
    },
    MONK_WINDWALKER = {
        [16] = 251162, -- Traitor's Talon (Maisara Caverns)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [9] = 193714, -- Frenzyroot Cuffs (Algeth'ar Academy)
        [10] = 151318, -- Gloves of the Dark Shroud (Seat of the Triumvirate)
        [6] = 251082, -- Snapvine Cinch (Windrunner Spire)
        [13] = 250256, -- Heart of Wind (Windrunner Spire)
        [14] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
    },
    PALADIN_HOLY = {
        [17] = 258049, -- Viryx's Indomitable Bulwark (Skyreach)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [6] = 151327, -- Girdle of the Shadowguard (Seat of the Triumvirate)
        [7] = 251118, -- Legplates of Lingering Dusk (Magister's Terrace)
        [8] = 251107, -- Oathsworn Stompers (Magister's Terrace)
        [11] = 251115, -- Bifurcation Band (Magister's Terrace)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 250256, -- Heart of Wind (Windrunner Spire)
        [14] = 250144, -- Emberwing Feather (Windrunner Spire)
    },
    PALADIN_PROTECTION = {
    },
    PALADIN_RETRIBUTION = {
        [16] = 251168, -- Liferipper's Cutlass (Maisara Caverns)
        [2] = 50228, -- Barbed Ymirheim Choker (Midnight Falls in March on Quel'Danas)
        [10] = 151332, -- Voidclaw Gauntlets (Seat of the Triumvirate)
        [6] = 151327, -- Girdle of the Shadowguard (Seat of the Triumvirate)
        [8] = 251107, -- Oathsworn Stompers (Magister's Terrace)
        [11] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 252420, -- Solarflare Prism (Skyreach)
        [14] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
    },
    PRIEST_DISCIPLINE = {
        [16] = 251178, -- Ceremonial Hexblade (Maisara Caverns)
        [2] = 151309, -- Necklace of the Twisting Void (Seat of the Triumvirate)
        [3] = 251213, -- Nysarra's Mantle (Nexus-Point Xenas)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [9] = 133493, -- Wristguards of Subterranean Moss (Pit of Saron)
        [8] = 258584, -- Lightbinder Treads (Skyreach)
        [11] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 250256, -- Heart of Wind (Windrunner Spire)
        [14] = 193718, -- Emerald Coach's Whistle (Algeth'ar Academy)
    },
    PRIEST_HOLY = {
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [15] = 49823, -- Cloak of the Fallen Cardinal (Pit of Saron)
        [9] = 258580, -- Bracers of Blazing Light (Skyreach)
        [8] = 251167, -- Nightprey Stalkers (Maisara Caverns)
        [11] = 151308, -- Eredath Seal of Nobility (Seat of the Triumvirate)
    },
    PRIEST_SHADOW = {
        [2] = 151309, -- Necklace of the Twisting Void (Seat of the Triumvirate)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [9] = 151305, -- Entropic Wristwraps (Seat of the Triumvirate)
        [10] = 251172, -- Vilehex Bonds (Maisara Caverns)
        [8] = 258584, -- Lightbinder Treads (Skyreach)
    },
    ROGUE_ASSASSINATION = {
        [2] = 151309, -- Necklace of the Twisting Void (Seat of the Triumvirate)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [6] = 251082, -- Snapvine Cinch (Windrunner Spire)
        [7] = 251087, -- Legwraps of Lingering Legacies (Windrunner Spire)
        [8] = 258577, -- Boots of Burning Focus (Skyreach)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
        [14] = 252420, -- Solarflare Prism (Skyreach)
    },
    ROGUE_OUTLAW = {
        [1] = 151336, -- Voidlashed Hood (Seat of the Triumvirate)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [9] = 50264, -- Chewed Leather Wristguards (Pit of Saron)
        [6] = 251166, -- Falconer's Cinch (Maisara Caverns)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 250256, -- Heart of Wind (Windrunner Spire)
        [14] = 252420, -- Solarflare Prism (Skyreach)
    },
    ROGUE_SUBTLETY = {
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [15] = 258575, -- Rigid Scale Greatcloak (Skyreach)
        [9] = 193714, -- Frenzyroot Cuffs (Algeth'ar Academy)
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
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [15] = 258575, -- Rigid Scale Greatcloak (Skyreach)
        [9] = 251079, -- Amberfrond Bracers (Windrunner Spire)
        [7] = 251215, -- Greaves of the Divine Guile (Nexus-Point Xenas)
        [11] = 193708, -- Platinum Star Band (Algeth'ar Academy)
        [12] = 251115, -- Bifurcation Band (Magister's Terrace)
        [13] = 250144, -- Emberwing Feather (Windrunner Spire)
        [14] = 250256, -- Heart of Wind (Windrunner Spire)
    },
    SHAMAN_ENHANCEMENT = {
        [16] = 258438, -- Blazing Sunclaws (Skyreach)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [9] = 251079, -- Amberfrond Bracers (Windrunner Spire)
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
        [15] = 258575, -- Rigid Scale Greatcloak (Skyreach)
        [9] = 151321, -- Darkfang Scale Wristguards (Seat of the Triumvirate)
        [11] = 151308, -- Eredath Seal of Nobility (Seat of the Triumvirate)
        [13] = 193718, -- Emerald Coach's Whistle (Algeth'ar Academy)
        [14] = 250253, -- Whisper of the Duskwraith (Nexus-Point Xenas)
    },
    WARLOCK_AFFLICTION = {
        [16] = 251111, -- Splitshroud Stinger (Magister's Terrace)
        [17] = 251094, -- Sigil of the Restless Heart (Windrunner Spire)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 251085, -- Mantle of Dark Devotion (Windrunner Spire)
        [6] = 251102, -- Clasp of Compliance (Magister's Terrace)
        [8] = 251167, -- Nightprey Stalkers (Maisara Caverns)
        [11] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 250144, -- Emberwing Feather (Windrunner Spire)
        [14] = 250256, -- Heart of Wind (Windrunner Spire)
    },
    WARLOCK_DEMONOLOGY = {
        [16] = 258047, -- Spire of the Furious Construct (Skyreach)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 251085, -- Mantle of Dark Devotion (Windrunner Spire)
        [8] = 251167, -- Nightprey Stalkers (Maisara Caverns)
        [11] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 250144, -- Emberwing Feather (Windrunner Spire)
        [14] = 250258, -- Vessel of Tortured Souls (Maisara Caverns)
    },
    WARLOCK_DESTRUCTION = {
        [16] = 258047, -- Spire of the Furious Construct (Skyreach)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 251085, -- Mantle of Dark Devotion (Windrunner Spire)
        [8] = 251167, -- Nightprey Stalkers (Maisara Caverns)
        [11] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 250256, -- Heart of Wind (Windrunner Spire)
        [14] = 250258, -- Vessel of Tortured Souls (Maisara Caverns)
    },
    WARRIOR_ARMS = {
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [10] = 151332, -- Voidclaw Gauntlets (Seat of the Triumvirate)
        [6] = 49808, -- Bent Gold Belt (Pit of Saron)
        [8] = 251107, -- Oathsworn Stompers (Magister's Terrace)
        [11] = 49812, -- Purloined Wedding Ring (Pit of Saron)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
        [14] = 252420, -- Solarflare Prism (Skyreach)
    },
    WARRIOR_FURY = {
        [1] = 251098, -- Fletcher's Faded Faceplate (Windrunner Spire)
        [2] = 151309, -- Necklace of the Twisting Void (Seat of the Triumvirate)
        [3] = 251164, -- Amalgamation's Harness (Maisara Caverns)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [5] = 151329, -- Breastplate of the Dark Touch (Seat of the Triumvirate)
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
        [2] = 151309, -- Necklace of the Twisting Void (Seat of the Triumvirate)
        [10] = 151332, -- Voidclaw Gauntlets (Seat of the Triumvirate)
        [6] = 251086, -- Riphook Defender (Windrunner Spire)
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
    },
    DEATHKNIGHT_FROST = {
    },
    DEATHKNIGHT_UNHOLY = {
    },
    DEMONHUNTER_DEVOURER = {
    },
    DEMONHUNTER_HAVOC = {
    },
    DEMONHUNTER_VENGEANCE = {
    },
    DRUID_BALANCE = {
    },
    DRUID_FERAL = {
    },
    DRUID_GUARDIAN = {
    },
    DRUID_RESTORATION = {
    },
    EVOKER_AUGMENTATION = {
    },
    EVOKER_DEVASTATION = {
    },
    EVOKER_PRESERVATION = {
    },
    HUNTER_BEASTMASTERY = {
    },
    HUNTER_MARKSMANSHIP = {
    },
    HUNTER_SURVIVAL = {
    },
    MAGE_ARCANE = {
    },
    MAGE_FIRE = {
    },
    MAGE_FROST = {
    },
    MONK_BREWMASTER = {
    },
    MONK_MISTWEAVER = {
    },
    MONK_WINDWALKER = {
    },
    PALADIN_HOLY = {
    },
    PALADIN_PROTECTION = {
        [16] = 193711, -- Spellbane Cutlass (Algeth'ar Academy)
        [17] = 251105, -- Ward of the Spellbreaker (Magister's Terrace)
        [2] = 251096, -- Pendant of Aching Grief (Windrunner Spire)
        [15] = 49823, -- Cloak of the Fallen Cardinal (Pit of Saron)
        [10] = 151332, -- Voidclaw Gauntlets (Seat of the Triumvirate)
        [6] = 251112, -- Shadowsplit Girdle (Magister's Terrace)
        [8] = 251169, -- Footwraps of Ill-Fate (Maisara Caverns)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 252420, -- Solarflare Prism (Skyreach)
        [14] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
    },
    PALADIN_RETRIBUTION = {
    },
    PRIEST_DISCIPLINE = {
    },
    PRIEST_HOLY = {
    },
    PRIEST_SHADOW = {
    },
    ROGUE_ASSASSINATION = {
    },
    ROGUE_OUTLAW = {
    },
    ROGUE_SUBTLETY = {
    },
    SHAMAN_ELEMENTAL = {
        [17] = 251105, -- Ward of the Spellbreaker (Magister's Terrace)
    },
    SHAMAN_ENHANCEMENT = {
    },
    SHAMAN_RESTORATION = {
    },
    WARLOCK_AFFLICTION = {
    },
    WARLOCK_DEMONOLOGY = {
    },
    WARLOCK_DESTRUCTION = {
    },
    WARRIOR_ARMS = {
    },
    WARRIOR_FURY = {
        [10] = 251081, -- Embergrove Grasps (Windrunner Spire)
    },
    WARRIOR_PROTECTION = {
    },
}

-- ============================================================================
-- DUNGEON LOOT TABLES
-- Extracted from BIS lists: items whose source is a M+ dungeon
-- ============================================================================
NS.DUNGEON_LOOT = {
    -- Algeth'ar Academy (22 items)
    ALGETHAR = {
        { itemId = 193720, slot = 5, itemName = "Bronze Challenger's Robe", boss = "Crawth" },
        { itemId = 193722, slot = 6, itemName = "Azure Belt of Competition", boss = "Crawth" },
        { itemId = 193721, slot = 10, itemName = "Ruby Contestant's Gloves", boss = "Crawth" },
        { itemId = 193718, slot = 13, itemName = "Emerald Coach's Whistle", boss = "Crawth" },
        { itemId = 193719, slot = 13, itemName = "Dragon Games Equipment", boss = "Crawth" },
        { itemId = 193723, slot = 16, itemName = "Obsidian Goaltending Spire", boss = "Crawth" },
        { itemId = 193703, slot = 1, itemName = "Organized Pontificator's Mask", boss = "Echo of Doragosa" },
        { itemId = 193704, slot = 3, itemName = "Scaled Commencement Spaulders", boss = "Echo of Doragosa" },
        { itemId = 193705, slot = 5, itemName = "Breastplate of Proven Knowledge", boss = "Echo of Doragosa" },
        { itemId = 193706, slot = 7, itemName = "Venerated Professor's Greaves", boss = "Echo of Doragosa" },
        { itemId = 193701, slot = 13, itemName = "Algeth'ar Puzzle Box", boss = "Echo of Doragosa" },
        { itemId = 193707, slot = 16, itemName = "Final Grade", boss = "Echo of Doragosa" },
        { itemId = 193715, slot = 8, itemName = "Boots of Explosive Growth", boss = "Overgrown Ancient" },
        { itemId = 193714, slot = 9, itemName = "Frenzyroot Cuffs", boss = "Overgrown Ancient" },
        { itemId = 193713, slot = 10, itemName = "Experimental Safety Gloves", boss = "Overgrown Ancient" },
        { itemId = 193712, slot = 15, itemName = "Potion-Stained Cloak", boss = "Overgrown Ancient" },
        { itemId = 193716, slot = 16, itemName = "Algeth'ar Hedgecleaver", boss = "Overgrown Ancient" },
        { itemId = 193717, slot = 16, itemName = "Mystakra's Harvester", boss = "Overgrown Ancient" },
        { itemId = 193708, slot = 11, itemName = "Platinum Star Band", boss = "Vexamus" },
        { itemId = 193710, slot = 16, itemName = "Spellboon Saber", boss = "Vexamus" },
        { itemId = 193711, slot = 16, itemName = "Spellbane Cutlass", boss = "Vexamus" },
        { itemId = 193709, slot = 17, itemName = "Vexamus' Expulsion Rod", boss = "Vexamus" },
    },
    -- Magisters' Terrace (26 items)
    MAGISTER = {
        { itemId = 251101, slot = 5, itemName = "Arcane Guardian's Shell", boss = "Arcanotron" },
        { itemId = 251102, slot = 6, itemName = "Clasp of Compliance", boss = "Arcanotron" },
        { itemId = 251104, slot = 7, itemName = "Leggings of Orderly Conduct", boss = "Arcanotron" },
        { itemId = 251103, slot = 9, itemName = "Custodial Cuffs", boss = "Arcanotron" },
        { itemId = 250246, slot = 13, itemName = "Refueling Orb", boss = "Arcanotron" },
        { itemId = 251100, slot = 16, itemName = "Malfeasance Mallet", boss = "Arcanotron" },
        { itemId = 251119, slot = 1, itemName = "Vortex Visage", boss = "Degentrius" },
        { itemId = 251120, slot = 5, itemName = "Wraps of Umbral Descent", boss = "Degentrius" },
        { itemId = 251118, slot = 7, itemName = "Legplates of Lingering Dusk", boss = "Degentrius" },
        { itemId = 251121, slot = 8, itemName = "Domanaar's Dire Treads", boss = "Degentrius" },
        { itemId = 250257, slot = 13, itemName = "Eye of the Drowning Void", boss = "Degentrius" },
        { itemId = 251117, slot = 16, itemName = "Whirling Voidcleaver", boss = "Degentrius" },
        { itemId = 251122, slot = 17, itemName = "Shadowslash Slicer", boss = "Degentrius" },
        { itemId = 251114, slot = 5, itemName = "Voidwarped Oozemail", boss = "Gemellus" },
        { itemId = 251112, slot = 6, itemName = "Shadowsplit Girdle", boss = "Gemellus" },
        { itemId = 251113, slot = 10, itemName = "Gloves of Viscous Goo", boss = "Gemellus" },
        { itemId = 251115, slot = 11, itemName = "Bifurcation Band", boss = "Gemellus" },
        { itemId = 250242, slot = 13, itemName = "Jelly Replicator", boss = "Gemellus" },
        { itemId = 251111, slot = 16, itemName = "Splitshroud Stinger", boss = "Gemellus" },
        { itemId = 251109, slot = 1, itemName = "Spellsnap Shadowmask", boss = "Seranel Sunlash" },
        { itemId = 251110, slot = 6, itemName = "Sunlash's Sunsash", boss = "Seranel Sunlash" },
        { itemId = 251107, slot = 8, itemName = "Oathsworn Stompers", boss = "Seranel Sunlash" },
        { itemId = 251108, slot = 9, itemName = "Wraps of Watchful Wrath", boss = "Seranel Sunlash" },
        { itemId = 260312, slot = 15, itemName = "Defiant Defender's Drape", boss = "Seranel Sunlash" },
        { itemId = 251106, slot = 16, itemName = "Resolute Runeglaive", boss = "Seranel Sunlash" },
        { itemId = 251105, slot = 17, itemName = "Ward of the Spellbreaker", boss = "Seranel Sunlash" },
    },
    -- Maisara Caverns (20 items)
    MAISARA = {
        { itemId = 251176, slot = 3, itemName = "Reanimator's Weight", boss = "Muro'jin and Nekraxx" },
        { itemId = 251166, slot = 6, itemName = "Falconer's Cinch", boss = "Muro'jin and Nekraxx" },
        { itemId = 251167, slot = 8, itemName = "Nightprey Stalkers", boss = "Muro'jin and Nekraxx" },
        { itemId = 263193, slot = 9, itemName = "Trollhunter's Bands", boss = "Muro'jin and Nekraxx" },
        { itemId = 251162, slot = 17, itemName = "Traitor's Talon", boss = "Muro'jin and Nekraxx" },
        { itemId = 251174, slot = 16, itemName = "Deceiver's Rotbow", boss = "Muro'jin and Nekraxx" },
        { itemId = 251177, slot = 1, itemName = "Fetid Vilecrown", boss = "Rak'tul, Vessel of Souls" },
        { itemId = 251164, slot = 3, itemName = "Amalgamation's Harness", boss = "Rak'tul, Vessel of Souls" },
        { itemId = 251179, slot = 5, itemName = "Decaying Cuirass", boss = "Rak'tul, Vessel of Souls" },
        { itemId = 250258, slot = 13, itemName = "Vessel of Tortured Souls", boss = "Rak'tul, Vessel of Souls" },
        { itemId = 251163, slot = 16, itemName = "Berserker's Hexclaws", boss = "Rak'tul, Vessel of Souls" },
        { itemId = 251168, slot = 16, itemName = "Liferipper's Cutlass", boss = "Rak'tul, Vessel of Souls" },
        { itemId = 251175, slot = 16, itemName = "Soulblight Cleaver", boss = "Rak'tul, Vessel of Souls" },
        { itemId = 251171, slot = 3, itemName = "Enthralled Bonespines", boss = "Vordaza" },
        { itemId = 251170, slot = 7, itemName = "Wickedweave Trousers", boss = "Vordaza" },
        { itemId = 251169, slot = 8, itemName = "Footwraps of Ill-Fate", boss = "Vordaza" },
        { itemId = 251172, slot = 10, itemName = "Vilehex Bonds", boss = "Vordaza" },
        { itemId = 250223, slot = 13, itemName = "Soulcatcher's Charm", boss = "Vordaza" },
        { itemId = 251161, slot = 15, itemName = "Soulhunter's Mask", boss = "Vordaza" },
        { itemId = 251178, slot = 16, itemName = "Ceremonial Hexblade", boss = "Vordaza" },
    },
    -- Nexus-Point Xenas (20 items)
    NEXUS_XENAS = {
        { itemId = 251205, slot = 7, itemName = "Leyline Leggings", boss = "Chief Corewright Kasreth" },
        { itemId = 251203, slot = 9, itemName = "Kasreth's Bindings", boss = "Chief Corewright Kasreth" },
        { itemId = 251204, slot = 10, itemName = "Corewright's Zappers", boss = "Chief Corewright Kasreth" },
        { itemId = 251206, slot = 15, itemName = "Fluxweave Cloak", boss = "Chief Corewright Kasreth" },
        { itemId = 251201, slot = 16, itemName = "Corespark Multitool", boss = "Chief Corewright Kasreth" },
        { itemId = 251202, slot = 17, itemName = "Reflux Reflector", boss = "Chief Corewright Kasreth" },
        { itemId = 251213, slot = 3, itemName = "Nysarra's Mantle", boss = "Corewarden Nysarra" },
        { itemId = 251208, slot = 7, itemName = "Lightscarred Cuisses", boss = "Corewarden Nysarra" },
        { itemId = 251210, slot = 8, itemName = "Eclipse Espadrilles", boss = "Corewarden Nysarra" },
        { itemId = 251209, slot = 9, itemName = "Corewarden Cuffs", boss = "Corewarden Nysarra" },
        { itemId = 251093, slot = 11, itemName = "Omission of Light", boss = "Corewarden Nysarra" },
        { itemId = 250253, slot = 13, itemName = "Whisper of the Duskwraith", boss = "Corewarden Nysarra" },
        { itemId = 251207, slot = 16, itemName = "Dreadflail Bludgeon", boss = "Corewarden Nysarra" },
        { itemId = 251157, slot = 3, itemName = "Searing Spaulders", boss = "Lothraxion" },
        { itemId = 251216, slot = 5, itemName = "Maledict Vest", boss = "Lothraxion" },
        { itemId = 251215, slot = 7, itemName = "Greaves of the Divine Guile", boss = "Lothraxion" },
        { itemId = 251211, slot = 10, itemName = "Fractured Fingerguards", boss = "Lothraxion" },
        { itemId = 251217, slot = 11, itemName = "Occlusion of Void", boss = "Lothraxion" },
        { itemId = 250241, slot = 13, itemName = "Mark of Light", boss = "Lothraxion" },
        { itemId = 251212, slot = 16, itemName = "Radiant Slicer", boss = "Lothraxion" },
    },
    -- Pit of Saron (23 items)
    PIT_OF_SARON = {
        { itemId = 50228, slot = 2, itemName = "Barbed Ymirheim Choker", boss = "Forgemaster Garfrost" },
        { itemId = 50233, slot = 3, itemName = "Spurned Val'kyr Shoulderguards", boss = "Forgemaster Garfrost" },
        { itemId = 50234, slot = 3, itemName = "Shoulderplates of Frozen Blood", boss = "Forgemaster Garfrost" },
        { itemId = 49806, slot = 6, itemName = "Flayer's Black Belt", boss = "Forgemaster Garfrost" },
        { itemId = 133489, slot = 8, itemName = "Ice-Steeped Sandals", boss = "Forgemaster Garfrost" },
        { itemId = 49802, slot = 16, itemName = "Garfrost's Two-Ton Hammer", boss = "Forgemaster Garfrost" },
        { itemId = 50227, slot = 16, itemName = "Surgeon's Needle", boss = "Forgemaster Garfrost" },
        { itemId = 49808, slot = 6, itemName = "Bent Gold Belt", boss = "Ick and Krick" },
        { itemId = 49810, slot = 6, itemName = "Scabrous Zombie Leather Belt", boss = "Ick and Krick" },
        { itemId = 50263, slot = 6, itemName = "Braid of Salt and Fire", boss = "Ick and Krick" },
        { itemId = 50264, slot = 9, itemName = "Chewed Leather Wristguards", boss = "Ick and Krick" },
        { itemId = 133493, slot = 9, itemName = "Wristguards of Subterranean Moss", boss = "Ick and Krick" },
        { itemId = 49812, slot = 11, itemName = "Purloined Wedding Ring", boss = "Ick and Krick" },
        { itemId = 252421, slot = 13, itemName = "Rotting Globule", boss = "Ick and Krick" },
        { itemId = 133491, slot = 16, itemName = "Krick's Beetle Stabber", boss = "Ick and Krick" },
        { itemId = 49819, slot = 1, itemName = "Skeleton Lord's Cranium", boss = "Scourgelord Tyrannus" },
        { itemId = 49824, slot = 1, itemName = "Horns of the Spurned Val'kyr", boss = "Scourgelord Tyrannus" },
        { itemId = 49825, slot = 5, itemName = "Palebone Robes", boss = "Scourgelord Tyrannus" },
        { itemId = 50272, slot = 5, itemName = "Frost Wyrm Ribcage", boss = "Scourgelord Tyrannus" },
        { itemId = 49817, slot = 7, itemName = "Shaggy Wyrmleather Leggings", boss = "Scourgelord Tyrannus" },
        { itemId = 50259, slot = 13, itemName = "Nevermelting Ice Crystal", boss = "Scourgelord Tyrannus" },
        { itemId = 49823, slot = 15, itemName = "Cloak of the Fallen Cardinal", boss = "Scourgelord Tyrannus" },
        { itemId = 49813, slot = 16, itemName = "Rimebane Rifle", boss = "Scourgelord Tyrannus" },
    },
    -- The Seat of the Triumvirate (31 items)
    SEAT = {
        { itemId = 151319, slot = 3, itemName = "Twilight's Edge Spaulders", boss = "L'ura" },
        { itemId = 151313, slot = 5, itemName = "Vest of the Void's Embrace", boss = "L'ura" },
        { itemId = 151301, slot = 8, itemName = "Slippers of Growing Despair", boss = "L'ura" },
        { itemId = 151328, slot = 9, itemName = "Vambraces of Lost Hope", boss = "L'ura" },
        { itemId = 151322, slot = 10, itemName = "Void-Touched Grips", boss = "L'ura" },
        { itemId = 151340, slot = 13, itemName = "Echo of L'ura", boss = "L'ura" },
        { itemId = 258525, slot = 16, itemName = "Scepter of the Endless Night", boss = "L'ura" },
        { itemId = 151337, slot = 1, itemName = "Shadow-Weaver's Crown", boss = "Saprish" },
        { itemId = 151323, slot = 3, itemName = "Pauldrons of the Void Hunter", boss = "Saprish" },
        { itemId = 151303, slot = 5, itemName = "Voidbender Robe", boss = "Saprish" },
        { itemId = 151327, slot = 6, itemName = "Girdle of the Shadowguard", boss = "Saprish" },
        { itemId = 151330, slot = 8, itemName = "Trap Jammers", boss = "Saprish" },
        { itemId = 151321, slot = 9, itemName = "Darkfang Scale Wristguards", boss = "Saprish" },
        { itemId = 151318, slot = 10, itemName = "Gloves of the Dark Shroud", boss = "Saprish" },
        { itemId = 258516, slot = 16, itemName = "Wand of Saprish's Gaze", boss = "Saprish" },
        { itemId = 151333, slot = 1, itemName = "Crown of the Dark Envoy", boss = "Viceroy Nezhar" },
        { itemId = 151309, slot = 2, itemName = "Necklace of the Twisting Void", boss = "Viceroy Nezhar" },
        { itemId = 151325, slot = 5, itemName = "Void-Linked Robe", boss = "Viceroy Nezhar" },
        { itemId = 151317, slot = 8, itemName = "Footpads of Seeping Dread", boss = "Viceroy Nezhar" },
        { itemId = 151305, slot = 9, itemName = "Entropic Wristwraps", boss = "Viceroy Nezhar" },
        { itemId = 151332, slot = 10, itemName = "Voidclaw Gauntlets", boss = "Viceroy Nezhar" },
        { itemId = 151310, slot = 13, itemName = "Reality Breacher", boss = "Viceroy Nezhar" },
        { itemId = 258524, slot = 16, itemName = "Grips of the Dark Viceroy", boss = "Viceroy Nezhar" },
        { itemId = 258523, slot = 17, itemName = "Nezhar's Netherclaw", boss = "Viceroy Nezhar" },
        { itemId = 151336, slot = 1, itemName = "Voidlashed Hood", boss = "Zuraal the Ascended" },
        { itemId = 151329, slot = 5, itemName = "Breastplate of the Dark Touch", boss = "Zuraal the Ascended" },
        { itemId = 151320, slot = 8, itemName = "Void-Coated Stompers", boss = "Zuraal the Ascended" },
        { itemId = 151300, slot = 10, itemName = "Handwraps of the Ascended", boss = "Zuraal the Ascended" },
        { itemId = 151308, slot = 11, itemName = "Eredath Seal of Nobility", boss = "Zuraal the Ascended" },
        { itemId = 151312, slot = 13, itemName = "Ampoule of Pure Void", boss = "Zuraal the Ascended" },
        { itemId = 258514, slot = 16, itemName = "Umbral Spire of Zuraal", boss = "Zuraal the Ascended" },
    },
    -- Skyreach (28 items)
    SKYREACH = {
        { itemId = 258579, slot = 1, itemName = "Gutcrusher Greathelm", boss = "Araknath" },
        { itemId = 258578, slot = 3, itemName = "Lightbinder Shoulderguards", boss = "Araknath" },
        { itemId = 258576, slot = 5, itemName = "Sharpeye Chestguard", boss = "Araknath" },
        { itemId = 258577, slot = 8, itemName = "Boots of Burning Focus", boss = "Araknath" },
        { itemId = 252418, slot = 13, itemName = "Solar Core Igniter", boss = "Araknath" },
        { itemId = 258047, slot = 16, itemName = "Spire of the Furious Construct", boss = "Araknath" },
        { itemId = 258436, slot = 16, itemName = "Edge of the Burning Sun", boss = "Araknath" },
        { itemId = 258585, slot = 1, itemName = "Sharpeye Gleam", boss = "High Sage Viryx" },
        { itemId = 258587, slot = 3, itemName = "Spaulders of Scorching Ray", boss = "High Sage Viryx" },
        { itemId = 258586, slot = 5, itemName = "Bloodfeather Chestguard", boss = "High Sage Viryx" },
        { itemId = 258584, slot = 8, itemName = "Lightbinder Treads", boss = "High Sage Viryx" },
        { itemId = 252420, slot = 13, itemName = "Solarflare Prism", boss = "High Sage Viryx" },
        { itemId = 258050, slot = 16, itemName = "Arcanic of the High Sage", boss = "High Sage Viryx" },
        { itemId = 258484, slot = 16, itemName = "Sunlance of Viryx", boss = "High Sage Viryx" },
        { itemId = 258049, slot = 17, itemName = "Viryx's Indomitable Bulwark", boss = "High Sage Viryx" },
        { itemId = 258574, slot = 7, itemName = "Legwraps of Swirling Light", boss = "Ranjit" },
        { itemId = 258575, slot = 15, itemName = "Rigid Scale Greatcloak", boss = "Ranjit" },
        { itemId = 258046, slot = 16, itemName = "Chakram-Breaker Greatsword", boss = "Ranjit" },
        { itemId = 258218, slot = 16, itemName = "Skybreaker's Blade", boss = "Ranjit" },
        { itemId = 258412, slot = 16, itemName = "Stormshaper's Crossbow", boss = "Ranjit" },
        { itemId = 258581, slot = 3, itemName = "Bloodfeather Mantle", boss = "Rukhran" },
        { itemId = 258582, slot = 8, itemName = "Rigid Scale Boots", boss = "Rukhran" },
        { itemId = 258580, slot = 9, itemName = "Bracers of Blazing Light", boss = "Rukhran" },
        { itemId = 258583, slot = 10, itemName = "Incarnadine Gauntlets", boss = "Rukhran" },
        { itemId = 252411, slot = 13, itemName = "Radiant Sunstone", boss = "Rukhran" },
        { itemId = 258048, slot = 16, itemName = "Beakbreaker Scimitar", boss = "Rukhran" },
        { itemId = 258438, slot = 16, itemName = "Blazing Sunclaws", boss = "Rukhran" },
        { itemId = 258472, slot = 17, itemName = "Rukhran's Solar Reliquary", boss = "Rukhran" },
    },
    -- Windrunner Spire (26 items)
    WINDRUNNER = {
        { itemId = 251092, slot = 3, itemName = "Fallen Grunt's Mantle", boss = "Commander Kroluk" },
        { itemId = 251090, slot = 7, itemName = "Commander's Faded Breeches", boss = "Commander Kroluk" },
        { itemId = 251091, slot = 8, itemName = "Sabatons of Furious Revenge", boss = "Commander Kroluk" },
        { itemId = 251089, slot = 10, itemName = "Grips of Forgotten Honor", boss = "Commander Kroluk" },
        { itemId = 250227, slot = 13, itemName = "Kroluk's Warbanner", boss = "Commander Kroluk" },
        { itemId = 251088, slot = 16, itemName = "Warworn Cleaver", boss = "Commander Kroluk" },
        { itemId = 251085, slot = 3, itemName = "Mantle of Dark Devotion", boss = "Derelict Duo" },
        { itemId = 251086, slot = 6, itemName = "Riphook Defender", boss = "Derelict Duo" },
        { itemId = 251087, slot = 7, itemName = "Legwraps of Lingering Legacies", boss = "Derelict Duo" },
        { itemId = 251084, slot = 8, itemName = "Whipcoil Sabatons", boss = "Derelict Duo" },
        { itemId = 250226, slot = 13, itemName = "Latch's Crooked Hook", boss = "Derelict Duo" },
        { itemId = 251083, slot = 16, itemName = "Excavating Cudgel", boss = "Derelict Duo" },
        { itemId = 251080, slot = 1, itemName = "Brambledawn Halo", boss = "Emberdawn" },
        { itemId = 251082, slot = 6, itemName = "Snapvine Cinch", boss = "Emberdawn" },
        { itemId = 251079, slot = 9, itemName = "Amberfrond Bracers", boss = "Emberdawn" },
        { itemId = 251081, slot = 10, itemName = "Embergrove Grasps", boss = "Emberdawn" },
        { itemId = 250144, slot = 13, itemName = "Emberwing Feather", boss = "Emberdawn" },
        { itemId = 251077, slot = 16, itemName = "Roostwarden's Bough", boss = "Emberdawn" },
        { itemId = 251078, slot = 16, itemName = "Emberdawn Defender", boss = "Emberdawn" },
        { itemId = 251098, slot = 1, itemName = "Fletcher's Faded Faceplate", boss = "The Restless Heart" },
        { itemId = 251096, slot = 2, itemName = "Pendant of Aching Grief", boss = "The Restless Heart" },
        { itemId = 251097, slot = 3, itemName = "Spaulders of Arrow's Flight", boss = "The Restless Heart" },
        { itemId = 251099, slot = 5, itemName = "Vest of the Howling Gale", boss = "The Restless Heart" },
        { itemId = 250256, slot = 13, itemName = "Heart of Wind", boss = "The Restless Heart" },
        { itemId = 251095, slot = 16, itemName = "Hurricane's Heart", boss = "The Restless Heart" },
        { itemId = 251094, slot = 17, itemName = "Sigil of the Restless Heart", boss = "The Restless Heart" },
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

