extends CharacterBody3D

var speed = 0
const Max_Walk_Speed = 5.0
const Max_Run_Speed = 10.0
const Jump_velo = 5.0
const Sensitivity = 0.003
const Walk_bo_freq = 2.0
const  Walk_bo_amp = 0.08
const Base_FOV = 75.0
const FOV_change = 1.5

var t_bo = 0.0


var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var head = $head
@onready var camera = $head/Camera3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * Sensitivity)
		camera.rotate_x(-event.relative.y * Sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))


func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = Jump_velo
	
	if Input.is_action_pressed('sprint') and is_on_floor():
		speed = Max_Run_Speed
	else:
		speed = Max_Walk_Speed
		
	var input_vec = Input.get_vector("left","right","forward","backward")
	var directionn = (head.transform.basis * Vector3(input_vec.x, 0 ,input_vec.y)).normalized()
	
	if is_on_floor():
		if directionn:
			velocity.x = directionn.x * speed
			velocity.z = directionn.z * speed
		else:
			velocity.x = lerp(velocity.x, directionn.x * speed, delta * 15.0)
			velocity.z = lerp(velocity.x, directionn.x * speed, delta * 15.0)
	else:
		velocity.x = lerp(velocity.x, directionn.x * speed, delta * 2.0)
		velocity.z = lerp(velocity.z, directionn.z * speed, delta * 2.0)
	
	t_bo += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = head_bob(t_bo)
	
	var velocity_clamed = clamp(velocity.length(), 0.5, Max_Run_Speed)
	var target_FOV = Base_FOV + FOV_change * velocity_clamed
	camera.fov = lerp(camera.fov, target_FOV, delta * 1)
	
	move_and_slide()

func head_bob(time) -> Vector3:
	var posi = Vector3.ZERO
	posi.y = sin(time * Walk_bo_freq) * Walk_bo_amp
	posi.x = sin(time * Walk_bo_freq / 2) * Walk_bo_amp
	return posi
