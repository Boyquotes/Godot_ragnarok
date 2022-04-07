extends HBoxContainer

func _ready():
	PlayerData.connect("max_hp_changed", self, "on_Player_hp_changed")

func _on_Button_pressed():
	PlayerData.max_hp_change(50)

func on_Player_hp_changed():
	$dmg.text = str(PlayerData.max_hp)

