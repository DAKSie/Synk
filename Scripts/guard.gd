extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -250.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") or area.is_in_group("enemy_2"):
		MusicManager.play_death_enemy_sfx()
		print("guard is dead")
		queue_free()
