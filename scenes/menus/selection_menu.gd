
@abstract
class_name GridMenu
extends Menu

enum Action {
	RIGHT,
	LEFT,
	DOWN,
	UP,
}

const row_len: int = 6
const num_rows: int = 5
var slots: Array
var detail: Control
var focused_inv: Inv
var focus_slot: int = 0


func update_slots()	 -> void:
	var num_items: int = focused_inv.inv_slots.size()
	var i: int = 0
	for s in slots:
		if i >= num_items:
			s.update(null)
		else:
			s.update(focused_inv.inv_slots[i])
		i += 1


func read_input() -> void:
	# I really feel like there's a better way of doing this...
	if Input.is_action_just_pressed("right"):
		browse(Action.RIGHT)
	if Input.is_action_just_pressed("left"):
		browse(Action.LEFT)
	if Input.is_action_just_pressed("up"):
		browse(Action.UP)
	if Input.is_action_just_pressed("down"):
		browse(Action.DOWN)


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
		focus_slot = max(0, focused_inv.inv_slots.size() - 1)
	elif focus_slot >= focused_inv.inv_slots.size():
		focus_slot = 0
	else:
		focus_slot += row_len * num_rows
		focus_slot %= row_len * num_rows
	
	slots[old_slot].focus_off()
	slots[focus_slot].focus_on()
	if detail != null:
		detail.load_slot(slots[focus_slot].get_slot())
