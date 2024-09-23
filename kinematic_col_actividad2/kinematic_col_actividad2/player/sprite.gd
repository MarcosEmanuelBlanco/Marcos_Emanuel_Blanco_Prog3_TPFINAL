extends Sprite2D
@onready var material_shader = material
var speed_pickup = false
var damage_pickup = false
var blanco = Vector3(1.0, 1.0, 1.0)
var verde = Vector3(0.0, 1.0, 0.0)
var rojo = Vector3(1.0, 0.0, 0.0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use_pickup") && speed_pickup:
		material_shader.set_shader_parameter("cambiar_blanco", verde)
	if event.is_action_pressed("use_pickup") && damage_pickup:
		material_shader.set_shader_parameter("cambiar_blanco", rojo)

func _on_player_speed_pickup_contact() -> void:
	speed_pickup = true


func _on_player_speed_pickup_expired() -> void:
	speed_pickup = false
	material_shader.set_shader_parameter("cambiar_blanco", blanco)


func _on_player_damage_pickup_contact() -> void:
	damage_pickup = true


func _on_player_damage_pickup_expired() -> void:
	damage_pickup = false
	material_shader.set_shader_parameter("cambiar_blanco", blanco)
