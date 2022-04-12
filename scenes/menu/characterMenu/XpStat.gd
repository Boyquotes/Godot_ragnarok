extends HBoxContainer

func _ready():
	PlayerData.connect("xp_changed", self, "on_xp_changed")

func on_xp_changed() -> void:
	$dmg.text = str(PlayerData.xp)
