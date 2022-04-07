extends Node

signal hp_changed
signal damage_changed
signal attack_speed_changed
signal bullet_speed_changed
signal max_hp_changed
signal bullet_changed

var speed = 400
var jump_force = -700
var gravity = 1270
var jump_counter = 0
var jump_max_count = 1

var hp = 100 setget hp_set
var max_hp = 100 setget max_hp_changed
var immunity_timer = 0
var immunity_time = 1

#stats
var damage = 10 setget damage_set
var attack_speed = 1.0 setget attack_speed_set
var attack_timer = 0
var bullet_speed = 300 setget bullet_speed_set

var current_bullet = BulletHandler.normalBullet setget current_bullet_set

func max_hp_change(value):
	var percent : float = float(hp)/max_hp
	self.max_hp += 50
	self.hp = int(max_hp*percent)

func hp_set(value):
	hp = value
	emit_signal("hp_changed")
	
func damage_set(value):
	damage = value
	emit_signal("damage_changed")
	
func attack_speed_set(value):
	attack_speed = value
	emit_signal("attack_speed_changed")
	
func bullet_speed_set(value):
	bullet_speed = value
	emit_signal("bullet_speed_changed")
	
func max_hp_changed(value):
	max_hp = value
	emit_signal("max_hp_changed")
	
func current_bullet_set(value):
	current_bullet = value
	emit_signal("bullet_changed")
