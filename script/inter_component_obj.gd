extends Node


enum Inter_type{
	Default,
	Vehice
}

@export var object_ref: Node3D
@export var interraction_type: Inter_type = Inter_type.Default

var can_interact: bool = true
var is_interacting: bool = true
var player_:CharacterBody3D = null
var player_hand: Marker3D
var max_distance: Vector3 = Vector3(3,5,3)
var strenght: float = 1

func _ready() -> void:
	return
	
func pre_interact(player: CharacterBody3D):
	var hand = player.get_node_or_null('head/Camera3D/Hand')
	is_interacting = true
	match interraction_type:
		Inter_type.Default:
			player_hand = hand
		Inter_type.Vehice:
			player_ = player
			player_hand = hand

	
func interact():
	if not can_interact:
		return
	match interraction_type:
		Inter_type.Default:
			default_interact()
		Inter_type.Vehice:
			vehice_interact()

func aux_interact():
	if not can_interact:
		return
	match interraction_type:
		Inter_type.Default:
			default_throw()

func post_interact():
	is_interacting = false
	
func _input(event: InputEvent) -> void:
	return
	
func default_interact():
	var object_current_position: Vector3 = object_ref.global_transform.origin
	var player_hand_position: Vector3 = player_hand.global_transform.origin
	var object_distance: Vector3 = player_hand_position - object_current_position
	
	
	if object_distance.length() > max_distance.length():
		return
	
	var rig_body_3d: RigidBody3D = object_ref as RigidBody3D
	if rig_body_3d:
		
		if object_distance.y > rig_body_3d.mass:
			
			var force: Vector3 = (object_distance)*(5/rig_body_3d.mass)
			rig_body_3d.linear_velocity = force
			
		else:
			var force: Vector3 = (object_distance)*(5/rig_body_3d.mass)
			force.y -= 2 / (strenght * 0.5)
			rig_body_3d.linear_velocity = force
			

func default_throw():
	var object_current_position: Vector3 = object_ref.global_transform.origin
	var player_hand_position: Vector3 = player_hand.global_transform.origin
	var object_distance: Vector3 = player_hand_position - object_current_position
	
	var rig_body_3d: RigidBody3D = object_ref as RigidBody3D
	if rig_body_3d:
		var throw_direction: Vector3 = -player_hand.global_transform.basis.z.normalized()
		var throw_strength: float = (10 / rig_body_3d.mass)
		rig_body_3d.set_linear_velocity(throw_direction * throw_strength)
		
		can_interact = false
		await get_tree().create_timer(1.0).timeout
		can_interact = true

func vehice_interact():
	var object_current_position: Vector3 = object_ref.global_transform.origin
	var player_hand_position: Vector3 = player_hand.global_transform.origin
	var object_distance: Vector3 = player_hand_position - object_current_position
	
	var facing_point: Node = object_ref.get_node_or_null("FacingPoint")
	var player_direction = -player_.get_node_or_null("head").global_transform.basis.z
	
	var rig_body_3d: RigidBody3D = object_ref as RigidBody3D
	if rig_body_3d:
		if facing_point:
			var object_current_direction: Vector3 = (facing_point.global_position - object_current_position).normalized()
			var force: Vector3 = (object_distance)*(5/rig_body_3d.mass)
			force.y = 0
			rig_body_3d.linear_velocity = force
			if object_current_direction.dot(player_direction) > 0.5:
				

				var rigid_v2: Vector2 = Vector2(rig_body_3d.global_position.x, rig_body_3d.global_position.z) 
				var player_v2: Vector2 = Vector2(player_.global_position.x, player_.global_position.z)
				var direction = -(player_v2 - rigid_v2)
				rig_body_3d.rotation.y = lerp_angle(rig_body_3d.rotation.y, atan2(direction.x, direction.y), 1)
				#
				print("Back")
			else:
				print("Side")


func on_deposit_area():
	get_parent().queue_free()
