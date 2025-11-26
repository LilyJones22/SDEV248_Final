extends Node

@export var total_enemies = 1

func _ready():
	$"Fire Keeper".hide()
	$ExitMirror.hide()
	$player.show()
	$player.global_position = $PlayerSpawn.global_position
	
	
func _physics_process(_delta):
	if total_enemies == 0 and not GameState.talked_fire:
		$"Fire Keeper".show()
		$"Fire Keeper".can_interact = true
	if GameState.talked_fire:
		$ExitMirror.show()
		$ExitMirror.can_interact = true


func _on_fire_enemy_death():
	total_enemies -= 1
