# attribute_bar.gd
extends ProgressBar

@onready var bar_label: Label = $BarLabel
@onready var parent: Character = get_parent()

func _ready() -> void:
	min_value = 0.0

func update(attribute: int) -> void:
	value = attribute
	bar_label.text = str(int(value)) + " / " + str(int(max_value))
