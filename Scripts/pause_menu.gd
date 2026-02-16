extends Control

func _ready() -> void:
	$blur_animation.play("RESET")
	visible = false  # Start hidden
	process_mode = Node.PROCESS_MODE_ALWAYS  # Process even when game is paused

func resume():
	$blur_animation.play_backwards("blur")
	visible = false
	get_tree().paused = false

func pause():
	$blur_animation.play("blur")
	visible = true
	get_tree().paused = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		if get_tree().paused:
			resume()
		else:
			pause()
		get_tree().root.set_input_as_handled()  # Prevent input propagation

func _on_resume_pressed() -> void:
	resume()

func _on_restart_pressed() -> void:
	get_tree().paused = false  # Unpause before reloading
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_main_menu_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
