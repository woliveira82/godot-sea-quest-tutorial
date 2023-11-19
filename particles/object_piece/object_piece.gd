extends Sprite2D

var velocity = Vector2.RIGHT
var move_speed = 150.0
var rotation_speed = 50.0

const TWO_PI = 6.283

func _ready():
	var random_angle = randf_range(0, TWO_PI)
	velocity = velocity.rotated(random_angle)
	rotation_speed = randf_range(-70, 70)


func _physics_process(delta):
	global_position += velocity * move_speed * delta
	rotation_degrees += rotation_speed * delta
	
	move_speed = lerp(move_speed, 0.0, 6 * delta)
