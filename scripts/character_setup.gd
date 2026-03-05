# character_setup.gd
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

@export var is_player_stats: bool = true

func _ready() -> void:
	if is_player_stats:
		$PlayerNameInput.grab_focus()
		player_spells_list.select(0)
		player_abilities_list.select(0)
		player_items_list.select(2)
	else:
		ai_spells_list.select(0)
		ai_abilities_list.select(0)
		ai_items_list.select(2)

func get_character_data() -> Dictionary:
	var character_data: Dictionary
	
	character_data["Name"] = _get_character_name() as String
	character_data["Texture"] = texture_selection.get_selected_texture() as Texture2D
	character_data["IsPlayer"] = _check_is_player() as bool
	character_data["MaxHealth"] = health_input.value as float
	character_data["Health"] = health_input.value as float
	character_data["MaxStamina"] = stamina_input.value as float
	character_data["Stamina"] = stamina_input.value as float
	character_data["MaxMana"] = mana_input.value as float
	character_data["Mana"] = mana_input.value as float
	character_data["Attack"] = attack_input.value as float
	character_data["Defense"] = defense_input.value as float
	character_data["SpellPower"] = spell_power_input.value as float
	character_data["MagicRes"] = magic_res_input.value as float
	character_data["CombatActions"] = _get_combat_actions_array() as Array[CombatAction]
	character_data["Loot"] = "50 GOLD" as String
	character_data["Experience"] = 50 as int
	character_data["Level"] = 3 as int
	
	return character_data

func _get_character_name() -> String:
	if is_player_stats:
		return $PlayerNameInput.text
	else:
		return texture_selection.get_name_from_selected_texture()

func _check_is_player() -> bool:
	if is_player_stats:
		return true
	else:
		return false

func _get_combat_actions_array() -> Array[CombatAction]:
	var attack_ca: CombatAction = load("res://combat_actions/attack.tres")
	var heavy_hit: CombatAction = load("res://combat_actions/heavy_attack.tres")
	var wait: CombatAction = load("res://combat_actions/wait.tres")
	
	var ca_array: Array[CombatAction] = [attack_ca, heavy_hit, wait]
	var spells: Array = []
	var abilities: Array = []
	var items: Array = []
	
	if is_player_stats:
		spells = _get_selected_items_from_list(player_spells_list)
		abilities = _get_selected_items_from_list(player_abilities_list)
		items = _get_selected_items_from_list(player_items_list)
	else:
		spells = _get_selected_items_from_list(ai_spells_list)
		abilities = _get_selected_items_from_list(ai_abilities_list)
		items = _get_selected_items_from_list(ai_items_list)
	
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

func _hide_all_lists() -> void:
	player_spells_list.visible = false
	player_abilities_list.visible = false
	player_items_list.visible = false
	ai_spells_list.visible = false
	ai_abilities_list.visible = false
	ai_items_list.visible = false

func _on_select_spells_button_pressed() -> void:
	_hide_all_lists()
	if is_player_stats:
		player_spells_list.visible = true
	else:
		ai_spells_list.visible = true

func _on_select_abilities_button_pressed() -> void:
	_hide_all_lists()
	if is_player_stats:
		player_abilities_list.visible = true
	else:
		ai_abilities_list.visible = true

func _on_select_items_button_pressed() -> void:
	_hide_all_lists()
	if is_player_stats:
		player_items_list.visible = true
	else:
		ai_items_list.visible = true
