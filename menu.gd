extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_save_pressed() -> void:
	Persist.save_game()


func _on_load_pressed() -> void:
	Persist.load_game()


func _on_exit_pressed() -> void:
	get_tree().quit()
