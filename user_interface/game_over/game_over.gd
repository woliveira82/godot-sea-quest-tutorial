extends Control

@onready var current_scene_label = $CurrentScoreLabel
@onready var high_score_label = $HighScoreLabel
@onready var game_over_delay = $GameOverDelay


func _ready():
	GameEvents.connect("game_over", Callable(self, "_activate_game_over"))
	visible = false


func _process(delta):
	if visible == true and Input.is_action_just_pressed("shoot"):
		Global.current_points = 0
		Global.saved_people_count = 0
		Global.oxygen_level = 100
		get_tree().reload_current_scene()


func _activate_game_over():
	current_scene_label.text = "Score %d" % Global.current_points
	Global.high_score = max(Global.high_score, Global.current_points)
	high_score_label.text = "Highscore %d" % Global.high_score
	game_over_delay.start()


func _on_game_over_delay_timeout():
	visible = true
