extends Control

@onready var item_img: Sprite2D = $Control/Item
@onready var focus: Sprite2D = $Focus
@onready var item_quant: Label = $Quantity


func _ready() -> void:
	focus.visible = false


func update(item_slot: InvSlot) -> void:
	if !item_slot || item_slot.quant == 0:
		item_img.visible = false
		item_quant.text = ""
	else:
		item_img.visible = true
		item_img.texture = item_slot.item.texture
		item_quant.text = str(item_slot.quant)


func focus_on() -> void:
	focus.visible = true


func focus_off() -> void:
	focus.visible = false
