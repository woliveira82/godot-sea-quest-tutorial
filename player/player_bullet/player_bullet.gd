extends AnimatedSprite2D

var velocity = Vector2.RIGHT

const SPEED = 300


func flip_direction():
	velocity = -velocity
	flip_h = not flip_h


func _ready():
	rotation_degrees = randf_range(-7.0, 7.0)
	velocity = velocity.rotated(rotation)


func _physics_process(delta):
	global_position += velocity * SPEED * delta 


func _screen_exited():
	queue_free()
