extends Area2D

func _on_button_body_entered(body: Node2D) -> void:
		if body.is_in_group("player"):
			queue_free()


func _on_button_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
			queue_free()
