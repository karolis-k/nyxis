# Phase 6b: Asset Integration — Detailed Plan

> **Status**: ✅ Complete  
> **Goal**: Replace placeholder shapes with actual sprites from the migrated asset library.

---

> [!NOTE]
> Assets were copied from the previous game in Phase 1, but the Flame components are still rendering colored shapes. This phase connects the visual assets to the game engine.

> [!IMPORTANT]
> **Deferred to Phase 10 (Post-Release)**: Smart wall rendering (neighbor-aware thin walls with corner detection). The old game used a segment-based `WallRenderer` that analyzed 8 neighbors per wall tile. This adds architectural complexity (each `TileComponent` needs neighbor info). For now, walls use simple full-tile sprites.

---

## Overview

The `assets/` folder contains ready-to-use sprites:
- `assets/icons/entities/` — Player character sprites (human.png, dwarf.png, elf.png)
- `assets/icons/monsters/` — Monster sprites (goblin.png, orc.png, dragon.png, fairy.png)
- `assets/icons/items/` — Item sprites (sword.png, armor.png, potion.png, etc.)
- `assets/icons/tiles/` — Tile sprites (stone-floor.png, stone-wall.png, stair-*.png)
- `assets/icons/effects/` — Visual effect overlays (SVG format)
- `assets/textures/` — UI backgrounds and textures

Current components use `canvas.drawCircle()`, `canvas.drawRect()`, etc. This phase converts them to use `Sprite.render()`.

---

## 6b.1 Entity Sprites

### PlayerComponent

**Current** (`lib/game/components/player_component.dart`):
```dart
final Paint _playerPaint = Paint()..color = Colors.green;

void render(Canvas canvas) {
  canvas.drawCircle(center, playerRadius, _playerPaint);
}
```

**Target**:
```dart
late Sprite _sprite;

@override
Future<void> onLoad() async {
  await super.onLoad();
  _sprite = await Sprite.load('icons/entities/human.png');
}

@override
void render(Canvas canvas) {
  _sprite.render(canvas, size: size);
}
```

- [ ] Add `Sprite` field to PlayerComponent
- [ ] Load sprite in `onLoad()` based on player class/race (future: configurable)
- [ ] Replace circle drawing with `_sprite.render()`
- [ ] Handle death state (tint red or use alternate sprite)

### MonsterComponent

**Current** (`lib/game/components/monster_component.dart`):
```dart
Color _getMonsterColor() {
  final config = MonsterRegistry.tryGet(_monster.configId);
  return config?.color ?? const Color(0xFFAA00AA);
}

void render(Canvas canvas) {
  final paint = Paint()..color = _getMonsterColor();
  canvas.drawPath(diamondPath, paint);
}
```

**Target**:
```dart
late Sprite _sprite;

@override
Future<void> onLoad() async {
  await super.onLoad();
  final config = MonsterRegistry.tryGet(_monster.configId);
  final spritePath = config?.spriteId ?? 'icons/monsters/goblin.png';
  _sprite = await Sprite.load(spritePath);
}

@override
void render(Canvas canvas) {
  _sprite.render(canvas, size: size);
  _renderHealthBar(canvas); // Keep health bar overlay
}
```

- [ ] Add `Sprite` field to MonsterComponent
- [ ] Load sprite from `MonsterConfig.spriteId`
- [ ] Update MonsterConfig entries with correct sprite paths
- [ ] Keep health bar rendering on top of sprite
- [ ] Handle death state (fade out or tint)

### ItemComponent

**Current** (`lib/game/components/item_component.dart`):
```dart
Color _getItemColor() => switch (config.type) {
  ItemType.weapon => Colors.orange,
  ItemType.armor => Colors.blue,
  // ...
};

void render(Canvas canvas) {
  final fillPaint = Paint()..color = itemColor;
  canvas.drawRRect(rect, fillPaint);
}
```

**Target**:
```dart
late Sprite _sprite;

@override
Future<void> onLoad() async {
  await super.onLoad();
  final config = ItemRegistry.tryGet(_item.configId);
  final spritePath = config?.spriteId ?? 'icons/items/potion.png';
  _sprite = await Sprite.load(spritePath);
}

@override
void render(Canvas canvas) {
  _sprite.render(canvas, size: size * 0.7); // Items render smaller
  _renderRarityBorder(canvas); // Optional: colored border for rarity
}
```

