# combat_action.gd
@tool extends Resource
class_name CombatAction

@export_category("Basic Info")
@export var display_name: String ## Name of the action displayed on UI elements
@export var description: String ## Description of how this action works displayed for the player
@export var message: String ## Message shown in game after casting this action
@export var base_weight: float = 100 ## Probability weight used by AI to calculate which action to cast
@export var type := Enums.CombatActionType.MAIN: ## Type of this action: MAIN, SPELL, ABILITY, ITEM
	set(value):
		type = value
		notify_property_list_changed()

@export_group("Melee Properties")
@export var melee_subtype := Enums.CombatActionMelee.NONE

@export_group("Spell Properties")
@export var spell_subtype := Enums.CombatActionSpells.NONE

@export_group("Ability Properties")
@export var ability_subtype := Enums.CombatActionAbilities.NONE

@export_group("Item Properties")
@export var item_subtype := Enums.CombatActionItems.NONE
@export var item_count: int = 0

@export_group("Main Properties")
@export var min_dmg: int = 0 ## Minimum amount of damage this action can deal
@export var max_dmg: int = 0 ## Maximum amount of damage this action can deal
@export var heal_amount: int = 0 ## Amount of health that this action restores
@export var stamina_cost: int = 0 ## Cost in stamina for performing this action
@export var mana_cost: int = 0 ## Cost in mana for performing this action

func _validate_property(property: Dictionary):
	if property.name in ["melee_subtype"] and type != Enums.CombatActionType.MAIN:
		property.usage = PROPERTY_USAGE_NO_EDITOR
	if property.name in ["spell_subtype"] and type != Enums.CombatActionType.SPELL:
		property.usage = PROPERTY_USAGE_NO_EDITOR
	if property.name in ["ability_subtype"] and type != Enums.CombatActionType.ABILITY:
		property.usage = PROPERTY_USAGE_NO_EDITOR
	if property.name in ["item_subtype", "item_count"] and type != Enums.CombatActionType.ITEM:
		property.usage = PROPERTY_USAGE_NO_EDITOR
