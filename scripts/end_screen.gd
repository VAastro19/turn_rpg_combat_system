# end_screen.gd
extends Panel

@onready var result_label: Label = $ResultLabel
@onready var quote_label: RichTextLabel = $QuoteLabel
@onready var loot_label: RichTextLabel = $LootLabel

func set_result_label(victor: String) -> void:
	if victor == "ai":
		result_label.text = "You have been defeated..."
		quote_label.text = "[font_size=20][i],,Every failure is an opportunity to learn.\"[/i]"
		loot_label.text = "[font_size=18][p align=center]+0 EXP,		+0 GOLD"
	else:
		result_label.text = "You have conquered your foe!"
		quote_label.text = "[center][font_size=20][i],,With great power comes great responsibility.\"[/i]"
		loot_label.text = "[font_size=18][p align=center]+20 EXP,		+15 GOLD"

func _on_continue_button_pressed() -> void:
	get_tree().quit()
