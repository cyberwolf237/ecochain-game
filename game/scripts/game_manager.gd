# EcoChain - Game Manager (Autoload)
# Manages global game state, settings, and progression

extends Node

# Game state variables
var current_level: int = 1
var current_biome: int = 1
var player_stats: Dictionary = {
    "levels_completed": 0,
    "total_score": 0,
    "achievements": [],
    "best_times": {}
}

var settings: Dictionary = {
    "music_volume": 0.8,
    "sfx_volume": 0.8,
    "difficulty": "normal",  # easy, normal, hard
    "language": "en"
}

var biomes: Array = [
    {"name": "Rainforest", "color": Color.GREEN, "unlocked": true},
    {"name": "Savanna", "color": Color.GOLDENROD, "unlocked": false},
    {"name": "Arctic", "color": Color.LIGHT_BLUE, "unlocked": false},
    {"name": "Ocean", "color": Color.BLUE, "unlocked": false},
    {"name": "Desert", "color": Color.YELLOW, "unlocked": false}
]

func _ready():
    print("🎮 EcoChain Game Manager Initialized")
    load_game_data()

# Load player progress from file
func load_game_data() -> void:
    var save_file = "user://ecochain_save.json"
    if ResourceLoader.exists(save_file):
        print("📂 Loading saved game data...")
        # TODO: Implement save/load system
    else:
        print("✨ New game detected")
        save_game_data()

# Save player progress
func save_game_data() -> void:
    var save_file = "user://ecochain_save.json"
    print("💾 Saving game data...")
    # TODO: Implement save system

# Unlock next biome
func unlock_biome(biome_index: int) -> void:
    if biome_index < biomes.size():
        biomes[biome_index]["unlocked"] = true
        print("🔓 Unlocked: " + biomes[biome_index]["name"])
        save_game_data()

# Add achievement
func add_achievement(achievement_name: String) -> void:
    if not achievement_name in player_stats["achievements"]:
        player_stats["achievements"].append(achievement_name)
        print("🏆 Achievement Unlocked: " + achievement_name)
        save_game_data()

# Get biome by index
func get_biome(index: int) -> Dictionary:
    if index >= 0 and index < biomes.size():
        return biomes[index]
    return {}

# Check if biome is unlocked
func is_biome_unlocked(index: int) -> bool:
    if index >= 0 and index < biomes.size():
        return biomes[index]["unlocked"]
    return false

# Transition to next scene
func goto_scene(scene_path: String) -> void:
    print("📍 Going to: " + scene_path)
    get_tree().change_scene_to_file(scene_path)
