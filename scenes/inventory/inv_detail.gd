extends Control

@onready var image: Sprite2D = \
	$Detail/MarginContainer/VBoxContainer/FocusItem/Icon/Control/Item
@onready var name_label: Label = \
	$Detail/MarginContainer/VBoxContainer/FocusItem/VSplitContainer/Name
@onready var quantity: Label = \
	$Detail/MarginContainer/VBoxContainer/FocusItem/VSplitContainer/Quantity
@onready var desc: Label = \
	$Detail/MarginContainer/VBoxContainer/ItemDesc/Desc


func load_slot(slot: InvSlot) -> void:
	if slot == null:
		image.texture = null
		name_label.text = "There is Nothing Here"
		quantity.text = "0"
		desc.text = "filler text filler text this shouldn't show up"
		return
	image.texture = slot.item.texture
	name_label.text = slot.item.name
	quantity.text = str(slot.quant)
	desc.text = slot.item.desc
