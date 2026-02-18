extends Node2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var crt_effect: Node2D = $CrtEffect
@onready var scream: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.hide()
	pass # Replace with function body.


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		MusicManager.stop_all_music()
		scream.play()
		crt_effect.queue_free()
		print("Hello")
		anim.show()
		anim.play("default")
