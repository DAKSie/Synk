extends Node

var main_menu_music: AudioStreamPlayer2D
var level_music: AudioStreamPlayer2D
var enemy_death_sfx: AudioStreamPlayer2D
var player_death: AudioStreamPlayer2D

func _ready() -> void:
	#-----------------------------------Main Menu music player
	main_menu_music = AudioStreamPlayer2D.new()
	add_child(main_menu_music)
	#load music
	var menu_music_stream = preload("uid://cwxdggc3hr700")
	#check if music loaded successfully
	if menu_music_stream:
		main_menu_music.stream = menu_music_stream
		print("Music stream loaded successfully")
	else:
		print("ERROR music load")
	main_menu_music.stream = menu_music_stream
	
	#-----------------------------------Level music playuer
	level_music = AudioStreamPlayer2D.new()
	add_child(level_music)
	var level_music_stream = preload("uid://diyf1me05f3am")
	if level_music_stream:
		level_music.stream = level_music_stream
		print("Music stream loaded successfully")
	else:
		print("ERROR music load")
	level_music.stream = level_music_stream
	
	#-----------------------------------SFX
	
	#enemy
	enemy_death_sfx = AudioStreamPlayer2D.new()
	add_child(enemy_death_sfx)
	var enemy_death_stream = preload("uid://dg5ludya0kiyr")
	if enemy_death_stream:
		enemy_death_sfx.stream = enemy_death_stream
		print("Music stream loaded successfully" + str(enemy_death_stream))
	else:
		print("ERROR music load")
	enemy_death_sfx.stream = enemy_death_stream
	
	#player death
	player_death = AudioStreamPlayer2D.new()
	add_child(player_death)
	var player_death_stream = load("res://Assets/music/sfx/death.mp3")
	if player_death_stream:
		player_death.stream = player_death_stream
		print("Music stream loaded successfully" + str(player_death))
	else:
		print("ERROR music load")
	player_death.stream = player_death_stream
	

#Music player endpoints

#-----------------------Main menu
func play_main_menu_music():
	if main_menu_music and main_menu_music.stream and not main_menu_music.playing:
		main_menu_music.play()

func stop_main_menu_music():
	main_menu_music.stop()

#-----------------------Levels

func play_level_music():
	stop_all_music()
	if level_music and level_music.stream and not level_music.playing:
		level_music.play()
		
func stop_level_music():
	if level_music:
		level_music.stop()

func stop_all_music():
	stop_main_menu_music()
	
#-----------------------SFX
# enemy
func play_death_enemy_sfx():
	if enemy_death_sfx and enemy_death_sfx.stream and not enemy_death_sfx.playing:
		enemy_death_sfx.play()

#player

func play_player_death_sfx():
	if player_death and player_death.stream and not player_death.playing:
		player_death.play()
