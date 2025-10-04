extends State
class_name Enemy_warding

var warder_direction: Vector3
var wander_time: float = 0.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var player: CharacterBody3D = null

@onready var enemy: CharacterBody3D = get_parent().get_parent()


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func randomize_stetus():
	warder_direction = Vector3(randf_range(-1.0, 1.0), 0.0, randf_range(-1.0, 1.0))
	wander_time = randf_range(1.5,4)
	
func enter():
	randomize_stetus()

func process(delta: float) -> void:
	if wander_time < 0.0:
		randomize_stetus()
	
	wander_time -= delta
	if enemy.global_position.distance_to(player.global_position) < enemy.chace_distance:
		emit_signal('Transition', self, "EnemyChase")
	
#func physics_process(delta: float) -> void:
	#enemy.velocity = warder_direction * enemy.walk_speed
	#
	#if not enemy.is_on_floor():
		#enemy.velocity.y -= gravity * delta
		
func physics_process(delta: float) -> void:
	enemy.velocity = warder_direction * enemy.walk_speed
	
	if not enemy.is_on_floor():
		enemy.velocity.y -= gravity * delta
	
	var horizontal_velocity = Vector3(enemy.velocity.x, 0, enemy.velocity.z)
	if horizontal_velocity.length() > 0.1 and enemy.global_position.distance_to(player.global_position) > enemy.chace_distance:
		var direction = horizontal_velocity.normalized()
		var target_rotation = atan2(direction.x, direction.z)
		
		enemy.rotation.y = lerp_angle(enemy.rotation.y, target_rotation, delta * 2.0)  # 5.0 = turn speed
