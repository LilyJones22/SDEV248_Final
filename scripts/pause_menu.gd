extends Control

func _ready():
	hide()

func resume():
	get_tree().paused = false
	hide()
	
func pause():
	get_tree().paused = true
	show()
	
func testEsc():
	if Input.is_action_just_pressed("menu") and not get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("menu") and get_tree().paused:
		resume()

func _on_resume_pressed():
	resume()

func _on_save_pressed():
	GameState.save()

func _on_load_pressed():
	GameState.load_data()
	resume()

func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	testEsc()
