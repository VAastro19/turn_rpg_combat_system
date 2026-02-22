# combat_system_manager.gd
extends Node2D

signal OnVictory
signal OnDefeat

@onready var player: Character = $PlayerCharacter
@onready var ai: Character = $AICharacter
@onready var player_buttons: Control = $UI/PlayerButtons
@onready var description_label: RichTextLabel = $UI/Description/Label
@onready var turn_count_label: Label = $UI/TurnCountLabel
@onready var end_screen: Panel = $UI/EndScreen

var turn_count: int = 0
var controller: Character
var can_cast: bool = false
var game_over: bool = false

func _ready() -> void:
	next_turn()
	end_screen.visible = false
	player.OnTakeDamage.connect(_on_player_damaged)
	ai.OnTakeDamage.connect(_on_ai_damaged)

func _on_player_damaged(health: int) -> void:
	if health <= 0:
		game_over = true
		show_end_screen("ai")
		OnDefeat.emit()

func _on_ai_damaged(health: int) -> void:
	if health <= 0:
		game_over = true
		show_end_screen("player")
		OnVictory.emit()

func show_end_screen(victor: String) -> void:
	end_screen.set_result_label(victor)
	await get_tree().create_timer(0.3).timeout
	player.visible = false
	ai.visible = false
	end_screen.visible = true

func next_turn() -> void:
	if controller == ai or controller == null:
		controller = player
		can_cast = true
		
		turn_count += 1
		turn_count_label.update(turn_count)
	else:
		controller = ai

	if not game_over:
		if controller == player:
			player_buttons.manage_combat_actions(player.combat_actions)
		else:
			var wait_time = randf_range(0.5, 1.5)
			await get_tree().create_timer(wait_time).timeout
			
			var action_to_cast = ai_decide_combat_action_to_cast()
			ai.cast_combat_action(action_to_cast, player)
			
			description_label.update("Enemy " + action_to_cast.message)
			await get_tree().create_timer(0.5).timeout
			next_turn()

func player_cast_combat_action(action: CombatAction) -> void:
	if controller != player:
		return
	await get_tree().create_timer(0.1).timeout
	
	if can_cast:
		var player_cast_exit_code = player.cast_combat_action(action, ai)
		if player_cast_exit_code != 0:
			return
		can_cast = false
		
	description_label.update("Player " + action.message)
	next_turn()

func ai_decide_combat_action_to_cast() -> CombatAction:
	if ai != controller:
		return
	
	var actions = ai.combat_actions
	var weights: Array[int] = []
	var total_weight: float = 0
	
	var ai_health_percent: float = float(ai.health) / float(ai.max_health)
	var ai_stamina_percent: float = float(ai.stamina) / float(ai.max_stamina)
	var ai_mana_percent: float = float(ai.mana) / float(ai.max_mana)
	
	for action in actions:
		var weight: float = action.base_weight
		
		if action.stamina_cost > ai.stamina:
			weight = 0
		if action.mana_cost > ai.mana:
			weight = 0
			
		if player.health <= action.damage:
			weight *= 10
		if action.heal_amount > 0:
			weight *= 1 + (1 - ai_health_percent)
			
		if action.stamina_regain > 0:
			if ai_stamina_percent <= 0.2:
				weight *= 5
			elif ai_stamina_percent >= 0.8:
				weight *= 0.1
			else:
				weight *= 1 + (1 - ai_stamina_percent)
				
		if action.mana_regain > 0:
			if ai_mana_percent <= 0.2:
				weight *= 3
			elif ai_stamina_percent >= 0.8:
				weight *= 0.1
			else:
				weight *= 1 + (1 - ai_mana_percent)
		
		weights.append(weight)
		total_weight += weight

	var cumulative_weight: float = 0
	var random_weight: float = randf_range(0, total_weight)

	for i in len(actions):
		cumulative_weight += weights[i]
		if random_weight < cumulative_weight:
			return actions[i]

	return null
