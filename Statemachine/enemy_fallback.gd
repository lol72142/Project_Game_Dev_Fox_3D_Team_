extends State
class_name EnemyFallBack

var marker: Marker3D = null
var so_far: bool = false
var player: CharacterBody3D
var far_from_dis: float = 5
@onready var enemy: CharacterBody3D = get_parent().get_parent()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	marker = enemy.marker
	player = get_tree().get_first_node_in_group("player")

func go_to_spawn():
	enemy.navigate_agent.target_position = marker.global_transform.origin

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> void:
	var distance_from_mark = enemy.global_position.distance_to(marker.global_position)
	if distance_from_mark > far_from_dis and so_far == false:
		so_far = true
		go_to_spawn()
		
	elif distance_from_mark < 5 and so_far == true:
		so_far = false
		emit_signal('Transition', self, "Enemy_warding")
	
	if enemy.global_position.distance_to(player.global_position) < enemy.chace_distance:
		so_far = false
		emit_signal('Transition', self, "EnemyChase")
		
func physics_process(delta: float) -> void:
	if not enemy.is_on_floor():
		enemy.velocity.y = enemy.gravity * delta
	if enemy.navigate_agent.is_navigation_finished():
		return
	
	var next_position: Vector3 = enemy.navigate_agent.get_next_path_position()
	enemy.velocity = enemy.global_position.direction_to(next_position) * enemy.run_speed
	
	var horizontal_velocity = Vector3(enemy.velocity.x, 0, enemy.velocity.z)
	if horizontal_velocity.length() > 0.1 and enemy.global_position.distance_to(marker.global_position) > far_from_dis:
		var direction = horizontal_velocity.normalized()
		var target_rotation = atan2(direction.x, direction.z)
		
		enemy.rotation.y = lerp_angle(enemy.rotation.y, target_rotation, delta * 2.0)  # 5.0 = turn speed
	
