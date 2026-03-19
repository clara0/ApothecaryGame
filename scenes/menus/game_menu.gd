extends Menu


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false


func open() -> void:
	pass


func close() -> void:
	# lowkey jeink af
	process_mode = Node.PROCESS_MODE_ALWAYS


func _on_save_pressed() -> void:
	Persist.save_game()


func _on_load_pressed() -> void:
	Persist.load_game()


func _on_exit_pressed() -> void:
	get_tree().quit()
