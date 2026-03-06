extends Item

class_name Potion

enum Type {
    POTION,
    SALVE,
}

@export var type: Type
@export var cost: int
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


func addIngredient(ing: Ingredient) -> void:
    for e in ing.effects:
        effects[e] += ing.effects[e]
    for f in ing.flavors:
        effects[f] += ing.flavors[f]


func removeIngredient(ing: Ingredient) -> void:
    for e in ing.effects:
        effects[e] -= ing.effects[e]
    for f in ing.flavors:
        effects[f] -= ing.flavors[f]


func getDescription() -> String:
    # TODO: Return actual description of stats
    return "too lazy to format rn"

