# EcoChain - Ecosystem Manager
# Handles food chains, population dynamics, and resource management

extends Node2D

class_name EcosystemManager

# Organism class
class Organism:
    var species_name: String
    var type: String  # "plant", "herbivore", "carnivore", "decomposer"
    var population: int
    var x: int
    var y: int
    var max_population: int
    var food_requirement: float
    var reproduction_rate: float
    
    func _init(p_species: String, p_type: String, p_x: int, p_y: int, p_population: int = 10):
        species_name = p_species
        type = p_type
        x = p_x
        y = p_y
        population = p_population
        max_population = 100
        food_requirement = 0.5
        reproduction_rate = 1.1

# Ecosystem grid and organisms
var grid_size: int = 10
var organisms: Array = []
var resources: Dictionary = {
    "energy": 100,
    "water": 100,
    "nutrients": 100
}
var current_turn: int = 0
var is_running: bool = false

# Food chain relationships
var food_chain: Dictionary = {
    "herbivore": "plant",
    "carnivore": "herbivore",
    "decomposer": ["plant", "herbivore", "carnivore"]
}

func _ready():
    print("🌱 Ecosystem Manager Ready")

# Add organism to ecosystem
func add_organism(species: String, type: String, x: int, y: int, population: int = 10) -> bool:
    if is_valid_position(x, y):
        var org = Organism.new(species, type, x, y, population)
        organisms.append(org)
        print("✅ Added %s (%s) at (%d, %d) | Population: %d" % [species, type, x, y, population])
        return true
    return false

# Check if position is valid
func is_valid_position(x: int, y: int) -> bool:
    if x >= 0 and x < grid_size and y >= 0 and y < grid_size:
        # Check if position is already occupied
        for org in organisms:
            if org.x == x and org.y == y:
                return false
        return true
    return false

# Simulate one turn of ecosystem
func simulate_turn() -> void:
    if not is_running:
        return
    
    current_turn += 1
    print("\n=== Turn %d ===" % current_turn)
    
    # Update resource generation
    update_resources()
    
    # Update each organism
    var organisms_to_remove: Array = []
    
    for org in organisms:
        # Check food availability
        var has_food = check_food_availability(org)
        
        if has_food:
            # Organism survives and reproduces
            org.population = min(int(org.population * org.reproduction_rate), org.max_population)
            resources["energy"] -= org.population * org.food_requirement
        else:
            # Organism dies from starvation
            org.population = max(0, int(org.population * 0.85))
        
        # Remove extinct species
        if org.population <= 0:
            organisms_to_remove.append(org)
    
    # Remove extinct organisms
    for org in organisms_to_remove:
        organisms.erase(org)
        print("💀 %s went extinct" % org.species_name)
    
    print("📊 Resources: Energy=%d, Water=%d, Nutrients=%d" % [resources["energy"], resources["water"], resources["nutrients"]])
    print("👥 Total Population: %d" % get_total_population())

# Check if organism has food
func check_food_availability(org: Organism) -> bool:
    var food_type = food_chain.get(org.type)
    
    if food_type == null:
        return true  # Plants don't need food
    
    # Count available food
    var food_count = 0
    for other_org in organisms:
        if other_org != org and other_org.type == food_type:
            food_count += other_org.population
    
    # Simple rule: need at least 1 food per 2 organisms
    return food_count >= org.population / 2

# Update resources each turn
func update_resources() -> void:
    # Plants generate nutrients
    resources["nutrients"] += 5
    
    # Water cycles (random weather effects)
    if randf() > 0.7:
        resources["water"] += 20  # Rain event
    else:
        resources["water"] -= 5  # Evaporation
    
    # Cap resources
    resources["water"] = clamp(resources["water"], 0, 200)
    resources["nutrients"] = clamp(resources["nutrients"], 0, 200)

# Get total population
func get_total_population() -> int:
    var total = 0
    for org in organisms:
        total += org.population
    return total

# Get organism count by type
func get_population_by_type(type: String) -> int:
    var count = 0
    for org in organisms:
        if org.type == type:
            count += org.population
    return count

# Check win condition
func check_win_condition() -> bool:
    var total_pop = get_total_population()
    return total_pop > 50  # Example: need 50+ organisms

# Check lose condition
func check_lose_condition() -> bool:
    var herbivores = get_population_by_type("herbivore")
    var plants = get_population_by_type("plant")
    
    # Lose if no herbivores or no plants
    return herbivores == 0 or plants == 0

# Start/stop simulation
func start_simulation() -> void:
    is_running = true
    print("▶️ Simulation started")

func stop_simulation() -> void:
    is_running = false
    print("⏸️ Simulation stopped")

# Reset ecosystem
func reset() -> void:
    organisms.clear()
    current_turn = 0
    resources = {"energy": 100, "water": 100, "nutrients": 100}
    print("🔄 Ecosystem reset")
