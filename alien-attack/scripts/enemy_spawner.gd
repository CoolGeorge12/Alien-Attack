extends Node2D

signal enemy_spawned(enemy_instance)

var enemy_scene = preload("res://scenes/enemy.tscn")

@onready var spawn_positions: Node2D = $SpawnPositions

func _on_timer_timeout() -> void:
	spawn_enemy()

func spawn_enemy():
	var spawn_positions_array = spawn_positions.get_children()
	var random_spawn_positions = spawn_positions_array.pick_random()
	
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = random_spawn_positions.global_position
	emit_signal("enemy_spawned",enemy_instance)
	#add_child(enemy_instance)
