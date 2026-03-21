-- ============================================================================
-- DungeonOptimizer - Data.lua
-- BIS lists (from Icy Veins) and Dungeon Loot Tables for WoW Midnight M+ S1
-- AUTO-GENERATED from Icy Veins on 2026-03-20
-- ============================================================================

local ADDON_NAME, NS = ...

-- ============================================================================
-- SLOT CONSTANTS
-- ============================================================================
NS.SLOT_IDS = {
    HEAD = 1, NECK = 2, SHOULDER = 3, BACK = 15, CHEST = 5,
    WRIST = 9, HANDS = 10, WAIST = 6, LEGS = 7, FEET = 8,
    FINGER1 = 11, FINGER2 = 12, TRINKET1 = 13, TRINKET2 = 14,
    MAINHAND = 16, OFFHAND = 17,
}

NS.SLOT_NAMES = {
    [1] = "Tête",
    [2] = "Cou",
    [3] = "Épaules",
    [5] = "Torse",
    [6] = "Taille",
    [7] = "Jambes",
    [8] = "Pieds",
    [9] = "Poignets",
    [10] = "Mains",
    [11] = "Doigt 1",
    [12] = "Doigt 2",
    [13] = "Bijou 1",
    [14] = "Bijou 2",
    [15] = "Dos",
    [16] = "Main droite",
    [17] = "Main gauche",
}

-- ============================================================================
-- DUNGEON LIST - Midnight Season 1 M+ Pool
-- ============================================================================
NS.DUNGEONS = {
    { id = "MAGISTER", name = "Magister's Terrace", shortName = "Magister", icon = "Interface\\Icons\\achievement_dungeon_magistersterrace_heroic" },
    { id = "SEAT", name = "Seat of the Triumvirate", shortName = "Seat", icon = "Interface\\Icons\\achievement_dungeon_seatofthetriumvirate" },
    { id = "SKYREACH", name = "Skyreach", shortName = "Skyreach", icon = "Interface\\Icons\\achievement_dungeon_skyreach" },
    { id = "ALGETHAR", name = "Algeth'ar Academy", shortName = "Algeth'ar", icon = "Interface\\Icons\\achievement_dungeon_algetharacademy" },
    { id = "PIT_OF_SARON", name = "Pit of Saron", shortName = "Pit", icon = "Interface\\Icons\\achievement_dungeon_pitofsaron" },
    { id = "WINDRUNNER", name = "Windrunner Spire", shortName = "Windrunner", icon = "Interface\\Icons\\inv_misc_tournaments_banner_bloodelf" },
    { id = "MAISARA", name = "Maisara Caverns", shortName = "Maisara", icon = "Interface\\Icons\\achievement_dungeon_utgardekeep" },
    { id = "NEXUS_XENAS", name = "Nexus-Point Xenas", shortName = "Xenas", icon = "Interface\\Icons\\achievement_dungeon_nexus70" },
}

