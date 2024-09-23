
extends CharacterBody2D
@export var player:CharacterBody2D
@export var speed:int
signal give_score
func _physics_process(delta):
	var player_group = get_tree().get_nodes_in_group("player")
	if player_group.size()>0:
		position = lerp(global_position, player.global_position, delta/speed)
		look_at(player.global_position)
		move_and_slide()

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		body._die()

func _destroy_enemy():
	give_score.emit()
	queue_free()

func _on_goal_body_entered(body: Node2D) -> void:
	if null:
		return
	
	queue_free()
