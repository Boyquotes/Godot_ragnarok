extends Node

func normal_settings(bullet : Bullet, position : Vector2, direction : Vector2,
friendly : int, damage : int, speed : int) -> void:
	bullet.position = position
	bullet.damage = damage
	add_child(bullet)
	bullet.gravity_scale = 0
	bullet.apply_impulse(Vector2(), direction*speed)
	if (friendly):
		bullet.collision_mask = BulletHandler.bullet_mask.friendly
	else:
		bullet.collision_mask = BulletHandler.bullet_mask.agressive

func get_texture(bullet_scene : PackedScene):
	var bullet = bullet_scene.instance()
	return bullet.get_node("Bullet").texture

func create_bullet(bulletScene : PackedScene, position : Vector2, direction : Vector2,
friendly : int, damage : int, speed : int) ->void:
	var bullet = bulletScene.instance()
	normal_settings(bullet, position, direction, friendly, damage, speed)
	
func get_current_texture() -> void:
	get_texture(PlayerData.current_bullet)
	
func create_current_bullet(position : Vector2, direction : Vector2) -> void:
	create_bullet(PlayerData.current_bullet, position, direction, true, PlayerData.damage, PlayerData.bullet_speed)