-- ============================================================================
-- BIS LISTS - OVERALL (from Icy Veins, Midnight Season 1)
-- ============================================================================
NS.BIS_OVERALL = {
    DEATHKNIGHT_BLOOD = {
        [16] = 251168, -- Liferipper's Cutlass (Maisara Caverns)
        [1] = 249970, -- Relentless Rider's Crown (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 249968, -- Relentless Rider's Dreadthorns (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [5] = 249973, -- Relentless Rider's Cuirass (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 251490, -- Spellbreaker's Bracers with  Stabilizing Gemstone Bandolier (Crafted by Blacksmithing)
        [10] = 151332, -- Voidclaw Gauntlets (Seat of the Triumvirate)
        [6] = 49808, -- Bent Gold Belt (Pit of Saron)
        [7] = 249969, -- Relentless Rider's Legguards (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249381, -- Greaves of the Unformed (Chimaerus in The Dreamrift)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 251513, -- Loa Worshiper's Band (Crafted by Jewelcrafting)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 249344, -- Light Company Guidon (Imperator Averzian in The Voidspire)
    },
    DEATHKNIGHT_FROST = {
        [16] = 249277, -- BiS ->  Bellamy's Final Judgement (Lightblinded Vanguard in The Voidspire)
        [1] = 249970, -- Relentless Rider's Crown (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Seat of the Triumvirate)
        [3] = 50234, -- Shoulderplates of Frozen Blood (Pit of Saron)
        [15] = 258575, -- Adherent's Silken Shroud with  Arcanoweave Lining ( Rigid Scale Greatcloak when running a Dual-Wield setup) (Crafted by Leatherworking)
        [5] = 249973, -- Relentless Rider's Cuirass (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 240167, -- Spellbreaker's Bracers with  Arcanoweave Lining (Crafted by Blacksmithing)
        [10] = 249971, -- Relentless Rider's Bonegrasps (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 249380, -- Hate-Tied Waistchain (Crown of the Cosmos in The Voidspire)
        [7] = 249969, -- Relentless Rider's Legguards (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249381, -- Greaves of the Unformed (Chimaerus in The Dreamrift)
        [11] = 193708, -- Platinum Star Band (Algeth'ar Academy)
        [12] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 249344, -- Light Company Guidon (Imperator Averzian in The Voidspire)
    },
    DEATHKNIGHT_UNHOLY = {
        [16] = 249277, -- BiS ->  Bellamy's Final Judgement (Lightblinded Vanguard in The Voidspire)
        [1] = 249970, -- Relentless Rider's Crown (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Seat of the Triumvirate)
        [3] = 50234, -- Shoulderplates of Frozen Blood (Pit of Saron)
        [15] = 239656, -- Adherent's Silken Shroud with  Arcanoweave Lining (Crafted by Leatherworking)
        [5] = 249973, -- Relentless Rider's Cuirass (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 240167, -- Spellbreaker's Bracers with  Arcanoweave Lining (Crafted by Blacksmithing)
        [10] = 249971, -- Relentless Rider's Bonegrasps (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 249380, -- Hate-Tied Waistchain (Crown of the Cosmos in The Voidspire)
        [7] = 249969, -- Relentless Rider's Legguards (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249381, -- Greaves of the Unformed (Chimaerus in The Dreamrift)
        [11] = 193708, -- Platinum Star Band (Algeth'ar Academy)
        [12] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 249344, -- Light Company Guidon (Imperator Averzian in The Voidspire)
    },
    -- DEMONHUNTER_DEVOURER removed: not a valid WoW spec (DH has Havoc + Vengeance only)
    DEMONHUNTER_HAVOC = {
        [16] = 260408, --  (Midnight Falls)
        [17] = 251175, --  (Maisara Caverns)
        [1] = 251109, --  (Magister's Terrace)
        [2] = 250247, --  (Midnight Falls)
        [3] = 250031, --  (Fallen-King Salhadaar)
        [15] = 239656, --  (Tailoring)
        [5] = 250036, --  (Chimaerus)
        [9] = 244576, --  (Leatherworking)
        [10] = 250034, --  (Vorasius)
        [6] = 251082, --  (Windrunner Spire)
        [7] = 250032, --  (Vaelgor and Ezzorak)
        [8] = 258577, --  (Skyreach)
        [11] = 249919, --  (Belo'ren)
        [12] = 193708, --  (Algeth'ar Academy)
        [13] = 249343, --  (Chimaerus)
        [14] = 193701, --  (Algeth'ar Academy)
    },
    DEMONHUNTER_VENGEANCE = {
        [16] = 260408, --  (Midnight Falls)
        [1] = 250033, --  (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 249368, --  (Crown of the Cosmos in The Voidspire)
        [3] = 250031, --  (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 260312, --  (Magister's Terrace)
        [5] = 251216, --  (Nexus-Point Xenas)
        [9] = 240167, --  (Crafted by Leatherworking)
        [10] = 250034, --  (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 249374, --  (Chimaerus in The Dreamrift)
        [7] = 250032, --  (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249334, --  (Imperator Averzian in The Voidspire)
        [11] = 251217, --  (Nexus-Point Xenas)
        [12] = 249920, --  (Midnight Falls in March on Quel'Danas)
        [13] = 250256, --  (Windrunner Spire)
        [14] = 249343, --  (Chimaerus in The Dreamrift)
    },
    DRUID_BALANCE = {
        [16] = 249286, --  (Midnight Falls in March on Quel'Danas)
        [1] = 250024, --  (Lightblinded Vanguard in The Voidspire)
        [2] = 250247, --  (Midnight Falls in March on Quel'Danas)
        [3] = 250022, --  (Fallen-King Salhadaar in The Voidspire)
        [15] = 250019, --  (Creation Catalyst)
        [5] = 250027, --  (Chimaerus in The Dreamrift)
        [9] = 249327, --  (Vorasius in The Voidspire)
        [10] = 244576, --  (Leatherworking)
        [6] = 249374, --  (Chimaerus in The Dreamrift)
        [7] = 250023, --  (Vaelgor and Ezzorak in The Voidspire)
        [8] = 240167, --  (Leatherworking)
        [11] = 251217, --  (Nexus-Point Xenas)
        [12] = 251093, --  (Nexus-Point Xenas)
        [13] = 249343, --  (Chimaerus in The Dreamrift)
        [14] = 249346, --  (Vaelgor and Ezzorak)
    },
    DRUID_FERAL = {
        [16] = 251077, --  (Windrunner Spire)
        [1] = 250024, --  (Lightblinded Vanguard)
        [2] = 250247, --  (Midnight Falls)
        [3] = 251092, --  (Windrunner Spire)
        [15] = 239656, --  (Tailoring)
        [5] = 250027, --  (Chimaerus)
        [9] = 244576, --  (Leatherworking)
        [10] = 250025, --  (Vorasius)
        [6] = 249374, --  (Chimaerus)
        [7] = 250023, --  (Vaelgor and Ezzorak)
        [8] = 249382, --  (Crown of the Cosmos)
        [11] = 251093, --  (Nexus-Point Xenas)
        [12] = 251217, --  (Nexus-Point Xenas)
        [13] = 249343, --  (Chimaerus)
        [14] = 193701, --  (Algeth'ar Academy)
    },
    DRUID_GUARDIAN = {
        [16] = 249278, --  (Chimaerus in The Dreamrift)
        [1] = 151336, --  (Seat of the Triumvirate)
        [2] = 249368, --  (Crown of the Cosmos in The Voidspire)
        [3] = 250022, --  (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 249370, --  (Vaelgor and Ezzorak in The Voidspire)
        [5] = 250027, --  (Chimaerus in The Dreamrift)
        [9] = 240167, --  (Crafted by Leatherworking)
        [10] = 250025, --  (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 244611, --  (Crafted by Leatherworking)
        [7] = 250023, --  (Vaelgor and Ezzorak in The Voidspire)
        [8] = 249334, --  (Imperator Averzian in The Voidspire)
        [11] = 251217, --  (Nexus-Point Xenas)
        [12] = 251093, --  (Nexus-Point Xenas)
        [13] = 249343, --  (Chimaerus in The Dreamrift)
        [14] = 193701, --  (Algeth'ar Academy)
    },
    DRUID_RESTORATION = {
        [1] = 250024, --  (Lightblinded Vanguard - The Voidspire)
        [2] = 250247, --  (Midnight Falls - March on Quel'Danas)
        [3] = 250022, --  (Fallen-King Salhadaar - The Voidspire)
        [15] = 249370, --  (Vaelgor and Ezzorak - The Voidspire)
        [5] = 251216, --  (Nexus-Point Xenas)
        [9] = 193714, --  (Algeth'ar Academy)
        [10] = 250025, --  (Vorasius - The Voidspire)
        [6] = 249314, --  (Fallen-King Salhadaar - The Voidspire)
        [7] = 250023, --  (Vaelgor and Ezzorak - The Voidspire)
        [8] = 251210, --  (Nexus-Point Xenas)
        [11] = 249920, --  (Midnight Falls - March on Quel'Danas)
        [13] = 249809, --  (Crown of the Cosmos - The Voidspire)
        [16] = 249283, --  (Belo'ren - March on Quel'Danas)
        [17] = 249922, --  (Chimaerus - Dreamrift)
    },
    EVOKER_AUGMENTATION = {
        [16] = 193709, --  (Maisara Caverns
            Magister's Terrace
            Skyreach
            Vorasius in The Voidspire
            Algeth'ar Academy)
        [1] = 49824, --  (Midnight Falls in March on Quel'Danas
            
            
              Vorasius in The Voidspire
            
            
              Pit of Saron)
        [2] = 50228, --  (Fallen-King Salhadaar in The Voidspire
            
            
              Pit of Saron)
        [3] = 249995, --  (Matrix Catalyst, Fallen-King Salhadaar in
          The Voidspire.)
        [15] = 239656, --  (Crafted by Tailoring)
        [5] = 250000, --  (Matrix Catalyst, or Chimaerus in
          The Dreamrift)
        [9] = 244584, --  (Crafted by Leatherworking)
        [10] = 249998, --  (Matrix Catalyst, or Vorasius in
          The Voidspire)
        [6] = 49810, --  (Pit of Saron)
        [7] = 249996, --  (Matrix Catalyst, or Vaelgor and Ezzorak in
          The Voidspire)
        [8] = 193715, --  (Belo'ren in March on Quel'Danas
            
            
              Matrix Catalyst
            
            
              Algeth'ar Academy)
        [11] = 240949, --  (Nexus-Point Xenas
            Midnight Falls in March on Quel'Danas
            Pit of Saron
            Crafted by Jewelcrafting)
        [13] = 250223, --  (Midnight Falls in March on Quel'Danas
            Vaelgor and Ezzorak in The Voidspire
            Maisara Caverns)
    },
    EVOKER_DEVASTATION = {
        [16] = 249294, --  (Lightblinded Vanguard in The Voidspire.)
        [17] = 249276, --  (Vorasius in The Voidspire.)
        [1] = 249997, --  (Matrix Catalyst, Lightblinded Vanguard in The Voidspire.)
        [2] = 250247, --  (Midnight Falls in March on Quel'Danas.)
        [3] = 249995, --  (Matrix Catalyst, Fallen-King Salhadaar in
          The Voidspire.)
        [15] = 239656, --  (Crafted by Tailoring)
        [5] = 250000, --  (Matrix Catalyst, or Chimaerus in
          The Dreamrift)
        [9] = 244584, --  (Crafted by Leatherworking)
        [10] = 249325, --  (Crown of the Cosmos in The Voidspire)
        [6] = 49810, --  (Pit of Saron)
        [7] = 249996, --  (Matrix Catalyst, or Vaelgor and Ezzorak in
          The Voidspire)
        [8] = 249999, --  (Matrix Catalyst.)
        [11] = 249919, --  (Belo'ren in March on Quel'Danas.)
        [13] = 249809, --  (Crown of the Cosmos in The Voidspire.)
    },
    EVOKER_PRESERVATION = {
        [16] = 258514, --  (Seat of the Triumvirate)
        [1] = 249914, --  (Midnight Falls in March on Quel'Danas)
        [2] = 250247, --  (Midnight Falls in March on Quel'Danas)
        [3] = 249995, --  (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 251206, --  (Nexus-Point Xenas)
        [5] = 250000, --  (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 251079, --  (Windrunner Spire)
        [10] = 249998, --  (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 244611, --  (Crafted by Leatherworking)
        [7] = 249996, --  (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 244610, --  (Crafted by Leatherworking)
        [11] = 249369, --  (Lightblinded Vanguard in The Voidspire)
        [12] = 249920, --  (Midnight Falls in March on Quel'Danas)
        [13] = 249346, --  (Vaelgor and Ezzorak in The Voidspire)
        [14] = 249343, --  (Chimaerus in The Dreamrift)
    },
    HUNTER_BEASTMASTERY = {
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
        [16] = 249279, -- Sunstrike Rifle (Imperator Averzian - Voidspire)
    },
    HUNTER_MARKSMANSHIP = {
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
        [16] = 249288, -- Ranger-Captain's Lethal Recurve (Crown of the Cosmos - Voidspire)
    },
    HUNTER_SURVIVAL = {
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
        [16] = 249302, -- Inescapable Reach (Vorasius - Voidspire)
        [17] = 237837, -- Farstrider's Mercy (Blacksmithing)
    },
    MAGE_ARCANE = {
        [16] = 258218, --  (The Great Vault / Skyreach)
        [17] = 251094, --  (The Great Vault / Windrunner Spire)
        [1] = 250060, --  (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, --  (Midnight Falls in March on Quel'Danas)
        [3] = 250058, --  (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 239661, --  (Crafted by Tailoring)
        [5] = 250063, --  (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 239660, --  (Crafted by Tailoring)
        [10] = 250061, --  (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 249376, --  (Belo'ren in March on Quel'Danas)
        [7] = 251090, --  (The Great Vault / Windrunner Spire)
        [8] = 249373, --  (Chimaerus in The Dreamrift)
        [11] = 249919, --  (Belo'ren in March on Quel'Danas)
        [13] = 249343, --  (Vaelgor and Ezzorak in The Voidspire)
    },
    MAGE_FIRE = {
        [16] = 249286, --  (Midnight Falls in March on Quel'Danas)
        [1] = 250060, --  (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, --  (Midnight Falls in March on Quel'Danas)
        [3] = 250058, --  (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 239656, --  (Crafted by Tailoring with  Arcanoweave Lining and Haste + Mastery)
        [5] = 249912, --  (Midnight Falls in March on Quel'Danas)
        [9] = 239648, --  (Crafted by Tailoring with  Arcanoweave Lining and Haste + Mastery)
        [10] = 250061, --  (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 249376, --  (Belo'ren in March on Quel'Danas)
        [7] = 250059, --  (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 258584, --  (Matrix Catalyst on any pair of boots, or The Great Vault)
        [11] = 249369, --  (Lightblinded Vanguard in The Voidspire)
        [13] = 250144, --  (The Great Vault / Windrunner Spire)
    },
    MAGE_FROST = {
        [16] = 258218, --  (Skyreach)
        [17] = 245876, --  (Inscription)
        [1] = 250060, --  (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, --  (Midnight Falls in March on Quel'Danas)
        [3] = 251085, --  (Windrunner Spire)
        [15] = 258575, --  (Skyreach)
        [5] = 250063, --  (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 240167, --  (Tailoring)
        [10] = 250061, --  (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 250057, --  (Matrix Catalyst)
        [7] = 250059, --  (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249373, --  (Chimaerus in The Dreamrift)
        [11] = 249919, --  (Belo'ren in March on Quel'Danas)
        [12] = 249920, --  (Midnight Falls in March on Quel'Danas)
        [13] = 249346, --  (Vaelgor and Ezzorak in The Voidspire)
        [14] = 249343, --  (Chimaerus in The Dreamrift)
    },
    MONK_BREWMASTER = {
        [1] = 250015, --  (Lightblinded Vanguard (March on Quel'Danas))
        [2] = 245792, --  (Jewelcrafting (see note))
        [3] = 250013, --  (Fallen-King Salhadaar (The Voidspire))
        [15] = 249335, --  (Imperator Averzian (The Voidspire))
        [5] = 250018, --  (Chimaerus (The Dreamrift))
        [9] = 250011, --  (Matrix Catalyst)
        [10] = 250016, --  (Vorasius (The Voidspire))
        [6] = 251082, --  (Windrunner Spire)
        [7] = 151314, --  (Seat of the Triumvirate)
        [8] = 151317, --  (Seat of the Triumvirate)
        [11] = 249336, --  (Vorasius (The Voidspire))
        [16] = 249302, --  (Vorasius (The Voidspire))
        [13] = 151312, --  (Belo'ren (March on Quel'Danas)
 Chimaerus (The Dreamrift)
 Vaelgor and Ezzorak (The Voidspire)
 Seat of the Triumvirate)
    },
    MONK_MISTWEAVER = {
        [16] = 258050, --  (Skyreach)
        [17] = 249276, --  (Vorasius in The Voidspire)
        [1] = 249913, --  (Midnight Falls in March on Quel'Danas)
        [2] = 249337, --  (Fallen-King Salhadaar in The Voidspire)
        [3] = 250013, --  (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 239656, --  (Crafted by Tailoring)
        [5] = 250018, --  (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 240167, --  (Crafted by Leatherworking)
        [10] = 250016, --  (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 249374, --  (Chimaerus in The Dreamrift)
        [7] = 250014, --  (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 251210, --  (Nexus-Point Xenas)
        [11] = 249920, --  (Midnight Falls in March on Quel'Danas)
        [12] = 151311, --  (Seat of the Triumvirate)
        [13] = 249343, --  (Chimaerus in The Dreamrift)
        [14] = 250144, --  (Windrunner Spire)
    },
    MONK_WINDWALKER = {
        [16] = 251162, --  (Maisara Caverns)
        [1] = 250015, --  (Matrix Catalyst, or Lightblinded Vanguard - The Voidspire)
        [2] = 250247, --  (Midnight Falls)
        [3] = 250013, --  (Matrix Catalyst, or Fallen-King Salhadaar - The Voidspire)
        [15] = 250010, --  (Matrix Catalyst)
        [5] = 250018, --  (Matrix Catalyst, or Chimaerus - The Dreamrift)
        [9] = 249327, --  (Vorasius)
        [10] = 249321, --  (Vaelgor and Ezzorak)
        [6] = 251082, --  (Windrunner Spire)
        [7] = 250014, --  (Matrix Catalyst, or Vaelgor and Ezzorak - The Voidspire)
        [8] = 250017, --  (Matrix Catalyst)
        [11] = 251513, --  (Jewelcrafting)
        [13] = 249343, --  (Chimaerus)
    },
    PALADIN_HOLY = {
        [16] = 193710, -- Spellboon Saber (Algeth'ar Academy)
        [17] = 258049, -- Viryx's Indomitable Bulwark (Skyreach)
        [1] = 249961, -- Luminant Verdict's Unwavering Gaze (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 249959, -- Luminant Verdict's Providence Watch (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 239656, -- Adherent's Silken Shroud with  Arcanoweave Lining and Haste/Mastery (Crafted by Tailoring)
        [5] = 249964, -- Luminant Verdict's Divine Warplate (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 240167, -- Spellbreaker's Bracers with  Arcanoweave Lining and Haste/Mastery (Crafted by Blacksmithing)
        [10] = 249962, -- Luminant Verdict's Gauntlets (Matrix Catalyst, or Vorasius in The Voidspire)
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
        [1] = 249961, -- Luminant Verdict's Unwavering Gaze (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 251096, -- Pendant of Aching Grief (Windrunner Spire)
        [3] = 249959, -- Luminant Verdict's Providence Watch (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 249335, -- Imperator's Banner (Imperator Averzian in The Voidspire)
        [5] = 249964, -- Luminant Verdict's Divine Warplate (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 251490, -- Spellbreaker's Bracers with  Stabilizing Gemstone Bandolier (Crafted by Blacksmithing)
        [10] = 151332, -- Voidclaw Gauntlets (Seat of the Triumvirate)
        [6] = 249331, -- Ezzorak's Gloombind (Vaelgor and Ezzorak in The Voidspire)
        [7] = 249960, -- Luminant Verdict's Greaves (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249332, -- Parasite Stompers (Vorasius in The Voidspire)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [12] = 251513, -- Loa Worshiper's Band (Crafted by Jewelcrafting)
        [13] = 260235, -- Umbral Plume (Belo'ren in March on Quel'Danas)
        [14] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
    },
    PALADIN_RETRIBUTION = {
        [16] = 249277, -- Bellamy's Final Judgement (Lightblinded Vanguard in The Voidspire)
        [1] = 249961, -- Luminant Verdict's Unwavering Gaze (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 249959, -- Luminant Verdict's Providence Watch (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 249964, -- Luminant Verdict's Divine Warplate (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 151332, -- Voidclaw Gauntlets (Seat of the Triumvirate)
        [6] = 249380, -- Hate-Tied Waistchain (Crown of the Cosmos in The Voidspire)
        [7] = 249960, -- Luminant Verdict's Greaves (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249381, -- Greaves of the Unformed (Chimaerus in The Dreamrift)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [13] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
        [14] = 260235, -- Umbral Plume (Belo'ren in March on Quel'Danas)
    },
    PRIEST_DISCIPLINE = {
        [16] = 249283, -- Belo'melorn, the Shattered Talon (Belo'ren in March on Quel'Danas)
        [17] = 245876, -- Aln'hara Lantern with  Darkmoon Sigil: Hunt (Crafted by Inscription)
        [1] = 250051, -- Blind Oath's Winged Crest (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 250049, -- Blind Oath's Seraphguards (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak in The Voidspire)
        [5] = 249912, -- Robes of Endless Oblivion (Midnight Falls in March on Quel'Danas)
        [9] = 249315, -- Voracious Wristwraps (Vorasius in The Voidspire)
        [10] = 250052, -- Blind Oath's Touch (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 239664, -- Arcanoweave Cord (Crafted by Tailoring)
        [7] = 250050, -- Blind Oath's Leggings (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 258584, -- Lightbinder Treads (Skyreach)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 251093, -- Omission of Light (Nexus-Point Xenas)
        [13] = 249346, -- Vaelgor's Final Stare (Vaelgor and Ezzorak in The Voidspire)
        [14] = 249341, -- Volatile Void Suffuser (Fallen-King Salhadaar in The Voidspire)
    },
    PRIEST_HOLY = {
        [1] = 250051, -- Blind Oath's Winged Crest (TIER SET) (Lightblinded Vanguard in The Voidspire / Matrix Catalyst)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 250049, -- Blind Oath's Seraphguards (TIER SET) (Fallen-King Salhadaar in The Voidspire / Matrix Catalyst)
        [15] = 249335, -- Imperator's Banner (Imperator Averzian in The Voidspire)
        [5] = 250054, -- Blind Oath's Raiment (TIER SET) (Chimaerus in The Dreamrift / Matrix Catalyst)
        [9] = 250047, -- Blind Oath's Wraps (Matrix Catalyst any bracer)
        [10] = 250052, -- Blind Oath's Touch (TIER SET) (Vorasius in The Voidspire / Matrix Catalyst)
        [6] = 239664, -- Arcanoweave Cord (Tailoring)
        [7] = 249323, -- Leggings of the Devouring Advance (Imperator Averzian in The Voidspire)
        [8] = 251167, -- Nightprey Stalkers (Maisara Caverns)
        [11] = 249336, -- Signet of the Starved Beast (Vorasius in The Voidspire)
        [13] = 249808, -- Litany of Lightblind Wrath (Lightblinded Vanguard in The Voidspire)
        [16] = 245770, -- Aln'hara Cane (Inscription)
    },
    PRIEST_SHADOW = {
        [16] = 249286, -- Belo'melorn, the Shattered Talon (1H)
 Tome of Alnscorned Regret (OH)
 Brazier of the Dissonant Dirge (2H) (Belo'ren in March on Quel'Danas
Chimaerus in The Dreamrift
Midnight Falls in March on Quel'Danas)
        [1] = 250051, -- Blind Oath's Winged Crest (TIER SET) (Lightblinded Vanguard in The Voidspire)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 250049, -- Blind Oath's Seraphguards (TIER SET) (Fallen-King Salhadaar in The Voidspire)
        [15] = 239661, -- Arcanoweave Cloak (Tailoring)
        [5] = 250054, -- Blind Oath's Raiment (TIER SET) (Chimaerus in The Dreamrift)
        [9] = 239660, -- Arcanoweave Bracers (Tailoring)
        [10] = 251172, -- Vilehex Bonds (Maisara Caverns)
        [6] = 249376, -- Whisper-Inscribed Sash (Belo'ren in March on Quel'Danas)
        [7] = 250050, -- Blind Oath's Leggings (TIER SET) (Vaelgor and Ezzorak in Voidspire)
        [8] = 258584, -- Lightbinder Treads (Skyreach)
        [11] = 251115, -- Omission of Light
         Eye of Midnight
         Bifurcation Band (Nexus-Point Xenas
        Midnight Falls in March on Quel'Danas
        Magister's Terrace)
        [13] = 249810, -- Gaze of the Alnseer
 Soulcatcher's Charm
 Vaelgor's Final Stare
 Shadow of the Empyrean Requiem (Chimaerus in The Dreamrift
Maisara Caverns
Vaelgor and Ezzorak in The Voidspire
Midnight Falls in March on Quel'Danas)
    },
    ROGUE_ASSASSINATION = {
        [16] = 249925, -- Your highest ilvl dagger.
Best choice:  Hungering Victory (Vorasius in The Voidspire)
        [17] = 245876, -- Farstrider's Mercy (Crit/Haste) with  Darkmoon Sigil: Hunt (Crafted by Blacksmithing)
        [1] = 250006, -- Masquerade of the Grim Jest (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 249337, -- Ribbon of Coiled Malice (Fallen-King Salhadaar in The Voidspire)
        [3] = 250004, -- Venom Casks of the Grim Jest (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [5] = 250009, -- Fantastic Finery of the Grim Jest (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 240167, -- Silvermoon Agent's Deflectors (Crit/Haste) with  Arcanoweave Lining (Crafted by Leatherworking)
        [10] = 250007, -- Sleight of Hand of the Grim Jest (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 249374, -- Scorn-Scarred Shul'ka's Belt (Chimaerus in The Dreamrift)
        [7] = 251087, -- Legwraps of Lingering Legacies (Windrunner Spire)
        [8] = 249382, -- Canopy Walker's Footwraps (Crown of the Cosmos in The Voidspire)
        [11] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [12] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [13] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
    },
    ROGUE_OUTLAW = {
        [16] = 260423, -- Your highest ilvl slow main-hand.
Best choice:  Arator's Swift Remembrance (Crown of the Cosmos in The Voidspire)
        [17] = 133491, -- Krick's Beetle Stabber (Pit of Saron)
        [1] = 151336, -- Voidlashed Hood (Seat of the Triumvirate)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 250004, -- Venom Casks of the Grim Jest (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 249335, -- Imperator's Banner (Imperator Averzian in The Voidspire)
        [5] = 250009, -- Fantastic Finery of the Grim Jest (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 50264, -- Chewed Leather Wristguards (Pit of Saron)
        [10] = 250007, -- Sleight of Hand of the Grim Jest (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 249374, -- Scorn-Scarred Shul'ka's Belt (Chimaerus in The Dreamrift)
        [7] = 250005, -- Blade Holsters of the Grim Jest (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 240167, -- Silvermoon Agent's Sneakers (Crit/Haste) with  Arcanoweave Lining (Crafted by Leatherworking)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 251487, -- Masterwork Sin'dorei Band (Crit/Haste) with  Prismatic Focusing Iris (Crafted by Jewelcrafting)
        [13] = 260235, -- Umbral Plume (Belo'ren in March on Quel'Danas)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
    },
    ROGUE_SUBTLETY = {
        [16] = 249925, -- Your highest ilevel dagger.
Best choice:  Hungering Victory (Vorasius in The Voidspire)
        [17] = 245876, -- Farstrider's Mercy with  Darkmoon Sigil: Hunt (Crafted by Blacksmithing)
        [1] = 250006, -- Masquerade of the Grim Jest (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 250004, -- Venom Casks of the Grim Jest (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 258575, -- Rigid Scale Greatcloak (Skyreach)
        [5] = 250009, -- Fantastic Finery of the Grim Jest (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 249327, -- Void-Skinned Bracers (Vorasius  in The Voidspire)
        [10] = 250007, -- Sleight of Hand of the Grim Jest (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 240167, -- Silvermoon Agent's Utility Belt with  Arcanoweave Lining (Crafted by Leatherworking)
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
        [1] = 249979, -- Locus of the Primal Core (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 249977, -- Tempests of the Primal Core (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 249974, -- Guardian of the Primal Core (Matrix Catalyst)
        [5] = 249982, -- Embrace of the Primal Core (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 249304, -- Fallen King's Cuffs (Fallen-King Salhadaar in The Voidspire)
        [10] = 249980, -- Earthgrips of the Primal Core (Matrix Catalyst, or Vorasius in The Voidspire)
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
        [16] = 249293, --  (Imperator Averzian in The Voidspire)
        [17] = 249921, --  (Belo'ren in March on Quel'Danas)
        [1] = 249914, --  (Midnight Falls in March on Quel'Danas)
        [2] = 249337, --  (Fallen-King Salhadaar in The Voidspire)
        [3] = 249977, --  (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 249974, --  (Matrix Catalyst)
        [5] = 249982, --  (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 249975, --  (Matrix Catalyst)
        [10] = 249980, --  (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 244611, --  (Crafted by Leatherworking)
        [7] = 249978, --  (Matrix Catalyst, or Vaelgor and Ezzorak in The Dreamrift)
        [8] = 244610, --  (Crafted by Leatherworking)
        [11] = 151308, --  (Seat of the Triumvirate)
        [12] = 151311, --  (Seat of the Triumvirate)
        [13] = 249808, --  (Lightblinded Vanguard in The Voidspire)
        [14] = 249343, --  (Chimaerus in The Dreamrift)
    },
    WARLOCK_AFFLICTION = {
        [1] = 250042, --  (Lightblinded Vanguard in The Voidspire or Matrix Catalyst)
        [2] = 249368, --  (Crown of the Cosmos in The Voidspire)
        [3] = 249328, --  (Belo'ren in March on Quel'Danas)
        [15] = 239656, --  (Crafted by Tailoring)
        [5] = 250045, --  (Chimaerus in The Dreamrift or Matrix Catalyst)
        [9] = 240167, --  (Crafted by Tailoring)
        [10] = 250043, --  (Vorasius in The Voidspire or Matrix Catalyst)
        [6] = 251102, --  (Magister's Terrace)
        [7] = 250041, --  (Vaelgor and Ezzorak in The Voidspire or Matrix Catalyst)
        [8] = 249305, --  (Vaelgor and Ezzorak in The Voidspire)
        [11] = 249920, --  (Midnight Falls in March on Quel'Danas)
        [12] = 251217, --  (Nexus-Point Xenas)
        [13] = 250144, --  (Windrunner Spire)
        [14] = 249810, --  (Midnight Falls in March on Quel'Danas)
        [16] = 251111, --  (Magister's Terrace)
        [17] = 249276, --  (Vorasius in The Voidspire)
    },
    WARLOCK_DEMONOLOGY = {
        [1] = 250042, --  (Lightblinded Vanguard in The Voidspire or Matrix Catalyst)
        [2] = 249368, --  (Crown of the Cosmos in The Voidspire)
        [3] = 251085, --  (Windrunner Spire)
        [15] = 239656, --  (Crafted by Tailoring)
        [5] = 250045, --  (Chimaerus in The Dreamrift or Matrix Catalyst)
        [9] = 240167, --  (Crafted by Tailoring)
        [10] = 250043, --  (Vorasius in The Voidspire or Matrix Catalyst)
        [6] = 250039, --  (Matrix Catalyst)
        [7] = 250041, --  (Vaelgor and Ezzorak in The Voidspire or Matrix Catalyst)
        [8] = 249373, --  (Chimaerus in The Dreamrift)
        [11] = 249920, --  (Midnight Falls in March on Quel'Danas)
        [12] = 249336, --  (Vorasius in The Voidspire)
        [13] = 250144, --  (Windrunner Spire)
        [14] = 249809, --  (Crown of the Cosmos in The Voidspire)
        [16] = 258047, --  (Skyreach)
    },
    WARLOCK_DESTRUCTION = {
        [1] = 250042, --  (Lightblinded Vanguard in The Voidspire or Matrix Catalyst)
        [2] = 249368, --  (Crown of the Cosmos in The Voidspire)
        [3] = 251085, --  (Windrunner Spire)
        [15] = 239656, --  (Crafted by Tailoring)
        [5] = 250045, --  (Chimaerus in The Dreamrift or Matrix Catalyst)
        [9] = 240167, --  (Crafted by Tailoring)
        [10] = 250043, --  (Vorasius in The Voidspire or Matrix Catalyst)
        [6] = 250039, --  (Matrix Catalyst)
        [7] = 250041, --  (Vaelgor and Ezzorak in The Voidspire or Matrix Catalyst)
        [8] = 249305, --  (Vaelgor and Ezzorak in The Voidspire)
        [11] = 249920, --  (Midnight Falls in March on Quel'Danas)
        [12] = 249336, --  (Vorasius in The Voidspire)
        [13] = 249346, --  (Vaelgor and Ezzorak in The Voidspire)
        [14] = 249810, --  (Midnight Falls in March on Quel'Danas)
        [16] = 258047, --  (Skyreach)
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
        [1] = 249952, -- Night Ender's Tusks (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 249950, -- Night Ender's Pauldrons (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted — Tailoring)
        [5] = 249955, -- Night Ender's Breastplate (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted — Blacksmithing)
        [10] = 151332, -- Voidclaw Gauntlets (Seat of the Triumvirate)
        [6] = 249949, -- Night Ender's Girdle (Matrix Catalyst)
        [7] = 249951, -- Night Ender's Chausses (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249954, -- Night Ender's Greatboots (Matrix Catalyst)
        [11] = 249920, -- Eye of Midnight (Midnight Falls)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy, only BiS if you can use it consistently.)
        [16] = 249295, -- Turalyon's False Echo (Crown of the Cosmos in The Voidspire)
        [17] = 251105, -- Ward of the Spellbreaker (Magister's Terrace)
    },
}

-- ============================================================================
-- BIS LISTS - MYTHIC (from Icy Veins, Midnight Season 1)
-- ============================================================================
NS.BIS_MYTHIC = {
    DEATHKNIGHT_BLOOD = {
        [16] = 251168, -- Liferipper's Cutlass (Maisara Caverns)
        [1] = 249970, -- Relentless Rider's Crown (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 249968, -- Relentless Rider's Dreadthorns (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [5] = 249973, -- Relentless Rider's Cuirass (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 251203, -- Kasreth's Bindings (Nexus-Point Xenas)
        [10] = 151332, -- Voidclaw Gauntlets (Seat of the Triumvirate)
        [6] = 249380, -- Hate-Tied Waistchain (Crown of the Cosmos in The Voidspire)
        [7] = 249969, -- Relentless Rider's Legguards (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249381, -- Greaves of the Unformed (Chimaerus in The Dreamrift)
        [11] = 251490, -- Masterwork Sin'dorei Band with  Stabilizing Gemstone Bandolier (Crafted by Jewelcrafting)
        [12] = 251513, -- Loa Worshiper's Band (Crafted by Jewelcrafting)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 260235, -- Umbral Plume (Belo'ren in March on Quel'Danas)
    },
    DEATHKNIGHT_FROST = {
        [16] = 249277, -- Liferipper's Cutlass (tied with  Bellamy's Final Judgement) (Maisara Caverns)
        [1] = 249970, -- Relentless Rider's Crown (Matrix Catalyst)
        [2] = 50228, -- Barbed Ymirheim Choker (Seat of the Triumvirate)
        [3] = 50234, -- Shoulderplates of Frozen Blood (Pit of Saron)
        [15] = 258575, -- Adherent's Silken Shroud with  Arcanoweave Lining ( Rigid Scale Greatcloak when running a Dual-Wield setup) (Crafted by Leatherworking)
        [5] = 249973, -- Relentless Rider's Cuirass (Matrix Catalyst)
        [9] = 240167, -- Spellbreaker's Bracers with  Arcanoweave Lining (Crafted by Blacksmithing)
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
        [16] = 249277, -- Liferipper's Cutlass (tied with  Bellamy's Final Judgement) (Maisara Caverns)
        [1] = 249970, -- Relentless Rider's Crown (Matrix Catalyst)
        [2] = 50228, -- Barbed Ymirheim Choker (Seat of the Triumvirate)
        [3] = 50234, -- Shoulderplates of Frozen Blood (Pit of Saron)
        [15] = 239656, -- Adherent's Silken Shroud with  Arcanoweave Lining (Crafted by Leatherworking)
        [5] = 249973, -- Relentless Rider's Cuirass (Matrix Catalyst)
        [9] = 240167, -- Spellbreaker's Bracers with  Arcanoweave Lining (Crafted by Blacksmithing)
        [10] = 249971, -- Relentless Rider's Bonegrasps (Matrix Catalyst)
        [6] = 49808, -- Bent Gold Belt (Pit of Saron)
        [7] = 249969, -- Relentless Rider's Legguards (Matrix Catalyst)
        [8] = 251107, -- Oathsworn Stompers (Magister's Terrace)
        [11] = 193708, -- Platinum Star Band (Algeth'ar Academy)
        [12] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [13] = 193701, -- Algeth'ar Puzzle Box (Algeth'ar Academy)
        [14] = 252420, -- Solarflare Prism (Skyreach)
    },
    -- DEMONHUNTER_DEVOURER removed: not a valid WoW spec
    DEMONHUNTER_HAVOC = {
        [16] = 260408, --  (Midnight Falls)
        [17] = 249280, --  (Vaelgor and Ezzorak)
        [1] = 249306, --  (Imperator Averzian)
        [2] = 250247, --  (Crown of the Cosmos)
        [3] = 250031, --  (Fallen-King Salhadaar)
        [15] = 239656, --  (Tailoring)
        [5] = 250036, --  (Chimaerus)
        [9] = 244576, --  (Leatherworking)
        [10] = 250034, --  (Vorasius)
        [6] = 249314, --  (Fallen-King Salhadaar)
        [7] = 250032, --  (Vaelgor and Ezzorak)
        [8] = 249382, --  (Crown of the Cosmos)
        [11] = 249919, --  (Belo'ren)
        [12] = 249336, --  (Vorasius)
        [13] = 249343, --  (Chimaerus)
        [14] = 260235, --  (Belo'ren)
    },
    DEMONHUNTER_VENGEANCE = {
        [16] = 260408, --  (Midnight Falls)
        [1] = 250033, --  (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 249368, --  (Crown of the Cosmos in The Voidspire)
        [3] = 250031, --  (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 249335, --  (Vaelgor and Ezzorak in The Voidspire)
        [5] = 249322, --  (Belo'ren in March on Quel'Danas)
        [9] = 240167, --  (Crafted by Leatherworking)
        [10] = 250034, --  (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 249374, --  (Chimaerus in The Dreamrift)
        [7] = 250032, --  (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249334, --  (Imperator Averzian in The Voidspire)
        [11] = 249336, --  (Vorasius in The Voidspire)
        [12] = 249920, --  (Midnight Falls in March on Quel'Danas)
        [13] = 249344, --  (Imperator Averzian in The Voidspire)
        [14] = 249343, --  (Chimaerus in The Dreamrift)
    },
    DRUID_BALANCE = {
        [16] = 249286, --  (Midnight Falls in March on Quel'Danas)
        [1] = 250024, --  (Lightblinded Vanguard in The Voidspire)
        [2] = 250247, --  (Midnight Falls in March on Quel'Danas)
        [3] = 250022, --  (Fallen-King Salhadaar in The Voidspire)
        [15] = 250019, --  (Creation Catalyst)
        [5] = 250027, --  (Chimaerus in The Dreamrift)
        [9] = 249327, --  (Vorasius in The Voidspire)
        [10] = 244576, --  (Leatherworking)
        [6] = 249374, --  (Chimaerus in The Dreamrift)
        [7] = 250023, --  (Vaelgor and Ezzorak in The Voidspire)
        [8] = 240167, --  (Leatherworking)
        [11] = 249920, --  (Midnight Falls in March on Quel'Danas)
        [12] = 249369, --  (Lightblinded Vanguard in The Voidspire)
        [13] = 249343, --  (Chimaerus in The Dreamrift)
        [14] = 249346, --  (Vaelgor and Ezzorak)
    },
    DRUID_FERAL = {
        [16] = 249302, --  (Midnight Falls)
        [1] = 250024, --  (Lightblinded Vanguard)
        [2] = 250247, --  (Midnight Falls)
        [3] = 250022, --  (Fallen-King Salhadaar)
        [15] = 239656, --  (Tailoring)
        [5] = 250027, --  (Chimaerus)
        [9] = 244576, --  (Leatherworking)
        [10] = 250025, --  (Vorasius)
        [6] = 249374, --  (Chimaerus)
        [7] = 250023, --  (Vaelgor and Ezzorak)
        [8] = 249382, --  (Crown of the Cosmos)
        [11] = 249920, --  (Midnight Falls)
        [12] = 249369, --  (Lightblinded Vanguard)
        [13] = 249343, --  (Chimaerus)
        [14] = 249806, --  (Belo'ren)
    },
    DRUID_GUARDIAN = {
        [16] = 251162, --  (Maisara Caverns)
        [1] = 151336, --  (Seat of the Triumvirate)
        [2] = 251096, --  (Windrunner Spire)
        [3] = 250022, --  (Matrix Catalyst)
        [15] = 251161, --  (Maisara Caverns)
        [5] = 250027, --  (Matrix Catalyst)
        [9] = 240167, --  (Crafted by Leatherworking)
        [10] = 250025, --  (Matrix Catalyst)
        [6] = 244611, --  (Crafted by Leatherworking)
        [7] = 250023, --  (Matrix Catalyst)
        [8] = 251210, --  (Nexus-Point Xenas)
        [11] = 251217, --  (Nexus-Point Xenas)
        [12] = 251093, --  (Nexus-Point Xenas)
        [13] = 250144, --  (Windrunner Spire)
        [14] = 193701, --  (Algeth'ar Academy)
    },
    DRUID_RESTORATION = {
        [1] = 249913, --  (Midnight Falls - March on Quel'Danas)
        [2] = 250247, --  (Midnight Falls - March on Quel'Danas)
        [3] = 250022, --  (Fallen-King Salhadaar - The Voidspire)
        [15] = 249370, --  (Vaelgor and Ezzorak - The Voidspire)
        [5] = 250027, --  (Chimaerus - Dreamrift)
        [9] = 250020, --  (Lightblinded Vanguard - The Voidspire)
        [10] = 250025, --  (Vorasius - The Voidspire)
        [6] = 249314, --  (Fallen-King Salhadaar - The Voidspire)
        [7] = 250023, --  (Vaelgor and Ezzorak - The Voidspire)
        [8] = 249334, --  (Imperator Averzian - The Voidspire)
        [11] = 249369, --  (Lightblinded Vanguard - The Voidspire)
        [13] = 249343, --  (Chimaerus - Dreamrift)
        [16] = 249283, --  (Belo'ren - March on Quel'Danas)
        [17] = 249922, --  (Chimaerus - Dreamrift)
    },
    EVOKER_AUGMENTATION = {
        [16] = 193709, --  (Maisara Caverns
            Magister's Terrace
            Skyreach
            Algeth'ar Academy)
        [1] = 49824, --  (Pit of Saron)
        [2] = 50228, --  (Pit of Saron)
        [3] = 249995, --  (Matrix Catalyst)
        [15] = 260312, --  (Crafted by Tailoring
            
            
              Magister's Terrace)
        [5] = 250000, --  (Matrix Catalyst)
        [9] = 151321, --  (Crafted by Leatherworking
            
            
              Seat of the Triumvirate)
        [10] = 249998, --  (Matrix Catalyst)
        [6] = 49810, --  (Pit of Saron)
        [7] = 249996, --  (Matrix Catalyst)
        [8] = 249999, --  (Algeth'ar Academy
            
            
              Matrix Catalyst)
        [11] = 240949, --  (Nexus-Point Xenas
            Pit of Saron
            Crafted by Jewelcrafting)
        [13] = 193718, --  (Maisara Caverns
            Windrunner Spire
            Magister's Terrace
            Algeth'ar Academy)
    },
    EVOKER_DEVASTATION = {
        [16] = 251201, --  ()
        [1] = 249997, --  (Matrix Catalyst)
        [2] = 50228, --  (Pit of Saron)
        [3] = 249995, --  (Matrix Catalyst)
        [15] = 239656, --  (Crafted by Tailoring)
        [5] = 250000, --  (Matrix Catalyst)
        [9] = 251079, --  (Windrunner Spire)
        [10] = 249998, --  (Matrix Catalyst)
        [6] = 49810, --  (Pit of Saron)
        [7] = 249996, --  (Matrix Catalyst)
        [8] = 251084, --  (Windrunner Spire)
        [11] = 251217, --  (Nexus-Point Xenas)
        [13] = 250258, --  (Maisara Caverns)
    },
    EVOKER_PRESERVATION = {
        [16] = 258514, --  (Seat of the Triumvirate)
        [1] = 251119, --  (Magister's Terrace)
        [2] = 50228, --  (Pit of Saron)
        [3] = 249995, --  (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 251206, --  (Nexus-Point Xenas)
        [5] = 250000, --  (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 251079, --  (Windrunner Spire)
        [10] = 249998, --  (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 244611, --  (Crafted by Leatherworking)
        [7] = 249996, --  (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 244610, --  (Crafted by Leatherworking)
        [11] = 251115, --  (Magister's Terrace)
        [12] = 251093, --  (Nexus-Point Xenas)
        [13] = 250256, --  (Windrunner Spire)
        [14] = 250144, --  (Windrunner Spire)
    },
    HUNTER_BEASTMASTERY = {
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
        [16] = 249279, -- Sunstrike Rifle (Imperator Averzian - Voidspire)
    },
    HUNTER_MARKSMANSHIP = {
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
        [16] = 249288, -- Ranger-Captain's Lethal Recurve (Crown of the Cosmos - Voidspire)
    },
    HUNTER_SURVIVAL = {
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
        [16] = 249302, -- Inescapable Reach (Vorasius - Voidspire)
        [17] = 237837, -- Farstrider's Mercy (Blacksmithing)
    },
    MAGE_ARCANE = {
        [16] = 258218, --  (Skyreach)
        [17] = 251094, --  (Windrunner Spire)
        [1] = 250060, --  (Matrix Catalyst)
        [2] = 50228, --  (Pit of Saron)
        [3] = 250058, --  (Matrix Catalyst)
        [15] = 239661, --  (Crafted by Tailoring)
        [5] = 250063, --  (Matrix Catalyst)
        [9] = 239660, --  (Crafted by Tailoring)
        [10] = 250061, --  (Matrix Catalyst)
        [6] = 251102, --  (Magister's Terrace)
        [7] = 251090, --  (The Great Vault / Windrunner Spire)
        [8] = 251167, --  (Maisara Caverns)
        [11] = 193708, --  (Algeth'ar Academy)
        [13] = 250144, --  (Windrunner Spire)
    },
    MAGE_FIRE = {
        [16] = 193710, --  (Algeth'ar Academy)
        [17] = 258472, --  (Windrunner Spire)
        [1] = 250060, --  (Matrix Catalyst)
        [2] = 151309, --  (Seat of the Triumvirate)
        [3] = 250058, --  (Matrix Catalyst)
        [15] = 239656, --  (Crafted by Tailoring with  Arcanoweave Lining and Haste + Mastery)
        [5] = 49825, --  (Pit of Saron)
        [9] = 239648, --  (Crafted by Tailoring with  Arcanoweave Lining and Haste + Mastery)
        [10] = 250061, --  (Matrix Catalyst)
        [6] = 50263, --  (Pit of Saron)
        [7] = 250059, --  (Matrix Catalyst)
        [8] = 258584, --  (Skyreach)
        [11] = 251093, --  (Nexus-Point Xenas)
        [13] = 250144, --  (Windrunner Spire)
    },
    MAGE_FROST = {
        [16] = 245876, --  (Inscription)
        [1] = 250060, --  (Matrix Catalyst)
        [2] = 50228, --  (Pit of Saron)
        [3] = 251085, --  (Windrunner Spire)
        [15] = 258575, --  (Skyreach)
        [5] = 250063, --  (Matrix Catalyst)
        [9] = 240167, --  (Tailoring)
        [10] = 250061, --  (Matrix Catalyst)
        [6] = 250057, --  (Matrix Catalyst)
        [7] = 250059, --  (Matrix Catalyst)
        [8] = 133489, --  (Pit of Saron)
        [11] = 251217, --  (Nexus-Point Xenas)
        [12] = 251093, --  (Nexus-Point Xenas)
        [13] = 250144, --  (Windrunner Spire)
        [14] = 250256, --  (Windrunner Spire)
    },
    MONK_BREWMASTER = {
        [1] = 250015, --  (Matrix Catalyst)
        [2] = 245792, --  (Jewelcrafting (see note))
        [3] = 250013, --  (Matrix Catalyst)
        [15] = 251161, --  (Maisara Caverns)
        [5] = 250018, --  (Matrix Catalyst)
        [9] = 50264, --  (Pit of Saron)
        [10] = 250016, --  (Matrix Catalyst)
        [6] = 251082, --  (Windrunner Spire)
        [7] = 151314, --  (Seat of the Triumvirate)
        [8] = 151317, --  (Seat of the Triumvirate)
        [11] = 151308, --  (Seat of the Triumvirate)
        [16] = 193723, --  (Algeth'ar Academy)
        [13] = 151312, --  (Skyreach
 Seat of the Triumvirate
 Pit of Saron
 Seat of the Triumvirate)
    },
    MONK_MISTWEAVER = {
        [16] = 258050, --  (Skyreach)
        [17] = 193709, --  (Algeth'ar Academy)
        [1] = 151336, --  (Seat of the Triumvirate)
        [2] = 251096, --  (Windrunner Spire)
        [3] = 250013, --  (Matrix Catalyst)
        [15] = 239656, --  (Crafted by Tailoring)
        [5] = 250018, --  (Matrix Catalyst)
        [9] = 240167, --  (Crafted by Leatherworking)
        [10] = 250016, --  (Matrix Catalyst)
        [6] = 251166, --  (Maisara Caverns)
        [7] = 250014, --  (Matrix Catalyst)
        [8] = 251210, --  (Nexus-Point Xenas)
        [11] = 151308, --  (Seat of the Triumvirate)
        [12] = 151311, --  (Seat of the Triumvirate)
        [13] = 250256, --  (Windrunner Spire)
        [14] = 250144, --  (Windrunner Spire)
    },
    MONK_WINDWALKER = {
        [16] = 251162, --  (Maisara Caverns)
        [1] = 250015, --  (Matrix Catalyst, or Lightblinded Vanguard - The Voidspire)
        [2] = 50228, --  (Pit of Saron)
        [3] = 250013, --  (Matrix Catalyst, or Fallen-King Salhadaar - The Voidspire)
        [15] = 250010, --  (Matrix Catalyst)
        [5] = 250018, --  (Matrix Catalyst, or Chimaerus - The Dreamrift)
        [9] = 193714, --  (Algeth'ar Academy)
        [10] = 151318, --  (Seat of the Triumvirate)
        [6] = 251082, --  (Windrunner Spire)
        [7] = 250014, --  (Matrix Catalyst, or Vaelgor and Ezzorak - The Voidspire)
        [8] = 250017, --  (Matrix Catalyst)
        [11] = 251513, --  (Jewelcrafting)
        [13] = 250256, --  (Windrunner Spire)
    },
    PALADIN_HOLY = {
        [16] = 193710, -- Spellboon Saber (Algeth'ar Academy)
        [17] = 258049, -- Viryx's Indomitable Bulwark (Skyreach)
        [1] = 249961, -- Luminant Verdict's Unwavering Gaze (Matrix Catalyst)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 249959, -- Luminant Verdict's Providence Watch (Matrix Catalyst)
        [15] = 239656, -- Adherent's Silken Shroud with  Arcanoweave Lining and Haste/Mastery (Crafted by Tailoring)
        [5] = 249964, -- Luminant Verdict's Divine Warplate (Matrix Catalyst)
        [9] = 240167, -- Spellbreaker's Bracers with  Arcanoweave Lining and Haste/Mastery (Crafted by Blacksmithing)
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
        [1] = 249961, -- Luminant Verdict's Unwavering Gaze (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 249337, -- Ribbon of Coiled Malice (Fallen-King Salhadaar in The Voidspire)
        [3] = 249959, -- Luminant Verdict's Providence Watch (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 249335, -- Imperator's Banner (Imperator Averzian in The Voidspire)
        [5] = 249309, -- Sunbound Breastplate (Crown of the Cosmos in The Voidspire)
        [9] = 251490, -- Spellbreaker's Bracers with  Stabilizing Gemstone Bandolier (Crafted by Blacksmithing)
        [10] = 249962, -- Luminant Verdict's Gauntlets (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 249331, -- Ezzorak's Gloombind (Vaelgor and Ezzorak in The Voidspire)
        [7] = 249960, -- Luminant Verdict's Greaves (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
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
        [17] = 245876, -- Aln'hara Lantern with  Darkmoon Sigil: Hunt (Crafted by Inscription)
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
        [1] = 250051, -- Blind Oath's Winged Crest (TIER SET) (Matrix Catalyst)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 250049, -- Blind Oath's Seraphguards (TIER SET) (Matrix Catalyst)
        [15] = 49823, -- Cloak of the Fallen Cardinal (Pit of Saron)
        [5] = 250054, -- Blind Oath's Raiment (TIER SET) (Matrix Catalyst)
        [9] = 258580, -- Bracers of Blazing Light (Skyreach)
        [10] = 250052, -- Blind Oath's Touch (TIER SET) (Matrix Catalyst)
        [6] = 239664, -- Arcanoweave Cord (Tailoring)
        [7] = 250050, -- Blind Oath's Leggings (TIER SET) (Matrix Catalyst)
        [8] = 251167, -- Nightprey Stalkers (Maisara Caverns)
        [11] = 151308, -- Eredath Seal of Nobility (Seat of the Triumvirate)
        [13] = 193718, -- Emerald Coach's Whistle (Algeth'ar Academy)
        [16] = 251094, -- Aln'hara Cane (Best Craft)
             Surgeon's Needle (1H)
             Wand of Saprish's Gaze (1H)
             Sigil of the Restless Heart (OH) (Tailoring
            Pit of Saron
            Seat of the Triumvirate
            Windrunner Spire)
    },
    PRIEST_SHADOW = {
        [16] = 258047, -- Splitshroud Stinger (1H)
 Rukhran's Solar Reliquary (OH)
 Corespark Multitool (2H)
 Spire of the Furious Construct (2H) (Magister's Terrace
Skyreach
Nexus-Point Xenas
Skyreach)
        [1] = 250051, -- Blind Oath's Winged Crest (TIER SET) (Matrix Catalyst)
        [2] = 151309, -- Necklace of the Twisting Void (Seat of the Triumvirate)
        [3] = 250049, -- Blind Oath's Seraphguards (TIER SET) (Matrix Catalyst)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [5] = 250054, -- Blind Oath's Raiment (TIER SET) (Matrix Catalyst)
        [9] = 151305, -- Entropic Wristwraps (Seat of the Triumvirate)
        [10] = 251172, -- Vilehex Bonds (Maisara Caverns)
        [6] = 151302, -- Cord of Unraveling Reality (Seat of the Triumvirate)
        [7] = 250050, -- Blind Oath's Leggings (TIER SET) (Matrix Catalyst)
        [8] = 258584, -- Lightbinder Treads (Skyreach)
        [11] = 251115, -- Omission of Light
         Bifurcation Band (Nexus-Point Xenas
        Magister's Terrace)
        [13] = 250256, -- Soulcatcher's Charm
 Vessel of Tortured Souls
 Emberwing Feather
 Heart of Wind (Maisara Caverns
Maisara Caverns
Windrunner Spire
Windrunner Spire)
    },
    ROGUE_ASSASSINATION = {
        [16] = 258436, -- Your highest ilvl dagger.
Best choice:  Edge of the Burning Sun (Skyreach)
        [17] = 245876, -- Farstrider's Mercy (Crit/Haste) with  Darkmoon Sigil: Hunt (Crafted by Blacksmithing)
        [1] = 250006, -- Masquerade of the Grim Jest (Matrix Catalyst)
        [2] = 151309, -- Necklace of the Twisting Void (Seat of the Triumvirate)
        [3] = 250004, -- Venom Casks of the Grim Jest (Matrix Catalyst)
        [15] = 260312, -- Defiant Defender's Drape (Magister's Terrace)
        [5] = 250009, -- Fantastic Finery of the Grim Jest (Matrix Catalyst)
        [9] = 240167, -- Silvermoon Agent's Deflectors (Crit/Haste) with  Arcanoweave Lining (Crafted by Leatherworking)
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
        [16] = 251207, -- Your highest ilvl slow main-hand.
Best choice:  Dreadflail Bludgeon (Nexus-Point Xenas)
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
        [8] = 240167, -- Silvermoon Agent's Sneakers (Crit/Haste) with  Arcanoweave Lining (Crafted by Leatherworking)
        [11] = 251217, -- Occlusion of Void (Nexus-Point Xenas)
        [12] = 251487, -- Masterwork Sin'dorei Band (Crit/Haste) with  Prismatic Focusing Iris (Crafted by Jewelcrafting)
        [13] = 250256, -- Heart of Wind (Windrunner Spire)
        [14] = 252420, -- Solarflare Prism (Skyreach)
    },
    ROGUE_SUBTLETY = {
        [16] = 258436, -- Your highest ilvl dagger.
Best choice:  Edge of the Burning Sun (Skyreach)
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
        [1] = 249979, -- Locus of the Primal Core (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 50228, -- Barbed Ymirheim Choker (Pit of Saron)
        [3] = 249977, -- Tempests of the Primal Core (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 258575, -- Rigid Scale Greatcloak (Skyreach)
        [5] = 249982, -- Embrace of the Primal Core (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 251079, -- Amberfrond Bracers (Windrunner Spire)
        [10] = 249980, -- Earthgrips of the Primal Core (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 244611, -- World Tender's Barkclasp (Crafted by Leatherworking)
        [7] = 251215, -- Greaves of the Divine Guile (Nexus-Point Xenas)
        [8] = 244610, -- World Tender's Rootslippers (Crafted by Leatherworking)
        [11] = 193708, -- Platinum Star Band (Algeth'ar Academy)
        [12] = 251115, -- Bifurcation Band (Magister's Terrace)
        [13] = 250144, -- Emberwing Feather (Windrunner Spire)
        [14] = 250256, -- Heart of Wind (Windrunner Spire)
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
        [16] = 251178, --  (Maisara Caverns)
        [17] = 258049, --  (Skyreach)
        [1] = 258585, --  (Skyreach)
        [2] = 50228, --  (Pit of Saron)
        [3] = 249977, --  (Matrix Catalyst)
        [15] = 258575, --  (Skyreach)
        [5] = 249982, --  (Matrix Catalyst)
        [9] = 151321, --  (Seat of the Triumvirate)
        [10] = 249980, --  (Matrix Catalyst)
        [6] = 244611, --  (Crafted by Leatherworking)
        [7] = 249978, --  (Matrix Catalyst)
        [8] = 244610, --  (Crafted by Leatherworking)
        [11] = 151308, --  (Seat of the Triumvirate)
        [12] = 151311, --  (Seat of the Triumvirate)
        [13] = 193718, --  (Algeth'ar Academy)
        [14] = 250253, --  (Nexus-Point Xenas)
    },
    WARLOCK_AFFLICTION = {
        [1] = 250042, --  (Matrix Catalyst)
        [2] = 50228, --  (Pit of Saron)
        [3] = 251085, --  (Windrunner Spire)
        [15] = 239656, --  (Crafted by Tailoring)
        [5] = 250045, --  (Matrix Catalyst)
        [9] = 240167, --  (Crafted by Tailoring)
        [10] = 250043, --  (Matrix Catalyst)
        [6] = 251102, --  (Magister's Terrace)
        [7] = 250041, --  (Matrix Catalyst)
        [8] = 251167, --  (Maisara Caverns)
        [11] = 251093, --  (Nexus-Point Xenas)
        [12] = 251217, --  (Nexus-Point Xenas)
        [13] = 250144, --  (Windrunner Spire)
        [14] = 250256, --  (Windrunner Spire)
        [16] = 251111, --  (Magister's Terrace)
        [17] = 251094, --  (Windrunner Spire)
    },
    WARLOCK_DEMONOLOGY = {
        [1] = 250042, --  (Matrix Catalyst)
        [2] = 50228, --  (Pit of Saron)
        [3] = 251085, --  (Windrunner Spire)
        [15] = 239656, --  (Crafted by Tailoring)
        [5] = 250045, --  (Matrix Catalyst)
        [9] = 240167, --  (Crafted by Tailoring)
        [10] = 250043, --  (Matrix Catalyst)
        [6] = 151302, --  (Seat of the Triumvirate)
        [7] = 250041, --  (Matrix Catalyst)
        [8] = 251167, --  (Maisara Caverns)
        [11] = 251093, --  (Nexus-Point Xenas)
        [12] = 251217, --  (Nexus-Point Xenas)
        [13] = 250144, --  (Windrunner Spire)
        [14] = 250258, --  (Maisara Caverns)
        [16] = 258047, --  (Skyreach)
    },
    WARLOCK_DESTRUCTION = {
        [1] = 250042, --  (Matrix Catalyst)
        [2] = 50228, --  (Pit of Saron)
        [3] = 251085, --  (Windrunner Spire)
        [15] = 239656, --  (Crafted by Tailoring)
        [5] = 250045, --  (Matrix Catalyst)
        [9] = 240167, --  (Crafted by Tailoring)
        [10] = 250043, --  (Matrix Catalyst)
        [6] = 151302, --  (Seat of the Triumvirate)
        [7] = 250041, --  (Matrix Catalyst)
        [8] = 251167, --  (Maisara Caverns)
        [11] = 251093, --  (Nexus-Point Xenas)
        [12] = 251217, --  (Nexus-Point Xenas)
        [13] = 250256, --  (Windrunner Spire)
        [14] = 250258, --  (Maisara Caverns)
        [16] = 258047, --  (Skyreach)
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
        [16] = 258525, -- Scepter of the Endless Night (Seat of the Triumvirate)
        [17] = 251105, -- Ward of the Spellbreaker (Magister's Terrace)
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
        [9] = 251490, -- Spellbreaker's Bracers with  Stabilizing Gemstone Bandolier (Crafted by Blacksmithing)
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
        [1] = 249970, -- Relentless Rider's Crown (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 249337, -- Ribbon of Coiled Malice (Fallen-King Salhadaar in The Voidspire)
        [3] = 249313, -- Light-Judged Spaulders (Imperator Averzian in The Voidspire)
        [15] = 249335, -- Adherent's Silken Shroud with  Arcanoweave Lining ( Imperator's Banner when running a Dual-Wield setup) (Crafted by Leatherworking)
        [5] = 249973, -- Relentless Rider's Cuirass (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 240167, -- Spellbreaker's Bracers with  Arcanoweave Lining (Crafted by Blacksmithing)
        [10] = 249971, -- Relentless Rider's Bonegrasps (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 249380, -- Hate-Tied Waistchain (Crown of the Cosmos in The Voidspire)
        [7] = 249969, -- Relentless Rider's Legguards (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249381, -- Greaves of the Unformed (Chimaerus in The Dreamrift)
        [11] = 249336, -- Signet of the Starved Beast (Vorasius in The Voidspire)
        [12] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 249344, -- Light Company Guidon (Imperator Averzian in The Voidspire)
    },
    DEATHKNIGHT_UNHOLY = {
        [16] = 249277, -- Bellamy's Final Judgement (Lightblinded Vanguard in The Voidspire)
        [1] = 249970, -- Relentless Rider's Crown (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 249337, -- Ribbon of Coiled Malice (Fallen-King Salhadaar in The Voidspire)
        [3] = 249313, -- Light-Judged Spaulders (Imperator Averzian in The Voidspire)
        [15] = 239656, -- Adherent's Silken Shroud with  Arcanoweave Lining (Crafted by Leatherworking)
        [5] = 249973, -- Relentless Rider's Cuirass (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 240167, -- Spellbreaker's Bracers with  Arcanoweave Lining (Crafted by Blacksmithing)
        [10] = 249971, -- Relentless Rider's Bonegrasps (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 249380, -- Hate-Tied Waistchain (Crown of the Cosmos in The Voidspire)
        [7] = 249969, -- Relentless Rider's Legguards (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249381, -- Greaves of the Unformed (Chimaerus in The Dreamrift)
        [11] = 249336, -- Signet of the Starved Beast (Vorasius in The Voidspire)
        [12] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 249344, -- Light Company Guidon (Imperator Averzian in The Voidspire)
    },
    -- DEMONHUNTER_DEVOURER removed: not a valid WoW spec
    DEMONHUNTER_HAVOC = {
        [16] = 251175, --  (Maisara Caverns)
        [1] = 251109, --  (Magister's Terrace)
        [2] = 50228, --  (Pit of Saron)
        [3] = 250031, --  (Matrix Catalyst)
        [15] = 239656, --  (Tailoring)
        [5] = 250036, --  (Matrix Catalyst)
        [9] = 244576, --  (Leatherworking)
        [10] = 250034, --  (Matrix Catalyst)
        [6] = 251082, --  (Windrunner Spire)
        [7] = 250032, --  (Matrix Catalyst)
        [8] = 258577, --  (Skyreach)
        [11] = 193708, --  (Algeth'ar Academy)
        [12] = 251217, --  (Nexus-Point Xenas)
        [13] = 193701, --  (Windrunner Spire)
        [14] = 252420, --  (Skyreach)
    },
    DEMONHUNTER_VENGEANCE = {
        [16] = 193717, --  (Algeth'ar Academy)
        [1] = 250033, --  (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 151309, --  (Seat of the Triumvirate)
        [3] = 250031, --  (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 260312, --  (Magister's Terrace)
        [5] = 251216, --  (Nexus-Point Xenas)
        [9] = 240167, --  (Crafted by Leatherworking)
        [10] = 250034, --  (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 251166, --  (Maisara Caverns)
        [7] = 250032, --  (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 251210, --  (Nexus-Point Xenas)
        [11] = 251217, --  (Nexus-Point Xenas)
        [12] = 49812, --  (Pit of Saron)
        [13] = 250256, --  (Windrunner Spire)
        [14] = 252420, --  (Skyreach)
    },
    DRUID_BALANCE = {
        [16] = 251201, --  (Nexus-Point Xenas)
        [1] = 250024, --  (Lightblinded Vanguard in The Voidspire)
        [2] = 50228, --  (Pit of Saron)
        [3] = 250022, --  (Fallen-King Salhadaar in The Voidspire)
        [15] = 260312, --  (Magister's Terrace)
        [5] = 250027, --  (Chimaerus in The Dreamrift)
        [9] = 50264, --  (Pit of Saron)
        [10] = 244576, --  (Leatherworking)
        [6] = 251082, --  (Windrunner Spire)
        [7] = 250023, --  (Vaelgor and Ezzorak in The Voidspire)
        [8] = 240167, --  (Leatherworking)
        [11] = 251115, --  (Magister's Terrace)
        [12] = 251093, --  (Nexus-Point Xenas)
        [13] = 250144, --  (Windrunner Spire)
        [14] = 250223, --  (Maisara Caverns)
    },
    DRUID_FERAL = {
        [16] = 251077, --  (Windrunner Spire)
        [1] = 250024, --  (Matrix Catalyst)
        [2] = 50228, --  (Pit of Saron)
        [3] = 251092, --  (Windrunner Spire)
        [15] = 239656, --  (Tailoring)
        [5] = 250027, --  (Matrix Catalyst)
        [9] = 244576, --  (Leatherworking)
        [10] = 250025, --  (Vorasius)
        [6] = 49806, --  (Pit of Saron)
        [7] = 250023, --  (Matrix Catalyst)
        [8] = 258577, --  (Skyreach)
        [11] = 251093, --  (Nexus-Point Xenas)
        [12] = 251217, --  (Nexus-Point Xenas)
        [13] = 193701, --  (Windrunner Spire)
        [14] = 250256, --  (Windrunner Spire)
    },
    DRUID_GUARDIAN = {
        [16] = 249278, --  (Chimaerus in The Dreamrift)
        [1] = 249913, --  (Midnight Falls)
        [2] = 249368, --  (Crown of the Cosmos in The Voidspire)
        [3] = 250022, --  (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 249370, --  (Vaelgor and Ezzorak in The Voidspire)
        [5] = 250027, --  (Chimaerus in The Dreamrift)
        [9] = 240167, --  (Crafted by Leatherworking)
        [10] = 250025, --  (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 244611, --  (Crafted by Leatherworking)
        [7] = 250023, --  (Vaelgor and Ezzorak in The Voidspire)
        [8] = 249334, --  (Imperator Averzian in The Voidspire)
        [11] = 249920, --  (Midnight Falls)
        [12] = 249336, --  (Vorasius in The Voidspire)
        [13] = 249343, --  (Chimaerus in The Dreamrift)
        [14] = 249807, --  (Belo'ren)
    },
    DRUID_RESTORATION = {
        [1] = 250024, --  (Lightblinded Vanguard - The Voidspire)
        [2] = 251096, --  (Windrunner Spire)
        [3] = 250022, --  (Fallen-King Salhadaar - The Voidspire)
        [15] = 193712, --  (Algeth'ar Academy)
        [5] = 251216, --  (Nexus-Point Xenas)
        [9] = 193714, --  (Algeth'ar Academy)
        [10] = 250025, --  (Vorasius - The Voidspire)
        [6] = 251166, --  (Maisara Caverns)
        [7] = 250023, --  (Vaelgor and Ezzorak - The Voidspire)
        [8] = 251121, --  (Magister's Terrace)
        [11] = 251093, --  (Nexus-Point Xenas)
        [13] = 193718, --  (Algeth'ar Academy)
        [16] = 193707, --  (Algeth'ar Academy)
    },
    EVOKER_AUGMENTATION = {
        [16] = 249276, --  (Belo'ren in March on Quel'Danas
            Lightblinded Vanguard in The Voidspire
            Vorasius in The Voidspire)
        [1] = 249317, --  (Midnight Falls in March on Quel'Danas
            
            
              Vorasius in The Voidspire)
        [2] = 249337, --  (Fallen-King Salhadaar in The Voidspire)
        [3] = 249995, --  (Matrix Catalyst, Fallen-King Salhadaar in
          The Voidspire.)
        [15] = 239656, --  (Crafted by Tailoring)
        [5] = 250000, --  (Matrix Catalyst, or Chimaerus in
          The Dreamrift)
        [9] = 244584, --  (Crafted by Leatherworking)
        [10] = 249998, --  (Matrix Catalyst, or Vorasius in
          The Voidspire)
        [6] = 249303, --  (Crafted by Leatherworking
            
            
              Chimaerus in The Dreamrift
            
            
              Lightblinded Vanguard in The Voidspire)
        [7] = 249996, --  (Matrix Catalyst, or Vaelgor and Ezzorak in
          The Voidspire)
        [8] = 249377, --  (Belo'ren in March on Quel'Danas)
        [11] = 249919, --  (Midnight Falls in March on Quel'Danas
            Crafted by Jewelcrafting
            Lightblinded Vanguard in The Voidspire
            Belo'ren in March on Quel'Danas)
        [13] = 249346, --  (Midnight Falls in March on Quel'Danas
            Vaelgor and Ezzorak in The Voidspire)
    },
    EVOKER_DEVASTATION = {
        [16] = 249294, --  (Lightblinded Vanguard in The Voidspire.)
        [17] = 249276, --  (Vorasius in The Voidspire.)
        [1] = 249997, --  (Matrix Catalyst, Lightblinded Vanguard in The Voidspire.)
        [2] = 250247, --  (Midnight Falls in March on Quel'Danas.)
        [3] = 249995, --  (Matrix Catalyst, Fallen-King Salhadaar in
          The Voidspire.)
        [15] = 239656, --  (Crafted by Tailoring)
        [5] = 250000, --  (Matrix Catalyst, or Chimaerus in
          The Dreamrift)
        [9] = 244584, --  (Crafted by Leatherworking)
        [10] = 249325, --  (Crown of the Cosmos in The Voidspire)
        [6] = 249371, --  (Chimaerus in The Dreamrift)
        [7] = 249996, --  (Matrix Catalyst, or Vaelgor and Ezzorak in
          The Voidspire)
        [8] = 249999, --  (Matrix Catalyst.)
        [11] = 249919, --  (Belo'ren in March on Quel'Danas.)
        [13] = 249809, --  (Crown of the Cosmos in The Voidspire.)
    },
    EVOKER_PRESERVATION = {
        [16] = 249286, --  (Midnight Falls in The Voidspire)
        [1] = 249914, --  (Midnight Falls in March on Quel'Danas)
        [2] = 250247, --  (Midnight Falls in March on Quel'Danas)
        [3] = 249995, --  (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 249370, --  (Vaelgor and Ezzorak in The Voidspire)
        [5] = 250000, --  (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 249304, --  (Fallen-King Salhadaar in The Voidspire)
        [10] = 249998, --  (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 244611, --  (Crafted by Leatherworking)
        [7] = 249996, --  (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 244610, --  (Crafted by Leatherworking)
        [11] = 249369, --  (Lightblinded Vanguard in The Voidspire)
        [12] = 249920, --  (Midnight Falls in March on Quel'Danas)
        [13] = 249346, --  (Vaelgor and Ezzorak in The Voidspire)
        [14] = 249343, --  (Chimaerus in The Dreamrift)
    },
    HUNTER_BEASTMASTERY = {
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
        [16] = 251174, -- Deceiver's Rotbow (Maisara Caverns)
    },
    HUNTER_MARKSMANSHIP = {
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
        [16] = 251095, -- Hurricane's Heart (Windrunner Spire)
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
        [16] = 251077, -- Roostwarden's Bough (Windrunner Spire)
        [17] = 237837, -- Farstrider's Mercy (Blacksmithing)
    },
    MAGE_ARCANE = {
        [16] = 249286, --  (Midnight Falls in March on Quel'Danas)
        [1] = 250060, --  (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, --  (Midnight Falls in March on Quel'Danas)
        [3] = 250058, --  (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 239661, --  (Crafted by Tailoring)
        [5] = 250063, --  (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 239660, --  (Crafted by Tailoring)
        [10] = 250061, --  (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 249376, --  (Belo'ren in March on Quel'Danas)
        [7] = 249323, --  (Imperator Averzian in The Voidspire)
        [8] = 249373, --  (Chimaerus in The Dreamrift)
        [11] = 249919, --  (Belo'ren in March on Quel'Danas)
        [13] = 249343, --  (Chimaerus in The Dreamrift)
    },
    MAGE_FIRE = {
        [16] = 249286, --  (Midnight Falls in March on Quel'Danas)
        [1] = 250060, --  (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, --  (Midnight Falls in March on Quel'Danas)
        [3] = 250058, --  (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 239656, --  (Crafted by Tailoring with  Arcanoweave Lining and Haste + Mastery)
        [5] = 249912, --  (Midnight Falls in March on Quel'Danas)
        [9] = 239648, --  (Crafted by Tailoring with  Arcanoweave Lining and Haste + Mastery)
        [10] = 250061, --  (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 249376, --  (Belo'ren in March on Quel'Danas)
        [7] = 250059, --  (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 258584, --  (Matrix Catalyst on any pair of boots, or The Great Vault)
        [11] = 249369, --  (Lightblinded Vanguard in The Voidspire)
        [13] = 249809, --  (Crown of the Cosmos in The Voidspire)
    },
    MAGE_FROST = {
        [16] = 245876, --  (Inscription)
        [1] = 250060, --  (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, --  (Midnight Falls in March on Quel'Danas)
        [3] = 249328, --  (Belo'ren in March on Quel'Danas)
        [15] = 249370, --  (Vaelgor and Ezzorak in The Voidspire)
        [5] = 250063, --  (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 240167, --  (Tailoring)
        [10] = 250061, --  (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 250057, --  (Matrix Catalyst)
        [7] = 250059, --  (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249373, --  (Chimaerus in The Dreamrift)
        [11] = 249919, --  (Belo'ren in March on Quel'Danas)
        [12] = 249920, --  (Midnight Falls in March on Quel'Danas)
        [13] = 249346, --  (Vaelgor and Ezzorak in The Voidspire)
        [14] = 249343, --  (Chimaerus in The Dreamrift)
    },
    MONK_BREWMASTER = {
        [1] = 250015, --  (Lightblinded Vanguard (March on Quel'Danas))
        [2] = 245792, --  (Jewelcrafting (see note))
        [3] = 250013, --  (Fallen-King Salhadaar (The Voidspire))
        [15] = 249335, --  (Imperator Averzian (The Voidspire))
        [5] = 250018, --  (Chimaerus (The Dreamrift))
        [9] = 249327, --  (Vorasius (The Voidspire))
        [10] = 250016, --  (>Vorasius (The Voidspire))
        [6] = 249314, --  (Fallen-King Salhadaar (The Voidspire))
        [7] = 249312, --  (Crown of the Cosmos (The Voidspire))
        [8] = 249382, --  (Crown of the Cosmos (The Voidspire))
        [11] = 249336, --  (Vorasius (The Voidspire))
        [16] = 249302, --  (Vorasius (The Voidspire))
        [13] = 249807, --  (Belo'ren (March on Quel'Danas)
 Chimaerus (The Dreamrift)
 Vaelgor and Ezzorak (The Voidspire)
 Belo'ren (March on Quel'Danas))
    },
    MONK_MISTWEAVER = {
        [16] = 249293, --  (Imperator Averzian in The Voidspire)
        [17] = 249276, --  (Vorasius in The Voidspire)
        [1] = 249913, --  (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 249337, --  (Fallen-King Salhadaar in The Voidspire)
        [3] = 250013, --  (Fallen-King Salhadaar in The Voidspire)
        [15] = 239656, --  (Crafted by Tailoring)
        [5] = 250018, --  (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 240167, --  (Crafted by Leatherworking)
        [10] = 250016, --  (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 249374, --  (Chimaerus in The Dreamrift)
        [7] = 250014, --  (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249334, --  (Imperator Averzian in The Voidspire)
        [11] = 249920, --  (Midnight Falls in March on Quel'Danas)
        [12] = 249336, --  (Vorasius in The Voidspire)
        [13] = 249343, --  (Chimaerus in The Dreamrift)
        [14] = 249341, --  (Fallen-King Salhadaar in The Voidspire)
    },
    MONK_WINDWALKER = {
        [16] = 249302, --  (Vorasius)
        [1] = 250015, --  (Matrix Catalyst, or Lightblinded Vanguard - The Voidspire)
        [2] = 250247, --  (Midnight Falls)
        [3] = 250013, --  (Matrix Catalyst, or Fallen-King Salhadaar - The Voidspire)
        [15] = 250010, --  (Matrix Catalyst)
        [5] = 250018, --  (Matrix Catalyst, or Chimaerus - The Dreamrift)
        [9] = 249327, --  (Vorasius)
        [10] = 249321, --  (Vaelgor and Ezzorak)
        [6] = 249374, --  (Chimaerus)
        [7] = 250014, --  (Matrix Catalyst, or Vaelgor and Ezzorak - The Voidspire)
        [8] = 250017, --  (Matrix Catalyst)
        [11] = 251513, --  (Jewelcrafting)
        [13] = 249343, --  (Chimaerus)
    },
    PALADIN_HOLY = {
        [16] = 249294, -- Blade of the Blind Verdict (Lightblinded Vanguard in The Voidspire)
        [17] = 249921, -- Thalassian Dawnguard (Belo'ren in March on Quel'Danas)
        [1] = 249961, -- Luminant Verdict's Unwavering Gaze (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 249959, -- Luminant Verdict's Providence Watch (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 239656, -- Adherent's Silken Shroud with  Arcanoweave Lining and Haste/Mastery (Crafted by Tailoring)
        [5] = 249964, -- Luminant Verdict's Divine Warplate (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 240167, -- Spellbreaker's Bracers with  Arcanoweave Lining and Haste/Mastery (Crafted by Blacksmithing)
        [10] = 249962, -- Luminant Verdict's Gauntlets (Matrix Catalyst, or Vorasius in The Voidspire)
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
        [9] = 251490, -- Spellbreaker's Bracers with  Stabilizing Gemstone Bandolier (Crafted by Blacksmithing)
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
        [1] = 249961, -- Luminant Verdict's Unwavering Gaze (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 249959, -- Luminant Verdict's Providence Watch (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted by Tailoring)
        [5] = 249964, -- Luminant Verdict's Divine Warplate (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted by Blacksmithing)
        [10] = 249307, -- Emberborn Grasps (Belo'ren in March on Quel'Danas)
        [6] = 249380, -- Hate-Tied Waistchain (Crown of the Cosmos in The Voidspire)
        [7] = 249960, -- Luminant Verdict's Greaves (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249381, -- Greaves of the Unformed (Chimaerus in The Dreamrift)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 249806, -- Radiant Plume (Belo'ren in March on Quel'Danas)
    },
    PRIEST_DISCIPLINE = {
        [16] = 249283, -- Belo'melorn, the Shattered Talon (Belo'ren in March on Quel'Danas)
        [17] = 245876, -- Aln'hara Lantern with  Darkmoon Sigil: Hunt (Crafted by Inscription)
        [1] = 250051, -- Blind Oath's Winged Crest (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 250049, -- Blind Oath's Seraphguards (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak in The Voidspire)
        [5] = 249912, -- Robes of Endless Oblivion (Midnight Falls in March on Quel'Danas)
        [9] = 249315, -- Voracious Wristwraps (Vorasius in The Voidspire)
        [10] = 250052, -- Blind Oath's Touch (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 239664, -- Arcanoweave Cord (Crafted by Tailoring)
        [7] = 250050, -- Blind Oath's Leggings (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249305, -- Slippers of the Midnight Flame (Vaelgor and Ezzorak in The Voidspire)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 249369, -- Bond of Light (Lightblinded Vanguard in The Voidspire)
        [13] = 249346, -- Vaelgor's Final Stare (Vaelgor and Ezzorak in The Voidspire)
        [14] = 249341, -- Volatile Void Suffuser (Fallen-King Salhadaar in The Voidspire)
    },
    PRIEST_HOLY = {
        [1] = 250051, -- Blind Oath's Winged Crest (TIER SET) (Lightblinded Vanguard in The Voidspire / Matrix Catalyst)
        [2] = 250247, -- Ribbon of Coiled Malice
             Amulet of the Abyssal Hymn (Fallen-King Salhadaar in The Voidspire
            Midnight Falls in March on Quel'Danas)
        [3] = 250049, -- Blind Oath's Seraphguards (TIER SET) (Fallen-King Salhadaar in The Voidspire / Matrix Catalyst)
        [15] = 249335, -- Imperator's Banner (Imperator Averzian in The Voidspire)
        [5] = 250054, -- Blind Oath's Raiment (TIER SET) (Chimaerus in The Dreamrift / Matrix Catalyst)
        [9] = 250047, -- Blind Oath's Wraps (Matrix Catalyst any bracer)
        [10] = 250052, -- Blind Oath's Touch (TIER SET) (Vorasius in The Voidspire / Matrix Catalyst)
        [6] = 239664, -- Arcanoweave Cord (Tailoring)
        [7] = 249323, -- Leggings of the Devouring Advance (Imperator Averzian in The Voidspire)
        [8] = 249373, -- Dream-Scorched Striders (Chimaerus in The Dreamrift)
        [11] = 249336, -- Signet of the Starved Beast (Vorasius in The Voidspire)
        [13] = 249808, -- Litany of Lightblind Wrath (Lightblinded Vanguard in The Voidspire)
        [16] = 249293, -- Aln'hara Cane (Best Craft)
             Weight of Command (Tailoring
            Imperator Averzian in The Voidspire)
        [17] = 249276, -- Grimoire of the Eternal Light (Vorasius in The Voidspire)
    },
    PRIEST_SHADOW = {
        [16] = 249286, -- Belo'melorn, the Shattered Talon (1H)
 Tome of Alnscorned Regret (OH)
 Brazier of the Dissonant Dirge (2H) (Belo'ren in March on Quel'Danas
Chimaerus in The Dreamrift
Midnight Falls in March on Quel'Danas)
        [1] = 250051, -- Blind Oath's Winged Crest (TIER SET) (Lightblinded Vanguard in The Voidspire)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 250049, -- Blind Oath's Seraphguards (TIER SET) (Fallen-King Salhadaar in The Voidspire)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak in Voidspire)
        [5] = 250054, -- Blind Oath's Raiment (TIER SET) (Chimaerus in The Dreamrift)
        [9] = 249315, -- Voracious Wristwraps (Vorasius in Voidspire)
        [10] = 249330, -- War Chaplain's Grips (Lightblinded Vanguard in Voidspire)
        [6] = 249376, -- Whisper-Inscribed Sash (Belo'ren in March on Quel'Danas)
        [7] = 250050, -- Blind Oath's Leggings (TIER SET) (Vaelgor and Ezzorak in Voidspire)
        [8] = 249373, -- Dream-Scorched Striders (Chimaerus in The Dreamrift)
        [11] = 249369, -- Eye of Midnight
         Bond of Light (Midnight Falls in March on Quel'Danas
        Lightblinded Vanguard in Voidspire)
        [13] = 249810, -- Gaze of the Alnseer
 Vaelgor's Final Stare
 Shadow of the Empyrean Requiem (Chimaerus in The Dreamrift
Vaelgor and Ezzorak in The Voidspire
Midnight Falls in March on Quel'Danas)
    },
    ROGUE_ASSASSINATION = {
        [16] = 249925, -- Your highest ilvl dagger.
Best choice:  Hungering Victory (Vorasius in The Voidspire)
        [17] = 245876, -- Farstrider's Mercy (Crit/Haste) with  Darkmoon Sigil: Hunt (Crafted by Blacksmithing)
        [1] = 250006, -- Masquerade of the Grim Jest (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 249337, -- Ribbon of Coiled Malice (Fallen-King Salhadaar in The Voidspire)
        [3] = 250004, -- Venom Casks of the Grim Jest (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak in The Voidspire)
        [5] = 250009, -- Fantastic Finery of the Grim Jest (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 240167, -- Silvermoon Agent's Deflectors (Crit/Haste) with  Arcanoweave Lining (Crafted by Leatherworking)
        [10] = 250007, -- Sleight of Hand of the Grim Jest (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 249374, -- Scorn-Scarred Shul'ka's Belt (Chimaerus in The Dreamrift)
        [7] = 249312, -- Nightblade's Pantaloons (Crown of the Cosmos in The Voidspire)
        [8] = 249382, -- Canopy Walker's Footwraps (Crown of the Cosmos in The Voidspire)
        [11] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [12] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [13] = 249806, -- Radiant Plume (Belo'ren in March on Quel'Danas)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
    },
    ROGUE_OUTLAW = {
        [16] = 260423, -- Your highest ilvl slow main-hand.
Best choice:  Arator's Swift Remembrance (Crown of the Cosmos in The Voidspire)
        [17] = 249284, -- Belo'ren's Swift Talon (Belo'ren in March on Quel'Danas)
        [1] = 249913, -- Mask of Darkest Intent (Midnight Falls in March on Quel'Danas)
        [2] = 249337, -- Ribbon of Coiled Malice (Fallen-King Salhadaar in The Voidspire)
        [3] = 250004, -- Venom Casks of the Grim Jest (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 249335, -- Imperator's Banner (Imperator Averzian in The Voidspire)
        [5] = 250009, -- Fantastic Finery of the Grim Jest (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 249327, -- Void-Skinned Bracers (Vorasius in The Voidspire)
        [10] = 250007, -- Sleight of Hand of the Grim Jest (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 249374, -- Scorn-Scarred Shul'ka's Belt (Chimaerus in The Dreamrift)
        [7] = 250005, -- Blade Holsters of the Grim Jest (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 240167, -- Silvermoon Agent's Sneakers (Crit/Haste) with  Arcanoweave Lining (Crafted by Leatherworking)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 251487, -- Masterwork Sin'dorei Band (Crit/Haste) with  Prismatic Focusing Iris (Crafted by Jewelcrafting)
        [13] = 260235, -- Umbral Plume (Belo'ren in March on Quel'Danas)
        [14] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
    },
    ROGUE_SUBTLETY = {
        [16] = 249925, -- Your highest ilevel dagger.
Best choice:  Hungering Victory (Vorasius in The Voidspire)
        [17] = 249925, -- Hungering Victory (Vorasius in The Voidspire)
        [1] = 250006, -- Masquerade of the Grim Jest (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 250004, -- Venom Casks of the Grim Jest (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak in The Voidspire)
        [5] = 250009, -- Fantastic Finery of the Grim Jest (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 249327, -- Void-Skinned Bracers (Vorasius  in The Voidspire)
        [10] = 250007, -- Sleight of Hand of the Grim Jest (Matrix Catalyst, or Vorasius in The Voidspire)
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
        [1] = 249979, -- Locus of the Primal Core (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 250247, -- Amulet of the Abyssal Hymn (Midnight Falls in March on Quel'Danas)
        [3] = 249977, -- Tempests of the Primal Core (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 249370, -- Draconic Nullcape (Vaelgor and Ezzorak in The Voidspire)
        [5] = 249982, -- Embrace of the Primal Core (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 249304, -- Fallen King's Cuffs (Fallen-King Salhadaar in The Voidspire)
        [10] = 249980, -- Earthgrips of the Primal Core (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 244611, -- World Tender's Barkclasp (Crafted by Leatherworking)
        [7] = 249324, -- Eternal Flame Scaleguards (Belo'ren March on Quel'Danas)
        [8] = 244610, -- World Tender's Rootslippers (Crafted by Leatherworking)
        [11] = 249369, -- Bond of Light (Lightblinded Vanguard in The Voidspire)
        [12] = 249919, -- Sin'dorei Band of Hope (Belo'ren in March on Quel'Danas)
        [13] = 249346, -- Vaelgor's Final Stare (Vaelgor and Ezzorak in The Voidspire)
        [14] = 249809, -- Locus-Walker's Ribbon (Crown of the Cosmos in The Voidspire)
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
        [16] = 249293, --  (Imperator Averzian in The Voidspire)
        [17] = 249921, --  (Belo'ren in March on Quel'Danas)
        [1] = 249914, --  (Midnight Falls in March on Quel'Danas)
        [2] = 249337, --  (Fallen-King Salhadaar in The Voidspire)
        [3] = 249977, --  (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 249974, --  (Matrix Catalyst)
        [5] = 249982, --  (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 249975, --  (Matrix Catalyst)
        [10] = 249980, --  (Matrix Catalyst, or Vorasius in The Voidspire)
        [6] = 244611, --  (Crafted by Leatherworking)
        [7] = 249978, --  (Matrix Catalyst, or Vaelgor and Ezzorak in The Dreamrift)
        [8] = 244610, --  (Crafted by Leatherworking)
        [11] = 249919, --  (Belo'ren in March on Quel'Danas)
        [12] = 249336, --  (Vorasius in The Voidspire)
        [13] = 249343, --  (Chimaerus in The Dreamrift)
        [14] = 249808, --  (Lightblinded Vanguard in The Voidspire)
    },
    WARLOCK_AFFLICTION = {
        [1] = 250042, --  (Lightblinded Vanguard in The Voidspire or Matrix Catalyst)
        [2] = 249368, --  (Crown of the Cosmos in The Voidspire)
        [3] = 249328, --  (Belo'ren in March on Quel'Danas)
        [15] = 239656, --  (Crafted by Tailoring)
        [5] = 250045, --  (Chimaerus in The Dreamrift or Matrix Catalyst)
        [9] = 240167, --  (Crafted by Tailoring)
        [10] = 250043, --  (Vorasius in The Voidspire or Matrix Catalyst)
        [6] = 249319, --  (Imperator Averzian in The Voidspire)
        [7] = 250041, --  (Vaelgor and Ezzorak in The Voidspire or Matrix Catalyst)
        [8] = 249305, --  (Vaelgor and Ezzorak in The Voidspire)
        [11] = 249920, --  (Midnight Falls in March on Quel'Danas)
        [12] = 249919, --  (Belo'ren in March on Quel'Danas)
        [13] = 249810, --  (Midnight Falls in March on Quel'Danas)
        [14] = 249343, --  (Chimaerus in The Dreamrift)
        [16] = 249283, --  (Belo'ren in March on Quel'Danas)
        [17] = 249276, --  (Vorasius in The Voidspire)
    },
    WARLOCK_DEMONOLOGY = {
        [1] = 250042, --  (Lightblinded Vanguard in The Voidspire or Matrix Catalyst)
        [2] = 249368, --  (Crown of the Cosmos in The Voidspire)
        [3] = 250040, --  (Fallen-King Salhadaar in The Voidspire or Matrix Catalyst)
        [15] = 239656, --  (Crafted by Tailoring)
        [5] = 250045, --  (Chimaerus in The Dreamrift or Matrix Catalyst)
        [9] = 240167, --  (Crafted by Tailoring)
        [10] = 250043, --  (Vorasius in The Voidspire or Matrix Catalyst)
        [6] = 249319, --  (Imperator Averzian in The Voidspire)
        [7] = 250041, --  (Vaelgor and Ezzorak in The Voidspire or Matrix Catalyst)
        [8] = 249373, --  (Chimaerus in The Dreamrift)
        [11] = 249920, --  (Midnight Falls in March on Quel'Danas)
        [12] = 249336, --  (Vorasius in The Voidspire)
        [13] = 249346, --  (Vaelgor and Ezzorak in The Voidspire)
        [14] = 249809, --  (Crown of the Cosmos in The Voidspire)
        [16] = 249286, --  (Midnight Falls in March on Quel'Danas)
    },
    WARLOCK_DESTRUCTION = {
        [1] = 250042, --  (Lightblinded Vanguard in The Voidspire or Matrix Catalyst)
        [2] = 249368, --  (Crown of the Cosmos in The Voidspire)
        [3] = 250040, --  (Fallen-King Salhadaar in The Voidspire or Matrix Catalyst)
        [15] = 239656, --  (Crafted by Tailoring)
        [5] = 250045, --  (Chimaerus in The Dreamrift or Matrix Catalyst)
        [9] = 240167, --  (Crafted by Tailoring)
        [10] = 250043, --  (Vorasius in The Voidspire or Matrix Catalyst)
        [6] = 249319, --  (Imperator Averzian in The Voidspire)
        [7] = 250041, --  (Vaelgor and Ezzorak in The Voidspire or Matrix Catalyst)
        [8] = 249305, --  (Vaelgor and Ezzorak in The Voidspire)
        [11] = 249920, --  (Midnight Falls in March on Quel'Danas)
        [12] = 249336, --  (Vorasius in The Voidspire)
        [13] = 249346, --  (Vaelgor and Ezzorak in The Voidspire)
        [14] = 249810, --  (Midnight Falls in March on Quel'Danas)
        [16] = 249286, --  (Midnight Falls in March on Quel'Danas)
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
        [1] = 249952, -- Night Ender's Tusks (Matrix Catalyst, or Lightblinded Vanguard in The Voidspire)
        [2] = 249368, -- Eternal Voidsong Chain (Crown of the Cosmos in The Voidspire)
        [3] = 249950, -- Night Ender's Pauldrons (Matrix Catalyst, or Fallen-King Salhadaar in The Voidspire)
        [15] = 239656, -- Adherent's Silken Shroud (Crafted — Tailoring)
        [5] = 249955, -- Night Ender's Breastplate (Matrix Catalyst, or Chimaerus in The Dreamrift)
        [9] = 237834, -- Spellbreaker's Bracers (Crafted — Blacksmithing)
        [10] = 249307, -- Emberborn Grasps (Belo'ren in March on Quel'Danas)
        [6] = 249331, -- Night Ender's Girdle /  Ezzorak's Gloombind (Matrix Catalyst / Vaelgor and Ezzorak in The Voidspire)
        [7] = 249951, -- Night Ender's Chausses (Matrix Catalyst, or Vaelgor and Ezzorak in The Voidspire)
        [8] = 249954, -- Night Ender's Greatboots (Matrix Catalyst)
        [11] = 249920, -- Eye of Midnight (Midnight Falls in March on Quel'Danas)
        [12] = 249369, -- Bond of Light (Lightblinded Vanguard in The Voidspire)
        [13] = 249343, -- Gaze of the Alnseer (Chimaerus in The Dreamrift)
        [14] = 260235, -- Radiant Plume /  Umbral Plume (Belo'ren in March on Quel'Danas)
        [16] = 249295, -- Turalyon's False Echo (Crown of the Cosmos in The Voidspire)
        [17] = 249275, -- Bulwark of Noble Resolve (Imperator Averzian in The Voidspire)
    },
}

-- ============================================================================
-- DUNGEON LOOT TABLES
-- Extracted from BIS lists: items whose source is a M+ dungeon
-- ============================================================================
NS.DUNGEON_LOOT = {
    MAGISTER = {
        { itemId = 260312, slot = 15, itemName = "Defiant Defender's Drape" },
        { itemId = 251100, slot = 16, itemName = "Malfeasance Mallet" },
        { itemId = 251107, slot = 8, itemName = "Oathsworn Stompers" },
        { itemId = 193709, slot = 16, itemName = nil },
        { itemId = 193718, slot = 13, itemName = nil },
        { itemId = 251119, slot = 1, itemName = nil },
        { itemId = 251115, slot = 11, itemName = nil },
        { itemId = 251102, slot = 6, itemName = nil },
        { itemId = 251122, slot = 16, itemName = nil },
        { itemId = 251118, slot = 7, itemName = "Legplates of Lingering Dusk" },
        { itemId = 258047, slot = 16, itemName = "Splitshroud Stinger" },
        { itemId = 251115, slot = 12, itemName = "Bifurcation Band" },
        { itemId = 251105, slot = 17, itemName = "Ward of the Spellbreaker" },
        { itemId = 251111, slot = 16, itemName = nil },
        { itemId = 251117, slot = 16, itemName = "Whirling Voidcleaver" },
        { itemId = 251109, slot = 1, itemName = "Shadowveil Helm" },
        { itemId = 251112, slot = 6, itemName = "Shadowsplit Girdle" },
        { itemId = 251121, slot = 5, itemName = "Vestments of Lingering Dusk" },
    },
    SEAT = {
        { itemId = 151332, slot = 10, itemName = "Voidclaw Gauntlets" },
        { itemId = 50228, slot = 2, itemName = "Barbed Ymirheim Choker" },
        { itemId = 151336, slot = 1, itemName = nil },
        { itemId = 151321, slot = 9, itemName = nil },
        { itemId = 258514, slot = 16, itemName = nil },
        { itemId = 151308, slot = 11, itemName = nil },
        { itemId = 151309, slot = 2, itemName = nil },
        { itemId = 151314, slot = 7, itemName = nil },
        { itemId = 151317, slot = 8, itemName = nil },
        { itemId = 151312, slot = 13, itemName = nil },
        { itemId = 151311, slot = 12, itemName = nil },
        { itemId = 151318, slot = 10, itemName = nil },
        { itemId = 151327, slot = 6, itemName = "Girdle of the Shadowguard" },
        { itemId = 251094, slot = 16, itemName = "Aln'hara Cane" },
        { itemId = 151305, slot = 9, itemName = "Entropic Wristwraps" },
        { itemId = 151302, slot = 6, itemName = "Cord of Unraveling Reality" },
        { itemId = 151329, slot = 5, itemName = "Breastplate of the Dark Touch" },
        { itemId = 258525, slot = 16, itemName = "Scepter of the Endless Night" },
        { itemId = 151323, slot = 3, itemName = "Pauldrons of the Void Hunter" },
        { itemId = 250247, slot = 2, itemName = "Amulet of the Abyssal Hymn" },
    },
    SKYREACH = {
        { itemId = 252420, slot = 14, itemName = "Solarflare Prism" },
        { itemId = 193709, slot = 16, itemName = nil },
        { itemId = 258218, slot = 16, itemName = nil },
        { itemId = 258047, slot = 16, itemName = nil },
        { itemId = 258584, slot = 8, itemName = nil },
        { itemId = 258575, slot = 15, itemName = nil },
        { itemId = 151312, slot = 13, itemName = nil },
        { itemId = 258050, slot = 16, itemName = nil },
        { itemId = 258049, slot = 17, itemName = "Viryx's Indomitable Bulwark" },
        { itemId = 252420, slot = 13, itemName = "Solarflare Prism" },
        { itemId = 258580, slot = 9, itemName = "Bracers of Blazing Light" },
        { itemId = 258436, slot = 16, itemName = "Edge of the Burning Sun" },
        { itemId = 258577, slot = 8, itemName = "Boots of Burning Focus" },
        { itemId = 258436, slot = 17, itemName = "Edge of the Burning Sun" },
        { itemId = 258585, slot = 1, itemName = nil },
        { itemId = 258438, slot = 16, itemName = "Blazing Sunclaws" },
    },
    ALGETHAR = {
        { itemId = 193708, slot = 11, itemName = "Platinum Star Band" },
        { itemId = 193701, slot = 13, itemName = "Algeth'ar Puzzle Box" },
        { itemId = 193701, slot = 14, itemName = nil },
        { itemId = 193709, slot = 16, itemName = nil },
        { itemId = 249999, slot = 8, itemName = nil },
        { itemId = 193718, slot = 13, itemName = nil },
        { itemId = 193710, slot = 16, itemName = nil },
        { itemId = 193723, slot = 16, itemName = nil },
        { itemId = 193709, slot = 17, itemName = nil },
        { itemId = 193714, slot = 9, itemName = nil },
        { itemId = 193718, slot = 14, itemName = "Emerald Coach's Whistle" },
        { itemId = 193707, slot = 15, itemName = "Ensemble Cape" },
        { itemId = 193711, slot = 16, itemName = "Spellbane Cutlass" },
        { itemId = 193712, slot = 5, itemName = "Algeth'ar Tunic" },
        { itemId = 193717, slot = 2, itemName = "Algeth'ar Choker" },
    },
    PIT_OF_SARON = {
        { itemId = 50234, slot = 3, itemName = "Shoulderplates of Frozen Blood" },
        { itemId = 49808, slot = 6, itemName = "Bent Gold Belt" },
        { itemId = 49824, slot = 1, itemName = nil },
        { itemId = 50228, slot = 2, itemName = nil },
        { itemId = 49810, slot = 6, itemName = nil },
        { itemId = 240949, slot = 11, itemName = nil },
        { itemId = 49825, slot = 5, itemName = nil },
        { itemId = 50263, slot = 6, itemName = nil },
        { itemId = 133489, slot = 8, itemName = nil },
        { itemId = 50264, slot = 9, itemName = nil },
        { itemId = 151312, slot = 13, itemName = nil },
        { itemId = 133493, slot = 9, itemName = "Wristguards of Subterranean Moss" },
        { itemId = 49823, slot = 15, itemName = "Cloak of the Fallen Cardinal" },
        { itemId = 251094, slot = 16, itemName = "Aln'hara Cane" },
        { itemId = 133491, slot = 17, itemName = "Krick's Beetle Stabber" },
        { itemId = 49806, slot = 6, itemName = "Flayer's Black Belt" },
        { itemId = 49817, slot = 7, itemName = "Shaggy Wyrmleather Leggings" },
        { itemId = 49802, slot = 16, itemName = "Garfrost's Two-Ton Hammer" },
        { itemId = 49812, slot = 11, itemName = "Purloined Wedding Ring" },
    },
    WINDRUNNER = {
        { itemId = 251096, slot = 2, itemName = nil },
        { itemId = 250144, slot = 13, itemName = nil },
        { itemId = 193718, slot = 13, itemName = nil },
        { itemId = 251079, slot = 9, itemName = nil },
        { itemId = 251084, slot = 8, itemName = nil },
        { itemId = 250256, slot = 13, itemName = nil },
        { itemId = 250144, slot = 14, itemName = nil },
        { itemId = 251094, slot = 17, itemName = nil },
        { itemId = 251090, slot = 7, itemName = nil },
        { itemId = 258472, slot = 17, itemName = nil },
        { itemId = 251085, slot = 3, itemName = nil },
        { itemId = 250256, slot = 14, itemName = nil },
        { itemId = 251082, slot = 6, itemName = nil },
        { itemId = 251094, slot = 16, itemName = "Aln'hara Cane" },
        { itemId = 251087, slot = 7, itemName = "Legwraps of Lingering Legacies" },
        { itemId = 251083, slot = 16, itemName = "Excavating Cudgel" },
        { itemId = 251098, slot = 1, itemName = "Fletcher's Faded Faceplate" },
        { itemId = 251086, slot = 6, itemName = "Riphook Defender" },
        { itemId = 251077, slot = 16, itemName = "Windrunner's Fang" },
        { itemId = 251081, slot = 10, itemName = "Embergrove Grasps" },
        { itemId = 251092, slot = 3, itemName = "Ranger-Captain's Shoulderguards" },
        { itemId = 251095, slot = 2, itemName = "Hurricane's Heart" },
    },
    MAISARA = {
        { itemId = 251168, slot = 16, itemName = "Liferipper's Cutlass" },
        { itemId = 249277, slot = 16, itemName = "Bellamy's Final Judgement" },
        { itemId = 251162, slot = 16, itemName = nil },
        { itemId = 251161, slot = 15, itemName = nil },
        { itemId = 193709, slot = 16, itemName = nil },
        { itemId = 193718, slot = 13, itemName = nil },
        { itemId = 250258, slot = 13, itemName = nil },
        { itemId = 251167, slot = 8, itemName = nil },
        { itemId = 251175, slot = 16, itemName = nil },
        { itemId = 251166, slot = 6, itemName = nil },
        { itemId = 251178, slot = 16, itemName = "Ceremonial Hexblade" },
        { itemId = 251172, slot = 10, itemName = "Vilehex Bonds" },
        { itemId = 250256, slot = 13, itemName = "Soulcatcher's Charm" },
        { itemId = 250258, slot = 14, itemName = nil },
        { itemId = 251164, slot = 3, itemName = "Amalgamation's Harness" },
        { itemId = 250223, slot = 13, itemName = "Soulcatcher's Idol" },
        { itemId = 251169, slot = 8, itemName = "Footwraps of Ill-Fate" },
        { itemId = 251174, slot = 16, itemName = "Deceiver's Rotbow" },
    },
    NEXUS_XENAS = {
        { itemId = 251203, slot = 9, itemName = "Kasreth's Bindings" },
        { itemId = 251217, slot = 12, itemName = "Occlusion of Void" },
        { itemId = 251210, slot = 8, itemName = nil },
        { itemId = 251217, slot = 11, itemName = nil },
        { itemId = 251093, slot = 12, itemName = nil },
        { itemId = 240949, slot = 11, itemName = nil },
        { itemId = 251093, slot = 11, itemName = nil },
        { itemId = 251206, slot = 15, itemName = nil },
        { itemId = 251201, slot = 16, itemName = nil },
        { itemId = 251175, slot = 16, itemName = nil },
        { itemId = 251213, slot = 3, itemName = "Nysarra's Mantle" },
        { itemId = 258047, slot = 16, itemName = "Splitshroud Stinger" },
        { itemId = 251115, slot = 11, itemName = "Omission of Light" },
        { itemId = 251207, slot = 16, itemName = "Dreadflail Bludgeon" },
        { itemId = 251215, slot = 7, itemName = "Greaves of the Divine Guile" },
        { itemId = 250253, slot = 14, itemName = nil },
        { itemId = 251216, slot = 5, itemName = "Void-Touched Chestguard" },
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
    [1467] = "EVOKER_DEVASTATION",
    [1468] = "EVOKER_PRESERVATION",
    [1473] = "EVOKER_AUGMENTATION",
}
