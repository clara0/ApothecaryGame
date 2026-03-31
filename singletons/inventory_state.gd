extends Node

enum Inventory {
	EQUIP,
	ITEM,
	MAT,
	POT,
}

@export var equipment_inv: Inv
@export var item_inv: Inv
@export var material_inv: Inv
@export var potion_inv: Inv


func _get_inv(inv: Inventory) -> Inv:
	match inv:
		Inventory.EQUIP:
			return equipment_inv
		Inventory.ITEM:
			return item_inv
		Inventory.MAT:
			return material_inv
		Inventory.POT:
			return potion_inv
		_:
			return null


# save player state to JSON format
func save() -> Dictionary:
	print("Saving player...")
	var data: Dictionary = {
		"file": get_scene_file_path(),
		"mat_inv": material_inv.to_json(),
	}
	return data


# load data from save file
func load(data : Dictionary) -> void:
	print("Loading inventory...")
	material_inv.from_json(data["mat_inv"])
