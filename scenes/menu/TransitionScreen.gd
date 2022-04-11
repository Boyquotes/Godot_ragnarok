extends CanvasLayer

signal transitioned

func transition() -> void:
	$AnimationPlayer.play("fade_in_color")

func _on_AnimationPlayer_animation_finished(anim_name) -> void:
	if(anim_name == "fade_in_color"):
		emit_signal("transitioned")
		$AnimationPlayer.play("fade_out")
