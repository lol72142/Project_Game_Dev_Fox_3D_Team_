extends Node3D



func _on_area_activate_body_entered(body: Node3D) -> void:
	if body.is_in_group("item_deposit") and body is RigidBody3D:
		var inter_com_obj = body.get_node_or_null('inter_component_obj')
		if inter_com_obj:
			if inter_com_obj.has_method('on_deposit_area'):
				inter_com_obj.on_deposit_area()
