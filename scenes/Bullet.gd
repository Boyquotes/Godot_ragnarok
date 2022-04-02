extends RigidBody2D

enum bullet_mask {
	friendly = 4+8 #enemy && wall mask group
	agressive = 4+1 #wall && player mask group
}

var time = 0
var livetime = 5
var deleting = false
var damage = 10

func _init():
	livetime = 5
	damage = 10

func _ready():
	pass
	
func _process(delta):
	time += delta
	if(time >= livetime || deleting):
		get_parent().remove_child(self)

func _on_Area2D_body_entered(body):
	var test = body.collision_layer
	if (collision_mask == bullet_mask.friendly):
		if (body.collision_layer != 1):
			deleting = true
	elif (body.collision_layer != 8):
		deleting = true
	
