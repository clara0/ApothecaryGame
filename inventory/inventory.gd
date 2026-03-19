extends Resource

class_name Inv

signal update

@export var name: String = "" # probably not necessary (?)
@export var inv_slots: Array[InvSlot]


#TODO: maintain order of items w/load & save
	# order field in InvItem or use indices in inv_slots? 


# Returns the position of the slot containing a specified item.
# Returns -1 if item does not exist in inventory or is null.
func get_item(item: Item) -> int:
	for i in range(len(inv_slots)):
		if inv_slots[i].item == item:
			return i 
	return -1


# Adds an item to the inventory.
func add(item: Item) -> void:
	for s in inv_slots:
		if s.item == item:
			s.quant += 1
			return
	var new_slot: InvSlot = InvSlot.new()
	new_slot.item = item
	new_slot.quant = 1
	update.emit()


# Removes a given amount of an item from the inventory. 
# Returns the item removed on success. Removal is not performed if amount of
# item to be removed exceeds amount in inventory.
func sub(item: Item, amt: int = 1) -> Item:
	var target_i: int = get_item(item)
	var target: InvSlot = inv_slots[target_i]
	if target != null:
		if target.quant < amt:
			return null
		if target.quant > amt:
			target.quant -= amt
		else:
			inv_slots.remove_at(target_i)
			update.emit()
		return target.item
	return null


func to_json() -> Dictionary:
	var data: Dictionary = {}
	for i in inv_slots:
		data[i.item.name] = i.to_json()
	return data


func from_json(data: Dictionary) -> void:
	inv_slots.clear()
	for k in data:
		var slot_data: Dictionary = data[k]
		if int(slot_data["quant"]) != 0:
			var slot: InvSlot = InvSlot.new()
			slot.from_json(slot_data)
			inv_slots.append(slot)
