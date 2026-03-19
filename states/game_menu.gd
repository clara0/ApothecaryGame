extends State


func enter() -> void:
	Signals.open_game_menu.emit(true)


func exit() -> void:
	Signals.open_game_menu.emit(false)


func handle_input() -> void:
	if Input.is_action_just_pressed("back"):
		Signals.exit_game_state.emit()	

