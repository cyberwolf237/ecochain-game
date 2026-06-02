# Game Level Script
# Main gameplay controller

extends Node2D

var level_manager: LevelManager
var ecosystem: EcosystemManager
var ui: CanvasLayer
var current_turn: int = 0
var game_running: bool = true

func _ready():
    print("🎮 Game Level Loaded")
    
    # Get references to managers
    ecosystem = $EcosystemManager
    ui = $CanvasLayer
    
    # Initialize level
    level_manager = LevelManager.new()
    level_manager.initialize_levels()
    
    # Load current level
    if level_manager.load_level(GameManager.current_level - 1):
        print("✅ Level loaded: " + level_manager.current_level.name)
        level_manager.start_level(ecosystem)
    else:
        print("❌ Failed to load level")
    
    # Connect buttons
    setup_buttons()
    
    # Start game timer
    var timer = Timer.new()
    add_child(timer)
    timer.wait_time = 2.0  # 2 seconds per turn
    timer.timeout.connect(_on_turn_timer)
    timer.start()

func setup_buttons():
    var pause_btn = ui.get_node("UI/VBoxContainer/HBoxContainer/PauseButton")
    if pause_btn:
        pause_btn.pressed.connect(_on_pause_pressed)
    
    var menu_btn = ui.get_node("UI/VBoxContainer/HBoxContainer/MenuButton")
    if menu_btn:
        menu_btn.pressed.connect(_on_menu_pressed)
    
    var help_btn = ui.get_node("UI/VBoxContainer/HBoxContainer/HelpButton")
    if help_btn:
        help_btn.pressed.connect(_on_help_pressed)

func _on_turn_timer():
    if not game_running:
        return
    
    current_turn += 1
    
    # Simulate ecosystem
    ecosystem.simulate_turn()
    
    # Update UI
    update_hud()
    
    # Check win/lose conditions
    if ecosystem.check_lose_condition():
        print("❌ Game Over - Ecosystem Failed")
        game_running = false
        show_game_over("Ecosystem collapsed!")
    
    if level_manager.check_objective():
        print("✅ Level Complete!")
        game_running = false
        show_level_complete()

func update_hud():
    # Update resources
    var resources_label = ui.get_node("UI/VBoxContainer/ResourcesLabel")
    if resources_label:
        resources_label.text = "🔋 Energy: %d | 💧 Water: %d | 🌱 Nutrients: %d" % [
            ecosystem.resources["energy"],
            ecosystem.resources["water"],
            ecosystem.resources["nutrients"]
        ]
    
    # Update population
    var pop_label = ui.get_node("UI/VBoxContainer/PopulationLabel")
    if pop_label:
        pop_label.text = "👥 Population: %d | 🔄 Turn: %d/%d" % [
            ecosystem.get_total_population(),
            current_turn,
            level_manager.current_level.max_turns
        ]

func _on_pause_pressed():
    print("⏸️ Game Paused")
    game_running = not game_running

func _on_menu_pressed():
    print("📋 Back to Menu")
    get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_help_pressed():
    print("❓ Help")
    # TODO: Show help dialog

func show_game_over(reason: String):
    print("💀 Game Over: " + reason)
    # TODO: Show game over screen
    await get_tree().create_timer(3.0).timeout
    get_tree().change_scene_to_file("res://scenes/level_select.tscn")

func show_level_complete():
    var total_pop = ecosystem.get_total_population()
    var stars = level_manager.calculate_stars(total_pop, current_turn)
    print("🎉 Level Complete! Stars: %d" % stars)
    # TODO: Show completion screen
    await get_tree().create_timer(3.0).timeout
    get_tree().change_scene_to_file("res://scenes/level_select.tscn")
