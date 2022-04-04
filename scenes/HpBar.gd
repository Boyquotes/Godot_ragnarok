extends HBoxContainer

onready var bar = $TextureProgress

func update_bar(percent) -> void:
	bar.value = percent
