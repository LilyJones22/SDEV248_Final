extends Node

var mirror_dialogue = load("res://dialogue/mirror.dialogue")

func _ready():
	$player.global_position = $PlayerSpawn.global_position
	

func _on_fire_mirror_interact():
	if not GameState.fire_complete:
		get_tree().change_scene_to_file("res://scenes/levels/fire/fire.tscn")
	else:
		DialogueManager.show_dialogue_balloon(mirror_dialogue, "fire")
	
func _on_water_mirror_interact():
	if not GameState.water_complete:
		get_tree().change_scene_to_file("res://scenes/levels/water/water.tscn")
	else:
		DialogueManager.show_dialogue_balloon(mirror_dialogue, "water")
