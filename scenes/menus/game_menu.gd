extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false
	Signals.open_game_menu.connect(toggle)


func toggle(open_menu: bool) -> void:
	if open_menu:
		open()
	else:
		close()


func open() -> void:
	visible = true


func close() -> void:
	visible = false


func _on_save_pressed() -> void:
	Persist.save_game()


func _on_load_pressed() -> void:
	Persist.load_game()


func _on_exit_pressed() -> void:
	get_tree().quit()
