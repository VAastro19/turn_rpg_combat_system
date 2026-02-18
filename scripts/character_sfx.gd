# character_sfx.gd
extends AudioStreamPlayer

var heal_sfx: AudioStream = preload("res://assets/audio/sfx/battle/heal.wav")
var take_damage_sfx: AudioStream = preload("res://assets/audio/sfx/misc/random5.wav")

@onready var parent: Character = get_parent()

func _ready() -> void:
	parent.OnHeal.connect(_play_heal_sfx)
	parent.OnTakeDamage.connect(_play_take_damage_sfx)

func _play_heal_sfx(_health: int) -> void:
	_play_audio(heal_sfx)

func _play_take_damage_sfx(_health: int) -> void:
	_play_audio(take_damage_sfx)

func _play_audio(audio: AudioStream) -> void:
	stream = audio
	play()
