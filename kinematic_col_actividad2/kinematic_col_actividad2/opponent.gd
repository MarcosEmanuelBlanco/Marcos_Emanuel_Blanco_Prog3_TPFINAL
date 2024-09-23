extends CharacterBody2D

@export var opponent_value:int
signal spawnerContact
signal gone
signal dead
func _on_spikes_body_entered(body: Node2D) -> void:
	if body.is_in_group("opponent"):
		gone.emit()
		body._opponent_die()

func _opponent_die():
	if is_queued_for_deletion():
		return
	dead.emit()
	queue_free()

func _on_enemy_spawner_body_entered(body: Node2D) -> void:
	if body.is_in_group("opponent"):
		spawnerContact.emit()

func _on_goal_body_entered(body: Node2D) -> void:
	if body.is_in_group("opponent"):
		gone.emit()
		queue_free()

func _on_spikes_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("opponent"):
		gone.emit()
		body._opponent_die()
