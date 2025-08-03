extends Area2D

@export var speed = 120

func _physics_process(delta: float) -> void:
	global_position.x += speed*delta
