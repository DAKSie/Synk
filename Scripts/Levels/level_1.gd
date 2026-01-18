extends Node2D

@onready var fade_in_out: ColorRect = $fade_in_out
@onready var animation_player: AnimationPlayer = $fade_in_out/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MusicManager.play_level_music()
	fade_in_out.show()
	animation_player.play("fade_out")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
