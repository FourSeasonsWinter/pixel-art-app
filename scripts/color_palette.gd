extends GridContainer

var color_button_scene := preload("res://scenes/color_button.tscn")
var colors := []

func add_color(color: Color) -> bool:
	if colors.find(color) != -1:
		return false
	
	var button = color_button_scene.instantiate()
	button.button_color = color
	colors.append(color)
	
	add_child(button)
	return true
