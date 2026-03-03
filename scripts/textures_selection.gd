# textures_selection
extends Control

@onready var slider: HSlider = $"../HSlider"
@onready var container: HBoxContainer = $HBoxContainer

var x_size: float
var buttons: Array[Button] = []
var selected: Button
var texture_data: Dictionary[Button, String] = {}

func _ready() -> void:
	x_size = container.size.x
	slider.min_value = 0.0
	slider.max_value = x_size - size.x
	
	for button: Button in container.get_children():
		texture_data[button] = str(button).erase(str(button).length() - 27, 100) # 27 to remove unecessary digits from name
		if button.button_pressed == true:
			selected = button

	for button: Button in container.get_children():
		button.pressed.connect(_on_button_pressed.bind(button))

func _on_button_pressed(button: Button) -> void:
	if button == selected:
		button.button_pressed = true
	else:
		selected.button_pressed = false
		selected = button

func get_selected_texture() -> String:
	return texture_data[selected]

func _on_h_slider_value_changed(value: float) -> void:
	container.position.x = -value
