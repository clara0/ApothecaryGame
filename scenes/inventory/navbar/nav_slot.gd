extends Node

@onready var icon: Sprite2D = $VBoxContainer/Icon/Control/Sprite2D
@onready var focus_bar: Line2D = $VBoxContainer/FocusLine/Line2D
@onready var label: Label = $VBoxContainer/Name/Label
var _navbar_slot: NavbarSlot


func _onready() -> void:
	hide()


func update(navbar_slot: NavbarSlot) -> void:
	_navbar_slot = navbar_slot
	icon.texture = _navbar_slot.icon
	label.text = _navbar_slot.name


func display() -> void:
	focus_bar.visible = true
	label.visible = true


func hide() -> void:
	focus_bar.visible = false
	label.visible = false
