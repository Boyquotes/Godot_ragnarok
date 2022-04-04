extends KinematicBody2D

var speed = 400
var jump_force = -700
var gravity = 1270
var jump_counter = 0
var jump_max_count = 1

var direction = Vector2()
var velocity = Vector2()

var hp = 100
var max_hp = 100
var immunity_timer = 0
var immunity_time = 1

onready var bullet_handler = get_parent().get_node("bulletHandler")
onready var current_bullet_type = bullet_handler.bulletType.normal
onready var hp_bar = get_parent().get_node("Interface/GUI/HpBar") 
onready var bullet_bar = get_parent().get_node("Interface/GUI/BulletGUI")

onready var animation = $AnimationTree
onready var anim_state_machine = animation.get("parameters/playback")
onready var immune_amin = $shieldAnim

func change_bullet(bullet_type) -> void:
	current_bullet_type = bullet_type

func fire() -> void:
	var point = get_global_mouse_position()
	var bullet_direction = point - position;
	bullet_direction = bullet_direction.normalized()
	
	bullet_handler.createBullet(current_bullet_type, position, bullet_direction, true)
	#true is a flag means bullet will hit enemy (false means bullet will hit player)
	
func switch_weapon(bullet_type) -> void:
	current_bullet_type = bullet_type
	bullet_bar.change_bullet(bullet_handler.get_texture(bullet_type))

func get_input() -> void:
	if Input.is_action_just_pressed("PlayerLeft"):
		direction.x -= 1
	elif Input.is_action_just_pressed("PlayerRight"):
		direction.x += 1
	elif Input.is_action_just_pressed("PlayerJump"):
		if (jump_counter < jump_max_count):
			jump_counter += 1
			velocity.y = jump_force
	if Input.is_action_just_released("PlayerLeft"):
		direction.x += 1
	elif Input.is_action_just_released("PlayerRight"):
		direction.x -= 1
	if Input.is_action_just_pressed("LMB"):
		fire()
	if Input.is_action_just_pressed("SwitchWeapon"):
		if (current_bullet_type != bullet_handler.bulletType.big):
			switch_weapon(bullet_handler.bulletType.big)
		else:
			switch_weapon(bullet_handler.bulletType.normal)
	
func animation_update() -> void:
	if direction.x != 0:
		animation.set("parameters/Idle/blend_position", direction)
		animation.set("parameters/Move/blend_position", direction)
		anim_state_machine.travel("Move")
	elif direction.x == 0:
		anim_state_machine.travel("Idle")
	
func _process(delta) -> void:
		get_input()
		if(immunity_timer > 0):
			immunity_timer -= delta
		elif ($Shield.visible == true):
			$Shield.visible = false

func _physics_process(delta) -> void:
	
	if is_on_floor() && velocity.y > 0:
		jump_counter = 0
		velocity.y = 0
		
	velocity.x = direction.x * speed
	velocity.y += gravity*delta
	
	animation_update()
	
	move_and_slide(velocity, Vector2(0, -1))

func kill() -> void:
	get_tree().reload_current_scene()

func change_hp(damage) -> void:
	hp -= damage
	hp_bar.update_bar(hp*100/max_hp)
	if(hp <= 0):
		kill()

func hit(damage) -> void:
	if(immunity_timer <= 0):
		change_hp(damage)
		immunity_timer = immunity_time
		immune_amin.play("shield_idle")
		$Shield.visible = true

func _on_Area2D_body_entered(body) -> void:
	if "Bullet" in body.name:
		hit(body.damage)
		body.deleting = true
