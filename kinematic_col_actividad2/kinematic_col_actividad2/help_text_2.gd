extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_instructions_change_trigger_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		text = "Esos pulsadores deberían desactivar las trampas
		al pisarlos."


func _on_instructions_change_trigger_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		text = "Cuidado, puede haber enemigos ocultos
		esperando a que toques el laser."
