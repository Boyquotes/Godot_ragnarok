extends HBoxContainer

func _ready() -> void:
	PlayerData.connect("damage_changed", self, "on_Player_damage_changed")
	PlayerData.connect("points_changed", self, "on_points_changed")

func _on_Button_pressed() -> void:
	PlayerData.damage += 5
	PlayerData.points -= 1

func on_Player_damage_changed() -> void:
	$dmg.text = str(PlayerData.damage)

func on_points_changed() -> void:
	if (PlayerData.points == 0):
		$Button.visible = false
	else:
		$Button.visible = true
	
