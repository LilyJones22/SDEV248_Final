extends Node


func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/cutscene/opening.tscn")
	
func _on_load_pressed():
	GameState.load_data()
	get_tree().change_scene_to_file("res://scenes/levels/hub.tscn")
	
