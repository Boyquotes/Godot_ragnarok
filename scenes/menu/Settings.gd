extends CanvasLayer

var config = preload("res://resources/config.tres")

func _ready():
	$Control/VBoxContainer/Volume/VolumeSl.value = config.volume

func _on_VolumeSl_value_changed(value):
	if (value != $Control/VBoxContainer/Volume/VolumeSl.min_value):
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
		config.volume = value
	else:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -100)
		config.volume = -100


func _on_Back_pressed():
	ResourceSaver.save("res://resources/config.tres", config)
	get_parent().add_child(get_parent().main_menu)
	get_parent().remove_child(self)
