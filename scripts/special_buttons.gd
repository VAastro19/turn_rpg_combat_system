# special_buttons.gd
extends FlowContainer

@onready var back_button: Button = $BackButton
@onready var main_buttons: FlowContainer = $"../MainButtons"

func _ready() -> void:
	back_button.pressed.connect(_on_back_button_pressed)

func _on_back_button_pressed() -> void:
	visible = false
	main_buttons.visible = true
