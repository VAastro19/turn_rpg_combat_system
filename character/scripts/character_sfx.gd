# character_sfx.gd
extends AudioStreamPlayer

var take_damage_sfx_1: AudioStream = preload("res://assets/audio/sfx/hurt1.mp3")
var take_damage_sfx_2: AudioStream = preload("res://assets/audio/sfx/hurt2.mp3")
var unsuccessful_sfx: AudioStream = preload("res://assets/audio/sfx/unsuccessful.mp3")

@onready var parent: Character = get_parent()

func _ready() -> void:
	parent.OnTakeDamage.connect(_play_take_damage_sfx)
	parent.OnNotEnough.connect(_play_not_enough_sfx)
	parent.OnAlreadyFull.connect(_play_already_full_sfx)
	parent.OnNoneLeft.connect(_play_none_left_sfx)
	
	parent.OnHeal.connect(_play_heal_sfx)
	parent.OnRest.connect(_play_rest_sfx)
	parent.OnFocus.connect(_play_focus_energy_sfx)
	parent.OnLightning.connect(_play_lightning_sfx)
	parent.OnHealthPotion.connect(_play_drink_potion_sfx)
	parent.OnStaminaPotion.connect(_play_drink_potion_sfx)
	parent.OnManaPotion.connect(_play_drink_potion_sfx)

func _play_take_damage_sfx(_health: int) -> void:
	volume_db = 0
	var take_damage_sfx: AudioStream = [take_damage_sfx_1, take_damage_sfx_2].pick_random()
	_play_audio(take_damage_sfx)

func _play_not_enough_sfx(_attribute) -> void:
	volume_db = 5.0
	_play_audio(unsuccessful_sfx)

func _play_already_full_sfx(_attribute) -> void:
	volume_db = 5.0
	_play_audio(unsuccessful_sfx)

func _play_none_left_sfx(_item) -> void:
	volume_db = 5.0
	_play_audio(unsuccessful_sfx)

var focus_sfx: AudioStream = preload("res://assets/audio/sfx/focus_energy.mp3")
func _play_focus_energy_sfx(_mana: int) -> void:
	volume_db = 5
	_play_audio(focus_sfx)

var rest_sfx: AudioStream = preload("res://assets/audio/sfx/rest.wav")
func _play_rest_sfx(_stamina: int) -> void:
	volume_db = -15
	_play_audio(rest_sfx)

var heal_sfx: AudioStream = preload("res://assets/audio/sfx/heal.mp3")
func _play_heal_sfx(_health: int) -> void:
	volume_db = -10
	_play_audio(heal_sfx)

var lightning_sfx: AudioStream = preload("res://assets/audio/sfx/lightning.mp3")
func _play_lightning_sfx() -> void:
	volume_db = 0.0
	_play_audio(lightning_sfx)

var potion_sfx: AudioStream = preload("res://assets/audio/sfx/drink_potion_sfx.mp3")
func _play_drink_potion_sfx(_attribute: int) -> void:
	volume_db = 5.0
	_play_audio(potion_sfx)

func _play_audio(audio: AudioStream) -> void:
	if has_stream_playback():
		stop()
	stream = audio
	play()
