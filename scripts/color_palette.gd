extends GridContainer
signal color_deleted

var color_button_scene := preload("res://scenes/color_button.tscn")

func add_color(color: Color) -> bool:
	if Globals.palette.find(color) != -1:
		return false
	
	Globals.palette.append(color)
	update_palette()
	return true


func update_palette() -> void:
	for element in get_children():
		element.disconnect("deleted", color_removed)
		remove_child(element)
	
	for color in Globals.palette:
		var button = color_button_scene.instantiate()
		button.button_color = color
		button.connect("deleted", color_removed)
		add_child(button)


func color_removed() -> void:
	update_palette()
	color_deleted.emit()
