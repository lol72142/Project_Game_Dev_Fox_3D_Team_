extends RigidBody3D

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	var contact_count = state.get_contact_count()
	if contact_count > 0:
		for i in range(contact_count):
			var local_pos = state.get_contact_local_position(i)
			var global_pos = state.get_contact_collider_position(i)
			var normal = state.get_contact_local_normal(i)

			print("Collision at local:", local_pos, " global:", global_pos, " normal:", normal)
