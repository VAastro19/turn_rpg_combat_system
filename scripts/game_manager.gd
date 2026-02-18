# game_manager.gd
extends Node2D

@onready var player: Character = $PlayerCharacter
@onready var ai: Character = $AICharacter
@onready var player_buttons: Control = $UI/PlayerButtons

var turn_count: int = 0
var controller: Character

func _ready() -> void:
	next_turn()

func next_turn() -> void:
	turn_count += 1
	if controller == ai or controller == null:
		controller = player
	else:
		controller = ai
		
	print("Current turn: " + str(controller))
	
	if controller == player:
		player_buttons.manage_combat_actions(player.combat_actions)
	else:
		next_turn()

func player_cast_combat_action(action: CombatAction) -> void:
	if controller != player:
		return
	var player_cast_exit_code = player.cast_combat_action(action, ai)
	if player_cast_exit_code != 0:
		return
	await get_tree().create_timer(0.5).timeout
	next_turn()

func ai_decide_combat_action_to_cast() -> void:
	pass
