# 🎮 EcoChain Setup Guide - Step by Step

## **STEP 1: Download Godot 4.x** ✅

### Windows / Mac / Linux
1. Go to: https://godotengine.org/download
2. Download **Godot 4.x** (latest stable version)
3. Extract and install
4. Launch Godot

---

## **STEP 2: Clone the Repository** ✅

Open terminal/command prompt and run:

```bash
git clone https://github.com/cyberwolf237/ecochain-game.git
cd ecochain-game
```

---

## **STEP 3: Import Project into Godot** ✅

### In Godot Engine:

1. **Click "Import" button** on the project manager
2. **Click "Browse"** and navigate to: `ecochain-game/game/`
3. **Click "Import & Edit"**
4. Godot will load your project!

---

## **STEP 4: Run the Game** ✅

### Play the Game:
1. Open `scenes/main_menu.tscn` in Godot
2. Press **F5** or click the **Play ▶️** button
3. You'll see the Main Menu! 🎮

---

## **File Structure Explained**

```
game/
├── project.godot              ← Godot project configuration
├── scenes/                    ← Game scenes (.tscn files)
│   ├── main_menu.tscn        ← Main menu screen
│   ├── game_level.tscn       ← Gameplay screen
│   └── level_select.tscn     ← Level selection screen
├── scripts/                   ← Game code (.gd files)
│   ├── game_manager.gd       ← Global game state
│   ├── ecosystem_manager.gd  ← Food chain & population logic
│   ├── ui_manager.gd         ← User interface
│   └── level_manager.gd      ← Level progression
├── assets/                    ← Images, sounds, data
│   ├── images/              ← Sprite graphics
│   ├── sounds/              ← Audio files
│   └── data/                ← Game data files
└── levels/                    ← Level configurations
    └── level_1.json         ← Tutorial level
```

---

## **What Each Script Does**

### 🎮 **game_manager.gd**
- Global game state (autoload)
- Saves/loads player progress
- Manages settings
- Unlocks biomes
- Tracks achievements

### 🌱 **ecosystem_manager.gd**
- Creates organisms
- Simulates food chains
- Updates population dynamics
- Manages resources (energy, water, nutrients)
- Checks win/lose conditions

### 🎨 **ui_manager.gd**
- Shows/hides menus
- Updates HUD displays
- Handles button presses
- Shows messages and dialogs

### 📋 **level_manager.gd**
- Loads level data
- Manages level progression
- Checks objectives
- Calculates star ratings

---

## **Game Control Flow**

```
1. Game Starts
        ↓
2. Main Menu Appears
        ↓
3. Click "PLAY"
        ↓
4. Level Select Screen
        ↓
5. Choose Level 1
        ↓
6. Gameplay Starts
        ↓
7. Place organisms, watch food chain
        ↓
8. Win or Lose
        ↓
9. Back to Menu
```

---

## **Testing the Game**

### First Time Playing:
1. Press **F5** to start
2. Click **"▶️ PLAY"** button
3. Click **"Level 1"** in Rainforest
4. The game scene loads
5. You'll see HUD with resources and population

### What's Working:
✅ Main menu UI
✅ Level selection screen
✅ Game scene with HUD
✅ Ecosystem manager (core logic)
✅ Game manager (global state)

### What's In Progress:
⏳ Organism visuals (sprites)
⏳ Interactive grid placement
⏳ Real-time simulation
⏳ Sound effects
⏳ Save/load system

---

## **Next Steps (What to Do Now)**

### Phase 1 Tasks:
1. **Test the menu system** - Make sure buttons work
2. **Add sprite graphics** - Place images in `assets/images/`
3. **Create organism visuals** - Sprites for plants, animals
4. **Build the grid UI** - Ecosystem canvas display
5. **Connect simulation** - Link game logic to UI updates

---

## **Common Issues & Fixes**

### "Cannot find project.godot"
- Make sure you selected the **`game/`** folder (not parent folder)

### "Scenes not found"
- Check paths are correct: `res://scenes/main_menu.tscn`
- Godot uses `res://` as the root (game folder)

### Scripts showing errors
- Make sure all files are in correct locations
- Check file names match exactly (case-sensitive)

---

## **Building for Mobile (Android)**

When ready to deploy:

```
1. Install Android SDK (in Godot settings)
2. File → Export
3. Select Android
4. Configure export settings
5. Click Export → APK
```

---

## **Helpful Resources**

- 📚 Godot Docs: https://docs.godotengine.org/
- 🎓 GDScript Guide: https://docs.godotengine.org/en/stable/getting_started/scripting/gdscript/index.html
- 🎮 Godot Tutorials: https://docs.godotengine.org/en/stable/community/tutorials.html

---

**You're all set! Happy coding! 🚀**

*Last Updated: 2026-05-11*
