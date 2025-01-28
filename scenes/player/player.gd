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
@export var speed: int = 100

var save_file_path = "user://save/"
var save_file_name = "player_save.tres"
var data = player_data.new()

func _ready() -> void:
	verify_save_dir(save_file_path)
	
func verify_save_dir(path : String):
	DirAccess.make_dir_absolute(path)
	
func load_data() -> void:
	data = ResourceLoader.load(save_file_path + save_file_name).duplicate(true)
	self.position = data.position
	_animation_player.play("RESET")
	print("Loaded successfully!")
	
func save() -> void:
	ResourceSaver.save(data, save_file_path + save_file_name)
	print("Saved successfully!")

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
	data.update_position(self.position)
	
	if Input.is_action_just_pressed("save"):
		save()
	elif Input.is_action_just_pressed("load"):
		load_data()
	
# runs 60 times each second
func _physics_process(_delta):
	velocity = direction * speed;
	move_and_slide()
