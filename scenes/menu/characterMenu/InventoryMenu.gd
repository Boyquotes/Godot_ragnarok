extends VBoxContainer

func _ready() -> void:
	PlayerData.connect("inventory_changed", self, "on_inventory_changed")
	

func on_inventory_changed() -> void:
	for i in range(PlayerData.inventory.slots.size()):
		var item_texture = $Items.get_child(i)
		var item = PlayerData.inventory.slots[i]
		if (item != null):
			item_texture.texture = item.texture
