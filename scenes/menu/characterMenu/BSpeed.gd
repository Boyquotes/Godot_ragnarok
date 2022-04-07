extends HBoxContainer

func _ready():
	PlayerData.connect("bullet_speed_changed", self, "on_Player_bspeed_changed")

func _on_Button_pressed():
	PlayerData.bullet_speed += 50

func on_Player_bspeed_changed():
	$dmg.text = str(PlayerData.bullet_speed)
