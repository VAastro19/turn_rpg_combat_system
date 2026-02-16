# main_buttons.gd
extends FlowContainer

@onready var flee_button: Button = $FleeButton
@onready var attack_button: Button = $VBoxContainer/HBoxContainerTop/AttackButton
@onready var heavy_attack_button: Button = $VBoxContainer/HBoxContainerTop/HeavyAttackButton
@onready var wait_button: Button = $VBoxContainer/HBoxContainerTop/WaitButton
