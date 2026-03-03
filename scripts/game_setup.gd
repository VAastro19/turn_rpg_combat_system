# game_setup.gd
extends Control

signal OnSendPlayerData(player_data: Dictionary)
signal OnAISendData(ai_data: Dictionary)

@onready var player_setup: Control = $PlayerSetup
@onready var ai_setup: Control = $AISetup

func _on_begin_button_pressed() -> void:
	OnAISendData.emit(ai_setup.get_ai_data())
	OnSendPlayerData.emit(player_setup.get_player_data())
	get_tree().change_scene_to_file("res://scenes/combat_system.tscn")

func _on_save_button_pressed() -> void:
	OnAISendData.emit(ai_setup.get_ai_data())
	OnSendPlayerData.emit(player_setup.get_player_data())

func _on_back_button_pressed() -> void:
	pass # Replace with function body.
