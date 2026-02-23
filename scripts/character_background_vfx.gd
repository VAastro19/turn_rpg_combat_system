# character_background.gd
extends Control

@onready var background: TextureRect = $Background
@onready var landscape_close: TextureRect = $LandscapeClose
@onready var landscape_far: TextureRect = $LandscapeFar
@onready var frame: TextureRect = $Frame

var move_speed: float = 3
var move_limit: float = 20.0
var initial_close_pos: Vector2
var initial_far_pos: Vector2
var random_speed_offset: float

func _ready() -> void:
	initial_close_pos = landscape_close.position
	initial_far_pos = landscape_far.position
	random_speed_offset = randf_range(-move_speed / 5, move_speed / 5)

func _process(_delta: float) -> void:
	var time = Time.get_unix_time_from_system()
	
	landscape_close.position.x = initial_close_pos.x + sin(time * move_speed + random_speed_offset) * move_limit
	landscape_far.position.x = initial_far_pos.x + sin(time * move_speed + random_speed_offset) * move_limit / 5
