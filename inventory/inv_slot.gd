extends Resource

class_name InvSlot

@export var item: Item
@export var count: int


func to_json() -> Dictionary:
	var data : Dictionary = {
		"item": item.resource_path,
		"path": resource_path,
		"count": count,
	}
	return data


func from_json(data: Dictionary) -> void:
	item = load(data["item"])
	count = data["count"]
