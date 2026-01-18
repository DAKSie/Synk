extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -250.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $detect_enemy/Timer
@onready var walking_sound: AudioStreamPlayer2D = $walking
@onready var jumping_sound: AudioStreamPlayer2D = $jumping

func _on_ready() -> void:
	GlobalVar.isDead = false
	GlobalVar.canPass = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	#disable movement if dead
	if GlobalVar.isDead:
		velocity.x = 0
		velocity.y = 0
		move_and_slide()
		return

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jumping_sound.play()
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
			walking_sound.stop()
		else:
			animated_sprite.play("run")
			if not walking_sound.playing:
				walking_sound.play()
	else:
		animated_sprite.play("jump")
		


	move_and_slide()


func _on_detect_enemy_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") or area.is_in_group("enemy_2"):
		GlobalVar.isDead = true
		MusicManager.play_player_death_sfx()
		animated_sprite.play("die")
		print("collided")
		Engine.time_scale = 0.5
		timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
