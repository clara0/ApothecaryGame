extends State

var nav_focused: bool = true

func enter() -> void:
	nav_focused = true
	Signals.open_inv.emit(true)


func exit() -> void:
	nav_focused = true
	Signals.open_inv.emit(false)


func handle_input() -> void:
	if Input.is_action_just_pressed("right"):
		Signals.browse_grid.emit(Signals.Action.RIGHT)
	if Input.is_action_just_pressed("left"):
		Signals.browse_grid.emit(Signals.Action.LEFT)
	if Input.is_action_just_pressed("up"):
		Signals.browse_grid.emit(Signals.Action.UP)
	if Input.is_action_just_pressed("down"):
		Signals.browse_grid.emit(Signals.Action.DOWN)
	
	if Input.is_action_just_pressed("menu"):
		Signals.enter_game_state.emit(GameState.GameStates.GAME_MENU)
	
	if nav_focused:
		if Input.is_action_just_pressed("back"):
			Signals.exit_game_state.emit()
		if Input.is_action_just_pressed("enter"):
			nav_focused = false
			Signals.focus_inv.emit()
	else:
		if Input.is_action_just_pressed("back"):
			nav_focused = true
			Signals.focus_nav.emit()
