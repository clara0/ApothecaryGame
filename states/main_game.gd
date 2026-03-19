extends State

func enter() -> void:
	pass


func exit() -> void:
	# shouldn't ever happen
	pass


func handle_input() -> void:
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down").normalized()
	Signals.player_move.emit(direction)
	
	if Input.is_action_just_pressed("menu"):
		Signals.enter_game_state.emit(GameState.GameStates.GAME_MENU)
	if Input.is_action_just_pressed("inventory"):
		Signals.enter_game_state.emit(GameState.GameStates.INVENTORY)
