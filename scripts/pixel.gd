extends ColorRect

@onready var outline: Line2D = $Line2D
var coordinates: Vector2i

func _ready() -> void:
	outline.hide()


func get_pixel_color() -> Color:
	return color


func _on_button_down() -> void:
	color = Globals.color


func _on_mouse_entered() -> void:
	if Input.is_action_pressed("left_click"):
		color = Globals.color
	
	outline.show()
	Globals.coord = coordinates


func _on_mouse_exited() -> void:
	outline.hide()
