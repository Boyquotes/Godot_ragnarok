extends Node

export (int) var xp = 0
export (Array, Resource) var items = []
var opened : bool = false

func _ready():
	PlayerData.connect("interaction", self, "on_interaction")

func _on_Area2D_body_entered(body):
	if(body.name == "Player" && !opened):
		$Control/Label.visible = true

func _on_Area2D_body_exited(body):
	if(body.name == "Player" && !opened):
		$Control/Label.visible = false

func on_interaction():
	if (!PlayerData.interacted && $Control/Label.visible && !opened):
		chest_open()
		
func chest_open():
	PlayerData.xp += xp
	var inventory : Inventory = PlayerData.inventory
	for i in items:
		inventory.set_item(i)
	opened = true
	$Control/Label.visible = false
