extends State


func enter() -> void:
    Signals.open_craft_menu.emit(true)


func exit() -> void:
    Signals.open_craft_menu.emit(false)


func handle_input() -> void:
    # CRAFT MENU SHOULD NOT BE OPENED BY KEY, TESTING PURPOSES ONLY
    if Input.is_action_just_pressed("craft_temp"):
        Signals.open_craft_menu.emit(true)

    if Input.is_action_just_pressed("back"):
        Signals.open_craft_menu.emit(false)