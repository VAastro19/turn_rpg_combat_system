# player_buttons.gd
extends Control

@onready var main_buttons: FlowContainer = $MainButtons
@onready var spells_buttons: FlowContainer = $SpellsButtons
@onready var abilities_buttons: FlowContainer = $AbilitiesButtons
@onready var items_buttons: FlowContainer = $ItemsButtons

func _ready() -> void:
	main_buttons.visible = true
	spells_buttons.visible = false
	abilities_buttons.visible = false
	items_buttons.visible = false

func _on_spells_button_pressed() -> void:
	main_buttons.visible = false
	spells_buttons.visible = true

func _on_abilities_button_pressed() -> void:
	main_buttons.visible = false
	abilities_buttons.visible = true

func _on_items_button_pressed() -> void:
	main_buttons.visible = false
	items_buttons.visible = true
