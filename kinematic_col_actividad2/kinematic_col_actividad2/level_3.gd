extends Node2D
@export var total_points = 2000
@export var bonus_reduction_rate = -1
var finished = false
var audio = AudioServer.get_bus_index("Master")

func _physics_process(delta: float) -> void:
	
	if total_points <= 0:
		bonus_reduction_rate = 0
		total_points = total_points - total_points
		_set_score_string(total_points)
	_set_score_string(bonus_reduction_rate)
	
func _on_goal_body_entered(body):
	if body.is_in_group("player"):
		bonus_reduction_rate = 0
		$level_completed.show()
		$level_completed_sound.play()
		$help_text_3.hide()
		$score.set_position(Vector2(520.0, 120.0))
		_set_score_string(0)
		finished = true
		body._level_finished()

func _on_player_death() -> void:
	$level_failed.show()
	$level_failed_sound.play()
	$help_text_3.hide()
	total_points = total_points - total_points
	_set_score_string(total_points)
	finished = true
	
func _set_score_string(points):
	total_points = total_points + points
	$score.text = "Puntos: " + str(total_points)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("next_level") && finished == true:
		get_tree().change_scene_to_file("res://level_4.tscn")
	if event.is_action_pressed("restart") && finished == true:
		get_tree().change_scene_to_file("res://level_3.tscn")
	if event.is_action_pressed("mute_audio"):
		AudioServer.set_bus_mute(audio, not AudioServer.is_bus_mute(audio))
		if AudioServer.is_bus_mute(audio):
			$audio_text.text = "Sonido(m): Silenciado"
		else:
			$audio_text.text = "Sonido(m): Activo"
func _on_mute_button_pressed() -> void:
	AudioServer.set_bus_mute(audio, not AudioServer.is_bus_mute(audio))