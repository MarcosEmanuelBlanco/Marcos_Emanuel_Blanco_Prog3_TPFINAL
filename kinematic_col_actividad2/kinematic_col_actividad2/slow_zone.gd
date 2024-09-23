extends Area2D

@export var slow_power = 120
var trapped_body = null
var player_dead = false
func _physics_process(delta):
	if trapped_body != null:
		trapped_body.slow(-slow_power)
	if player_dead:
		trapped_body = null

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		trapped_body = body

func _on_body_exited(body: Node2D) -> void:
	if trapped_body != null:
		trapped_body.slow(slow_power)
		trapped_body = null


func _on_player_death() -> void:
	player_dead = true
