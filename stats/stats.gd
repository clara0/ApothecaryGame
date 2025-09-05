extends Resource

class_name Stats

@export var happiness: int = 0
@export var reputation: int = 0
@export var coins: int = 0


func happ_change(val: int):
	happiness += val


func rep_change(val: int):
	reputation += val


func coin_change(val: int):
	coins += val


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
