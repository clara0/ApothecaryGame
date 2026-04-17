extends Control

var is_open: bool = false
var objective_exist: bool = false
var curr_slot: Control

# @onready var detail: Control = $MarginContainer/VSplitContainer/MarginContainer/HBoxContainer/Ingredient

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.open_craft_menu.connect(toggle)
	close()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
	# if curr_slot:
	# 	detail.load_slot(curr_slot.get_slot())


func toggle(open_menu: bool) -> void:
	if open_menu:
		open()
	else:
		close()


func close() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	get_tree().paused = false
	visible = false
	is_open = false


func open() -> void:
	visible = true
	is_open = true
