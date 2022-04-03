extends CanvasLayer

func _ready():
	$Timer.start()

func _on_Timer_timeout():
	$Level1Label.hide()
	$Timer.stop()
