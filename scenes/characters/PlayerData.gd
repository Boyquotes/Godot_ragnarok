extends Node

signal hp_changed
signal damage_changed
signal attack_speed_changed
signal bullet_speed_changed
signal max_hp_changed
signal bullet_changed
signal inventory_changed
signal xp_changed
signal lvl_changed
signal points_changed

var speed = 400
var jump_force = -700
var gravity = 1270
var jump_counter = 0
var jump_max_count = 1

var hp = 100 setget hp_set
var max_hp = 100 setget max_hp_changed
var immunity_timer = 0
var immunity_time = 1

var inventory = preload("res://resources/inventory.tres")
#stats
var damage = 10 setget damage_set
var attack_speed = 1.0 setget attack_speed_set
var attack_timer = 0
var bullet_speed = 300 setget bullet_speed_set

var current_bullet = BulletHandler.normalBullet setget current_bullet_set

var lvl = 1 setget lvl_set
var xp = 0 setget xp_set
var needed_xp = 250
var points = 3 setget points_set

func _ready():
	inventory.connect("item_changed", self, "on_inventory_changed")

func max_hp_change(value : int) -> void:
	var percent : float = float(hp)/max_hp
	self.max_hp += value
	self.hp = int(max_hp*percent)

func hp_set(value : int) -> void:
	hp = value
	emit_signal("hp_changed")
	
func damage_set(value : int) -> void:
	damage = value
	emit_signal("damage_changed")
	
func attack_speed_set(value : float) -> void:
	attack_speed = value
	emit_signal("attack_speed_changed")
	
func bullet_speed_set(value : int) -> void:
	bullet_speed = value
	emit_signal("bullet_speed_changed")
	
func max_hp_changed(value : int) -> void:
	max_hp = value
	emit_signal("max_hp_changed")
	
func current_bullet_set(value : PackedScene) -> void:
	current_bullet = value
	emit_signal("bullet_changed")

func xp_set(value : int) -> void:
	xp = value
	while (xp >= lvl*250):
		xp -= 250*lvl
		self.lvl += 1
	emit_signal("xp_changed")

func lvl_set(value : int) -> void:
	lvl = value
	self.points += 2
	emit_signal("lvl_changed")

func points_set(value : int) -> void:
	points = value
	emit_signal("points_changed")

func on_inventory_changed() -> void:
	for i in inventory.slots.size():
		var slot = inventory.slots[i]
		if (slot != null):
			self.max_hp_change(slot.hp)
			self.bullet_speed += slot.bullet_speed
			if (slot.attack_speed != 0):
				self.attack_speed /= slot.attack_speed
			self.damage += slot.damage
	emit_signal("inventory_changed")
