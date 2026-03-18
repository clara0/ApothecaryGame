extends Control

@onready var item_img: Sprite2D = $Control/Item
@onready var focus: NinePatchRect = $Focus
var _inv_slot: InvSlot


func _ready() -> void:
	focus.visible = false


func update(item_slot: InvSlot) -> void:
	if !item_slot || item_slot.quant == 0:
		item_img.visible = false
	else:
		_inv_slot = item_slot
		item_img.visible = true
		item_img.texture = item_slot.item.texture


func get_slot() -> InvSlot:
	return _inv_slot


func focus_on() -> void:
	focus.visible = true


func focus_off() -> void:
	focus.visible = false
