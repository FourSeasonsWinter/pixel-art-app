extends Control

@onready var color_rect: ColorRect = $ColorRect
@onready var darker: Polygon2D = $Darker
@onready var line: Line2D = $Line2D
var button_color: Color

func _ready() -> void:
	color_rect.color = button_color
	line.hide()


func _on_button_pressed() -> void:
	Globals.current_color = button_color


func _on_button_mouse_entered() -> void:
	line.show()


func _on_button_mouse_exited() -> void:
	line.hide()
