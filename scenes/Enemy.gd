extends KinematicBody2D

var speed = 100
var jumpForce = -500
var gravity = 1270
var damage = 10

enum state {
	sleep, 
	awake
}

var current_state = state.sleep
var target_near = false
var target : PhysicsBody2D
var direction = 0
var velocity = Vector2()
var awake_timer = 0
var awake_time = 6

var deleting = false
var hp = 100
var max_hp = 100


onready var animation = $AnimationTree
onready var anim_state_machine = animation.get("parameters/playback")
onready var hp_bar = $TextureProgress

onready var raycast = $TimeMapRayCast
onready var hero_raycast = $PlayerRayCast

func state_check() -> void:
	if(target_near):
		if (awake_timer >= 0):
			current_state = state.awake
			return
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(position, target.position, [self], collision_mask + 1)
		if result:
			if (result.collider.name == "Player"):
				awake_timer = awake_time
				current_state = state.awake
				return
	current_state = state.sleep
	
func move() -> void:
	if (abs((position - target.position).x) > 25):
		if ((position - target.position).x > 0):
			direction = -1
		else:
			direction = 1
	else:
		direction = 0
		
	if (direction != 0):
		raycast.cast_to = Vector2(35 * direction, 0)
		hero_raycast.cast_to = Vector2(30 * direction, 0)
	
	var ray_result = raycast.get_collider()
	if(ray_result):
		velocity.y = jumpForce
	
func _physics_process(delta) -> void:
	state_check()
	
	if is_on_floor() && velocity.y > 0:
		velocity.y = 0
		
	velocity.y += gravity * delta
	velocity.x = direction * speed
	
	move_and_slide(velocity, Vector2(0, -1))
	
	var player_near = hero_raycast.get_collider()
	if(player_near):
		target.hit(damage)
	
func _process(delta) -> void:
	
	awake_timer -= delta
	
	if (direction != 0):
		animation.set("parameters/Idle/blend_position", Vector2(direction, 0))
		animation.set("parameters/Move/blend_position", Vector2(direction, 0))
		animation.set("parameters/Damaged/blend_position", Vector2(direction, 0))
	match current_state:
		state.sleep:
			anim_state_machine.travel("Idle")
			velocity.x = 0
		state.awake:
			anim_state_machine.travel("Move")
			move()
			
	if(deleting):
		get_parent().remove_child(self)
	
	pass
	

func _on_Vision_body_entered(body) -> void:
	if (body.name == "Player"):
		target_near = true
		target = body

func _on_Vision_body_exited(body) -> void:
	if (body.name == "Player"):
		target_near = false

func change_hp(damage) -> void:
	hp -= damage
	hp_bar.value = hp*100/max_hp
	anim_state_machine.start("Damaged")
	if(hp <= 0):
		deleting = true

func delete() -> void:
	if(deleting):
		get_parent().remove_child(self)

func hit(damage) -> void:
	change_hp(damage)
		

func _on_htibox_body_entered(body) -> void:
	if "Bullet" in body.name:
		change_hp(body.damage)
		body.deleting = true
