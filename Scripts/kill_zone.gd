extends Area2D

@onready var timer: Timer = $Timer

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		GlobalVar.canMove = true
		Engine.time_scale = 0.5
		timer.start()
