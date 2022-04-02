extends HBoxContainer

onready var bar = $TextureProgress

func update_bar(percent):
	bar.value = percent
