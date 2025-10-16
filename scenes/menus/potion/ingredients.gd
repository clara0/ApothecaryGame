extends Control

enum Action {
	RIGHT,
	LEFT,
}

const row_len: int = 6

var focus_slot: int = 0
var first_inv_item: int = 0 # inv item in first slot

@onready var inv = preload("res://inventory/invs/mat_inv_player.tres")
@onready var slots = $GridContainer.get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func reset() -> void:
	slots[focus_slot].focus_off()
	focus_slot = 0
	slots[focus_slot].focus_on()
	first_inv_item = 0
	update_slots()


func update_slots() -> void:
	var num_items: int = inv.inv_slots.size()
	var i: int = first_inv_item
	for s in slots:
		if i >= num_items:
			s.update(null)
		else:
			s.update(inv.inv_slots[i])
		i += 1


func browse(action: Action) -> Control:
	var old_slot: int = focus_slot
	match action:
		Action.RIGHT:
			focus_slot += 1
		Action.LEFT:
			focus_slot -= 1
	
	if focus_slot < 0:
		if first_inv_item != 0:
			first_inv_item -= 1
			update_slots()
		focus_slot = 0
	elif focus_slot >= row_len:
		if first_inv_item + row_len - 1 < inv.inv_slots.size():
			first_inv_item += 1
			update_slots()
		focus_slot = row_len - 1
	elif focus_slot >= inv.inv_slots.size():
		focus_slot -= 1
	
	slots[old_slot].focus_off()
	slots[focus_slot].focus_on()
	return slots[focus_slot]
