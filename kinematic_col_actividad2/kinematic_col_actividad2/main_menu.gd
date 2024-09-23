extends Node2D
var audio = AudioServer.get_bus_index("Master")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("next_level"):
		get_tree().change_scene_to_file("res://main.tscn")
	if event.is_action_pressed("mute_audio"):
		AudioServer.set_bus_mute(audio, not AudioServer.is_bus_mute(audio))
		if AudioServer.is_bus_mute(audio):
			$audio_text.text = "Sonido(m): Silenciado"
		else:
			$audio_text.text = "Sonido(m): Activo"

