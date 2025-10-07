extends Node
class_name State

signal Transition(state: State, new_state_name: String)

func enter():
	pass

func exit():
	pass

func process(delta: float) -> void:
	pass

func physics_process(delta: float) -> void:
	pass
