# end_screen.gd
extends TextureRect

@onready var result_label: Label = $ResultLabel
@onready var quote_label: RichTextLabel = $QuoteLabel
@onready var loot_label: RichTextLabel = $LootLabel

func set_result_label(victor: String) -> void:
	if victor == "ai":
		flip_h = true
		result_label.text = "You have been defeated..."
		quote_label.text = "[font_size=20][i],,Every failure is an opportunity to learn.\"[/i]"
		loot_label.text = "[font_size=18][p align=center]+0 EXP,		+0 GOLD"
	elif victor == "player":
		flip_h = false
		result_label.text = "You have conquered your foe!"
		quote_label.text = "[center][font_size=20][i],,With great power comes great responsibility.\"[/i]"
		loot_label.text = "[font_size=18][p align=center]+20 EXP,		+15 GOLD"
	else:
		flip_h = true
		result_label.text = "You have fled..."
		quote_label.text = "[font_size=20][i],,A wise man knows when to back down.\"[/i]"
		loot_label.text = "[font_size=18][p align=center]+0 EXP,		+0 GOLD"

func _on_continue_button_pressed() -> void:
	get_tree().quit()
