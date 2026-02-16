# combat_action.gd
extends Resource
class_name CombatAction

@export var display_name: String
@export var description: String

@export var damage: int = 0
@export var heal_amount: int = 0
@export var stamina_cost: int = 0
@export var stamina_regain: int = 0
@export var mana_cost: int = 0
@export var mana_regain: int = 0

@export var base_weight: float = 100
