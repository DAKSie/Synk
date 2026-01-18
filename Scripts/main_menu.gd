extends Node2D

var button_type = null
@onready var timer: Timer = $fade_in_out/Timer
@onready var fade_in_out: ColorRect = $fade_in_out
@onready var animation_player: AnimationPlayer = $fade_in_out/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MusicManager.play_main_menu_music()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	button_type = "start"
	fade_in_out.show()
	timer.start()
	animation_player.play("fade_in")

func _on_options_pressed() -> void:
	button_type = "option"
	fade_in_out.show()
	timer.start()
	animation_player.play("fade_in")

func _on_quit_pressed() -> void:
	button_type = "quit"
	fade_in_out.show()
	timer.start()
	animation_player.play("fade_in")

func _on_timer_timeout() -> void:
	if button_type == "start":
		if MusicManager.has_method("stop_main_menu_music"):
			MusicManager.stop_main_menu_music()
		get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")
	elif button_type == "options":
		get_tree().change_scene_to_file("res://Scenes/option_menu.tscn")
	elif button_type == "quit":
		get_tree().quit()


#get_tree().change_scene_to_file("res://Scenes/game.tscn")
#get_tree().quit()
