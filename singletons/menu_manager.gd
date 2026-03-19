extends Node

enum MenuType {
	INV,
	POTION,
	GAME,
	NONE,
}

@export var menus: Array[Node]
var open_menus: Array[MenuType] = [MenuType.NONE]
 

func _ready() -> void:
	menus = get_tree().get_nodes_in_group("Menu")


func toggle(menu: MenuType) -> void:
	var menu_node = menus[menu]
	if menu_node.visible:
		_close(menu)
	else:
		_open(menu)


func _open(menu: MenuType) -> void:
	print("open!")
	open_menus.push_back(menu)
	var open_menu = menus[menu]
	open_menu.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	open_menu.visible = true
	open_menu.open()


func _close(menu: MenuType) -> void:
	var open_menu = menus[menu]
	open_menu.process_mode = Node.PROCESS_MODE_INHERIT
	get_tree().paused = false
	open_menu.close()
	open_menus.pop_back()
