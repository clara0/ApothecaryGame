extends Resource

class_name InvItem

@export var name: String = ""
@export var texture: Texture2D
@export var desc: String = ""
@export var effects: Dictionary = {
	"heat": 0,
	"cool": 0,
	"pain relief": 0,
	"calm": 0,
	"digestion": 0,
}
@export var flavors: Dictionary = {
	"bitter": 0,
	"salty": 0,
	"sour": 0,
	"spicy": 0,
	"sweet": 0,
}
