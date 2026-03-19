extends Node

var game_state_stack: Array[State] = []
var curr_state: State

enum GameStates {
	MAIN_GAME,
	GAME_MENU,
	INVENTORY
}

var game_states: Dictionary = {}


func _ready() -> void:
	if not Signals.enter_game_state.is_connected(push_state):
		Signals.enter_game_state.connect(push_state)
	Signals.exit_game_state.connect(pop_state)

	game_states[GameStates.MAIN_GAME] = get_node("MainGame")
	game_states[GameStates.GAME_MENU] = get_node("GameMenu")
	game_states[GameStates.INVENTORY] = get_node("Inventory")
	push_state(GameStates.MAIN_GAME)


func _process(_delta: float) -> void:
	curr_state.handle_input()


func push_state(state: GameStates) -> void:
	curr_state = game_states[state]
	game_state_stack.push_back(curr_state)
	curr_state.set_process(true)
	curr_state.enter()


func pop_state() -> bool:
	if curr_state != game_states[GameStates.MAIN_GAME]:
		var prev = game_state_stack.pop_back()
		curr_state = game_state_stack.back()
		prev.exit()
		prev.set_process(false)
		return true
	return false
