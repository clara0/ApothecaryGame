extends Control

@onready var item_img: Sprite2D = $Control/Item
@onready var item_quant: Label = $Quantity


func update(item_slot: InvSlot) -> void:
	if !item_slot || item_slot.quant == 0:
		item_img.visible = false
		item_quant.text = ""
	else:
		item_img.visible = true
		item_img.texture = item_slot.item.texture
		item_quant.text = str(item_slot.quant)
