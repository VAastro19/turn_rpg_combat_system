# button_sfx.gd
extends AudioStreamPlayer

var hover_sfx: AudioStream = preload("res://assets/audio/sfx/button_hover.mp3")
var click_sfx: AudioStream = preload("res://assets/audio/sfx/button_click.mp3")

@onready var parent: BaseButton = get_parent()

func _ready() -> void:
	parent.pressed.connect(_play_pressed_sfx)
	parent.mouse_entered.connect(_play_hover_sfx)

func _play_pressed_sfx() -> void:
	volume_db = 5.0
	_play_audio(click_sfx)

func _play_hover_sfx() -> void:
	volume_db = 0.0
	_play_audio(hover_sfx)

func _play_audio(audio: AudioStream) -> void:
	stream = audio
	play()
