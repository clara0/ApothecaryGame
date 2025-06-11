extends Resource

class_name InvItem

@export var name: String = ""
@export var texture: Texture2D
@export var quant: int
@export var desc: String = ""


func to_json() -> Dictionary:
	var data : Dictionary = {
		"name": name,
		"path": resource_path,
		"texture": texture.resource_path,
		"quant": quant,
		"desc": desc,
	}
	return data


func from_json(data: Dictionary) -> void:
	name = data["name"]
	texture = load(data["texture"])
	quant = data["quant"]
	desc = data["desc"]
