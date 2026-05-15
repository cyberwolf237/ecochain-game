# Level Select Manager
# Handles level selection and navigation

extends Control

func _ready():
	print("📋 Level Select Loaded - Buttons Connected")

# Handle level button press
func _on_level_pressed(level_name: String) -> void:
	print("🎮 Level button pressed: %s" % level_name)
	
	# Extract level number from button name (Level1 -> 0, Level2 -> 1, etc.)
	var level_number = int(level_name.trim_prefix("Level")) - 1
	
	print("✅ Loading Level %d" % (level_number + 1))
	get_tree().change_scene_to_file("res://scenes/game_level.tscn")

# Go back to main menu
func _on_back_pressed() -> void:
	print("🔙 Back to main menu")
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
