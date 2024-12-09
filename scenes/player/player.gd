extends CharacterBody2D

var direction: Vector2 = Vector2.ZERO
@export var speed: int = 100
@onready var _animation_player = self.get_node("AnimationPlayer")
enum Anim {UP, DOWN, RIGHT, LEFT}

# runs once per frame
func _process(_delta):
	direction = Input.get_vector("left", "right", "up", "down")
	if Input.is_action_pressed("down"):
		_animation_player.play("forward_walk")
	else:
		_animation_player.stop()
	
# runs 60 times each second
func _physics_process(_delta):
	velocity = direction * speed;
	move_and_slide()
