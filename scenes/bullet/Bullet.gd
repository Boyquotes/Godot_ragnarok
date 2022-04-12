extends RigidBody2D
class_name Bullet

var time = 0
export (float) var livetime = 5
var deleting = false
export (int) var damage = 10

func _init() -> void:
	livetime = 5
	damage = 10

func _ready() -> void:
	
	pass
	
func _process(delta : float) -> void:
	time += delta
	if(time >= livetime || deleting):
		get_parent().remove_child(self)

func _on_Area2D_body_entered(body : PhysicsBody2D) -> void:
	if (collision_mask == BulletHandler.bullet_mask.friendly):
		if (body.collision_layer != 1):
			deleting = true
	elif (body.collision_layer != 8):
		deleting = true
	
