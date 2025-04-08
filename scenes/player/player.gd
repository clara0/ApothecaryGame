extends CharacterBody2D

enum Anim {IDLE, UP, DOWN, RIGHT, LEFT}
var _anim_states = {
	0 : "idle",
	1 : "backward_walk",
	2 : "forward_walk",
	3 : "right_walk",
	4 : "left_walk",
}


@onready var _animation_player = self.get_node("AnimationPlayer")
var _curr_anim: Anim = Anim.IDLE
var direction: Vector2 = Vector2.ZERO
@export var speed: int = 175

	
func save() -> Dictionary:
	var data = {
		"file" = get_scene_file_path(),
		"x" = position.x,
		"y" = position.y,
		"anim" = "idle", 
	}
	return data


func load(data : Dictionary):
	position.x = data["x"]
	position.y = data["y"]
	_animation_player.play(data["anim"])


# runs once per frame
func _process(_delta):
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
func _physics_process(_delta):
	velocity = direction * speed;
	move_and_slide()
