extends Node

@export var total_enemies = 1

func _ready():
	$"Fire Keeper".hide()
	$ExitMirror.hide()
	$player.show()
	$player.global_position = $PlayerSpawn.global_position
	
func enemies_gone():
	$"Fire Keeper".show()
	$"Fire Keeper".can_interact = true

func _on_fire_keeper_talked():
	$ExitMirror.show()
	$ExitMirror.can_interact = true

func _on_fire_enemy_death():
	total_enemies -= 1

func _on_exit_mirror_interact():
	get_tree().change_scene_to_file("res://scenes/levels/hub.tscn")
