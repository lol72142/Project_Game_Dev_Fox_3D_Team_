extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("Ending")
	AudioManager.miao.play()
	await get_tree().create_timer(11.0).timeout
	get_tree().change_scene_to_file("res://Forest/forest.tscn")