- [ ] Add `Sprite` field to ItemComponent
- [ ] Load sprite from `ItemConfig.spriteId`
- [ ] Update ItemConfig entries with correct sprite paths
- [ ] Render at ~70% tile size (items should be smaller than entities)
- [ ] Add rarity border overlay (common/rare/epic/legendary colors)

---

## 6b.2 Tile Sprites

### TileComponent

**Current** (`lib/game/components/tile_component.dart`):
```dart
Color _getColorForTileType(TileType type) => switch (type) {
  TileType.floor => Colors.grey.shade700,
  TileType.wall => Colors.grey.shade900,
  // ...
};

void render(Canvas canvas) {
  final paint = Paint()..color = _getColorForTileType(tile.type);
  canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), paint);
}
```

**Target**:
```dart
late Sprite _sprite;
Sprite? _overlaySprite;

@override
Future<void> onLoad() async {
  await super.onLoad();
  _sprite = await _loadSpriteForTileType(tile.type);
  _overlaySprite = await _loadOverlayIfNeeded(tile.type);
}

Sprite _loadSpriteForTileType(TileType type) => switch (type) {
  TileType.floor => Sprite.load('icons/tiles/stone-floor.png'),
  TileType.wall => Sprite.load('icons/tiles/stone-wall.png'),
  TileType.stairsDown => Sprite.load('icons/tiles/stone-floor.png'),
  TileType.stairsUp => Sprite.load('icons/tiles/stone-floor.png'),
  // ...
};

@override
void render(Canvas canvas) {
  _sprite.render(canvas, size: size);
  _overlaySprite?.render(canvas, size: size);
}
```

- [ ] Add `Sprite` and optional `_overlaySprite` fields
- [ ] Create tile type → sprite path mapping
- [ ] Handle stair tiles: base floor + overlay (`stair-down-overlay.png`)
- [ ] Consider fog-of-war tinting (multiply blend mode)
- [ ] Walls: use simple full-tile sprite (smart wall rendering deferred to Phase 10)

### Tile Sprite Mapping

| TileType | Base Sprite | Overlay |
|----------|-------------|---------|
| `floor` | `stone-floor.png` | — |
| `wall` | `stone-wall.png` | — |
| `stairsDown` | `stone-floor.png` | `stair-down-overlay.png` |
| `stairsUp` | `stone-floor.png` | `stair-up-overlay.png` |
| `water` | `water.png` | — |
| `grass` | `grass.png` | — |

---

## 6b.3 Sprite Caching

Loading sprites individually in each component's `onLoad()` is inefficient. Use Flame's built-in image cache.

### Preload in MyGame

```dart
class MyGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Preload all sprites
    await images.loadAll([
      // Entities
      'icons/entities/human.png',
      'icons/entities/dwarf.png',
      'icons/entities/elf.png',
      // Monsters
      'icons/monsters/goblin.png',
      'icons/monsters/orc.png',
      'icons/monsters/dragon.png',
      'icons/monsters/fairy.png',
      // Items
      'icons/items/sword.png',
      'icons/items/armor.png',
      'icons/items/potion.png',
      'icons/items/helmet.png',
      'icons/items/boots.png',
      'icons/items/medieval-leather-pants.png',
      'icons/items/stone.png',
      // Tiles
      'icons/tiles/stone-floor.png',
      'icons/tiles/stone-wall.png',
      'icons/tiles/stair-down-overlay.png',
      'icons/tiles/stair-up-overlay.png',
      'icons/tiles/water.png',
      'icons/tiles/grass.png',
    ]);
  }
}
```

### Use Cached Images in Components

```dart
// In any component with HasGameReference<MyGame>
@override
Future<void> onLoad() async {
  final image = game.images.fromCache('icons/monsters/goblin.png');
  _sprite = Sprite(image);
}
```

- [ ] Add `images.loadAll()` in MyGame.onLoad()
- [ ] Update components to use `game.images.fromCache()`
- [ ] Handle missing images gracefully (log warning, use fallback)

### Fallback Strategy

```dart
Sprite _loadSprite(String path, String fallbackPath) {
  try {
    return Sprite(game.images.fromCache(path));
  } catch (e) {
    debugPrint('Missing sprite: $path, using fallback');
    return Sprite(game.images.fromCache(fallbackPath));
  }
}
```

