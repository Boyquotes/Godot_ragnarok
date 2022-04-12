extends Node

enum bullet_mask {
	friendly = 4+8 #enemy && wall mask group
	agressive = 4+1 #wall && player mask group
}

var normalBullet = load("res://scenes/bullet/NormalBullet.tscn")
var bigBullet = load("res://scenes/bullet/BigBullet.tscn")
