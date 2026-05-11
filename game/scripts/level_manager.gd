# EcoChain - Level Manager
# Handles level loading, progression, and objectives

extends Node

class_name LevelManager

# Level data structure
class Level:
    var level_number: int
    var biome: String
    var name: String
    var description: String
    var objective: String
    var target_population: int
    var max_turns: int
    var starting_organisms: Array
    var difficulty: String
    
    func _init(p_number: int, p_biome: String, p_name: String):
        level_number = p_number
        biome = p_biome
        name = p_name
        description = ""
        objective = ""
        target_population = 50
        max_turns = 50
        starting_organisms = []
        difficulty = "normal"

# Current level
var current_level: Level
var levels: Array = []
var ecosystem: EcosystemManager

func _ready():
    print("📋 Level Manager Initialized")
    initialize_levels()

# Initialize all levels
func initialize_levels() -> void:
    # Level 1 - Tutorial
    var level_1 = Level.new(1, "Rainforest", "Life Begins")
    level_1.description = "Learn the basics of ecosystems"
    level_1.objective = "Keep all organisms alive for 20 turns"
    level_1.target_population = 30
    level_1.max_turns = 20
    level_1.starting_organisms = [
        {"species": "Grass", "type": "plant", "population": 20},
        {"species": "Rabbit", "type": "herbivore", "population": 5},
        {"species": "Fox", "type": "carnivore", "population": 2}
    ]
    level_1.difficulty = "easy"
    
    # Level 2 - Balance
    var level_2 = Level.new(2, "Rainforest", "Finding Balance")
    level_2.description = "Create a stable ecosystem"
    level_2.objective = "Reach 50+ total population"
    level_2.target_population = 50
    level_2.max_turns = 30
    level_2.starting_organisms = [
        {"species": "Grass", "type": "plant", "population": 25},
        {"species": "Herbivore", "type": "herbivore", "population": 8},
        {"species": "Fungi", "type": "decomposer", "population": 3}
    ]
    level_2.difficulty = "normal"
    
    # Add more levels as needed
    levels.append(level_1)
    levels.append(level_2)
    
    print("✅ Loaded %d levels" % levels.size())

# Load a specific level
func load_level(level_number: int) -> bool:
    if level_number >= 0 and level_number < levels.size():
        current_level = levels[level_number]
        print("📂 Loaded Level %d: %s" % [current_level.level_number, current_level.name])
        return true
    return false

# Start current level
func start_level(ecosystem_manager: EcosystemManager) -> void:
    if current_level == null:
        print("❌ No level loaded")
        return
    
    ecosystem = ecosystem_manager
    ecosystem.reset()
    ecosystem.start_simulation()
    
    # Add starting organisms
    for org in current_level.starting_organisms:
        ecosystem.add_organism(
            org["species"],
            org["type"],
            randi() % ecosystem.grid_size,
            randi() % ecosystem.grid_size,
            org["population"]
        )
    
    print("🎮 Level %d Started: %s" % [current_level.level_number, current_level.name])

# Check if level objective is met
func check_objective() -> bool:
    if ecosystem == null:
        return false
    
    var total_pop = ecosystem.get_total_population()
    return total_pop >= current_level.target_population

# Calculate star rating
func calculate_stars(population: int, turns_used: int) -> int:
    var stars = 1
    
    if population >= current_level.target_population:
        stars = 2
    
    if population > current_level.target_population * 1.5 and turns_used < current_level.max_turns * 0.8:
        stars = 3
    
    return stars

# Get level by number
func get_level(number: int) -> Level:
    if number >= 0 and number < levels.size():
        return levels[number]
    return null

# Get all levels
func get_all_levels() -> Array:
    return levels

# Check if level is completed
func is_level_completed(level_number: int) -> bool:
    # TODO: Check save data
    return false
