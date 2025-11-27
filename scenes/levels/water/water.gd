extends Node

func _ready():
	$"Water Keeper".hide()
	$ExitMirror.hide()
	$player.show()
	$player.global_position = $PlayerSpawn.global_position
	$Before.visible = true
	$KeeperPath.visible = false
	$MirrorPath.visible = false
	
func _on_water_puzzle_water_solved():
	$KeeperPath.visible = true
	$Before.set_layer_enabled(0, false)
	$"Water Keeper".show()
	$"Water Keeper".can_interact = true

func _on_exit_mirror_interact():
	get_tree().change_scene_to_file("res://scenes/levels/hub.tscn")

func _on_water_keeper_talked():
		$MirrorPath.visible = true
		$KeeperPath.set_layer_enabled(0, false)
		$ExitMirror.show()
