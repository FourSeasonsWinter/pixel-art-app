extends ColorRect

@onready var outline: Line2D = $Line2D

func _ready() -> void:
	color = Globals.start_color
	outline.hide()


func _on_button_down() -> void:
	color = Globals.current_color


func _on_mouse_entered() -> void:
	if Input.is_action_pressed("left_click"):
		color = Globals.current_color
	
	outline.show()


func _on_mouse_exited() -> void:
	outline.hide()
