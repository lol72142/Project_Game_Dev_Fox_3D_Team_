extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("Ending")
	AudioManager.miao.play()
	await get_tree().create_timer(11.0).timeout
	AudioManager.start_chasing_loop()
	await get_tree().create_timer(4.0).timeout
	AudioManager.stop_chasing_loop()
	
func _process(delta: float) -> void:
	if not $Running/AnimationPlayer.is_playing():
		$Running/AnimationPlayer.play("mixamo_com")

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
