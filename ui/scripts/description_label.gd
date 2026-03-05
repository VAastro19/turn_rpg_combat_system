# description_label.gd
extends RichTextLabel

var last_message: String

func _ready() -> void:
	text = "[b]The battle begins![/b]"
	last_message = text

func update(message: String, damage_dealt: int) -> void:
	if damage_dealt > 0:
		message = message + str(damage_dealt) + " damage!"
	last_message = message
	text = message
	print(message)
