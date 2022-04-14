extends Resource
class_name Config

export (float) var volume = 0

func apply_config() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume)
