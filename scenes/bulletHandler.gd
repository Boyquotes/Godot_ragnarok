extends Node

var normalSpeed = 300
var normalBullet = preload("res://scenes/NormalBullet.tscn")
var bigBullet = preload("res://scenes/BigBullet.tscn")

enum bulletType {
	normal,
	big
}

func _ready():
	pass

func normal_settings(bullet, position, direction, friendly):
	bullet.position = position
	add_child(bullet)
	bullet.gravity_scale = 0
	bullet.apply_impulse(Vector2(), direction*normalSpeed)
	if (friendly):
		bullet.collision_mask = Bullet.bullet_mask.friendly
	else:
		bullet.collision_mask = Bullet.bullet_mask.agressive

func createBullet(bullet_type, position, direction, friendly):
	match(bullet_type):
		bulletType.normal:
			var bullet = normalBullet.instance()
			normal_settings(bullet, position, direction, friendly)
		bulletType.big:
			var bullet = bigBullet.instance()
			normal_settings(bullet, position, direction, friendly)

func get_texture(bullet_type):
	match bullet_type:
		bulletType.normal:
			var bullet = normalBullet.instance()
			return bullet.get_node("Bullet").texture
		bulletType.big:
			var bullet = bigBullet.instance()
			return bullet.get_node("Bullet").texture
