# 📋 EcoChain Game Design Document

## 1. Game Overview

### Title
**EcoChain: Educational Ecosystem Game**

### Tagline
*"Build, Balance, and Save Ecosystems - Learn Real Science Through Gameplay"*

### Genre
Educational Puzzle-Adventure

### Target Audience
- **Primary**: Teens (13-18) and Young Adults
- **Secondary**: Adults interested in education/science
- **Educational Use**: School STEM programs, biology classes

### Platform
- Android (primary mobile)
- Windows/Mac/Linux (desktop)
- Web (bonus)

---

## 2. Core Concept

**EcoChain** is an interactive game where players build and manage ecosystems by carefully placing plants, herbivores, predators, and decomposers. The game teaches real science about food chains, biodiversity, conservation, and climate while providing engaging, addictive gameplay.

### Key Innovation
Combines puzzle mechanics (resource management, spatial placement) with education (real science facts, ecosystem dynamics), creating a fun learning experience.

---

## 3. Game Mechanics

### 3.1 Core Gameplay Loop

```
1. Player Placement Phase
   ↓
2. Simulation Phase (Game Run)
   ↓
3. Population Changes
   ↓
4. Resource Updates
   ↓
5. Check Win/Lose Conditions
   ↓
6. Return to Step 1 (repeat)
```

### 3.2 Placement System
- Grid-based ecosystem canvas (10x10 to 20x20 depending on level)
- Drag-and-drop organisms from side panel
- Each organism occupies 1-4 grid cells
- Placement restrictions based on biome and organism type

### 3.3 Food Chain Logic

**Automatic Relationships:**
- Plants → Herbivores → Carnivores → Decomposers
- Players don't manually set relationships
- Game engine determines compatibility

**Example:**
```
Grass (Plant) → Rabbit (Herbivore) → Wolf (Carnivore) → Fungi (Decomposer)
```

### 3.4 Population Dynamics

**Birth Conditions:**
- Food available: +10% population per turn
- Adequate space: Organism doesn't multiply if overcrowded
- Minimum population: Need at least 2 to breed

**Death Conditions:**
- No food: -15% population per turn
- Overpopulation: -5% when exceeding capacity
- Environmental stress: Weather, disease, competition

**Population Decay Formula:**
```
New Population = Current Population × Growth_Rate × Food_Multiplier × Space_Multiplier
```

### 3.5 Resource Management

**Three Main Resources:**

1. **Energy** (🔋)
   - Herbivores consume plants
   - Carnivores consume herbivores
   - Efficiency loss up the food chain (10 units of plants = 1 unit of herbivore energy)

2. **Water** (💧)
   - Rain provides water
   - Drought depletes water
   - All organisms need water

3. **Nutrients** (🌱)
   - Provided by decomposers
   - Plants need nutrients to grow
   - Cycles through decomposition

### 3.6 Environmental Events

**Weather (Random, Biome-Specific):**
- 🌧️ **Heavy Rain**: +3 water, -1 energy (wet conditions)
- ☀️ **Drought**: -3 water, -1 food production
- 🌪️ **Storm**: Random organism removal (5-10%)
- ❄️ **Freeze**: Arctic-specific, kills non-adapted species
- 🔥 **Wildfire**: Desert/Savanna, kills plants

**Impact:**
- Happens randomly every 5-10 turns
- More frequent on higher difficulties
- Part of the learning experience

---

## 4. Level Design

### 4.1 Level Structure (50 Levels Total)

**Distribution:**
- Biome 1 (Rainforest): Levels 1-10
- Biome 2 (Savanna): Levels 11-20
- Biome 3 (Arctic): Levels 21-30
- Biome 4 (Ocean): Levels 31-40
- Biome 5 (Desert): Levels 41-50

### 4.2 Difficulty Progression

**Early Levels (1-15):**
- Simple ecosystems (3-5 species)
- Generous resource amounts
- Longer success windows
- Clear objectives
- Tutorial guidance

**Mid Levels (16-35):**
- Complex ecosystems (6-10 species)
- Balanced resources
- Multiple win conditions
- Some environmental challenges

**Advanced Levels (36-50):**
- Advanced ecosystems (10+ species)
- Limited resources
- Strict conditions
- Frequent events
- Multiple paths to victory

