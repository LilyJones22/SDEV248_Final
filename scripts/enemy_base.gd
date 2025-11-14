extends CharacterBody2D

@export var health = 3

@onready var attack_timer = $AttackTimer


var player = null
var speed = 60
var randomnum
var target
var player_in = false

enum {
	SURROUND,
	ATTACK,
	HIT,
}
var state = SURROUND

func _ready(): 
	player = get_tree().get_first_node_in_group("player") # generating random number at startup
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	randomnum = rng.randf()
	$DangerZone.hide()


func get_circle_position(random): # picks random position around circle to position
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
			$DangerZone.hide()
		ATTACK:
			move(player.global_position, delta)
			$DangerZone.hide()
		HIT:
			move(player.global_position, delta)
			$DangerZone.show()
			
	if health == 0: # removes enemy if health = 0
		die()

func _on_attack_timer_timeout():
	state = ATTACK

func _on_danger_zone_body_entered(body):
	if body.is_in_group("player"):
		player_in = true
		while player_in:
			body.take_damage()
			await get_tree().create_timer(1).timeout

func _on_danger_zone_body_exited(body):
	if body.is_in_group("player"):
		player_in = false
		
func take_damage(): # remove health from enemy
	health -= 1
	
func die(): # removes enemy from scene
	queue_free()
