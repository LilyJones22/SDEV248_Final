extends GridContainer

signal water_solved

var correct_order = [
	preload("res://final_art/enviornment/water/challenge/puzzle1_TopLeft.png"),
	preload("res://final_art/enviornment/water/challenge/puzzle1_TopRight.png"),
	preload("res://final_art/enviornment/water/challenge/puzzle1_BottomLeft.png"),
	preload("res://final_art/enviornment/water/challenge/puzzle1_BottomRight.png")
]

var tile_names = ["Top Left", "Top Right", "Bottom Left", "Bottom Right"]
var current_order = []
var first_selected = null

func _ready():
	$"Top Left/Hover".visible = false
	$"Top Right/Hover".visible = false
	$"Bottom Left/Hover".visible = false
	$"Bottom Right/Hover".visible = false
	
	current_order = correct_order.duplicate()
	current_order.shuffle()
	
	for i in range(4):
		var tile_button = get_node(tile_names[i])
		tile_button.texture_normal = current_order[i]
		tile_button.pressed.connect(_on_tile_pressed.bind(i))
		
func _on_tile_pressed(index):
	if first_selected == null:
		first_selected = index
		
	else:
		var temp = current_order[first_selected]
		current_order[first_selected] = current_order[index]
		current_order[index] = temp
		
		update_tiles()
		first_selected = null
		if is_puzzle_solved():
			solve_puzzle()
			
func update_tiles():
	for i in range(4):
		var tile_button = get_node(tile_names[i])
		tile_button.texture_normal = current_order[i]
		
func is_puzzle_solved():
	for i in range(4):
		if current_order[i] != correct_order[i]:
			return false
	return true
	
func solve_puzzle():
	print("PUZZLE COMPLETE")
	emit_signal("water_solved")


#region Cursor Visibility Control
func _on_top_left_mouse_entered():
	$"Top Left/Hover".visible = true

func _on_top_left_mouse_exited():
	$"Top Left/Hover".visible = false

func _on_top_right_mouse_entered():
	$"Top Right/Hover".visible = true

func _on_top_right_mouse_exited():
	$"Top Right/Hover".visible = false

func _on_bottom_left_mouse_entered():
	$"Bottom Left/Hover".visible = true

func _on_bottom_left_mouse_exited():
	$"Bottom Left/Hover".visible = false

func _on_bottom_right_mouse_entered():
	$"Bottom Right/Hover".visible = true
	
func _on_bottom_right_mouse_exited():
	$"Bottom Right/Hover".visible = false
#endregion
