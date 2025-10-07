extends Control


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Forest/cutscreen2.tscn")


func _on_setting_pressed() -> void:
	$".".visible = false
	$"../setting_canva_layer".visible = true


func _on_back_pressed() -> void:
	$".".visible = true
	$"../setting_canva_layer".visible = false
