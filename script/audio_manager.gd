extends Node

@onready var forest_sfx: AudioStreamPlayer = $forest_sfx
@onready var run: AudioStreamPlayer = $Run
@onready var miao: AudioStreamPlayer = $miao
@onready var chasing_1: AudioStreamPlayer = $Chasing_1
@onready var chasing_2: AudioStreamPlayer = $Chasing_2
@onready var chasing_3: AudioStreamPlayer = $Chasing_3


@export var min_delay: float = 2.0
@export var max_delay: float = 5.0

var chasing_players: Array[AudioStreamPlayer]
var random_loop_active: bool = false

func _ready() -> void:
	randomize()
	chasing_players = [chasing_1, chasing_2, chasing_3]
	# optional: start automatically
	# start_chasing_loop()

func _loop_random_chasing_sound() -> void:
	if not random_loop_active:
		return

	var random_player = chasing_players.pick_random()
	random_player.play()

	var sound_length = random_player.stream.get_length()
	var delay = sound_length + randf_range(min_delay, max_delay)

	await get_tree().create_timer(delay).timeout
	_loop_random_chasing_sound()


func start_chasing_loop() -> void:
	if random_loop_active:
		return
	random_loop_active = true
	_loop_random_chasing_sound()


func stop_chasing_loop() -> void:
	random_loop_active = false
