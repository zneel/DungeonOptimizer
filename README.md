# Dungeon Optimizer

*Stop wasting keys. Run the dungeon that actually matters.*

---

Dungeon Optimizer scans your gear (and your group's gear), compares it against **Best-in-Slot lists from Icy Veins** for all 40 specializations, then **ranks every dungeon** by how many BIS upgrades are available. The best dungeon to run is always on top. Works solo or in a group.

---

## Why Use This?

- **Smart ranking** — Dungeons are ranked by a combined score of gear upgrades and Raider.IO rating gains. The best dungeon to run is always #1.
- **Works solo** — Open the addon alone to see your personal BIS needs, upgrade roadmap, and which dungeons to target.
- **Group-wide optimization** — In a party, ranks dungeons for your entire group. Every player's BIS needs factor into the score.
- **BIS-sourced intelligence** — All 40 spec BIS lists sourced from Icy Veins, embedded and updated with each release.
- **Zero configuration** — Scan, rank, run. No setup, no data import, no external tools.

---

## Features

### Dungeon Ranking Engine

- **Combined Scoring** — Each dungeon is scored using a weighted blend of BIS gear upgrades and Raider.IO rating gains. Configurable weights let you prioritize gearing or pushing.
- **M+ and Raid Rankings** — Switch between M+ dungeon rankings, raid rankings, and overall rankings across all content.
- **Minimum Key Level Hints** — Each BIS item shows the minimum keystone level needed for it to be an upgrade based on your current item level.
- **Great Vault Bonus** — Dungeons that would unlock your next vault slot get a score boost.

### Upgrade Roadmap

- **Personal Upgrade Path** — The Roadmap tab shows your top upgrade actions: which dungeons to run, which items to upgrade with crests, and which items to craft.
- **Slot-by-Slot Breakdown** — See your BIS status for every gear slot: what you have, what you need, where it drops, and your upgrade track progress.
- **Crest Budget** — Shows your available crests and sparks so you know what upgrades you can afford right now.

### Group Intelligence

- **Full Group Gear Scanning** — Uses the Inspect API for nearby players and addon-to-addon gear sync for everyone else. No range limit, works cross-realm.
- **Party Keystone Sync** — See every group member's current keystone dungeon and level at a glance, class-colored by player.
- **Off-Spec Tracking** — Set an off-spec to track BIS items for your secondary specialization alongside your main spec.
- **Per-Player Breakdown** — See which player needs which item from which boss, with slot names and item tooltips on hover.

### Mythic+ Dashboard

- **Great Vault Progress** — Shows your weekly vault slot progress (1/4/8 dungeons), key level thresholds, and alerts you to unclaimed rewards.
- **Current Affixes Display** — This week's M+ affixes are shown directly in the addon window.
- **Season Run History** — View your personal stats per dungeon: total runs completed, best key level, and best score.
- **Auto-Hide During Runs** — The UI automatically hides when you start a Mythic+ key and restores after the run completes.

### Quality of Life

- **Minimap Button** — Left-click to toggle the window, right-click to scan.
- **Auto-Scan** — Your gear is scanned automatically when the addon loads. No manual action needed.
- **Slash Commands** — `/do`, `/dopt`, and `/dungeonopt` all work as shortcuts.
- **Localization** — English and French (frFR) fully supported.

---

## Midnight Season 1 — Dungeon Pool

All 8 Mythic+ dungeons are supported with full boss-by-boss loot tables:

- Magisters' Terrace
- The Seat of the Triumvirate
- Skyreach
- Algeth'ar Academy
- Pit of Saron
- Windrunner Spire
- Maisara Caverns
- Nexus-Point Xenas

---

## Supported Classes & Specs

**All 40 specializations** are supported with BIS data sourced from Icy Veins (Midnight Season 1):

| Class | Specs |
|-------|-------|
| **Warrior** | Arms, Fury, Protection |
| **Paladin** | Holy, Protection, Retribution |
| **Hunter** | Beast Mastery, Marksmanship, Survival |
| **Rogue** | Assassination, Outlaw, Subtlety |
| **Priest** | Discipline, Holy, Shadow |
| **Death Knight** | Blood, Frost, Unholy |
| **Shaman** | Elemental, Enhancement, Restoration |
| **Mage** | Arcane, Fire, Frost |
| **Warlock** | Affliction, Demonology, Destruction |
| **Monk** | Brewmaster, Mistweaver, Windwalker |
| **Druid** | Balance, Feral, Guardian, Restoration |
| **Demon Hunter** | Devourer, Havoc, Vengeance |
| **Evoker** | Augmentation, Devastation, Preservation |

---

## How to Use

### Step 1 — Open
Type **/dopt** or click the minimap button. Your gear is scanned automatically.

### Step 2 — Read the rankings
The M+ tab shows all dungeons ranked by upgrade potential. The #1 dungeon has the most BIS upgrades for you (or your group).

### Step 3 — Check your roadmap
Switch to the Roadmap tab for a personalized upgrade path: which dungeons to farm, which items to upgrade with crests, and which items to craft.

### Step 4 — Run the #1 dungeon
Go run it. When you're in a group, the addon syncs everyone's gear and keystones automatically.

---

## Slash Commands

```
/do              Toggle the main window
/do scan         Scan the group
/do reset        Reset your dungeon completions
/do purge        Clear all cached group data and re-scan
/do history      Show season run history
/do help         Show help
```

Aliases: `/dopt` and `/dungeonopt` work identically.

---

## FAQ

**Q: Where does the BIS data come from?**
All BIS lists are sourced from [Icy Veins](https://www.icy-veins.com/wow/class-guides) class guides for Midnight Season 1. Data is embedded in the addon and updated with each release.

**Q: Can the addon fetch BIS data live from Icy Veins?**
No. WoW addons run in a sandboxed Lua environment with no HTTP access. The data is updated manually with each addon version.

**Q: Do all party members need the addon?**
No. Members without the addon are scanned via the Inspect API (requires being within range). Members with the addon get instant cross-realm gear sync with no range limit, plus keystone and completion sharing.

**Q: Does it work solo?**
Yes. The addon scans your gear automatically and shows your personal BIS needs, upgrade roadmap, and dungeon rankings. Group features (sync, keystones) activate when you join a party.

**Q: What happens when the dungeon pool rotates next season?**
The addon reads the active M+ dungeon pool from the game API dynamically. BIS lists and loot tables are updated with each addon release to match the new season.

**Q: Does it work in raids?**
No. Dungeon Optimizer is designed for Mythic+ party groups (5 players max). Raid groups are not supported.

---

## Installation

Install via [CurseForge](https://www.curseforge.com/), WowUp, or your preferred addon manager.

To install manually, extract to:
```
World of Warcraft/_retail_/Interface/AddOns/DungeonOptimizer/
```

All libraries (Ace3, LibDataBroker, LibDBIcon) are embedded. No additional downloads required.

---

## Feedback & Support

Bug reports and feature requests: [GitHub Issues](https://github.com/zneel/DungeonOptimizer/issues)

**Author:** BIS-Group

---

## Credits

- BIS data sourced from [Icy Veins](https://www.icy-veins.com/) class guides
- Built on the [Ace3](https://www.wowace.com/projects/ace3) framework
- [LibDataBroker-1.1](https://www.wowace.com/projects/libdatabroker-1-1) and [LibDBIcon-1.0](https://www.wowace.com/projects/libdbicon-1-0)
