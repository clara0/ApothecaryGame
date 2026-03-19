extends Control
class_name PlayerInv

const row_len: int = 6
const num_rows: int = 5

@onready var invs: Array[Inv] = [
	preload("res://inventory/invs/mat_inv_player.tres"),
	preload("res://inventory/invs/pot_inv_player.tres"),
	preload("res://inventory/invs/equip_inv_player.tres"),
	preload("res://inventory/invs/item_inv_player.tres"),
]

@onready var slots: Array = $HSplitContainer/Inventory/MarginContainer/VBoxContainer/GridContainer.get_children()
@onready var navbar: Array = $HSplitContainer/Inventory/MarginContainer/VBoxContainer/Navbar/MarginContainer/HBoxContainer.get_children()
@onready var detail: Control = $HSplitContainer/Detail

var navbar_slots: Array = [
	preload("res://inventory/navbar/navbar_mat.tres"),
	preload("res://inventory/navbar/navbar_pot.tres"),
	preload("res://inventory/navbar/navbar_equip.tres"),
	preload("res://inventory/navbar/navbar_item.tres"),
]

var focused_inv: Inv

var is_open: bool = false
var navbar_focused: bool = true
var focus_slot: int = 0
var focus_nav: int = 0


func _ready() -> void:
	focused_inv = invs[focus_nav]
	focused_inv.update.connect(update_slots)
	Signals.open_inv.connect(toggle)
	Signals.browse_grid.connect(browse)
	Signals.focus_inv.connect(enter_inv)
	Signals.focus_nav.connect(enter_navbar)
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
	var num_items: int = focused_inv.inv_slots.size()
	var i: int = 0
	for s in slots:
		if i >= num_items:
			s.update(null)
		else:
			s.update(focused_inv.inv_slots[i])
		i += 1


func toggle(open_inv: bool) -> void:
	if open_inv:
		open()
	else:
		close()


func close() -> void:
	visible = false
	is_open = false


func open() -> void:	
	slots[focus_slot].focus_off()
	focus_slot = 0
	
	navbar[focus_nav].hide()
	focus_nav = 0
	navbar[focus_nav].display()
	
	is_open = true
	navbar_focused = true
	visible = true


func browse(action: Signals.Action) -> void:
	if navbar_focused:
		browse_nav(action)
	else:
		browse_inv(action)


func browse_nav(action: Signals.Action) -> void:
	var old_nav: int = focus_nav
	match action:
		Signals.Action.RIGHT:
			focus_nav += 1
		Signals.Action.LEFT:
			focus_nav -= 1
	
	if focus_nav < 0:
		focus_nav = navbar_slots.size() - 1
	elif focus_nav >= navbar_slots.size():
		focus_nav = 0
	
	navbar[old_nav].hide()
	navbar[focus_nav].display()
	focused_inv = invs[focus_nav]
	update_slots()


func browse_inv(action: Signals.Action) -> void:
	var old_slot: int = focus_slot
	match action:
		Signals.Action.RIGHT:
			focus_slot += 1
		Signals.Action.LEFT:
			focus_slot -= 1
		Signals.Action.UP:
			focus_slot -= row_len
		Signals.Action.DOWN:
			focus_slot += row_len
	
	if focus_slot < 0:
		focus_slot = max(0, focused_inv.inv_slots.size() - 1)
	elif focus_slot >= focused_inv.inv_slots.size():
		focus_slot = 0
	else:
		focus_slot += row_len * num_rows
		focus_slot %= row_len * num_rows
	
	slots[old_slot].focus_off()
	slots[focus_slot].focus_on()
	detail.load_slot(slots[focus_slot].get_slot())