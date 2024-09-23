extends CharacterBody2D
signal destroyed
func _destroy():
	destroyed.emit()
	queue_free()
