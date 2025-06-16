extends Resource

class_name InvSlot

@export var item: InvItem
@export var quant: int


func to_json() -> Dictionary:
	var data : Dictionary = {
		"invItem": item.resource_path,
		"path": resource_path,
		"quant": quant,
	}
	return data


func from_json(data: Dictionary) -> void:
	item = load(data["invItem"])
	quant = data["quant"]
