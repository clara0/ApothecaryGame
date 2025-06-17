extends Resource

class_name Inv

signal update

@export var name: String = "" # probably not necessary (?)
@export var inv_slots: Array[InvSlot]
var curr: int = 0


#TODO: maintain order of items w/load & save
	# order field in InvItem or use indices in inv_slots? 


## Returns the slot containing a specified item.
## Returns null if item does not exist in inventory or is null.
func get_item(item: InvItem) -> InvSlot:
	for s in inv_slots:
		if s == item:
			return s
	return null


## Adds an item to the inventory.
func add(item: InvItem) -> void:
	for s in inv_slots:
		if s == item:
			s.quant += 1
			return
	inv_slots[curr].item = item
	inv_slots[curr].quant = 1
	curr += 1
	update.emit()


## Removes a given amount of an item from the inventory. 
## Returns the item removed on success. Removal is not performed if amount of
## item to be removed exceeds amount in inventory.
func sub(item: InvItem, amt: int = 1) -> InvItem:
	var target: InvSlot = get_item(item)
	if target != null:
		if target.quant < amt:
			return null
		if target.quant > amt:
			target.quant -= amt
		else:
			inv_slots.remove_at(1)
		return target.item
	return null


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
