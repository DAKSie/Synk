extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MusicManager.stop_all_music()
	MusicManager.play_scary_sounds()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
