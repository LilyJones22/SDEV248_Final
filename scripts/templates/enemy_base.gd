extends CharacterBody2D

@export var health = 3

@onready var attack_timer = $AttackTimer


var player = null
var speed = 60
var target
var player_in = false
var interested = false


func _ready(): 
	$AnimationPlayer.play("surround")
	player = get_tree().get_first_node_in_group("player") 
	$DangerZone.visible = true  # ensure danger zone is active



func move(target, delta): # moves towards 'player' target
	var direction = (target - global_position).normalized()
	var desired_velocity = direction * speed
	var steering = (desired_velocity -  velocity) * delta * 2.5
	velocity += steering
	move_and_slide()
	
func _physics_process(delta):
	if interested:
		move(player.global_position, delta)
	
	if health == 0: # removes enemy if health = 0
		die()
		

func _on_warning_zone_body_entered(body):
	if body.is_in_group("player"):
		$AnimationPlayer.play("surround-attack")
		await $AnimationPlayer.animation_finished
		$AnimationPlayer.play("attack")

func _on_warning_zone_body_exited(body):
	if body.is_in_group("player"):
		$AnimationPlayer.play("attack-surround")
		await $AnimationPlayer.animation_finished
		$AnimationPlayer.play("surround")


func _on_danger_zone_body_entered(body): # player gets too close to enemy
	if body.is_in_group("player"):
		$AnimationPlayer.play("attack-hit")
		await $AnimationPlayer.animation_finished
		$AnimationPlayer.play("hit")
		player_in = true
		while player_in:
			body.take_damage()
			await get_tree().create_timer(1).timeout

func _on_danger_zone_body_exited(body): # player creates distance between enemy
	if body.is_in_group("player"):
		player_in = false
		$AnimationPlayer.play("hit-attack")
		await $AnimationPlayer.animation_finished
		$AnimationPlayer.play("attack")
		
func take_damage(): # remove health from enemy
	health -= 1
	
func die(): # removes enemy from scene
	queue_free()


func _on_interest_zone_body_entered(body):
	if body.is_in_group("player"):
		interested = true

func _on_interest_zone_body_exited(body):
	if body.is_in_group("player"):
		interested = false
