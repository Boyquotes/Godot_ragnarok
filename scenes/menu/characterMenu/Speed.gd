extends HBoxContainer

func _ready():
	PlayerData.connect("attack_speed_changed", self, "on_Player_speed_changed")

func _on_Button_pressed():
	PlayerData.attack_speed /= 2

func on_Player_speed_changed():
	$dmg.text = str(PlayerData.attack_speed)
