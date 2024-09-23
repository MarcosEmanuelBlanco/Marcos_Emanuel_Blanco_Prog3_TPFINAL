extends CharacterBody2D

var direction:Vector2
var damage_boost = false
@export var projVel:int
func _physics_process(delta):
	velocity = projVel * direction.normalized()
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.is_in_group("enemy"):
		body._destroy_enemy()
		queue_free()
	if body.is_in_group("breakable_wall"):
		queue_free()
	if body.is_in_group("breakable_wall") && damage_boost:
		body._destroy()
		queue_free()
	if body.is_in_group("wall"):
		queue_free()
	if body.is_in_group("box"):
		queue_free()
	if body.is_in_group("big_enemy"):
		body._hurt(1)
		queue_free()
	if body.is_in_group("big_enemy") && damage_boost:
		body._hurt(2)
		queue_free()
func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
