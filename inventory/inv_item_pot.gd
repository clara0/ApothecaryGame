extends InvItem

class_name InvItemPot

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


func addIngredient(mat: InvItemMat) -> void:
    for e in mat.effects:
        effects[e] += mat.effects[e]
    for f in mat.flavors:
        effects[f] += mat.flavors[f]


func removeIngredient(mat: InvItemMat) -> void:
    for e in mat.effects:
        effects[e] -= mat.effects[e]
    for f in mat.flavors:
        effects[f] -= mat.flavors[f]
