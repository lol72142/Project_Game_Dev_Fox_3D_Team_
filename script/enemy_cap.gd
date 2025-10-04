extends CharacterBody3D

@export var walk_speed: float = 1.5
@export var run_speed: float = 4.0
@export var chace_distance: float = 15.0

@onready var navigate_agent: NavigationAgent3D = $NavigationAgent3D

#var player: CharacterBody3D = null
var gravity: float

func _ready() -> void:
	#var players = get_tree().get_nodes_in_group("player")
	#if players:
		#player = players[0]
	gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
	
func _physics_process(delta: float) -> void:
	
	move_and_slide()
