# Level Select Script
# Handles level selection and biome navigation

extends Control

func _ready():
    print("🎯 Level Select Loaded")

func _on_level_pressed(level_name: String) -> void:
    print("▶️ " + level_name + " Selected")
    
    match level_name:
        "Level1":
            GameManager.current_level = 1
        "Level2":
            GameManager.current_level = 2
        "Level3":
            GameManager.current_level = 3
    
    get_tree().change_scene_to_file("res://scenes/game_level.tscn")

func _on_back_pressed() -> void:
    print("🔙 Back to Menu")
    get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
