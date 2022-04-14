extends Resource
class_name Inventory

signal item_changed

export(Array, Resource) var slots = [null, null, null, null, null, null] setget set_item

func set_item(item : Item) -> bool:
	if(slots.has(item) && item != null):
		var slot = slots[slots.find(item)]
		slot.lvl += 1
		emit_signal("item_changed")
		return true
	for i in range(6):
		if(slots[i] == null):
			slots[i] = item
			emit_signal("item_changed")
			return true
	return false

func remove_item(index : int) -> void:
	slots[index] = null
