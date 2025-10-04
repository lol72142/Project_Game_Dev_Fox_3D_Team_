extends StaticBody3D

var player: CharacterBody3D
var big_forest

func _ready() -> void:
	big_forest = get_parent().get_parent().get_parent()

func _process(delta: float) -> void:
	
	if big_forest.player_node == null or big_forest.player_node is CharacterBody3D:
		player = big_forest.player_node
		var distance = global_position.distance_to(player.global_position) <= 30.0
		
		visible = distance
	
