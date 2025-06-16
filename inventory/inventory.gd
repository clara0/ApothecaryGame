extends Resource

class_name Inv

signal update

@export var name: String = "" # probably not necessary (?)
@export var inv_slots: Array[InvSlot]
var curr: int = 0


#TODO: maintain order of items w/load & save
	# order field in InvItem or use indices in inv_slots? 


func add(item: InvItem) -> void:
	for s in inv_slots:
		if s == item:
			s.quant += 1
			return
	inv_slots[curr].item = item
	inv_slots[curr].quant = 1
	curr += 1
	update.emit()


func to_json() -> Dictionary:
	var data: Dictionary = {}
	data["curr"] = curr
	for i in inv_slots:
		data[i.item.name] = i.to_json()
	return data


func from_json(data: Dictionary) -> void:
	inv_slots.clear()
	for k in data:
		if k == "curr":
			curr = int(data["curr"])
			continue
		var slot_data: Dictionary = data[k]
		var slot: InvSlot = InvSlot.new()
		slot.from_json(slot_data)
		if int(slot_data["quant"]) != 0:
			inv_slots.append(slot)
