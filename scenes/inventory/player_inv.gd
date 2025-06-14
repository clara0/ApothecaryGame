extends Control

@onready var inv = preload("res://inventory/mat_inv_player.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
	
var is_open: bool = false

func _ready() -> void:
	print("ready")
	update_slots()
	close()
	
	
func update_slots()	 -> void:
	var num_items: int = inv.inv_items.size()
	var i: int = 0
	for s in slots:
		if i >= num_items:
			s.update(null)
		else:
			s.update(inv.inv_items[i])
		i += 1


func _process(delta) -> void:
	if Input.is_action_just_pressed("inventory"):
		if is_open:
			close()
		else:
			update_slots()
			open()


func close() -> void:
	visible = false
	is_open = false


func open() -> void:
	visible = true
	is_open = true
