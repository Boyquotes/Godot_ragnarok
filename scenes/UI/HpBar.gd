extends HBoxContainer

onready var bar = $TextureProgress

func _ready():
	PlayerData.connect("hp_changed", self, "on_player_hp_changed")
	
func on_player_hp_changed() -> void:
	bar.value = PlayerData.hp*100/PlayerData.max_hp
