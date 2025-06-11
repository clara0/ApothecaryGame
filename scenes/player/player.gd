extends CharacterBody2D

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


@export var speed: int = 175
var _curr_anim: Anim = Anim.IDLE
var direction: Vector2 = Vector2.ZERO
@onready var _animation_player = $AnimationPlayer
@export var material_inv: Inv


func pause() -> void:
	_animation_player.stop


# save player state to JSON format
func save() -> Dictionary:
	print("Saving player...")
	var data: Dictionary = {
		"file": get_scene_file_path(),
		"x": position.x,
		"y": position.y,
		"anim": "idle",
		"mat_inv": material_inv.to_json(),
	}
	return data


# load data from save file
func load(data : Dictionary) -> void:
	print("Loading player...")
	position.x = data["x"]
	position.y = data["y"]
	_animation_player.play(data["anim"])
	material_inv.from_json(data["mat_inv"])


# runs once per frame
func _process(_delta) -> void:
	direction = Input.get_vector("left", "right", "up", "down").normalized()
	
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


# runs 60 times each second
func _physics_process(_delta) -> void:
	velocity = direction * speed;
	move_and_slide()
