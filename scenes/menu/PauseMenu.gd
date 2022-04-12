extends CanvasLayer

signal resumed
signal quited

func set_visible(visible : bool) -> void:
	$ColorRect.visible = visible

func _on_Resume_pressed() -> void:
	emit_signal("resumed")


func _on_Quit_pressed() -> void:
	emit_signal("quited")
