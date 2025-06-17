extends Control

@onready var inv = preload("res://inventory/mat_inv_player.tres")
@onready var slots: Array = $HSplitContainer/Inventory/GridContainer.get_children()
	
var is_open: bool = false

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


func _process(delta) -> void:
	if Input.is_action_just_pressed("inventory"):
		visible = !visible
		is_open = !is_open


func close() -> void:
	visible = false
	is_open = false


func open() -> void:
	visible = true
	is_open = true
