extends Control
signal deleted

@onready var color_rect: ColorRect = $ColorRect
@onready var line: Line2D = $Line2D
@onready var delete_timer: Timer = $DeleteTimer
var button_color: Color

func _ready() -> void:
	color_rect.color = button_color
	line.hide()


func _on_button_mouse_entered() -> void:
	line.show()


func _on_button_mouse_exited() -> void:
	line.hide()


func _on_button_up() -> void:
	delete_timer.stop()
	Globals.set_color(button_color)


func _on_button_down() -> void:
	delete_timer.start()


func _on_delete_timer_timeout() -> void:
	Globals.palette.remove_at(Globals.palette.find(color_rect.color))
	deleted.emit()
