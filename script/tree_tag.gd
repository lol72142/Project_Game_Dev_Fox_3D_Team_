extends StaticBody3D

var player: CharacterBody3D
var big_forest
var find = false

func _ready() -> void:
	var group_check = get_parent()
	if not group_check.get_groups().is_empty():
		if group_check.get_groups()[0] == 'textures':
			big_forest = group_check
			find = true
			$CollisionShape3D.disabled = true
			$CollisionShape3D.debug_fill = false
	
	

func _process(delta: float) -> void:
	if find:
		if big_forest.player_node == null or big_forest.player_node is CharacterBody3D:
			player = big_forest.player_node
			var distance_tree_player_texture = global_position.distance_to(player.global_position) 
		
			visible = distance_tree_player_texture <= 50.0
			if distance_tree_player_texture <= 5:
				$CollisionShape3D.disabled = false
				$CollisionShape3D.debug_fill = false
			else:
				$CollisionShape3D.disabled = true
				$CollisionShape3D.debug_fill = true
	
