extends Area2D

const FILE_BEGIN = "res://Scenes/levels/level_"

@onready var door_sprite: AnimatedSprite2D = $Door_Sprite
@onready var level_fade: ColorRect = $level_fade
@onready var level_fade_animation: AnimationPlayer = $level_fade/level_fade_animation
@onready var next_level_timer: Timer = $next_level_timer
@onready var door_entered: AudioStreamPlayer2D = $door_entered

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
		print("Current level: " + current_scene_file)
		var file_name = current_scene_file.get_file().get_basename()
		var number_part = file_name.replace("level_", "")
		next_level_number = number_part.to_int() + 1
		next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
		level_fade_animation.play("fade_in")
		print("Next Level: " + next_level_path)
		next_level_timer.start()
		door_entered.play()
		GlobalVar.canPass = false
		GlobalVar.isDead = true

func _on_next_level_timer_timeout() -> void:
	get_tree().change_scene_to_file(next_level_path)
