extends CanvasLayer

func _enter_tree() -> void:
	layer = 1

func _on_Start_pressed() -> void:
	get_parent().game_start()
	layer = -1

func _on_Settings_pressed() -> void:
	get_parent().add_child(load("res://scenes/menu/Settings.tscn").instance())
	get_parent().remove_child(self)


func _on_Quit_pressed() -> void:
	get_tree().quit()
