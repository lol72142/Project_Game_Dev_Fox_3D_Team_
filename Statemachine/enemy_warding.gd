extends State
class_name Enemy_warding
@onready var animation_player: AnimationPlayer = $"../../bacteria/AnimationPlayer"
var warder_direction: Vector3
var wander_time: float = 0.0
var warder_wait: float = 0.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var player: CharacterBody3D = null
var marker: Marker3D

@onready var enemy: CharacterBody3D = get_parent().get_parent()


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	marker = enemy.marker
	print(marker)

func randomize_stetus():
	warder_direction = Vector3(randf_range(-1.0, 1.0), 0.0, randf_range(-1.0, 1.0))
	wander_time = randf_range(1.5,6)
	warder_wait = randf_range(1.5,4)
	
func enter():
	randomize_stetus()

func process(delta: float) -> void:
	if wander_time < 0.0:
		warder_wait -= delta
		warder_direction = Vector3(0,0,0)
		animation_player.stop()
		if warder_wait < 0.0:
			randomize_stetus()
	
	wander_time -= delta
	animation_player.get_animation("mixamo_com").loop = true
	animation_player.play("mixamo_com")
	if enemy.global_position.distance_to(player.global_position) < enemy.chace_distance:
		emit_signal('Transition', self, "EnemyChase")
	if enemy.global_position.distance_to(marker.global_position) > 20:
		emit_signal('Transition', self, "EnemyFallBack")
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
