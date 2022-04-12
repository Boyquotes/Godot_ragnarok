extends HBoxContainer

func _ready():
	PlayerData.connect("points_changed", self, "on_points_changed")

func on_points_changed() -> void:
	$dmg.text = str(PlayerData.points)
