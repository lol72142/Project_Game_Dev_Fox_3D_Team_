extends CharacterBody3D

@export var marker: Marker3D = null
@export var walk_speed: float = 1.5
@export var run_speed: float = 5
@export var chace_distance: float = 15.0


@onready var navigate_agent: NavigationAgent3D = $NavigationAgent3D

var gravity: float
var player: CharacterBody3D = null
var attack_distance: float = 3

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

	GlobalValSignal.connect("Deposit_food",Multiple_by_chicken)
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

func Multiple_by_chicken():
	var mul = GlobalValSignal.Current_Number_Food
	walk_speed += (mul * 2 * 0.15) / mul
	run_speed += (mul * 2 * 0.1) / mul
	if mul <= 6:
		mul += 4 
	chace_distance += mul + 2
	print(walk_speed, " ",run_speed, " ",chace_distance)
