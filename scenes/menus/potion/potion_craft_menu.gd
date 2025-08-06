extends Control


var is_open: bool = false
var objective_exist: bool = false

@onready var ingredients: Control = $MarginContainer/VSplitContainer/Ingredients


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	close()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# CRAFT MENU SHOULD NOT BE OPENED BY KEY, TESTING PURPOSES ONLY
	if Input.is_action_just_pressed("craft_temp"):
		if is_open:
			close()
		else:
			open()
	
	if is_open:
		if Input.is_action_just_pressed("right"):
			ingredients.browse(ingredients.Action.RIGHT)
		if Input.is_action_just_pressed("left"):
			ingredients.browse(ingredients.Action.LEFT)


func close() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	get_tree().paused = false
	visible = false
	is_open = false


func open() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	
	ingredients.reset()
	
	visible = true
	is_open = true
