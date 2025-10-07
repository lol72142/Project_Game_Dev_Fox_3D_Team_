extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("Ending")
	AudioManager.fox.play()
	await get_tree().create_timer(11.0).timeout
	AudioManager.scream.play()
	
func _process(delta: float) -> void:
	if not $Running/AnimationPlayer.is_playing():
		$Running/AnimationPlayer.play("mixamo_com")

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
