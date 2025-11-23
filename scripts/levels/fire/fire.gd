extends Node

@export var total_enemies = 1

func _ready():
	$"Fire Keeper".hide()
	$ExitMirror.hide()
	$player.show()
	$player.global_position = $PlayerSpawn.global_position
	
	
func _physics_process(_delta):
	if total_enemies <= 0:
		$"Fire Keeper".show()
	if GameState.talked_fire:
		$"Fire Keeper".hide()
		$ExitMirror.show()


func _on_fire_enemy_death():
	total_enemies -= 1
