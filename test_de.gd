extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var t: Array = ["a","b","c","d","e"]
	for i in range(t.size()):
		print(t[i])
