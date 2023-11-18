extends Area2D


const SPEED = 50
const MOVEMENT_FREQUENCY = 0.15
const MOVEMENT_AMPLITUDE = 0.5

var velocity = Vector2.RIGHT
var random_offset = randf_range(0.0, 10.0)

enum states {DEFAULT, PAUSED}
var current_state = states.DEFAULT

var point_value = 25

@onready var sprite = $AnimatedSprite2D


func _ready():
	GameEvents.connect("pause_enemies", Callable(self, "_pause"))
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
		Global.current_points += point_value
		GameEvents.emit_signal("update_points")
		area.queue_free()
		queue_free()
	
	if area.is_in_group("Player"):
		area.death()


func _pause(pause):
	if pause:
		current_state = states.PAUSED
	else:
		current_state = states.DEFAULT
