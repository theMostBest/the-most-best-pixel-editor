extends ColorPickerButton

func _ready() -> void:
	color = PixelEditor.current_color;

func _on_color_changed(color: Color) -> void:
	PixelEditor.current_color = color;
