extends KinematicBody2D

var direction = Vector2()
var velocity = Vector2()

onready var bullet_creator = get_parent().get_node("bulletCreator")

onready var animation = $AnimationTree
onready var anim_state_machine = animation.get("parameters/playback")
onready var immune_amin = $shieldAnim

func fire() -> void:
	if (PlayerData.attack_timer <= 0):
		var point = get_global_mouse_position()
		var bullet_direction = point - position;
		bullet_direction = bullet_direction.normalized()
		bullet_creator.create_current_bullet(position, bullet_direction)
		PlayerData.attack_timer = PlayerData.attack_speed
	
func switch_weapon(bullet) -> void:
	PlayerData.current_bullet = bullet

func get_input() -> void:
	if Input.is_action_just_pressed("PlayerLeft"):
		direction.x -= 1
		
	elif Input.is_action_just_pressed("PlayerRight"):
		direction.x += 1
		
	elif Input.is_action_just_pressed("PlayerJump"):
		if (PlayerData.jump_counter < PlayerData.jump_max_count):
			PlayerData.jump_counter += 1
			velocity.y = PlayerData.jump_force
			
	if Input.is_action_just_released("PlayerLeft"):
		direction.x += 1
		
	elif Input.is_action_just_released("PlayerRight"):
		direction.x -= 1
		
	if Input.is_action_just_pressed("LMB"):
		fire()
		
	if Input.is_action_just_pressed("SwitchWeapon"):
		if (PlayerData.current_bullet != BulletHandler.bigBullet):
			switch_weapon(BulletHandler.bigBullet)
		else:
			switch_weapon(BulletHandler.normalBullet)
	
func animation_update() -> void:
	if direction.x != 0:
		animation.set("parameters/Idle/blend_position", direction)
		animation.set("parameters/Move/blend_position", direction)
		anim_state_machine.travel("Move")
	elif direction.x == 0:
		anim_state_machine.travel("Idle")
	
func _process(delta) -> void:
		get_input()
		if(PlayerData.immunity_timer > 0):
			PlayerData.immunity_timer -= delta
		if(PlayerData.attack_timer > 0):
			PlayerData.attack_timer -= delta
		elif ($Shield.visible == true):
			$Shield.visible = false

func _physics_process(delta) -> void:
	
	if is_on_floor() && velocity.y > 0:
		PlayerData.jump_counter = 0
		velocity.y = 0
		
	velocity.x = direction.x * PlayerData.speed
	velocity.y += PlayerData.gravity*delta
	
	animation_update()
	
	move_and_slide(velocity, Vector2(0, -1))

func kill() -> void:
	get_tree().reload_current_scene()

func change_hp(damage) -> void:
	PlayerData.hp -= damage
	if(PlayerData.hp <= 0):
		kill()

func hit(damage) -> void:
	if(PlayerData.immunity_timer <= 0):
		change_hp(damage)
		PlayerData.immunity_timer = PlayerData.immunity_time
		immune_amin.play("shield_idle")
		$Shield.visible = true

func _on_Area2D_body_entered(body) -> void:
	if "Bullet" in body.name:
		hit(body.damage)
		body.deleting = true
