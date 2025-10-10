extends Control

@onready var image: Sprite2D = \
	$Detail/MarginContainer/VBoxContainer/FocusItem/Icon/Control/Item
@onready var name_label: Label = \
	$Detail/MarginContainer/VBoxContainer/FocusItem/VSplitContainer/Name
@onready var quantity: Label = \
	$Detail/MarginContainer/VBoxContainer/FocusItem/VSplitContainer/Quantity
@onready var desc: Label = \
	$Detail/MarginContainer/VBoxContainer/ItemDesc/Desc
@onready var effects: Label = \
	$Detail/MarginContainer/VBoxContainer/Properties/HSplitContainer/Effects
@onready var flavors: Label = \
	$Detail/MarginContainer/VBoxContainer/Properties/HSplitContainer/Flavors


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
	image.texture = slot.item.texture
	name_label.text = slot.item.name
	quantity.text = str(slot.quant)
	desc.text = slot.item.desc
	effects.text = format_list(slot.item.effects)
	flavors.text = format_list(slot.item.flavors)


func clear() -> void:
	image.texture = null
	name_label.text = ""
	quantity.text = "0"
	desc.text = ""
	effects.text = ""
	flavors.text = ""
