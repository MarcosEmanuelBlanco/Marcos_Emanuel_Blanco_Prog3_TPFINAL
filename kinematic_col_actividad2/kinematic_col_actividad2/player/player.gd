@tool
extends CharacterBody2D
@onready var speed_pickup_timer = $SpeedPickupTimer
@onready var damage_pickup_timer = $DamagePickupTimer
@export var MOTION_SPEED = 160
@export var slow_power = 40
@export var base_speed = 160
@export var projectile:PackedScene
signal death
signal spawnerContact
signal speed_pickup_contact
signal speed_pickup_expired
signal damage_pickup_contact
signal damage_pickup_expired
var follow_mouse_is_active = false
var cursor_position
var speed_pickup = false
var damage_pickup = false
var damage_bonus = false

#func _ready():
	##var sprite = $sprite
	##if sprite:
		##sprite.material = material_shader
	#if Engine.is_editor_hint():
		#queue_redraw()
		#_draw()
#
#func _draw():
	#if Engine.is_editor_hint():
		#draw_line(Vector2(-40,0),Vector2(40,0),Color(0,1,0),3)
		#draw_line(Vector2(0,-40),Vector2(0,40),Color(0,1,0),3)
		#draw_line(Vector2(-40,-40),Vector2(40,40),Color(0,1,0),3)
		#draw_line(Vector2(-40,40),Vector2(40,-40),Color(0,1,0),3)

func _physics_process(delta):
	if Engine.is_editor_hint():
		return
	#speeding()
	if(!Input.is_anything_pressed() && !follow_mouse_is_active):
		velocity.x = 0
		velocity.y = 0
	if (Input.is_action_pressed("move_up") && !follow_mouse_is_active):
		velocity.y = -MOTION_SPEED
	if (Input.is_action_pressed("move_bottom") && !follow_mouse_is_active):
		velocity.y = MOTION_SPEED
	if (Input.is_action_pressed("move_left") && !follow_mouse_is_active):
		velocity.x = -MOTION_SPEED
	if (Input.is_action_pressed("move_right") && !follow_mouse_is_active):
		velocity.x = MOTION_SPEED	
	if (cursor_position != null && position.distance_to(cursor_position) > 5 && follow_mouse_is_active):
		velocity = position.direction_to(cursor_position) * MOTION_SPEED
	move_and_slide()
	_fire()
	
func _fire():
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("click"):
		var newProjectile = projectile.instantiate()
		get_parent().add_child(newProjectile)
		if damage_bonus == false:
			$gun_sound.play()
		else:
			$super_gun_sound.play()
		newProjectile.global_position = $fire_point.global_position
		newProjectile.direction = get_global_mouse_position() - $fire_point.global_position
		if damage_bonus == true:
			newProjectile.damage_boost = true
		else:
			newProjectile.damage_boost = false

func _die():
	if is_queued_for_deletion():
		return
	
	death.emit()
	queue_free()

func _input(event):
	
	if event.is_action_pressed("use_pickup") && speed_pickup:
		$speed_boost_sound.play()
		speed_pickup_timer.start()
		slow_power = 160
		base_speed = 320
		MOTION_SPEED = 320
		await (speed_pickup_timer.timeout)
		speed_pickup = false
		slow_power = 40
		base_speed = 160
		MOTION_SPEED = 160
		speed_pickup_expired.emit()
	
	if event.is_action_pressed("use_pickup") && damage_pickup:
		$damage_boost_sound.play()
		damage_pickup_timer.start()
		damage_bonus = true
		await (damage_pickup_timer.timeout)
		damage_pickup = false
		damage_bonus = false
		damage_pickup_expired.emit()
	
	if event.is_action_pressed("switch_mobility"):
		follow_mouse_is_active = !follow_mouse_is_active
		
	
	if event is InputEventMouseMotion && follow_mouse_is_active:
		cursor_position = get_global_mouse_position()
		
func _on_enemy_spawner_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		spawnerContact.emit()

func _on_spikes_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_die()


func _on_spikes_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_die()

func _on_spikes_3_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_die()

func _on_spikes_4_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_die()

func slow(s):
	MOTION_SPEED = clamp(MOTION_SPEED+s, slow_power , base_speed)

func reset_speed():
	MOTION_SPEED = base_speed

func _on_slow_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.slow(slow_power)

func _level_finished():
	set_physics_process(false)

func _on_slow_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.reset_speed()


func _on_slow_zone_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.slow(slow_power)


	
func _on_slow_zone_2_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.reset_speed()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_die()


func _on_speed_pickup_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$pickup_sound.play()
		speed_pickup = true
		speed_pickup_contact.emit()



func _on_damage_pickup_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$pickup_sound.play()
		damage_pickup = true
		damage_pickup_contact.emit()






