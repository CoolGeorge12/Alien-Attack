extends Node2D

var lives = 3
var score = 0

@onready var player: CharacterBody2D = $Player
@onready var hud: Control = $UI/HUD

func _ready() -> void:
	hud.set_score_label(score)
	hud.set_lives(lives)

func _on_deathzone_area_entered(area: Area2D) -> void:
	area.die()

func _on_player_took_damage() -> void:
	lives -= 1
	hud.set_lives(lives)
	if (lives == 0):
		print("Game over")
		player.die()

func _on_enemy_spawner_enemy_spawned(enemy_instance: Variant) -> void:
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died():
	score += 100
	hud.set_score_label(score)