---

## 6b.4 Visual Polish

### Entity Death Feedback

```dart
void render(Canvas canvas) {
  if (_monster.isAlive) {
    _sprite.render(canvas, size: size);
  } else {
    // Death effect: fade out or tint red
    canvas.saveLayer(null, Paint()..color = Colors.white.withOpacity(0.3));
    _sprite.render(canvas, size: size);
    canvas.restore();
  }
}
```

- [ ] Monster death: fade out sprite over ~0.5s
- [ ] Player death: tint sprite red
- [ ] Optional: death animation (sprite flip, shrink)

### Item Rarity Indicators

```dart
void _renderRarityBorder(Canvas canvas) {
  final borderColor = switch (config.rarity) {
    ItemRarity.common => Colors.grey,
    ItemRarity.uncommon => Colors.green,
    ItemRarity.rare => Colors.blue,
    ItemRarity.epic => Colors.purple,
    ItemRarity.legendary => Colors.orange,
  };
  
  final borderPaint = Paint()
    ..color = borderColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;
  
  canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), borderPaint);
}
```

- [ ] Add colored border based on `ItemConfig.rarity`
- [ ] Optional: subtle glow effect for legendary items

### Monster Elite/Boss Indicators

```dart
void _renderEliteIndicator(Canvas canvas) {
  if (config.isElite) {
    // Draw crown or star above monster
    final crownSprite = Sprite(game.images.fromCache('icons/effects/elite-crown.svg'));
    crownSprite.render(canvas, position: Vector2(size.x / 2 - 8, -12), size: Vector2(16, 16));
  }
}
```

- [ ] Elite monsters: crown/star indicator
- [ ] Boss monsters: larger sprite scale + aura
- [ ] Optional: use SVG effects from `assets/icons/effects/`

---

## Implementation Order

1. **Sprite Caching** (6b.3) — Set up preloading first
2. **Tile Sprites** (6b.2) — Visual foundation
3. **Entity Sprites** (6b.1) — Player, then monsters, then items
4. **Visual Polish** (6b.4) — Death effects, rarity, elite indicators

---

## Testing Checklist

- [ ] All sprites load without errors
- [ ] Missing sprites fall back gracefully (no crashes)
- [ ] Performance: no frame drops with 50+ entities on screen
- [ ] Sprites render at correct size and position
- [ ] Stair overlays display correctly on floor tiles
- [ ] Health bars still visible above monster sprites
- [ ] Rarity borders visible on items
- [ ] Death effects trigger correctly

---

## Asset Reference

### Available Entity Sprites
- `icons/entities/human.png`
- `icons/entities/dwarf.png`
- `icons/entities/elf.png`
- `icons/entities/village_elder.png`

### Available Monster Sprites
- `icons/monsters/goblin.png`
- `icons/monsters/orc.png`
- `icons/monsters/dragon.png`
- `icons/monsters/fairy.png`

### Available Item Sprites
- `icons/items/sword.png`
- `icons/items/armor.png`
- `icons/items/potion.png`
- `icons/items/helmet.png`
- `icons/items/boots.png`
- `icons/items/medieval-leather-pants.png`
- `icons/items/stone.png`

### Available Tile Sprites
- `icons/tiles/stone-floor.png`
- `icons/tiles/stone-wall.png`
- `icons/tiles/stair-down.png` / `stair-down-overlay.png`
- `icons/tiles/stair-up.png` / `stair-up-overlay.png`
- `icons/tiles/water.png`
- `icons/tiles/grass.png`
- `icons/tiles/portal.png`
- `icons/tiles/dark_plains.png`
- `icons/tiles/desert_*.png`
- `icons/tiles/grassland_withtrees.png`

### Available Effect SVGs
- `icons/effects/fire-aura.svg`
- `icons/effects/poison-cloud.svg`
- `icons/effects/ice-crystals.svg`
- `icons/effects/lightning-sparks.svg`
- `icons/effects/sword-slash.svg`
- `icons/effects/bow-shot.svg`
- `icons/effects/elite-crown.svg`
- `icons/effects/legendary-sparkle.svg`
- `icons/effects/burning-status.svg`
