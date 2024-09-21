extends Node2D

var width: int
var height: int
var background_color: Color
var grid := {}
var pixel_size: int

const pixel_scene = preload("res://scenes/pixel.tscn")

func create() -> void:
	var thread = Thread.new()
	thread.start(_create)


func create_from_image(path: String) -> void:
	var thread = Thread.new()
	thread.start(_create_from_image.bind(path))


func set_pixel(x: int, y: int, color: Color) -> void:
	if grid.has(Vector2i(x, y)):
		grid[Vector2i(x, y)].color = color


func _create() -> void:
	for y in height:
		for x in width:
			var pixel = pixel_scene.instantiate()
			pixel.position = Vector2(pixel_size * x, pixel_size * y)
			pixel.color = background_color
			grid[Vector2i(x, y)] = pixel
			call_deferred("add_child", pixel)


func _create_from_image(path: String) -> void:
	var image = Image.load_from_file(path)
	
	for y in height:
		for x in width:
			var pixel = pixel_scene.instantiate()
			pixel.position = Vector2(pixel_size * x, pixel_size * y)
			pixel.color = image.get_pixel(x, y)
			grid[Vector2i(x, y)] = pixel
			call_deferred("add_child", pixel)
