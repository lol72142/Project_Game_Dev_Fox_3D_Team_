extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalValSignal.connect("Get_Hit", check_dead)
	GlobalValSignal.connect("Deposit_food", check_win)
	$win.visible = false
	
func check_dead():
	if GlobalValSignal.Current_HP_Player <= 0:
		get_tree().paused = true
		get_tree().change_scene_to_file("res://sence/lose.tscn")
		
	
func check_win():
	if GlobalValSignal.Current_Number_Food >= 7:
		get_tree().paused = true
		for i in range(11):
			var col_var_a = (i - 1) / (11 - 1)
			$win/Control/ColorRect.self_modulate = col_var_a * 255
			await get_tree().create_timer(0.1).timeout
		get_tree().paused = false
		get_tree().change_scene_to_file("res://Forest/cutscreen.tscn")
