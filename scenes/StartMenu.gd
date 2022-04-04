extends CanvasLayer

func _enter_tree() -> void:
	layer = 1

func _on_Start_pressed() -> void:
	get_parent().game_start()
	layer = -1

func _on_Settings_pressed() -> void:
	pass # Replace with function body.


func _on_Quit_pressed() -> void:
	get_tree().quit()
