extends Area2D

@onready var key_sprite: AnimatedSprite2D = $key_sprite
@onready var key_anim_timer: Timer = $key_anim_timer
@onready var door_sprite: AnimatedSprite2D
@onready var key_explode_sound: AudioStreamPlayer2D = $key_explode_sound

func _ready() -> void:
	door_sprite = get_node("../NextLevel/Door_Sprite") as AnimatedSprite2D
	GlobalVar.canPass = false
	print(GlobalVar.canPass)

func _player_collected_key(area: Area2D) -> void:
	if area.is_in_group("player"):
		GlobalVar.canPass = true
		key_explode_sound.play()
		key_sprite.play("collect")
		door_sprite.play("open")
		key_anim_timer.start()
		print(GlobalVar.canPass)

func _on_key_anim_timer_timeout() -> void:
	queue_free()
