extends Node

enum MenuType {
    NONE,
    GAME,
    INV,
    POTION,
}

@export var menus: Array[Control]
var open_menus: Array[MenuType] = [MenuType.NONE]
 

func toggle(menu: MenuType) -> void:
    var menu_node = menus[menu]
    if menu_node.visible:
        _close(menu_node)
    else:
        _open(menu_node)


func _open(menu: MenuType) -> void:
    open_menus.push_back(menu)
    var open_menu = menus[menu]
    open_menu.process_mode = Node.PROCESS_MODE_ALWAYS
    get_tree().paused = true
    open_menu.open()


func _close(menu: MenuType) -> void:
    var open_menu = menus[menu]
    open_menu.process_mode = Node.PROCESS_MODE_INHERIT
    get_tree().paused = false
    open_menu.close()
    open_menus.pop_back()
