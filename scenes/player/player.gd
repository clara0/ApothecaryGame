extends CharacterBody2D

enum Inventory {
	EQUIP,
	ITEM,
	MAT,
	POT,
}

enum Anim {
	IDLE, 
	UP, 
	DOWN, 
	RIGHT, 
	LEFT,
}

var _anim_states = {
	0: "idle",
	1: "backward_walk",
	2: "forward_walk",
	3: "right_walk",
	4: "left_walk",
}

@export var speed: int = 100
var _curr_anim: Anim = Anim.IDLE
var direction: Vector2 = Vector2.ZERO
@onready var _animation_player = $AnimationPlayer
@export var equipment_inv: Inv
@export var item_inv: Inv
@export var material_inv: Inv
@export var potion_inv: Inv
@export var stats: Stats


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	Signals.player_move.connect(_handle_movement)
	

# runs 60 times each second
func _physics_process(_delta) -> void:
	velocity = direction * speed;
	move_and_slide()


func _handle_movement(dir: Vector2) -> void:
	direction = dir
	
	# feel like there's a better way of doing this...
	var x: float = direction.x
	var y: float = direction.y
	if y == 0 && x == 0:
		# DO WE WANT AN IDLE?
		_curr_anim = Anim.IDLE
	elif abs(y) >= abs(x): # fyi y-axis is flipped
		_curr_anim = Anim.UP if y < 0 else Anim.DOWN
	else:
		_curr_anim = Anim.RIGHT if x > 0 else Anim.LEFT
	
	_animation_player.play(_anim_states[_curr_anim]) 


func pause() -> void:
	_animation_player.stop()


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


func collect(item: Item, inv: Inventory) -> void:
	var target = _get_inv(inv)
	target.add(item)


func give(item: Item) -> Item:
	return material_inv.sub(item)
	

# save player state to JSON format
func save() -> Dictionary:
	print("Saving player...")
	var data: Dictionary = {
		"file": get_scene_file_path(),
		"x": position.x,
		"y": position.y,
		"anim": "idle",
		"mat_inv": material_inv.to_json(),
		"stats": stats.to_json(),
	}
	return data


# load data from save file
func load(data : Dictionary) -> void:
	print("Loading player...")
	position.x = data["x"]
	position.y = data["y"]
	_animation_player.play(data["anim"])
	material_inv.from_json(data["mat_inv"])
	stats.from_json(data["stats"])
