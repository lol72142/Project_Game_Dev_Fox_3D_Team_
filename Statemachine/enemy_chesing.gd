extends State
class_name EnemyChase

@onready var enemy: CharacterBody3D = get_parent().get_parent()
var player: CharacterBody3D = null

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	

func process(delta):
	enemy.navigate_agent.target_position = player.global_transform.origin
	
	if enemy.global_position.distance_to(player.global_position) > enemy.chace_distance:
		emit_signal('Transition', self, "Enemy_warding")

func physics_process(delta: float) -> void:
	if not enemy.is_on_floor():
		enemy.velocity.y = enemy.gravity * delta
	if enemy.navigate_agent.is_navigation_finished():
		return
	
	var next_position: Vector3 = enemy.navigate_agent.get_next_path_position()
	enemy.velocity = enemy.global_position.direction_to(next_position) * enemy.run_speed
	
