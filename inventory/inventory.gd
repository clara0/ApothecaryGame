extends Resource

class_name Inv

@export var name: String = "" # probably not necessary (?)
@export var inv_items: Array[InvItem]


func to_json() -> Dictionary:
	var data: Dictionary = {}
	for i in inv_items:
		data[i.name] = i.to_json()
	return data


func from_json(data: Dictionary) -> void:
	for k in data:
		var item_data: Dictionary = data[k]
		var item: InvItem = load(item_data["path"])
		item.from_json(item_data)
		if item_data["quant"] != 0:
			inv_items.append(item)
