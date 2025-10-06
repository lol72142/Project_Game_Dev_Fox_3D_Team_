extends Control

var player: CharacterBody3D = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player:
		var player_position = player.global_position
		var norm_position = player_position + Vector3(200.0, 0.0, 250.0)
		norm_position.z = norm_position.z / 500.0 * 200.0
		norm_position.x = norm_position.x / 450.0 * 200.0
		
		$Panel/player_point.position = Vector2(norm_position.x, norm_position.z)
		
