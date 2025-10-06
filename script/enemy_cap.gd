extends CharacterBody3D

@export var walk_speed: float = 1.5
@export var run_speed: float = 7.0
@export var chace_distance: float = 25.0
var player: CharacterBody3D = null
@onready var animation_player: AnimationPlayer = $bacteria/AnimationPlayer
@onready var navigate_agent: NavigationAgent3D = $NavigationAgent3D
var gravity: float

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
	animation_player.get_animation("mixamo_com").loop = true
	animation_player.play("mixamo_com")
#func _physics_process(delta: float) -> void:
	#if player != null and global_position.distance_to(player.global_position) < chace_distance:
		#var target_pos = player.global_position
		#target_pos.y = global_position.y
		#look_at(target_pos, Vector3.UP)
		#
	#move_and_slide()

func _physics_process(delta: float) -> void:
	if player != null and global_position.distance_to(player.global_position) < chace_distance:
		var target_pos = player.global_position
		target_pos.y = global_position.y

		var direction = (target_pos - global_position).normalized()
		var target_rotation = atan2(direction.x, direction.z)
		
		# Smooth rotation
		rotation.y = lerp_angle(rotation.y, target_rotation, delta * 5.0)

	move_and_slide()
