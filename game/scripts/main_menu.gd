# Main Menu Script
# Handles button clicks and navigation

extends Control

func _ready():
    print("🎮 Main Menu Loaded")

func _on_play_pressed() -> void:
    print("▶️ Play button pressed")
    get_tree().change_scene_to_file("res://scenes/level_select.tscn")

func _on_sandbox_pressed() -> void:
    print("🎨 Sandbox button pressed")
    # TODO: Load sandbox mode
    pass

func _on_settings_pressed() -> void:
    print("⚙️ Settings button pressed")
    # TODO: Load settings screen
    pass

func _on_quit_pressed() -> void:
    print("👋 Quit button pressed")
    get_tree().quit()
