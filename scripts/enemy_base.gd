extends CharacterBody2D

@onready var attack_timer = $AttackTimer

var player = null
var speed = 60
var randomnum
var target

enum {
	SURROUND,
	ATTACK,
	HIT,
}
var state = SURROUND

func _ready(): # generating random number at startup
	player = get_tree().get_first_node_in_group("player")
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	randomnum = rng.randf()


func get_circle_position(random):
	var kill_circle_center = player.global_position
	var radius = 40
	var angle = random * PI * 2
	var x = kill_circle_center.x + cos(angle) * radius
	var y = kill_circle_center.y + sin(angle) * radius
	
	return Vector2(x, y)
	

func move(target, delta): # moves towards 'player' target
	var direction = (target - global_position).normalized()
	var desired_velocity = direction * speed
	var steering = (desired_velocity -  velocity) * delta * 2.5
	velocity += steering
	move_and_slide()
	
func _physics_process(delta):
	match state:
		SURROUND:
			move(get_circle_position(randomnum), delta)
		ATTACK:
			move(player.global_position, delta)
		HIT:
			move(player.global_position, delta)
			print("HIT")


func _on_attack_timer_timeout():
	state = ATTACK
