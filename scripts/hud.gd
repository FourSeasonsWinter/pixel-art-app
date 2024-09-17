extends Control
signal save_image
signal export_image
signal create_image(name: String, width: int, height: int)

@onready var color_picker: ColorPicker = $CanvasLayer/ColorPick/ColorPicker
@onready var color_palette: Container = $CanvasLayer/ColorPalette
@onready var animation_player: AnimationPlayer = $CanvasLayer/ColorPick/AnimationPlayer
@onready var color_hex_input: TextEdit = $CanvasLayer/ColorPick/ColorHexInput
@onready var palette_background: Panel = $CanvasLayer/PaletteBackground
@onready var width_input: LineEdit = $CanvasLayer/NewProjectWindow/Width
var is_color_picker_visible := false


func _ready() -> void:
	palette_background.size.x = color_palette.size.x + 4.0
	palette_background.size.y = 22.0
	palette_background.position.x = color_palette.position.x - 4.0
	palette_background.position.y = color_palette.position.y - 20.0
	Globals.connect("color_changed", _on_current_color_changed)
	
	$Menu/File/Dropdown.hide()
	$CanvasLayer/NewProjectWindow.hide()


func show_notification(notification_text: String) -> void:
	$CanvasLayer/ImageSavedNotification.text = notification_text
	$CanvasLayer/ImageSavedNotification/AnimationPlayer.play("show")


func set_tool_label(text: String) -> void:
	$CanvasLayer/ToolLabel.text = text


func set_new_project(project_name: String) -> void:
	$CanvasLayer/ProjectName.text = project_name


#region CanvasLayer
func _on_show_hide_pressed() -> void:
	if not is_color_picker_visible:
		animation_player.play("move")
		is_color_picker_visible = true


func _on_close_pressed() -> void:
	animation_player.play("move_back")
	is_color_picker_visible = false


func _on_add_pressed() -> void:
	_add_color_to_palette(color_picker.color)


func _on_color_picker_color_changed(color: Color) -> void:
	Globals.color = color
	color_hex_input.text = color.to_html()


func _on_color_hex_input_changed() -> void:
	color_picker.color = Color.from_string(color_hex_input.text, Color.WHITE)


func _on_color_palette_color_deleted() -> void:
	if not _is_odd(Globals.palette.size()):
		palette_background.size.y -= 33.0


func _on_current_color_changed() -> void:
	color_picker.color = Globals.color


func _add_color_to_palette(color: Color) -> void:
	if color_palette.add_color(color):
		if _is_odd(Globals.palette.size()):
			palette_background.size.y += 33.0


func _is_odd(n: int) -> bool:
	return n % 2 != 0
#endregion

#region Menu
func _on_file_button_pressed() -> void:
	if not $Menu/File/Dropdown.visible:
		$Menu/File/Dropdown.show()
		return
	$Menu/File/Dropdown.hide()


func _on_save_pressed() -> void:
	save_image.emit()
	$Menu/File/Dropdown.hide()


func _on_new_pressed() -> void:
	$CanvasLayer/NewProjectWindow/Name.text = ""
	$CanvasLayer/NewProjectWindow/Height.text = ""
	$CanvasLayer/NewProjectWindow/Width.text = ""
	$CanvasLayer/NewProjectWindow.show()
	$Menu/File/Dropdown.hide()


func _on_export_pressed() -> void:
	export_image.emit()
	$Menu/File/Dropdown.hide()
#endregion

#region NewProjectWindow
func _on_cancel_pressed() -> void:
	$CanvasLayer/NewProjectWindow.hide()


func _on_confirm_pressed() -> void:
	var name: String = $CanvasLayer/NewProjectWindow/Name.text
	var width: String = $CanvasLayer/NewProjectWindow/Width.text
	var height: String = $CanvasLayer/NewProjectWindow/Height.text
	
	if not width.is_valid_int() or not height.is_valid_int():
		return
	
	var w: int = width.to_int()
	var h: int = height.to_int()
	
	if (w > 64 or w < 1) or (h > 64 or h < 1):
		return
	
	if name.is_empty():
		return
	
	create_image.emit(name, w, h)
	$CanvasLayer/NewProjectWindow.hide()
#endregion
