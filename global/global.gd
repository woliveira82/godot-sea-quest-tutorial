extends Node

var saved_people_count = 0
var oxygen_level = 100
var current_points = 0
var high_score = 0

const SCREEN_BOUND_MAX_X = 300
const SCREEN_BOUND_MIN_X = -50


func _process(delta):
	if Input.is_action_pressed("exit"):
		get_tree().quit()
