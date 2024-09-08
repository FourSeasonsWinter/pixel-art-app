extends Node

@onready var camera: Camera2D = $Camera2D
@onready var hud: Control = $hud
@onready var background: ColorRect = $Background
@onready var paper: ColorRect = $Paper
@export var width := 8
@export var height := 8
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


func print_grid() -> void:
	for y in height:
		var line := []
		for x in width:
			line.append(grid[Vector2i(x, y)].color.to_html())
		
		print(line)
