extends HSlider


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
