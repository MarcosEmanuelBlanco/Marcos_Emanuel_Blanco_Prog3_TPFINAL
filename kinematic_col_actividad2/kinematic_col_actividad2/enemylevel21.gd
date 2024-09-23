extends CharacterBody2D
@export var opponent:CharacterBody2D
@export var player:CharacterBody2D
@export var speed:int
var target
var attack = false
signal give_score
func _ready() -> void:
	set_physics_process(false)
	target = true

func _physics_process(delta):
	var player_group = get_tree().get_nodes_in_group("player")
	if target == true:
		position = lerp(global_position, opponent.global_position, delta/speed)
		look_at(opponent.global_position)
		move_and_slide()
	else:
		if player_group.size()>0:
			position = lerp(global_position, player.global_position, delta/speed)
			look_at(player.global_position)
			move_and_slide()
	
func _destroy_enemy():
	give_score.emit()
	queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("player") && attack == true:
		body._die()
		target = false
	if body.is_in_group("opponent") && attack == true:
		body._opponent_die()
		target = false

func _on_goal_body_entered(body: Node2D) -> void:
	if null:
		return
	target = false
	queue_free()

func _on_opponent_spawner_contact() -> void:
	set_physics_process(true)
	attack = true
	
func _on_opponent_gone() -> void:
	target = false

func _on_opponent_gone_2() -> void:
	target = false

func _on_enemy_spawner_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		show()
		set_physics_process(true)
		attack = true
