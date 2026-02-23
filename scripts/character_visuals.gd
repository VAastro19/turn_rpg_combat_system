# character_visuals.gd
extends Sprite2D

@onready var parent: Character = get_parent()

@export var max_shake_intensity: float = 5.0
@export var shake_damping: float = 10.0
var shake_intensity: float = 0.0

@export var bob_amplitude: float = 0.05
@export var bob_frequency: float = 7.0
var bob_offset: float

var initial_y_scale: float
var initial_offset: Vector2
var sprite_size: float = 192

func _ready() -> void:
	parent.OnTakeDamage.connect(_take_damage_visual)
	parent.OnHeal.connect(_heal_visual)
	parent.OnFocus.connect(_focus_visual)
	parent.OnRest.connect(_rest_visual)
	bob_offset = randf_range(1.0, 5.0)

func setup_texture() -> void:
	scale.x = sprite_size / texture.get_width()
	scale.y = sprite_size / texture.get_height()
	offset.y = - texture.get_height() / 2.0
	initial_y_scale = scale.y
	initial_offset = offset

func _process(delta: float) -> void:
	_bob()
	
	if shake_intensity > 0:
		shake_intensity = lerpf(shake_intensity, 0.0, shake_damping * delta)
		offset = initial_offset + _get_random_offset()

func _bob() -> void:
	var time = Time.get_unix_time_from_system()
	var y_scale = initial_y_scale + (sin(time * bob_frequency + bob_offset) * bob_amplitude)
	scale.y = y_scale

func _take_damage_visual(_health: int) -> void:
	modulate = Color.RED
	shake_intensity = max_shake_intensity
	await get_tree().create_timer(0.05).timeout
	modulate = Color.WHITE

func _heal_visual(_health: int) -> void:
	modulate = Color.GREEN
	shake_intensity = max_shake_intensity / 5
	await get_tree().create_timer(0.05).timeout
	modulate = Color.WHITE

func _rest_visual(_stamina: int) -> void:
	modulate = Color.LIME_GREEN
	await get_tree().create_timer(0.15).timeout
	modulate = Color.WHITE

func _focus_visual(_mana: int) -> void:
	modulate = Color.BLUE
	await get_tree().create_timer(0.15).timeout
	modulate = Color.WHITE

func _get_random_offset() -> Vector2:
	var y: float = randf_range(-shake_intensity, shake_intensity)
	var x: float = randf_range(-shake_intensity, shake_intensity)
	return Vector2(x,y)
