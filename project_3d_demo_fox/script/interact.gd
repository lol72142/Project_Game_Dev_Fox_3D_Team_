extends Node

@onready var interact_: Node = %interact
@onready var raycast_: RayCast3D = %RayCast3D
@onready var camera_: Camera3D = %Camera3D
@onready var hand_: Marker3D = %Hand
@onready var player: CharacterBody3D = $".."

var current_obj_inter: Object
var last_potential_obj: Object
var insteraction_component: Node

func _physics_process(delta: float) -> void:
	
	if current_obj_inter:
		if Input.is_action_just_pressed('secound'):
			if insteraction_component:
				insteraction_component.aux_interact()
				current_obj_inter = null
			
		if Input.is_action_pressed("primary"):
			if insteraction_component:
				insteraction_component.interact()
		else:
			if insteraction_component:
				insteraction_component.post_interact()
				current_obj_inter = null
					
	else:
		var po_object: Object = raycast_.get_collider()
		
		if po_object and po_object is Node:
			insteraction_component = po_object.get_node_or_null('inter_component_obj')
			if insteraction_component:
				if insteraction_component.can_interact == false:
					return
				last_potential_obj = current_obj_inter
				
				if Input.is_action_pressed("primary"):
					current_obj_inter = po_object
					insteraction_component.pre_interact(player)
