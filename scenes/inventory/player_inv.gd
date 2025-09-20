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
@onready var slots: Array = $HSplitContainer/Inventory/MarginContainer/VBoxContainer/GridContainer.get_children()
@onready var navbar: Array = $HSplitContainer/Inventory/MarginContainer/VBoxContainer/Navbar/MarginContainer/HBoxContainer.get_children()
@onready var detail: Control = $HSplitContainer/Detail

var navbar_slots: Array = [
	preload("res://inventory/navbar/navbar_mat.tres"),
	preload("res://inventory/navbar/navbar_pot.tres"),
	preload("res://inventory/navbar/navbar_equip.tres"),
	preload("res://inventory/navbar/navbar_item.tres"),
]

var is_open: bool = false
var navbar_focused: bool = true
var focus_slot: int = 0
var focus_nav: int = 0

func _ready() -> void:
	inv.update.connect(update_slots)
	load_navbar()
	update_slots()
	close()


func load_navbar() -> void:
	var i: int = 0;
	for s in navbar:
		s.update(navbar_slots[i])
		i += 1


func enter_navbar() -> void:
	navbar_focused = true
	slots[focus_slot].focus_off()
	focus_slot = 0
	detail.load_slot(slots[focus_slot].get_slot())


func enter_inv() -> void:
	navbar_focused = false
	slots[focus_slot].focus_on()
	detail.load_slot(slots[focus_slot].get_slot())


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
		if navbar_focused:
			if Input.is_action_just_pressed("right"):
				browse_nav(Action.RIGHT)
			if Input.is_action_just_pressed("left"):
				browse_nav(Action.LEFT)
			if Input.is_action_just_pressed("enter"):
				enter_inv()
		else:
			if Input.is_action_just_pressed("right"):
				browse_inv(Action.RIGHT)
			if Input.is_action_just_pressed("left"):
				browse_inv(Action.LEFT)
			if Input.is_action_just_pressed("up"):
				browse_inv(Action.UP)
			if Input.is_action_just_pressed("down"):
				browse_inv(Action.DOWN)
			if Input.is_action_just_pressed("back"):
				enter_navbar()



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
	
	navbar[focus_nav].hide()
	focus_nav = 0
	navbar[focus_nav].display()
	
	visible = true
	is_open = true
	navbar_focused = true


func browse_nav(action: Action) -> void:
	var old_nav: int = focus_nav
	match action:
		Action.RIGHT:
			focus_nav += 1
		Action.LEFT:
			focus_nav -= 1
	
	if focus_nav < 0:
		focus_nav = navbar_slots.size() - 1
	elif focus_nav >= navbar_slots.size():
		focus_nav = 0
	
	navbar[old_nav].hide()
	navbar[focus_nav].display()


func browse_inv(action: Action) -> void:
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
