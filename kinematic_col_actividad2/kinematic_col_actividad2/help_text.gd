extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_instructions_change_trigger_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		set_position(Vector2(270.0, 250.0))
		text = "Esta parte parece más difícil. 
		Pero con el click derecho vas a poder moverte
		con más agilidad siguiendo el cursor."
