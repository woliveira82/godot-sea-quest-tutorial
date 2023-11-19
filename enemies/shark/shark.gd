extends Area2D


const SPEED = 50
const MOVEMENT_FREQUENCY = 0.15
const MOVEMENT_AMPLITUDE = 0.5
const DeathSound = preload("res://enemies/shark/shark_death.ogg")
const ObjectPiece = preload("res://particles/object_piece/object_piece.tscn")
const PIECE_COUNT = 2
const PointValuePopup = preload("res://user_interface/points_value_popup/point_value_popup.tscn")

var velocity = Vector2.RIGHT
var random_offset = randf_range(0.0, 10.0)

enum states {DEFAULT, PAUSED}
var current_state = states.DEFAULT

var point_value = 25

@onready var sprite = $AnimatedSprite2D


func _ready():
	GameEvents.connect("pause_enemies", Callable(self, "_pause"))
	GameEvents.connect("kill_all_enemies", Callable(self, "_death"))


func _physics_process(delta):
	if current_state == states.DEFAULT:
		velocity.y = sin(global_position.x * MOVEMENT_FREQUENCY + random_offset) * MOVEMENT_AMPLITUDE
		global_position += velocity * SPEED * delta


func _process(_delta):
	if global_position.x > Global.SCREEN_BOUND_MAX_X or global_position.x < Global.SCREEN_BOUND_MIN_X:
		queue_free()


func flip_direction():
	velocity = -velocity
	sprite.flip_h = not sprite.flip_h


func _on_area_entered(area):
	if area.is_in_group("PlayerBullet"):
		area.queue_free()
		_death()
	
	if area.is_in_group("Player"):
		area.death()


func instance_point_popup():
	var point_value_popup_instance = PointValuePopup.instantiate()
	
	point_value_popup_instance.value = point_value
	get_tree().current_scene.add_child(point_value_popup_instance)
	point_value_popup_instance.global_position = global_position


func instance_death_pieces():
	for i in range(PIECE_COUNT):
		var piece_instance = ObjectPiece.instantiate()
		piece_instance.frame = i
		
		get_tree().current_scene.add_child(piece_instance)
		piece_instance.global_position = global_position


func _death():
	Global.current_points += point_value
	GameEvents.emit_signal("update_points")
	
	SoundManager.play_sound(DeathSound)
	instance_death_pieces()
	instance_point_popup()
	
	queue_free()


func _pause(pause):
	if pause:
		current_state = states.PAUSED
	else:
		current_state = states.DEFAULT
