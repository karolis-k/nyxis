# Phase 9: Content & Polish — Detailed Plan

> **Status**: ⏳ Pending  
> **Goal**: Expand the game with varied content and polished UX.

---

## Overview

With the game released, this phase focuses on making the game more fun, varied, and polished. This is where the game grows from MVP to a richer experience.

> [!NOTE]
> Advanced polish items (minimap, damage numbers, smart wall rendering, quest system) are deferred to Phase 10 (Post-Release).

---

## 9.1 Content Expansion

### Monsters
Use available monster assets (no new art required).

| Monster | Asset | Behavior |
|---------|-------|----------|
| Goblin | `goblin.png` | Basic melee, low HP |
| Orc | `orc.png` | Strong melee, high HP |
| Dragon | `dragon.png` | Boss, high damage |
| Fairy | `fairy.png` | Fast, evasive, magic |

- [ ] Configure all 4 monster types with distinct stats
- [ ] Each monster has unique behavior pattern
- [ ] Update MonsterRegistry with configs

### Items
Use available item assets (no new art required).

| Category | Asset | Item |
|----------|-------|------|
| Weapon | `sword.png` | Sword (melee) |
| Weapon | `stone.png` | Stone (thrown/missile) |
| Armor | `armor.png` | Chestplate |
| Armor | `helmet.png` | Helmet |
| Armor | `boots.png` | Boots |
| Armor | `medieval-leather-pants.png` | Pants |
| Consumable | `potion.png` | Health Potion |

- [ ] Configure all 7 item types with distinct stats
- [ ] Add stat variations (e.g., Iron Sword vs Steel Sword using same sprite)
- [ ] Update ItemRegistry with configs

---

## 9.2 UI/UX Polish

### Main Menu
- [ ] New game button
- [ ] Continue game button
- [ ] Settings button
- [ ] Credits
- [ ] Visual design

### Settings
- [ ] Sound volume slider
- [ ] Music volume slider
- [ ] Basic options

---

## 9.3 Audio

### Music
- [ ] Main menu theme
- [ ] Dungeon ambiance

### Sound Effects
- [ ] Weapon hits
- [ ] Monster sounds (attack, death)
- [ ] UI sounds (menu, pickup, equip)

---

## 9.4 Balance & Tuning

### Difficulty
- [ ] Define difficulty curve per dungeon level
- [ ] Test and adjust monster stats
- [ ] Test and adjust item drop rates

### Rarity System
- [ ] Define rarity tiers (common → legendary)
- [ ] Assign items to tiers
- [ ] Implement drop rate formulas

---

## Done Criteria

Phase 9 is complete when:
- [ ] All 4 monster types configured with unique behaviors
- [ ] All 7 item types configured with stats
- [ ] Main menu and settings screens
- [ ] Core sound effects implemented
- [ ] Difficulty feels balanced and fun

---

## Deferred to Phase 10 (Post-Release)

- Minimap widget
- Floating damage numbers
- Smooth transitions and animations
- Particle effects
- Smart wall rendering
- Quest/objective system
- NPC dialogue system
- Achievements/leaderboards

---

## Next Phase

After completing Phase 9, proceed to [Phase 10: Post-Release Polish](phase10-post-release.md) based on priorities and player feedback.
