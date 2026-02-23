# combat system_music.gd
extends AudioStreamPlayer

var battle_music: AudioStream = preload("res://assets/audio/music/battle_theme.mp3")
var victory_music: AudioStream = preload("res://assets/audio/music/victory_music.mp3")
var defeat_music: AudioStream = preload("res://assets/audio/music/defeat_music.mp3")

@onready var parent: Node2D = get_parent()

func _ready() -> void:
	parent.OnVictory.connect(_play_victory_music)
	parent.OnDefeat.connect(_play_defeat_music)
	
	_play_battle_music()

func _play_victory_music() -> void:
	volume_db = 10.0
	_play_audio(victory_music)

func _play_defeat_music() -> void:
	volume_db = 10.0
	_play_audio(defeat_music)

func _play_battle_music() -> void:
	volume_db = -10.0
	_play_audio(battle_music)

func _play_audio(audio: AudioStream) -> void:
	if has_stream_playback():
		stop()
	stream = audio
	play()

func _on_finished() -> void:
	_play_battle_music()
