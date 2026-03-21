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
-- BIS LISTS - OVERALL (from Icy Veins, Midnight Season 1)
-- ============================================================================
NS.BIS_OVERALL = {
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
    DEMONHUNTER_VENGEANCE = {
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
    },
    EVOKER_AUGMENTATION = {
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
        [1] = 249988, -- Primal Sentry's Maw (Lightblinded Vanguard - Voidspire, or Matrix Catalyst)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls - March on Quel'Danas)
        [3] = 151323, -- Pauldrons of the Void Hunter (Seat of the Triumvirate)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak - Voidspire)
        [5] = 249991, -- Primal Sentry's Scaleplate (Chimaerus - Dreamrift, or Matrix Catalyst)
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
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus)
        [14] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
    },
    PALADIN_HOLY = {
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
        [14] = 249341, -- Volatile Void Suffuser (Fallen-King Salhadaar in The Voidspire)
    },
    PRIEST_HOLY = {
        [16] = 245770, -- Aln'hara Cane (Inscription)
        [1] = 250051, -- Blind Oath's Winged Crest (Lightblinded Vanguard in The Voidspire / Matrix Catalyst)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 250049, -- Blind Oath's Seraphguards (Fallen-King Salhadaar in The Voidspire / Matrix Catalyst)
        [15] = 249335, -- Imperator's Banner (Imperator Averzian in The Voidspire)
        [5] = 250054, -- Blind Oath's Raiment (Chimaerus in The Dreamrift / Matrix Catalyst)
        [9] = 250047, -- Blind Oath's Wraps (Matrix Catalyst any bracer)
        [10] = 250052, -- Blind Oath's Touch (Vorasius in The Voidspire / Matrix Catalyst)
        [6] = 239664, -- Arcanoweave Cord (Tailoring)
        [7] = 249323, -- Leggings of the Devouring Advance (Imperator Averzian in The Voidspire)
        [8] = 251167, -- Nightprey Stalkers (Maisara Caverns)
        [11] = 249336, -- Signet of the Starved Beast (Vorasius in The Voidspire)
    },
    PRIEST_SHADOW = {
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
    },
    ROGUE_ASSASSINATION = {
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

-- ============================================================================
-- BIS LISTS - MYTHIC (from Icy Veins, Midnight Season 1)
-- ============================================================================
NS.BIS_MYTHIC = {
    DEATHKNIGHT_BLOOD = {
        [16] = 251168, -- Liferipper's Cutlass (Maisara Caverns)
        [1] = 249970, -- Relentless Rider's Crown (Matrix Catalyst , or Lightblinded Vanguard in The Voidspire)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 249968, -- Relentless Rider's Dreadthorns (Matrix Catalyst , or Fallen-King Salhadaar in The Voidspire)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [5] = 249973, -- Relentless Rider's Cuirass (Matrix Catalyst , or Chimaerus in The Dreamrift)
        [9] = 251203, -- Kasreth's Bindings (Nexus-Point Xenas)
        [10] = 151332, -- Voidclaw Gauntlets (Seat of the Triumvirate)
        [6] = 249380, -- Hate-Tied Waistchain (Crown of the Cosmos in The Voidspire)
        [7] = 249969, -- Relentless Rider's Legguards (Matrix Catalyst , or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249381, -- Greaves of the Unformed (Chimaerus in The Dreamrift)
        [11] = 240949, -- Masterwork Sin'dorei Band (Crafted by Jewelcrafting)
        [12] = 251513, -- Loa Worshiper's Band (Crafted by Jewelcrafting)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 260235, -- Umbral Plume (Belo'ren in March on Quel'Danas)
    },
    DEATHKNIGHT_FROST = {
        [16] = 251168, -- Liferipper's Cutlass (Maisara Caverns)
        [1] = 249970, -- Relentless Rider's Crown (Matrix Catalyst)
        [2] = 50228, -- Barbed Ymirheim Choker (Seat of the Triumvirate)
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
        [2] = 50228, -- Barbed Ymirheim Choker (Seat of the Triumvirate)
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
    },
    EVOKER_AUGMENTATION = {
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
    },
    EVOKER_DEVASTATION = {
        [16] = 251201, -- Corespark Multitool (Nexus-Point Xenas)
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
        [2] = 151309, -- Necklace of the Twisting Void (Seat of the Triumvirate)
        [3] = 151323, -- Pauldrons of the Void Hunter (Seat of the Triumvirate)
        [15] = 251206, -- Fluxweave Cloak (Nexus-Point Xenas)
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
        [13] = 250144, -- Emberwing Feather (Windrunner Spire)
        [14] = 250256, -- Heart of Wind (Windrunner Spire)
    },
    MAGE_FROST = {
        [16] = 245770, -- Aln'hara Cane (Inscription)
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
        [13] = 250256, -- Heart of Wind (Windrunner Spire)
        [14] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
    },
    PALADIN_HOLY = {
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
        [16] = 245770, -- Aln'hara Cane (Tailoring Pit of Saron Seat of the Triumvirate Windrunner Spire)
        [1] = 250051, -- Blind Oath's Winged Crest (Matrix Catalyst)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 250049, -- Blind Oath's Seraphguards (Matrix Catalyst)
        [15] = 49823, -- Cloak of the Fallen Cardinal (Pit of Saron)
        [5] = 250054, -- Blind Oath's Raiment (Matrix Catalyst)
        [9] = 258580, -- Bracers of Blazing Light (Skyreach)
        [10] = 250052, -- Blind Oath's Touch (Matrix Catalyst)
        [6] = 239664, -- Arcanoweave Cord (Tailoring)
        [7] = 250050, -- Blind Oath's Leggings (Matrix Catalyst)
        [8] = 251167, -- Nightprey Stalkers (Maisara Caverns)
        [11] = 151308, -- Eredath Seal of Nobility (Seat of the Triumvirate)
    },
    PRIEST_SHADOW = {
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
    },
    ROGUE_ASSASSINATION = {
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
    },
    EVOKER_AUGMENTATION = {
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
        [1] = 249988, -- Primal Sentry's Maw (Lightblinded Vanguard - Voidspire, or Matrix Catalyst)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls - March on Quel'Danas)
        [3] = 249318, -- Nullwalker's Dread Epaulettes (Vaelgor and Ezzorak - Voidspire)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak - Voidspire)
        [5] = 249991, -- Primal Sentry's Scaleplate (Chimaerus - Dreamrift, or Matrix Catalyst)
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
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus)
        [14] = 249806, -- Radiant Plume (Belo'ren)
    },
    PALADIN_HOLY = {
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
        [16] = 245770, -- Aln'hara Cane (Tailoring Imperator Averzian in The Voidspire)
        [17] = 249276, -- Grimoire of the Eternal Light (Vorasius in The Voidspire)
        [1] = 250051, -- Blind Oath's Winged Crest (Lightblinded Vanguard in The Voidspire / Matrix Catalyst)
        [2] = 249337, -- Ribbon of Coiled Malice (Fallen-King Salhadaar in The Voidspire Midnight Falls in March on Quel'Danas)
        [3] = 250049, -- Blind Oath's Seraphguards (Fallen-King Salhadaar in The Voidspire / Matrix Catalyst)
        [15] = 249335, -- Imperator's Banner (Imperator Averzian in The Voidspire)
        [5] = 250054, -- Blind Oath's Raiment (Chimaerus in The Dreamrift / Matrix Catalyst)
        [9] = 250047, -- Blind Oath's Wraps (Matrix Catalyst any bracer)
        [10] = 250052, -- Blind Oath's Touch (Vorasius in The Voidspire / Matrix Catalyst)
        [6] = 239664, -- Arcanoweave Cord (Tailoring)
        [7] = 249323, -- Leggings of the Devouring Advance (Imperator Averzian in The Voidspire)
        [8] = 249373, -- Dream-Scorched Striders (Chimaerus in The Dreamrift)
        [11] = 249336, -- Signet of the Starved Beast (Vorasius in The Voidspire)
    },
    PRIEST_SHADOW = {
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
    },
    ROGUE_ASSASSINATION = {
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
        [11] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [12] = 249336, -- Signet of the Starved Beast (Vorasius in The Voidspire)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 249808, -- Litany of Lightblind Wrath (Lightblinded Vanguard in The Voidspire)
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
        { itemId = 251122, slot = 16, itemName = "Shadowslash Slicer", boss = "Degentrius" },
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
        { itemId = 251162, slot = 16, itemName = "Traitor's Talon", boss = "Muro'jin and Nekraxx" },
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

