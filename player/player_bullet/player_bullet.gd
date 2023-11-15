extends Area2D

var velocity = Vector2.RIGHT

const SPEED = 300

@onready var sprite = $AnimatedSprite2D


func flip_direction():
	velocity = -velocity
	sprite.flip_h = not sprite.flip_h


func _ready():
	rotation_degrees = randf_range(-7.0, 7.0)
	velocity = velocity.rotated(rotation)


func _physics_process(delta):
	global_position += velocity * SPEED * delta 


func _on_screen_exited():
	queue_free()
