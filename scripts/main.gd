extends Node

@onready var camera: Camera2D = $Camera2D
@onready var hud: Control = $hud
@onready var canvas_background: ColorRect = $CanvasBackground

@export var project_name := "gengar"
@export var width := 8
@export var height := 8
@export var resolution := Vector2i(64, 64)
@export var background_color := Color.TRANSPARENT

var grid := {}
var last_color_selected: Color
var canvas: Node2D

const pixel_size = 16
const canvas_scene = preload("res://scenes/canvas.tscn")
const canvas_index = 4

func _ready() -> void:
	create_canvas()
	set_camera()


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("brush"):
		Globals.color = last_color_selected
		hud.set_tool_label("Brush")
	
	if event.is_action_pressed("eraser"):
		Globals.color = background_color
		hud.set_tool_label("Eraser")
	
	if event.is_action_pressed("save"):
		save_image()


func create_canvas() -> void:
	var c = canvas_scene.instantiate()
	c.width = width
	c.height = height
	c.background_color = background_color
	c.pixel_size = pixel_size
	c.create()
	add_child(c)
	
	canvas = c
	canvas_background.size = Vector2(pixel_size * width, pixel_size * height)


func set_camera() -> void:
	camera.position.x = pixel_size * (width / 2)
	camera.position.y = pixel_size * (height / 2)
	
	camera.limit_left = pixel_size * (width / 2) - 800
	camera.limit_right = pixel_size * (width / 2) + 800
	camera.limit_top = pixel_size * (height / 2) - 600
	camera.limit_bottom = pixel_size * (height / 2) + 600


func save_image() -> void:
	var image = Image.create_empty(width, height, false, Image.FORMAT_RGBA8)
	
	for y in range(height):
		for x in range(width):
			var color = canvas.grid[Vector2i(x, y)].color
			image.set_pixel(x, y, color)
	
	var file_path = "res://" + project_name + ".png"
	var error = image.save_png(file_path) != OK
	var notification_text: String
	
	if not error:
		notification_text = "\"[color=green]" + project_name + "[/color]\" saved as a png file!"
	else:
		notification_text = "Failed to save."
	
	hud.show_notification(notification_text)


func _on_hud_create_image(name: String, w: int, h: int) -> void:
	project_name = name
	width = w
	height = h
	
	get_child(canvas_index).queue_free()
	create_canvas()
	set_camera()
	hud.set_new_project(name)
