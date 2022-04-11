extends Camera2D

onready var player = get_parent().get_node("Player")

func _process(delta) -> void:
	position = lerp(position, player.position, 0.1)
