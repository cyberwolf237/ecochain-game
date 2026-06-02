# Level Select Script
# Handles level selection and biome navigation

extends Control

func _ready():
    print("📋 Level Select Loaded")
    setup_buttons()

func setup_buttons():
    # Connect Level 1 button
    var level1_btn = $VBoxContainer/ScrollContainer/VBoxContainer/RainforestBiome/VBoxContainer/HBoxContainer/Level1
    if level1_btn:
        level1_btn.pressed.connect(_on_level_1_pressed)
    
    # Connect Level 2 button
    var level2_btn = $VBoxContainer/ScrollContainer/VBoxContainer/RainforestBiome/VBoxContainer/HBoxContainer/Level2
    if level2_btn:
        level2_btn.pressed.connect(_on_level_2_pressed)
    
    # Connect Level 3 button
    var level3_btn = $VBoxContainer/ScrollContainer/VBoxContainer/RainforestBiome/VBoxContainer/HBoxContainer/Level3
    if level3_btn:
        level3_btn.pressed.connect(_on_level_3_pressed)
    
    # Connect Back button
    var back_btn = $VBoxContainer/BackButton
    if back_btn:
        back_btn.pressed.connect(_on_back_pressed)

func _on_level_1_pressed() -> void:
    print("▶️ Level 1 Selected")
    GameManager.current_level = 1
    get_tree().change_scene_to_file("res://scenes/game_level.tscn")

func _on_level_2_pressed() -> void:
    print("▶️ Level 2 Selected")
    GameManager.current_level = 2
    get_tree().change_scene_to_file("res://scenes/game_level.tscn")

func _on_level_3_pressed() -> void:
    print("▶️ Level 3 Selected")
    GameManager.current_level = 3
    get_tree().change_scene_to_file("res://scenes/game_level.tscn")

func _on_back_pressed() -> void:
    print("🔙 Back to Menu")
    get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
