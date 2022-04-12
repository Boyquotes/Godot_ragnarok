extends CanvasLayer

func set_visible(visible : bool) -> void:
	$Control.visible = visible

func _process(delta : float) -> void:
	if($Control.visible == true && Input.is_action_just_pressed("PlayerJump")):
		var loadedItem = load("res://resources/shoes.tres")
		PlayerData.inventory.set_item(loadedItem)
