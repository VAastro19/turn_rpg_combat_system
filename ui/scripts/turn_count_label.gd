# turn_count_label.gd
extends Label

var current_turn: int = 1

func _ready() -> void:
	text = "Turn: \n" + str(current_turn)

func update(turn: int) -> void:
	current_turn = turn
	text = "Turn: \n" + str(turn)
	print("\nCurrent turn: " + str(current_turn))
