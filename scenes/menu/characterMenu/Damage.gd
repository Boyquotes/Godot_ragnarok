extends HBoxContainer

func _ready():
	PlayerData.connect("damage_changed", self, "on_Player_damage_changed")

func _on_Button_pressed():
	PlayerData.damage += 5

func on_Player_damage_changed():
	$dmg.text = str(PlayerData.damage)
