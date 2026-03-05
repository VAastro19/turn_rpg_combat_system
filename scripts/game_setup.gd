# game_setup.gd
extends Control

@onready var player_setup: Control = $PlayerSetup
@onready var ai_setup: Control = $AISetup

var ai_data: Dictionary
var player_data: Dictionary

func update_data() -> void:
	ai_data = ai_setup.get_character_data()
	player_data = player_setup.get_character_data()

func _ready() -> void:
	update_data()

func _on_begin_button_pressed() -> void:
	update_data()
	get_parent().save_data()
	get_tree().change_scene_to_file("res://scenes/combat_system.tscn")

func _on_save_button_pressed() -> void:
	update_data()

func _on_back_button_pressed() -> void:
	visible = false
