# EcoChain - UI Manager
# Handles all user interface elements and interactions

extends CanvasLayer

class_name UIManager

# UI References
@onready var main_menu_panel = preload("res://scenes/main_menu.tscn")

# UI State
var current_screen: String = "menu"  # menu, level_select, game, settings
var is_paused: bool = false

func _ready():
    print("🎨 UI Manager Initialized")

# Show main menu
func show_main_menu() -> void:
    current_screen = "menu"
    print("📍 Showing Main Menu")
    # TODO: Load and show main menu scene

# Show level selection
func show_level_select() -> void:
    current_screen = "level_select"
    print("📍 Showing Level Select")
    # TODO: Load and show level select scene

# Show game HUD
func show_game_hud() -> void:
    current_screen = "game"
    print("📍 Showing Game HUD")
    # TODO: Show game UI elements

# Update HUD values
func update_resources(energy: int, water: int, nutrients: int) -> void:
    # TODO: Update resource display
    print("📊 Updated Resources: E=%d W=%d N=%d" % [energy, water, nutrients])

func update_population(population: int) -> void:
    # TODO: Update population display
    print("👥 Population: %d" % population)

func update_turn(turn: int) -> void:
    # TODO: Update turn counter
    print("🔄 Turn: %d" % turn)

# Pause game
func pause_game() -> void:
    is_paused = true
    get_tree().paused = true
    print("⏸️ Game Paused")

# Resume game
func resume_game() -> void:
    is_paused = false
    get_tree().paused = false
    print("▶️ Game Resumed")

# Show message dialog
func show_message(title: String, message: String) -> void:
    print("💬 Message: %s - %s" % [title, message])
    # TODO: Show message dialog

# Show level complete screen
func show_level_complete(stars: int, score: int) -> void:
    print("🎉 Level Complete! Stars: %d, Score: %d" % [stars, score])
    # TODO: Show completion screen

# Show game over screen
func show_game_over(reason: String) -> void:
    print("💀 Game Over: %s" % reason)
    # TODO: Show game over screen

# Button callbacks
func _on_play_pressed() -> void:
    print("▶️ Play button pressed")
    GameManager.goto_scene("res://scenes/level_select.tscn")

func _on_sandbox_pressed() -> void:
    print("🎨 Sandbox button pressed")
    # TODO: Load sandbox mode

func _on_settings_pressed() -> void:
    print("⚙️ Settings button pressed")
    # TODO: Show settings screen

func _on_quit_pressed() -> void:
    print("👋 Quit button pressed")
    get_tree().quit()
