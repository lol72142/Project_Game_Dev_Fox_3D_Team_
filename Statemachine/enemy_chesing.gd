extends State
class_name EnemyChase
@onready var animation_player: AnimationPlayer = $"../../bacteria/AnimationPlayer"
@onready var enemy: CharacterBody3D = get_parent().get_parent()
@onready var chase_ing: AudioStreamPlayer = $"../../sound/chase_ing"

var dammage = 1
var player: CharacterBody3D = null
var is_acttack = false
var wait_time: float = 0
var cur_time: float = 0

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
func hit_and_wait():
	wait_time = randf_range(2, 3)
	is_acttack = true

<<<<<<< Updated upstream
=======
func enter():
	#AudioManager.start_chasing_loop()
	chase_ing.play()

>>>>>>> Stashed changes
func process(delta):
	enemy.navigate_agent.target_position = player.global_transform.origin
	
	var distance_enemy_player = enemy_to_distance(player)
	var groan_db = distance_to_db(distance_enemy_player)
	
	chase_ing.volume_db = groan_db
	print(chase_ing.volume_db)
	if distance_enemy_player <= enemy.attack_distance and is_acttack == false:
		GlobalValSignal.Current_HP_Player -= dammage
		GlobalValSignal.emit_signal("Get_Hit")
		hit_and_wait()
		
	if distance_enemy_player > enemy.chace_distance:
		emit_signal('Transition', self, "Enemy_warding")
<<<<<<< Updated upstream
		AudioManager.start_chasing_loop()
		
=======
		#AudioManager.stop_chasing_loop()
		chase_ing.stop()
>>>>>>> Stashed changes
func physics_process(delta: float) -> void:
	
	if not enemy.is_on_floor():
		enemy.velocity.y = enemy.gravity * delta
	if enemy.navigate_agent.is_navigation_finished():
		return
	if is_acttack:
		cur_time += delta
		if cur_time >= wait_time:
			is_acttack = false
			wait_time = 0
			cur_time = 0
			#AudioManager.start_chasing_loop()
		enemy.velocity = Vector3.ZERO
		animation_player.stop()
	else:
		var next_position: Vector3 = enemy.navigate_agent.get_next_path_position()
		enemy.velocity = enemy.global_position.direction_to(next_position) * enemy.run_speed
		
		animation_player.get_animation("mixamo_com").loop = true
		animation_player.play("mixamo_com")

func enemy_to_distance(body):
	var distan = enemy.global_position.distance_to(body.global_position)
	return distan

func distance_to_db(distance_):
	var di = clamp(distance_ , 0.0, enemy.chace_distance*2) 
	var nor = (distance_ - 0) / (enemy.chace_distance*2 - 0)
	var range_ = nor * 36
	return clamp((7.5 - range_) * 3.52185103,-40, 5)
