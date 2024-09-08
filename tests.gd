extends Node

@onready var text_edit: TextEdit = $TextEdit
@onready var color_rect: ColorRect = $ColorRect
@export var c: Color

func _on_text_changed() -> void:
	print("hex: #" + text_edit.text)
	color_rect.color = int(text_edit.text)
