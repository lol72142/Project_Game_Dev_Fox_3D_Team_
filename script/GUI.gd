extends CanvasLayer

func _ready() -> void:
	$".".visible = false

func _on_setting_button_pressed() -> void:
	$setting_canva_layer.visible = true
	%pause_menu.visible = false


func _on_resume_button_pressed() -> void:
	
	#get_tree().quit()
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$".".visible = false
