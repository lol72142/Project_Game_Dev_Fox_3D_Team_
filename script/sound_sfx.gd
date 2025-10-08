extends Node
@onready var ward_ing: AudioStreamPlayer3D = $ward_ing
@onready var chace_ing: AudioStreamPlayer3D = $chace_ing
@onready var enemy = get_parent()

@export var chace_: Array[Node3D]
@export var ward_: Array[Node3D]
@onready var chace = chace_
@onready var ward = ward_

var now_is = null

func _ready() -> void:
	GlobalValSignal.connect("Deposit_food",set_max_dis)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func set_max_dis(cur_track):
	if now_is == "chace":
		cur_track.set_max_distance(enemy.chace_distance * 2)
	elif now_is == "ward":
		cur_track.set_max_distance(enemy.chace_distance * 4)

	
func select_chace():
	var ran = randi_range(0,chace.size() - 1)
	if ran <= chace.size():
		now_is = 'chace'
		return chace[ran]
	else:
		return null

func select_ward():
	var ward = ward_
	var ran = randi_range(0,ward.size() - 1)
	if ran < ward.size():
		now_is = 'ward'
		var yoo = ward[ran]
		return yoo
	else:
		return null
