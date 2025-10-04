extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ForPath/env/Nature/Tree.force_rebuild_on_load
	$ForPath/env/Building/Coops.force_rebuild_on_load

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
