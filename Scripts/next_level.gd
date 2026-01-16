extends Area2D

const FILE_BEGIN = "res://Scenes/levels/level_"

@onready var door_sprite: AnimatedSprite2D = $Door_Sprite
@onready var level_fade: ColorRect = $level_fade
@onready var level_fade_animation: AnimationPlayer = $level_fade/level_fade_animation
@onready var next_level_timer: Timer = $next_level_timer

var current_scene_file
var next_level_number
var next_level_path

func _on_ready() -> void:
	level_fade.show()
	level_fade_animation.play("fade_out")

func _on_area_entered(area: Area2D) -> void:
	#Trigger next level
	if area.is_in_group("player") and GlobalVar.canPass:
		current_scene_file = get_tree().current_scene.scene_file_path
		next_level_number = current_scene_file.to_int() + 1
		next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
		level_fade_animation.play("fade_in")
		next_level_timer.start()
		GlobalVar.canPass = false

func _on_next_level_timer_timeout() -> void:
	get_tree().change_scene_to_file(next_level_path)
