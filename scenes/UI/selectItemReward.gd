extends Control

signal reward_changed

onready var buttons = $ColorRect/VBoxContainer/ItemButtons

export (Array, Resource) var items = [null, null, null] setget set_item

func set_item(value : Resource) -> void:
	emit_signal("reward_changed")
	set_button_textures()

func _ready():
	PlayerData.connect("lvl_changed", self, "on_lvl_changed")
	self.items[0] = load("res://resources/shoes.tres")
	
func on_lvl_changed():
	visible = true

func set_button_textures() -> void:
	for i in range(1):
		var button : Button = buttons.get_child(i)
		if (items[i] != null):
			button.icon = items[i].texture
		else:
			button.icon = load("res://res/items/emptyItem.png")

func button_pressed(value : int) -> void:
	var is_item_got : bool = PlayerData.inventory.set_item(items[value])
	if (is_item_got):
		items[value] = null
		visible = false

func _on_Button1_pressed():
	button_pressed(0)
	

