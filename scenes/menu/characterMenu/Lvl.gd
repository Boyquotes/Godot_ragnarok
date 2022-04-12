extends HBoxContainer

func _ready():
	PlayerData.connect("lvl_changed", self, "on_lvl_changed")

func on_lvl_changed() -> void:
	$dmg.text = str(PlayerData.lvl)
