extends Control

enum Action {
	RIGHT,
	LEFT,
	DOWN,
	UP,
}

const row_len: int = 6
const num_rows: int = 5

@onready var inv = preload("res://inventory/invs/mat_inv_player.tres")
@onready var slots: Array = $HSplitContainer/Inventory/VBoxContainer/GridContainer.get_children()
@onready var navbar: Array = $HSplitContainer/Inventory/VBoxContainer/Control.get_children()
@onready var detail: Control = $HSplitContainer/Detail

var is_open: bool = false
var focus_slot: int = 0

func _ready() -> void:
	inv.update.connect(update_slots)
	update_slots()
	close()


func update_slots()	 -> void:
	var num_items: int = inv.inv_slots.size()
	var i: int = 0
	for s in slots:
		if i >= num_items:
			s.update(null)
		else:
			s.update(inv.inv_slots[i])
		i += 1


func _process(_delta) -> void:
	if Input.is_action_just_pressed("inventory"):
		if is_open:
			close()
		else:
			open()
	
	if is_open:
		if Input.is_action_just_pressed("right"):
			browse(Action.RIGHT)
		if Input.is_action_just_pressed("left"):
			browse(Action.LEFT)
		if Input.is_action_just_pressed("up"):
			browse(Action.UP)
		if Input.is_action_just_pressed("down"):
			browse(Action.DOWN)



func close() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	get_tree().paused = false
	visible = false
	is_open = false


func open() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	
	slots[focus_slot].focus_off()
	focus_slot = 0
	slots[focus_slot].focus_on()
	detail.load_slot(slots[focus_slot].get_slot())
	
	visible = true
	is_open = true


func browse(action: Action) -> void:
	var old_slot: int = focus_slot
	match action:
		Action.RIGHT:
			focus_slot += 1
		Action.LEFT:
			focus_slot -= 1
		Action.UP:
			focus_slot -= row_len
		Action.DOWN:
			focus_slot += row_len
	
	if focus_slot < 0:
		focus_slot = inv.inv_slots.size() - 1
	elif focus_slot >= inv.inv_slots.size():
		focus_slot = 0
	else:
		focus_slot += row_len * num_rows
		focus_slot %= row_len * num_rows
	
	slots[old_slot].focus_off()
	slots[focus_slot].focus_on()
	detail.load_slot(slots[focus_slot].get_slot())
