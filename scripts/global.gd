extends Node
signal color_changed

var color: Color
var palette: Array
var coord: Vector2i

func set_color(c: Color):
	color = c
	color_changed.emit()
