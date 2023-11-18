extends Area2D

var velocity = Vector2.ZERO
var can_shoot = true

var state = "default"

const SPEED = Vector2(125, 90)
const OXYGEN_DECREASE_SPEED = 2.5
const OXYGEN_INCREASE_SPEED = 60.0
const BULLET_OFFSET = 7
const Bullet = preload("res://player/player_bullet/player_bullet.tscn")

@onready var reload_timer = $ReloadTimer
@onready var sprite = $AnimatedSprite2D


func _ready():
	GameEvents.connect("full_crew_oxygen_refuel", Callable(self, "_full_crew_oxygen_refuel"))
	GameEvents.connect("less_people_oxygen_refuel", Callable(self, "_less_people_oxygen_refuel"))


func _process(_delta):
	if state == "default":
		process_movement_input()
		direction_follows_input()
		process_shooting()
		lose_oxygen()
	elif state == "less_people_refuel":
		oxygen_refuel()
	elif state == "people_refuel":
		oxygen_refuel()


func _physics_process(_delta):
	if state == "default":
		movement()


func process_movement_input():
	velocity.x = Input.get_axis("move_left", "move_right")
	velocity.y = Input.get_axis("move_up", "move_down")
	velocity = velocity.normalized()


func direction_follows_input():
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true


func process_shooting():
	if Input.is_action_pressed("shoot") and can_shoot:
		var bullet_instance = Bullet.instantiate()
		bullet_instance.global_position = global_position
		get_tree().current_scene.add_child(bullet_instance)
		
		if sprite.flip_h:
			bullet_instance.flip_direction()
			bullet_instance.global_position = global_position - Vector2(BULLET_OFFSET, 0)
		else:
			bullet_instance.global_position = global_position + Vector2(BULLET_OFFSET, 0)
		
		reload_timer.start()
		can_shoot = false


func lose_oxygen():
	var orygin_decrease_delta = OXYGEN_DECREASE_SPEED * get_process_delta_time()
	Global.oxygen_level = move_toward(Global.oxygen_level, 0.0, orygin_decrease_delta)


func oxygen_refuel():
	Global.oxygen_level += OXYGEN_INCREASE_SPEED * get_process_delta_time()
	
	if Global.oxygen_level > 99:
		state = "default"


func movement():
	global_position += velocity * SPEED * get_physics_process_delta_time()


func _on_reload_timer_timeout():
	can_shoot = true


func _full_crew_oxygen_refuel():
	state = "people_refuel"


func _less_people_oxygen_refuel():
	state = "less_people_refuel"
