extends Camera2D

const ZOOM_INCREMENT = 0.1
const ZOOM_RATE = 10.0
var min_zoom = 0.8
var max_zoom = 2.0
var target_zoom := 1.0
var dragging := false
var previous_position := Vector2()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("right_click"):
		previous_position = event.position
		dragging = true
	if event.is_action_released("right_click"):
		dragging = false
	
	if dragging:
		var delta = event.position - previous_position
		position -= delta / zoom
		previous_position = event.position
	
	if event.is_action("scroll_down"):
		target_zoom = max(target_zoom - ZOOM_INCREMENT, min_zoom)
		set_physics_process(true)
	
	if event.is_action("scroll_up"):
		target_zoom = min(target_zoom + ZOOM_INCREMENT, max_zoom)
		set_physics_process(true)


func _physics_process(delta: float) -> void:
	zoom = lerp(zoom, target_zoom * Vector2.ONE, ZOOM_RATE * delta)
	set_physics_process(not is_equal_approx(zoom.x, target_zoom))
