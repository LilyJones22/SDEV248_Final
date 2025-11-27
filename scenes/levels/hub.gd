extends Node

func _ready():
	$player.global_position = $PlayerSpawn.global_position
	

func _on_fire_mirror_interact():
	get_tree().change_scene_to_file("res://scenes/levels/fire/fire.tscn")
	
func _on_water_mirror_interact():
	get_tree().change_scene_to_file("res://scenes/levels/water/water.tscn")
