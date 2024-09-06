extends Node

@onready var camera: Camera2D = $Camera2D
@onready var hud: Control = $hud
@export var width := 8
@export var height := 8
var pixel_scene := preload("res://pixel.tscn")
var pixel_size := 16

func _ready() -> void:
	for y in height:
		for x in width:
			var pixel = pixel_scene.instantiate()
			pixel.position = Vector2(pixel_size * x, pixel_size * y)
			add_child(pixel)
	
	camera.position.x = pixel_size * (width / 2)
	camera.position.y = pixel_size * (height / 2)
	
	camera.limit_left = pixel_size * (width / 2) - 800
	camera.limit_right = pixel_size * (width / 2) + 800
	camera.limit_top = pixel_size * (height / 2) - 600
	camera.limit_bottom = pixel_size * (height / 2) + 600
