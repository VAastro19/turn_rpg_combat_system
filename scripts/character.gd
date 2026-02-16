# character.gd
extends Node2D
class_name Character

signal OnTakeDamage(health: int)
signal OnHeal(health: int)

@export var character_name: String
@export var is_player: bool = false
@export var facing_left: bool = false

@export var max_health: int = 100
@export var health: int = 80
@export var max_stamina: int = 40
@export var stamina: int = 30
@export var max_mana: int = 40
@export var mana: int = 30

@export var combat_actions: Array[CombatAction]
@export var display_texture: Texture2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var health_bar: ProgressBar = $HealthBar
@onready var stamina_bar: ProgressBar = $StaminaBar
@onready var mana_bar: ProgressBar = $ManaBar
@onready var character_name_label: Label = $CharacterName/CharacterNameLabel

var stamina_bar_offset: float = 325
var mana_bar_offset: float = 350

func _ready() -> void:
	character_name_label.text = character_name
	sprite.texture = display_texture
	
	if facing_left:
		sprite.flip_h = true
		stamina_bar.position.x = stamina_bar_offset
		mana_bar.position.x = mana_bar_offset
		
	health_bar.max_value = max_health
	health_bar.update(health)
	
	stamina_bar.max_value = max_stamina
	stamina_bar.update(stamina)
	
	mana_bar.max_value = max_mana
	mana_bar.update(mana)

func take_damage(amount: int) -> void:
	health -= amount
	health = clamp(health, 0, max_health)
	health_bar.update(health)
	OnTakeDamage.emit(health)

func heal(amount: int) -> void:
	health += amount
	health = clamp(health, 0, max_health)
	health_bar.update(health)
	OnHeal.emit(health)

func use_stamina(amount: int) -> void:
	stamina -= amount
	stamina = clamp(stamina, 0, max_stamina)
	stamina_bar.update(stamina)

func regain_stamina(amount: int) -> void:
	stamina += amount
	stamina = clamp(stamina, 0, max_stamina)
	stamina_bar.update(stamina)

func use_mana(amount: int) -> void:
	mana -= amount
	mana = clamp(mana, 0, max_mana)
	mana_bar.update(mana)

func regain_mana(amount: int) -> void:
	mana += amount
	mana = clamp(mana, 0, max_mana)
	mana_bar.update(mana)

func cast_combat_action(action: CombatAction, opponent: Character) -> void:
	if action == null:
		return
		
	if action.damage > 0:
		opponent.take_damage(action.damage)
	if action.heal_amount > 0:
		heal(action.heal_amount)
		
	if action.stamina_cost > 0:
		use_stamina(action.stamina_cost)
	if action.stamina_regain > 0:
		regain_stamina(action.stamina_regain)
	
	if action.mana_cost > 0:
		use_mana(action.mana_cost)
	if action.mana_regain > 0:
		regain_mana(action.mana_regain)
