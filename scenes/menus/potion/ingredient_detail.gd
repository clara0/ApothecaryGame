extends Control

@onready var name_label: Label = \
	$VBoxContainer/MarginContainer/NinePatchRect/MarginContainer/VBoxContainer/Name
@onready var effects: Label = \
	$VBoxContainer/MarginContainer/NinePatchRect/MarginContainer/VBoxContainer/Effects
@onready var flavors: Label = \
	$VBoxContainer/MarginContainer/NinePatchRect/MarginContainer/VBoxContainer/Flavors


func format_list(data: Dictionary):
	var formatted: String = ""
	for d in data:
		if (data[d] != 0):
			formatted += d + ": " + str(data[d]) + "\n"
	return formatted.strip_edges(true, true)


func load_slot(slot: InvSlot) -> void:
	if slot == null:
		clear()
		return
	name_label.text = slot.item.name
	effects.text = format_list(slot.item.effects)
	flavors.text = format_list(slot.item.flavors)


func clear() -> void:
	name_label.text = ""
	effects.text = ""
	flavors.text = ""
