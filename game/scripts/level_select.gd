# Level Select Manager
# Handles level selection and navigation

extends Control

@onready var level_manager = preload("res://scripts/level_manager.gd").new()
@onready var game_manager = preload("res://scripts/game_manager.gd").new()

func _ready():
	print("📋 Level Select Loaded")
	add_child(level_manager)
	
	# Connect all level buttons
	var level_buttons = get_all_level_buttons()
	for button in level_buttons:
		if button.name.begins_with("Level"):
			button.pressed.connect(_on_level_button_pressed.bind(button))
	
	# Connect back button
	if has_node("VBoxContainer/BackButton"):
		$VBoxContainer/BackButton.pressed.connect(_on_back_pressed)

# Get all level buttons from the scene
func get_all_level_buttons() -> Array:
	var buttons = []
	var scroll_container = $VBoxContainer/ScrollContainer/VBoxContainer
	
	if scroll_container:
		for biome in scroll_container.get_children():
			if biome is PanelContainer:
				var vbox = biome.get_node("VBoxContainer/HBoxContainer")
				if vbox:
					for button in vbox.get_children():
						if button is Button:
							buttons.append(button)
	
	return buttons

# Handle level button press
func _on_level_button_pressed(button: Button) -> void:
	var button_name = button.name
	print("🎮 Level button pressed: %s" % button_name)
	
	# Extract level number from button name (Level1, Level2, etc.)
	var level_number = int(button_name.trim_prefix("Level")) - 1
	
	# Load the level
	if level_manager.load_level(level_number):
		print("✅ Level %d loaded successfully" % (level_number + 1))
		# Load the game level scene
		get_tree().change_scene_to_file("res://scenes/game_level.tscn")
	else:
		print("❌ Failed to load level %d" % (level_number + 1))

# Go back to main menu
func _on_back_pressed() -> void:
	print("🔙 Back to main menu")
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
