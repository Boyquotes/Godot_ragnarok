extends HBoxContainer

func _ready() -> void:
	PlayerData.connect("attack_speed_changed", self, "on_Player_speed_changed")
	PlayerData.connect("points_changed", self, "on_points_changed")

func _on_Button_pressed() -> void:
	PlayerData.attack_speed /= 2
	PlayerData.points -= 1

func on_Player_speed_changed() -> void:
	$dmg.text = str(PlayerData.attack_speed)

func on_points_changed() -> void:
	if (PlayerData.points == 0):
		$Button.visible = false
	else:
		$Button.visible = true
