# player_buttons.gd
extends Control

@onready var game_manager: Node2D = get_parent().get_parent()
@onready var description_label: RichTextLabel = $"../Description/Label"

@onready var main_buttons_container: FlowContainer = $MainButtons
@onready var spells_buttons_container: FlowContainer = $SpellsButtons
@onready var abilities_buttons_container: FlowContainer = $AbilitiesButtons
@onready var items_buttons_container: FlowContainer = $ItemsButtons

var main_buttons: Array[CombatActionButton] = []
var spells_buttons: Array[CombatActionButton] = []
var abilities_buttons: Array[CombatActionButton] = []
var items_buttons: Array[CombatActionButton] = []

func _ready() -> void:
	main_buttons_container.visible = true
	spells_buttons_container.visible = false
	abilities_buttons_container.visible = false
	items_buttons_container.visible = false
	
	_fill_buttons_array(main_buttons_container, main_buttons)
	_fill_buttons_array(spells_buttons_container, spells_buttons)
	_fill_buttons_array(abilities_buttons_container, abilities_buttons)
	_fill_buttons_array(items_buttons_container, items_buttons)
	
	_bind_buttons_signals(main_buttons)
	_bind_buttons_signals(spells_buttons)
	_bind_buttons_signals(abilities_buttons)
	_bind_buttons_signals(items_buttons)

func _fill_buttons_array(container, array: Array[CombatActionButton]) -> void:
	for child in container.get_children():
		if child is CombatActionButton:
			array.append(child)
		else:
			if child.get_child_count() > 0:
				_fill_buttons_array(child, array)

func _bind_buttons_signals(array: Array[CombatActionButton]) -> void:
	for button in array:
		if button is not CombatActionButton:
			continue
		button.pressed.connect(_button_pressed.bind(button))
		button.mouse_entered.connect(_button_entered.bind(button))
		button.mouse_exited.connect(_button_exited.bind(button))

func manage_combat_actions(actions: Array[CombatAction]) -> void:
	var main_actions: Array[CombatAction] = []
	var spells_actions: Array[CombatAction] = []
	var abilities_actions: Array[CombatAction] = []
	var items_actions: Array[CombatAction] = []
	
	for action in actions:
		match action.type:
			Enums.CombatActionType.MAIN:
				main_actions.append(action)
			Enums.CombatActionType.SPELL:
				spells_actions.append(action)
			Enums.CombatActionType.ABILITY:
				abilities_actions.append(action)
			Enums.CombatActionType.ITEM:
				items_actions.append(action)
			_:
				continue
	
	_set_combat_actions(main_buttons, main_actions)
	_set_combat_actions(spells_buttons, spells_actions)
	_set_combat_actions(abilities_buttons, abilities_actions)
	_set_combat_actions(items_buttons, items_actions)
	
func _set_combat_actions(array: Array[CombatActionButton], actions: Array[CombatAction]) -> void:
	for i in len(array):
		if i >= len(actions):
			array[i].visible = false
			continue
		array[i].visible = true
		array[i].set_combat_action(actions[i])

func _button_pressed(button: CombatActionButton) -> void:
	game_manager.player_cast_combat_action(button.combat_action)

func _button_entered(button: CombatActionButton) -> void:
	description_label.text = "[b]" + button.combat_action.display_name + "[/b]\n" + button.combat_action.description

func _button_exited(_button: CombatActionButton) -> void:
	description_label.text = description_label.last_message

func _on_spells_button_pressed() -> void:
	main_buttons_container.visible = false
	spells_buttons_container.visible = true

func _on_abilities_button_pressed() -> void:
	main_buttons_container.visible = false
	abilities_buttons_container.visible = true

func _on_items_button_pressed() -> void:
	main_buttons_container.visible = false
	items_buttons_container.visible = true
