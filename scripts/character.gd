# character.gd
extends Node2D

@export var facing_left: bool = false
@export var max_health: float = 100
@export var health: float = 80
@export var max_stamina: float = 40
@export var stamina: float = 30

@onready var sprite: Sprite2D = $Sprite2D
@onready var health_bar: ProgressBar = $HealthBar
@onready var stamina_bar: ProgressBar = $StaminaBar

var stamina_bar_offset: float = 324

func _ready() -> void:
	if facing_left:
		sprite.flip_h = true
		stamina_bar.position.x = stamina_bar_offset
