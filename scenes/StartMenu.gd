extends CanvasLayer

func _ready():
	pass # Replace with function body.
	
func _on_Start_pressed():
	get_parent().game_start()
	layer = -1
	pass # Replace with function body.


func _on_Settings_pressed():
	pass # Replace with function body.


func _on_Quit_pressed():
	get_tree().quit()
	pass # Replace with function body.
