extends Resource

class_name Stats

@export var happiness: int = 0
@export var reputation: int = 0
@export var coins: int = 0


func happ_change(val: int) -> int:
	happiness += val
	return happiness


func rep_change(val: int) -> int:
	reputation += val
	return reputation


func coin_change(val: int) -> int:
	coins += val
	return coins


func to_json() -> Dictionary:
	var data: Dictionary = {
		"happy": happiness,
		"rep": reputation,
		"coins": coins,
	}
	return data


func from_json(data: Dictionary) -> void:
	happiness = data["happy"]
	reputation = data["rep"]
	coins = data["coins"]
