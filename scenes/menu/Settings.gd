extends CanvasLayer

func _ready():
	pass # Replace with function body.

func _on_VolumeSl_value_changed(value):
	if (value != $Control/VBoxContainer/Volume/VolumeSl.min_value):
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	else:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -100)


func _on_Back_pressed():
	get_parent().add_child(get_parent().main_menu)
	get_parent().remove_child(self)