### 4.3 Level Objectives

**Examples:**

**Level 1 (Rainforest Tutorial):**
- Objective: Create a simple food chain
- Provided: Grass, Rabbit, Fox
- Success: Keep all species alive for 20 turns
- Bonus: 3-star if maintained for 50 turns

**Level 5 (Rainforest):**
- Objective: Create balanced ecosystem
- Species Available: 8 different organisms
- Success: Reach 50+ total population
- Bonus: 3-star with 100+ population

**Level 25 (Arctic):**
- Objective: Survive Arctic fragility
- Species Available: Arctic-specific (5 organisms)
- Success: Maintain ecosystem for 30 turns
- Bonus: 3-star without using save/reload

### 4.4 Star Rating System

- ⭐ 1 Star: Complete level objective
- ⭐⭐ 2 Stars: Achieve bonus condition
- ⭐⭐⭐ 3 Stars: Perfect execution (no species extinction, high population)

---

## 5. User Interface Design

### 5.1 Main Menu
```
┌─────────────────────────────┐
│      🌍 EcoChain 🌍         │
├─────────────────────────────┤
│  [PLAY LEVELS]              │
│  [SANDBOX MODE]             │
│  [ACHIEVEMENTS]             │
│  [SETTINGS]                 │
│  [ABOUT]                    │
└─────────────────────────────┘
```

### 5.2 In-Game HUD Layout

```
┌────────────────────────────────────────┐
│ 🎮 EcoChain | Level 5: Rainforest    │
├────────────────────────────────────────┤
│                                        │
│     [Ecosystem Canvas 10x10]           │
│                                        │
│  Resources: 🔋 Energy   💧 Water      │
│            🌱 Nutrients                │
│                                        │
│  ╭─────────────╮                      │
│  │ Species:    │                      │
│  │ 🌿 Grass    │  Ecosystem Stats:    │
│  │ 🐰 Rabbit   │  Population: 45      │
│  │ 🦊 Fox      │  Turn: 15/50         │
│  │ 🍄 Fungi    │                      │
│  ╰─────────────╯  [Objective Complete]│
│                                        │
│  [PAUSE] [HELP] [MENU]                │
└────────────────────────────────────────┘
```

### 5.3 Level Select
```
┌─────────────────────────────────────┐
│  SELECT A BIOME & LEVEL             │
├─────────────────────────────────────┤
│                                     │
│  🌴 Rainforest  [1★] [2★] [3★] ... │
│  🦁 Savanna     [1★] [2★] [3★] ... │
│  ❄️  Arctic      [🔒] [🔒] [🔒] ... │
│  🌊 Ocean       [🔒] [🔒] [🔒] ... │
│  🏜️  Desert      [🔒] [🔒] [🔒] ... │
│                                     │
│  [BACK]                             │
└─────────────────────────────────────┘
```

---

## 6. Art Style & Aesthetics

### 6.1 Visual Style
- **Genre**: Colorful 2D pixel/vector art
- **Color Palette**: Vibrant, nature-inspired
- **Biome Colors**:
  - Rainforest: Deep greens, bright flowers
  - Savanna: Golds, oranges, browns
  - Arctic: Whites, light blues, icy blues
  - Ocean: Blues, teals, purples
  - Desert: Sandy yellows, rust oranges

### 6.2 Character Design
- Cute, educational style (not realistic)
- Recognizable silhouettes
- Animated movement (idle, eating, reproducing)
- Color-coded by role (green=plant, red=predator, etc.)

### 6.3 UI Design
- Clean, modern interface
- Clear typography
- High contrast for readability
- Intuitive icons
- Colorblind-friendly palette

---

## 7. Audio Design

### 7.1 Sound Effects
- **Placement**: Click sound when placing organism
- **Eating**: Soft munching sounds
- **Population Growth**: Subtle chirping
- **Death**: Gentle fade-out sound
- **Events**: Distinctive sounds for rain, wind, etc.
- **UI**: Click, select, error sounds

### 7.2 Music
- **Background**: Ambient, nature-inspired soundtrack
- **Biome Themes**: Unique music per biome
- **Victory**: Celebratory jingle
- **Defeat**: Sad, learning-oriented tune
- **Menu**: Calm, welcoming theme

