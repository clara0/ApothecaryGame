extends Node

enum Action {
    RIGHT,
	LEFT,
	DOWN,
	UP,
}

signal enter_game_state(new_state: GameState.GameStates)
signal exit_game_state
signal player_move(dir: Vector2)
signal open_inv(open: bool)
signal browse_grid(action: Action)
signal focus_inv
signal focus_nav
signal open_game_menu(open: bool)