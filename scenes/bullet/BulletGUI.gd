extends TextureRect

func _ready() -> void:
	PlayerData.connect("bullet_changed", self, "on_bullet_changed")

func on_bullet_changed() -> void:
	var texture = PlayerData.current_bullet.instance().get_node("Bullet").texture
	$BulletTexture.texture = texture
