extends PathFollow2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var animationPlayer = $Opponent1AnimPlayer
	animationPlayer.play("opponent1movement")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
