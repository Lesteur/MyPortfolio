extends Node2D

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Actualisation position cam
	$"./Camera2D".position = $"./Player".position
	$"./HUD".position = $"./Camera2D".position
	
	if Input.is_action_just_pressed("menu") :
		get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
	if not $"./GameTimer".is_stopped():
		var timeleft = $"./GameTimer".get_time_left()
		$"./HUD/Timer".text = "Temps restant : " + str(int(timeleft)) + "''"
		$"./HUD/Score".text = "Score : " + str(score) 


func _on_game_timer_timeout(): # Fin du temps imparti
	pass
