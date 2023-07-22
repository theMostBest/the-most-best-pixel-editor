class_name ThePopupMenu
extends PopupMenu

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		popup();
		pass