---

## 8. Educational Content

### 8.1 Learning Objectives

Players will understand:
1. How food chains and food webs work
2. Energy flow through ecosystems
3. Nutrient cycling (carbon, nitrogen)
4. Biodiversity and its importance
5. Population dynamics and carrying capacity
6. Predator-prey relationships
7. Competition for resources
8. Extinction and conservation
9. Climate impact on ecosystems
10. Adaptation to environments

### 8.2 Educational Features

**In-Game Learning:**
- Tap any organism to see:
  - Real photograph/illustration
  - Scientific name
  - Diet and habitat
  - Fun facts (2-3 per species)
  - Conservation status

**Progressive Knowledge:**
- Levels introduce concepts gradually
- Quizzes check understanding
- Achievements reward learning

**Science Accuracy:**
- Content reviewed by science educators
- Food chains reflect reality
- Population dynamics realistic
- Information from reliable sources (NASA, WWF, National Geographic)

---

## 9. Progression & Unlocking

### 9.1 Biome Unlocking
- Biome 1 (Rainforest): Available from start
- Biome 2 (Savanna): Unlock after completing Rainforest Level 5
- Biome 3 (Arctic): Unlock after completing Savanna Level 15
- Biome 4 (Ocean): Unlock after completing Arctic Level 25
- Biome 5 (Desert): Unlock after completing Ocean Level 35

### 9.2 Species Unlocking
- Basic species available in first biome
- New species unlock as you progress
- Bonus species for earning 3-stars
- Special rare species for achievements

### 9.3 Features Unlocking
- Tutorial: First play-through
- Sandbox Mode: After completing Level 3
- Difficulty Selection: After completing Biome 1
- Custom Levels: Post-launch (future)

---

## 10. Achievements & Rewards

### 10.1 Achievement Categories

**Progress Achievements:**
- "First Steps" - Complete Level 1
- "Biome Explorer" - Unlock all biomes
- "Level Master" - Complete all 50 levels

**Challenge Achievements:**
- "Perfectionist" - Get 3 stars on all levels
- "Speedrun" - Complete level in under X time
- "Survivor" - Maintain ecosystem 100+ turns

**Learning Achievements:**
- "Scholar" - Read 100 species facts
- "Scientist" - Answer 50 quiz questions correctly
- "Educator" - Complete all educational content

### 10.2 Reward System
- Badges displayed in profile
- Unlocks cosmetic rewards (themes, skins)
- Points towards leaderboard

---

## 11. Target Metrics

### 11.1 Gameplay Metrics
- **Average Level Duration**: 5-10 minutes
- **Completion Rate Goal**: 40%+ complete all levels
- **Replay Rate**: 50%+ attempt levels for 3 stars

### 11.2 Educational Metrics
- **Engagement**: 30+ minutes average session
- **Learning**: 80%+ correct answers on quizzes
- **Retention**: 60%+ return monthly

---

## 12. Monetization (Free-to-Play)

### Current Model: **FREE**
- No ads
- No in-app purchases
- No premium content

### Optional Future Revenue (Post-Launch):
- Cosmetic skins (not pay-to-win)
- Optional donation for continued development
- Educational institution licenses

---

## 13. Technology Stack

**Engine:** Godot 4.x
**Language:** GDScript
**Platforms:** Android, Windows, Mac, Linux, Web
**Art Tool:** Aseprite (or equivalent)
**Audio Tool:** FMOD or Godot's built-in audio
**Version Control:** Git/GitHub

---

## 14. Development Timeline

- **Phase 1 (Weeks 1-4)**: Foundation
- **Phase 2 (Weeks 5-8)**: Content Expansion
- **Phase 3 (Weeks 9-12)**: Advanced Features
- **Phase 4 (Weeks 13-16)**: Polish & Launch

---

## 15. Success Criteria

✅ Runs on Android and Desktop
✅ Playable 50+ levels
✅ Educational content accurate and engaging
✅ 95%+ bug-free at launch
✅ 4+ star rating on app stores
✅ 10,000+ downloads in first month
✅ Positive teacher feedback

---

**Document Version:** 1.0
**Last Updated:** 2026-05-11
**Author:** cyberwolf237