extends Item

class_name Ingredient

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

func getDescription() -> String:
    # TODO: output effects and flavors
    return desc