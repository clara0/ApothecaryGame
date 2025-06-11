extends Control

@onready var item_img: Sprite2D = $Control/Item
@onready var item_quant: Label = $Quantity

func update(item: InvItem) -> void:
	if !item:
		item_img.visible = false
		item_quant.text = ""
	else:
		item_img.visible = true
		item_img.texture = item.texture
		item_quant.text = str(item.quant)
