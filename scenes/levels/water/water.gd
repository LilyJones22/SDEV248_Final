extends Node

func _ready():
	$"Water Keeper".hide()
	$ExitMirror.hide()
	$player.show()
	$player.global_position = $PlayerSpawn.global_position
	
func _on_water_puzzle_water_solved():
	$"Water Keeper".show()
	
func _physics_process(_delta):
	if GameState.talked_water:
		$"Water Keeper".hide()
		$ExitMirror.show()
