# flee_popup.gd
extends Panel

@onready var combat_system_manager: Node2D = get_parent().get_parent()
@onready var main_buttons: FlowContainer = $"../PlayerButtons/MainButtons"

func _ready() -> void:
	visible = false

func _on_yes_button_pressed() -> void:
	combat_system_manager.OnDefeat.emit()
	combat_system_manager.show_end_screen("fled")

func _on_no_button_pressed() -> void:
	visible = false
	main_buttons.visible = true
