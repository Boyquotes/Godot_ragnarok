extends HBoxContainer

func _ready() -> void:
	PlayerData.connect("bullet_speed_changed", self, "on_Player_bspeed_changed")
	PlayerData.connect("points_changed", self, "on_points_changed")

func _on_Button_pressed() -> void:
	PlayerData.bullet_speed += 50
	PlayerData.points -= 1

func on_Player_bspeed_changed() -> void:
	$dmg.text = str(PlayerData.bullet_speed)

func on_points_changed() -> void:
	if (PlayerData.points == 0):
		$Button.visible = false
	else:
		$Button.visible = true
