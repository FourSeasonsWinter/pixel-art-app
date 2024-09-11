extends Node

@onready var camera: Camera2D = $Camera2D
@onready var hud: Control = $hud
@onready var canvas_background: ColorRect = $CanvasBackground
@export var width: int = 8
@export var height: int = 8
var pixel_scene := preload("res://scenes/pixel.tscn")
var pixel_size := 16
var grid := {}

func _ready() -> void:
	for y in height:
		for x in width:
			var pixel = pixel_scene.instantiate()
			pixel.position = Vector2(pixel_size * x, pixel_size * y)
			grid[Vector2i(x, y)] = pixel
			call_deferred("add_child", pixel)
	
	camera.position.x = pixel_size * (width / 2)
	camera.position.y = pixel_size * (height / 2)
	
	camera.limit_left = pixel_size * (width / 2) - 800
	camera.limit_right = pixel_size * (width / 2) + 800
	camera.limit_top = pixel_size * (height / 2) - 600
	camera.limit_bottom = pixel_size * (height / 2) + 600
	
	canvas_background.size = Vector2(pixel_size * width, pixel_size * height)


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("save"):
		hud.show_image_saved_notification("gengar", save_image())


func save_image() -> bool:
	var image = Image.create_empty(width, height, false, Image.FORMAT_RGBA8)
	
	for y in range(height):
		for x in range(width):
			var color = grid[Vector2i(x, y)].color
			image.set_pixel(x, y, color)
	
	var file_path = "res://pixel_art.png"
	var is_error = image.save_png(file_path)
	return is_error != OK
