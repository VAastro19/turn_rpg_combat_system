# main_menu.gd
extends Control

@onready var setup_screen: Control = $SetupScreen
@onready var left_sprite: TextureRect = $KnightTexture
@onready var right_sprite: TextureRect = $SkeletonTexture

@export var bob_amplitude: float = 0.01
@export var bob_frequency: float = 7.0
var bob_offset: float

var initial_y_scale: float =  1.0

func _process(_delta: float) -> void:
	_bob()

func _bob() -> void:
	var time = Time.get_unix_time_from_system()
	var y_scale: float
	
	bob_offset = randf_range(0.1, 0.5)
	y_scale = initial_y_scale + (sin(time * bob_frequency + bob_offset) * bob_amplitude)
	left_sprite.scale.y = y_scale
	
	bob_offset = randf_range(0.1, 0.5)
	y_scale = initial_y_scale + (sin(time * bob_frequency + bob_offset) * bob_amplitude)
	right_sprite.scale.y = y_scale

func _on_begin_button_pressed() -> void:
	save_data()
	get_tree().change_scene_to_file("res://main/combat_system.tscn")

func _on_setup_button_pressed() -> void:
	setup_screen.visible = true

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func save_data() -> void:
	var saved_data: SavedData = SavedData.new()
	
	saved_data.ai_data = setup_screen.ai_data
	saved_data.player_data = setup_screen.player_data
	ResourceSaver.save(saved_data, "res://saved_data/game_data.tres")
