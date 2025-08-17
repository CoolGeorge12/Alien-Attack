extends Node2D

var lives = 3
var score = 0

@onready var player: CharacterBody2D = $Player
@onready var hud: Control = $UI/HUD
@onready var ui: CanvasLayer = $UI

@onready var enemy_hit_sound: AudioStreamPlayer = $EnemyHitSound
@onready var player_hit_sound: AudioStreamPlayer = $PlayerHitSound

var gos_scene = preload("res://scenes/game_over_screen.tscn")

func _ready() -> void:
	hud.set_score_label(score)
	hud.set_lives(lives)

func _on_deathzone_area_entered(area: Area2D) -> void:
	area.queue_free()

func _on_player_took_damage() -> void:
	lives -= 1
	hud.set_lives(lives)
	score = score - 100
	player_hit_sound.play()
	if (lives == 0):
		print("Game over")
		player.die()
		
		await get_tree().create_timer(1.5).timeout
		
		var gos = gos_scene.instantiate()
		gos.set_score(score)
		ui.add_child(gos)

func _on_enemy_spawner_enemy_spawned(enemy_instance: Variant) -> void:
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died():
	score += 100
	hud.set_score_label(score)
	enemy_hit_sound.play()
