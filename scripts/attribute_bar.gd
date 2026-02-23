# attribute_bar.gd
extends ProgressBar

@onready var bar_label: Label = $BarLabel
@onready var parent: Character = get_parent()

@export var bar_type: Enums.Attribute
var local_stylebox_bg: StyleBoxFlat 
var local_stylebox_fill: StyleBoxFlat 

func _ready() -> void:
	parent.OnNotEnough.connect(_on_not_enough_vfx)
	parent.OnAlreadyFull.connect(_on_already_full_vfx)
	min_value = 0.0
	
	local_stylebox_bg = get_theme_stylebox("background").duplicate()
	local_stylebox_fill = get_theme_stylebox("fill").duplicate()
	add_theme_stylebox_override("background", local_stylebox_bg)
	add_theme_stylebox_override("fill", local_stylebox_fill)

func _on_already_full_vfx(attribute: Enums.Attribute) -> void:
	if attribute == bar_type and parent.is_player:
		for i in 2:
			local_stylebox_fill.border_color = Color(0.7, 0.7, 0.7)
			await get_tree().create_timer(0.1).timeout
			local_stylebox_fill.border_color = Color(0.0, 0.0, 0.0)
			await get_tree().create_timer(0.1).timeout

func _on_not_enough_vfx(attribute: Enums.Attribute) -> void:
	if attribute == bar_type and parent.is_player:
		for i in 2:
			local_stylebox_bg.bg_color = Color(0.72, 0.0, 0.0)
			await get_tree().create_timer(0.1).timeout
			local_stylebox_bg.bg_color = Color(0.0, 0.0, 0.0)
			await get_tree().create_timer(0.1).timeout



func update(attribute: int) -> void:
	value = attribute
	bar_label.text = str(int(value)) + " / " + str(int(max_value))
