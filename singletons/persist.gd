extends Node


func create_save_file(name: String) -> FileAccess:
	var dir = DirAccess.open("user://save")
	if !dir:
		DirAccess.make_dir_recursive_absolute("user://save")
	return FileAccess.open("user://save/" + name, FileAccess.WRITE)


func save_game() -> void:
	var	save_file = create_save_file("game.save")
	var save_nodes : Array = get_tree().get_nodes_in_group("Persist")
	
	for node : Node in save_nodes:
		if (!node.has_method("save")):
			print("No save method found, skipped.")
		
		var node_data : Dictionary = node.call("save")
		var json_str = JSON.stringify(node_data)
		save_file.store_line(json_str)


func load_game() -> void:
	if not FileAccess.file_exists("user://save/game.save"):
		print("No save file found!")
		return
		
	var	save_file = FileAccess.open("user://save/game.save", FileAccess.READ)
	var save_nodes : Array = get_tree().get_nodes_in_group("Persist")
	
	for node : Node in save_nodes:
		var json_str = save_file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_str)
		
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_str, " at line ", json.get_error_line())
			continue
		
		var node_data = json.data
		node.load(node_data)
