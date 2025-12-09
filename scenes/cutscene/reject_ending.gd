extends VideoStreamPlayer


func _on_finished():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
