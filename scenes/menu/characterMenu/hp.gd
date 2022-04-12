extends HBoxContainer

func _ready() -> void:
	PlayerData.connect("max_hp_changed", self, "on_Player_hp_changed")
	PlayerData.connect("points_changed", self, "on_points_changed")
	
func _on_Button_pressed() -> void:
	PlayerData.max_hp_change(50)
	PlayerData.points -= 1

func on_Player_hp_changed() -> void:
	$dmg.text = str(PlayerData.max_hp)

func on_points_changed() -> void:
	if (PlayerData.points == 0):
		$Button.visible = false
	else:
		$Button.visible = true
