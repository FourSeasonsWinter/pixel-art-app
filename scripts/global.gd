extends Node
signal current_color_changed

var start_color := Color.TRANSPARENT
var current_color := Color.WHITE
var current_palette := []

func set_current_color(color: Color):
	current_color = color
	current_color_changed.emit()
