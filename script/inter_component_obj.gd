extends Node


enum Inter_type{
	Default
}

@export var object_ref: Node3D
@export var interraction_type: Inter_type = Inter_type.Default

var can_interact: bool = true
var is_interacting: bool = true
var player_hand: Marker3D

func _ready() -> void:
	return
	
func pre_interact(hand: Marker3D):
	is_interacting = true
	match interraction_type:
		Inter_type.Default:
			player_hand = hand
	
	
func interact():
	if not can_interact:
		return
	match interraction_type:
		Inter_type.Default:
			default_interact()

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
	
	var rig_body_3d: RigidBody3D = object_ref as RigidBody3D
	if rig_body_3d:
		rig_body_3d.set_linear_velocity((object_distance)*(5/rig_body_3d.mass))

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

func on_deposit_area():
	get_parent().queue_free()
