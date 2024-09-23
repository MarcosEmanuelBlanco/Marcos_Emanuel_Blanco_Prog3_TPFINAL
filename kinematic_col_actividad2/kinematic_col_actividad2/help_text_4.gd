extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_big_enemy_trigger_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		text = "Ese si es uno grande y feo 
		que puede recibir hasta 10 golpes.
		Pero con el potenciador recibe el doble de daño."
