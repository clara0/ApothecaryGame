extends Node

@onready var icon: Sprite2D = $VBoxContainer/Name
@onready var focus_bar: Line2D = $VBoxContainer/FocusLine/Line2D
@onready var label: Label = $VBoxContainer/Control/Icon
var navbarSlot: NavbarSlot


func _onready() -> void:
	icon.texture = navbarSlot.icon
	label.text = navbarSlot.name
	hide()


func display() -> void:
	focus_bar.visible = true
	label.visible = true


func hide() -> void:
	focus_bar.visible = false
	label.visible = false
