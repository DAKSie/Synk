extends Control

@onready var options_fade: ColorRect = $options_fade
@onready var animation_player: AnimationPlayer = $options_fade/AnimationPlayer
@onready var options_timer: Timer = $options_timer
@onready var resolution: OptionButton = $MarginContainer/VBoxContainer/Resolution

var master_bus = AudioServer.get_bus_index("Master")
var SFX_bus = AudioServer.get_bus_index("SFX")

func _on_ready() -> void:
	options_fade.show()
	animation_player.play("fade_out")

func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus, value)

func _on_resolution_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_size(Vector2i(1920, 1080))
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_size(Vector2i(1600, 900))
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_size(Vector2i(1280, 720))
		3:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_size(Vector2i(1152, 648))
		4:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_mute_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(master_bus, toggled_on)

func _on_back_pressed() -> void:
	animation_player.play("fade_in")
	options_timer.start()

func _on_options_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
