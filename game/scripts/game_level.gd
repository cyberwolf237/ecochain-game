# Game Level Script - COMPLETE WORKING VERSION
# Handles all gameplay

extends Node2D

var current_turn: int = 0
var max_turns: int = 20
var game_running: bool = true
var game_paused: bool = false

# Populations
var grass_count: int = 5
var rabbit_count: int = 3
var fox_count: int = 1

# Resources
var energy: int = 100
var water: int = 100
var nutrients: int = 100

func _ready():
	print("🎮 Game Level Started!")
	setup_buttons()
	start_game()

func setup_buttons():
	$CanvasLayer/UI/VBoxContainer/Buttons/PauseButton.pressed.connect(_on_pause_pressed)
	$CanvasLayer/UI/VBoxContainer/Buttons/RestartButton.pressed.connect(_on_restart_pressed)
	$CanvasLayer/UI/VBoxContainer/Buttons/MenuButton.pressed.connect(_on_menu_pressed)

func start_game():
	# Start game loop
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 2.0
	timer.timeout.connect(_on_turn)
	timer.start()

func _on_turn():
	if not game_running or game_paused:
		return
	
	current_turn += 1
	print("=== TURN %d ===" % current_turn)
	
	# Simulate ecosystem
	simulate_ecosystem()
	
	# Update UI
	update_ui()
	
	# Check win/lose
	check_conditions()

func simulate_ecosystem():
	# Grass grows
	grass_count += randi_range(1, 3)
	
	# Rabbits eat grass and reproduce
	if grass_count > 5:
		rabbit_count += 1
		grass_count -= 2
	else:
		rabbit_count -= 1 if rabbit_count > 0 else 0
	
	# Foxes hunt rabbits
	if rabbit_count > 5:
		fox_count += 1
		rabbit_count -= 2
	else:
		fox_count -= 1 if fox_count > 0 else 0
	
	# Resources naturally decrease
	energy = max(0, energy - 5)
	water = max(0, water - 3)
	nutrients = max(0, nutrients - 2)
	
	# Resources regenerate if populations are healthy
	if grass_count > 10:
		nutrients += 10
	if rabbit_count > 0:
		energy += 5
	if fox_count > 0:
		energy += 10
	
	# Cap resources
	energy = min(energy, 200)
	water = min(water, 200)
	nutrients = min(nutrients, 200)
	
	print("🌿 Grass: %d | 🐰 Rabbits: %d | 🦊 Foxes: %d" % [grass_count, rabbit_count, fox_count])
	print("🔋 Energy: %d | 💧 Water: %d | 🌱 Nutrients: %d" % [energy, water, nutrients])

func update_ui():
	$CanvasLayer/UI/VBoxContainer/Info/ResourcesLabel.text = "🔋 Energy: %d | 💧 Water: %d | 🌱 Nutrients: %d" % [energy, water, nutrients]
	$CanvasLayer/UI/VBoxContainer/Info/PopulationLabel.text = "🌿 Grass: %d | 🐰 Rabbits: %d | 🦊 Foxes: %d" % [grass_count, rabbit_count, fox_count]
	
	var status = "⏸️ Paused" if game_paused else "▶️ Running"
	$CanvasLayer/UI/VBoxContainer/Info/TurnLabel.text = "🔄 Turn: %d/%d | ⏱️ Status: %s" % [current_turn, max_turns, status]

func check_conditions():
	# Lose condition: everything dead
	if grass_count == 0 and rabbit_count == 0 and fox_count == 0:
		print("❌ GAME OVER - Ecosystem Collapsed!")
		game_running = false
		await get_tree().create_timer(2.0).timeout
		show_game_over("ECOSYSTEM COLLAPSED!\nAll life forms extinct.")
	
	# Win condition: balanced ecosystem
	if current_turn >= 10 and grass_count > 8 and rabbit_count > 2 and fox_count > 0:
		print("✅ LEVEL COMPLETE - Balanced Ecosystem!")
		game_running = false
		show_level_complete()
	
	# Max turns reached
	if current_turn >= max_turns:
		print("⏰ TIME'S UP!")
		game_running = false
		var outcome = "Success! Ecosystem survived!" if (grass_count + rabbit_count + fox_count) > 5 else "Failed! Ecosystem too weak."
		show_game_over(outcome)

func show_game_over(message: String):
	print("📊 " + message)
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")

func show_level_complete():
	print("🎉 VICTORY!")
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")

func _on_pause_pressed():
	game_paused = not game_paused
	print("⏸️ Game " + ("PAUSED" if game_paused else "RESUMED"))
	update_ui()

func _on_restart_pressed():
	print("🔄 Restarting...")
	get_tree().reload_current_scene()

func _on_menu_pressed():
	print("📋 Back to Menu")
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
