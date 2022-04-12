extends TextureProgress

func _ready() -> void:
	PlayerData.connect("xp_changed", self, "on_player_xp_changed")
	
func on_player_xp_changed() -> void:
	value = PlayerData.xp*100/(PlayerData.lvl*250)
