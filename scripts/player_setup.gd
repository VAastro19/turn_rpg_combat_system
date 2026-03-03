# player_setup.gd
extends Control

@onready var select_spells_button: Button = $CapabilitiesVBoxContainer/SelectSpellsButton
@onready var select_abilities_button: Button = $CapabilitiesVBoxContainer/SelectAbilitiesButton
@onready var select_items_button: Button = $CapabilitiesVBoxContainer/SelectItemsButton
@onready var player_spells_list: ItemList = $"../PlayerSpellsList"
@onready var player_abilities_list: ItemList = $"../PlayerAbilitiesList"
@onready var player_items_list: ItemList = $"../PlayerItemsList"
@onready var ai_spells_list: ItemList = $"../AISpellsList"
@onready var ai_abilities_list: ItemList = $"../AIAbilitiesList"
@onready var ai_items_list: ItemList = $"../AIItemsList"

@onready var texture_selection: Control = $SelectableTextures
@onready var health_input: SpinBox = $StatsVBoxContainer/AttributeContainer/HealthInput
@onready var stamina_input: SpinBox = $StatsVBoxContainer/AttributeContainer/StaminaInput
@onready var mana_input: SpinBox = $StatsVBoxContainer/AttributeContainer/ManaInput
@onready var attack_input: SpinBox = $StatsVBoxContainer/SkillContainer/AttackInput
@onready var defense_input: SpinBox = $StatsVBoxContainer/SkillContainer/DefenseInput
@onready var spell_power_input: SpinBox = $StatsVBoxContainer/SkillContainer/SpellPowerInput
@onready var magic_res_input: SpinBox = $StatsVBoxContainer/SkillContainer/MagicResInput

var player_data: Dictionary

func _ready() -> void:
	$PlayerNameInput.grab_focus()
	get_player_data()

func get_player_data() -> Dictionary:
	player_data["Name"] = $PlayerNameInput.text
	player_data["Texture"] = texture_selection.get_selected_texture()
	player_data["IsPlayer"] = true
	player_data["MaxHealth"] = health_input.value
	player_data["Health"] = health_input.value
	player_data["MaxStamina"] = stamina_input.value
	player_data["Stamina"] = stamina_input.value
	player_data["MaxMana"] = mana_input.value
	player_data["Mana"] = mana_input.value
	player_data["Attack"] = health_input.value
	player_data["Defense"] = health_input.value
	player_data["SpellPower"] = health_input.value
	player_data["MagicRes"] = health_input.value
	player_data["CombatActions"] = _get_combat_actions_array()
	player_data["Loot"] = "50 GOLD"
	player_data["Experience"] = 50
	player_data["Level"] = 3
	
	return player_data

func _get_combat_actions_array() -> Array[CombatAction]:
	var ca_array: Array[CombatAction] = []
	var spells = _get_selected_items_from_list(ai_spells_list)
	var abilities = _get_selected_items_from_list(ai_abilities_list)
	var items = _get_selected_items_from_list(ai_items_list)
	
	ca_array.append_array(spells)
	ca_array.append_array(abilities)
	ca_array.append_array(items)
	
	return ca_array

func _get_selected_items_from_list(list: ItemList) -> Array[CombatAction]:
	var arr: Array[CombatAction] = []
	for idx in list.get_selected_items():
		var action_name = list.get_item_text(idx).to_snake_case()
		var action = _load_combat_action_from_string(action_name)
		arr.append(action)
	return arr

func _load_combat_action_from_string(action_name: String) -> CombatAction:
	return load("res://combat_actions/" + action_name + ".tres")

func _on_select_spells_button_pressed() -> void:
	player_abilities_list.visible = false
	player_items_list.visible = false
	ai_spells_list.visible = false
	ai_abilities_list.visible = false
	ai_items_list.visible = false
	
	if player_spells_list.visible == true:
		player_spells_list.visible = false
	else:
		player_spells_list.visible = true

func _on_select_abilities_button_pressed() -> void:
	player_spells_list.visible = false
	player_items_list.visible = false
	ai_spells_list.visible = false
	ai_abilities_list.visible = false
	ai_items_list.visible = false
	
	if player_abilities_list.visible == true:
		player_abilities_list.visible = false
	else:
		player_abilities_list.visible = true

func _on_select_items_button_pressed() -> void:
	player_abilities_list.visible = false
	player_spells_list.visible = false
	ai_spells_list.visible = false
	ai_abilities_list.visible = false
	ai_items_list.visible = false
	
	if player_items_list.visible == true:
		player_items_list.visible = false
	else:
		player_items_list.visible = true
