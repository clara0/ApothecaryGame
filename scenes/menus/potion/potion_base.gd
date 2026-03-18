extends GridMenu

func _init() -> void:
	focused_inv = preload("res://inventory/invs/avail_base_pot.tres")


func _ready() -> void:
	close()


func close() -> void:
	visible = false
	is_open = false


func open() -> void:
	slots[focus_slot].focus_off()
	focus_slot = 0
	
	visible = true
	is_open = true
