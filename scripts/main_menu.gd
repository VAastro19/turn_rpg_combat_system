# main_menu.gd
extends Control

@onready var setup_screen: Control = $SetupScreen

func save_data() -> void:
	var saved_data: SavedData = SavedData.new()
	
	saved_data.ai_data = setup_screen.ai_data
	saved_data.player_data = setup_screen.player_data
	ResourceSaver.save(saved_data, "res://saved_data/game_data.tres")

func _on_begin_button_pressed() -> void:
	save_data()
	get_tree().change_scene_to_file("res://scenes/combat_system.tscn")

func _on_setup_button_pressed() -> void:
	setup_screen.visible = true

func _on_quit_button_pressed() -> void:
	get_tree().quit()
