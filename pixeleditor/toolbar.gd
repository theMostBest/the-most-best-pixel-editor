extends HFlowContainer

# toolbar signal handling
# general format is: PixelEditor.toolbarState = PixelEditor.toolbarStates."something";

func _on_eraser_pressed() -> void:
	PixelEditor.toolbarState = PixelEditor.toolbarStates.ERASE;


func _on_fill_pressed() -> void:
	PixelEditor.toolbarState = PixelEditor.toolbarStates.FILL;


func _on_pencil_pressed() -> void:
	PixelEditor.toolbarState = PixelEditor.toolbarStates.DRAW;
