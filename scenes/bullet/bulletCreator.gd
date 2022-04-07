extends Node

func normal_settings(bullet, position, direction, friendly, damage, speed) -> void:
	bullet.position = position
	bullet.damage = damage
	add_child(bullet)
	bullet.gravity_scale = 0
	bullet.apply_impulse(Vector2(), direction*speed)
	if (friendly):
		bullet.collision_mask = Bullet.bullet_mask.friendly
	else:
		bullet.collision_mask = Bullet.bullet_mask.agressive

func get_texture(bullet_scene):
	var bullet = bullet_scene.instance()
	return bullet.get_node("Bullet").texture

func create_bullet(bulletScene, position, direction, friendly, damage, speed) ->void:
	var bullet = bulletScene.instance()
	normal_settings(bullet, position, direction, friendly, damage, speed)
	
func get_current_texture():
	get_texture(PlayerData.current_bullet)
	
func create_current_bullet(position, direction):
	create_bullet(PlayerData.current_bullet, position, direction, true, PlayerData.damage, PlayerData.bullet_speed)
