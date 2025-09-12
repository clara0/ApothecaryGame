extends Node

@onready var icon: Sprite2D
@onready var text: Label


func _ready() -> void:
	focus_off()


func focus_on() -> void:
	text.visible = true


func focus_off() -> void:
	text.visible = false
