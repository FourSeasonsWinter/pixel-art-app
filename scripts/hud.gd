extends Control

@onready var color_picker: ColorPicker = $CanvasLayer/ColorPick/ColorPicker
@onready var color_palette: Container = $CanvasLayer/ColorPalette
@onready var animation_player: AnimationPlayer = $CanvasLayer/ColorPick/AnimationPlayer
@onready var color_hex_input: TextEdit = $CanvasLayer/ColorPick/ColorHexInput
@onready var palette_background: Panel = $CanvasLayer/PaletteBackground
var is_color_picker_visible := false


func _ready() -> void:
	palette_background.size.x = color_palette.size.x
	palette_background.size.y = 2.0
	palette_background.position = color_palette.position
	Globals.connect("current_color_changed", on_current_color_changed)


func _on_show_hide_pressed() -> void:
	if not is_color_picker_visible:
		animation_player.play("move")
		is_color_picker_visible = true


func _on_close_pressed() -> void:
	animation_player.play("move_back")
	is_color_picker_visible = false


func _on_add_pressed() -> void:
	add_color_to_palette(color_picker.color)


func _on_color_picker_color_changed(color: Color) -> void:
	Globals.current_color = color
	color_hex_input.text = color.to_html()


func _on_color_hex_input_changed() -> void:
	color_picker.color = Color.from_string(color_hex_input.text, Color.WHITE)


func _on_color_palette_color_deleted() -> void:
	if not is_odd(Globals.current_palette.size()):
		palette_background.size.y -= 33.0


func on_current_color_changed():
	color_picker.color = Globals.current_color


func add_color_to_palette(color: Color) -> void:
	if color_palette.add_color(color):
		if is_odd(Globals.current_palette.size()):
			palette_background.size.y += 33.0


func is_odd(n: int) -> bool:
	return n % 2 != 0


func show_image_saved_notification(project_name: String, is_error: bool) -> void :
	var text: String
	if not is_error:
		text = "\"[color=green]" + project_name + "[/color]\" saved!"
	else:
		text = "Failed to save."
	$CanvasLayer/ImageSavedNotification/RichTextLabel.text = text
