# Game Level Script - SIMPLIFIED
# Main gameplay controller

extends Node2D

var ecosystem: EcosystemManager
var current_turn: int = 0
var game_running: bool = true
var max_turns: int = 20
var target_population: int = 30

func _ready():
    print("🎮 Game Level Loaded")
    
    # Get ecosystem manager
    ecosystem = $EcosystemManager
    ecosystem.grid_size = 10
    ecosystem.reset()
    
    # Add starting organisms
    ecosystem.add_organism("Grass", "plant", 2, 2, 20)
    ecosystem.add_organism("Rabbit", "herbivore", 5, 5, 5)
    ecosystem.add_organism("Fox", "carnivore", 7, 7, 2)
    
    # Start simulation
    ecosystem.start_simulation()
    
    # Connect buttons
    setup_buttons()
    
    # Start game loop
    var timer = Timer.new()
    add_child(timer)
    timer.wait_time = 1.5
    timer.timeout.connect(_on_turn_timer)
    timer.start()

func setup_buttons():
    var pause_btn = $CanvasLayer/UI/VBoxContainer/HBoxContainer/PauseButton
    if pause_btn:
        pause_btn.pressed.connect(_on_pause_pressed)
    
    var menu_btn = $CanvasLayer/UI/VBoxContainer/HBoxContainer/MenuButton
    if menu_btn:
        menu_btn.pressed.connect(_on_menu_pressed)
    
    var help_btn = $CanvasLayer/UI/VBoxContainer/HBoxContainer/HelpButton
    if help_btn:
        help_btn.pressed.connect(_on_help_pressed)

func _on_turn_timer():
    if not game_running:
        return
    
    current_turn += 1
    print("Turn: %d" % current_turn)
    
    # Simulate ecosystem
    ecosystem.simulate_turn()
    
    # Update UI
    update_hud()
    
    # Check lose condition
    if ecosystem.check_lose_condition():
        print("❌ Game Over - Ecosystem Failed")
        game_running = false
        await get_tree().create_timer(2.0).timeout
        get_tree().change_scene_to_file("res://scenes/level_select.tscn")
    
    # Check win condition
    var total_pop = ecosystem.get_total_population()
    if total_pop >= target_population and current_turn >= 10:
        print("✅ Level Complete!")
        game_running = false
        await get_tree().create_timer(2.0).timeout
        get_tree().change_scene_to_file("res://scenes/level_select.tscn")
    
    # Check max turns
    if current_turn >= max_turns:
        print("⏰ Time's up!")
        game_running = false
        await get_tree().create_timer(2.0).timeout
        get_tree().change_scene_to_file("res://scenes/level_select.tscn")

func update_hud():
    # Update resources
    var resources_label = $CanvasLayer/UI/VBoxContainer/ResourcesLabel
    if resources_label:
        resources_label.text = "🔋 Energy: %d | 💧 Water: %d | 🌱 Nutrients: %d" % [
            ecosystem.resources["energy"],
            ecosystem.resources["water"],
            ecosystem.resources["nutrients"]
        ]
    
    # Update population
    var pop_label = $CanvasLayer/UI/VBoxContainer/PopulationLabel
    if pop_label:
        pop_label.text = "👥 Population: %d | 🔄 Turn: %d/%d" % [
            ecosystem.get_total_population(),
            current_turn,
            max_turns
        ]

func _on_pause_pressed():
    print("⏸️ Game Paused")
    game_running = not game_running

func _on_menu_pressed():
    print("📋 Back to Menu")
    get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_help_pressed():
    print("❓ Help")
