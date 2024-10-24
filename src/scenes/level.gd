extends Node

var score : int = 0
var lifes : int = 5

var spawner = preload("res://src/scenes/spawner.tscn")
var game : Node
var game_is_running : bool = false
var audio : AudioStream
var audio_stream_player : AudioStreamPlayer

func start() -> void:
	audio = load_wav("res://src/assets/sound/Game-start.wav")
	audio_stream_player.stream = audio
	audio_stream_player.play()
	$"Game Over".hide()
	$"Final Score".hide()
	score = 0
	$Score.show()
	$Start.hide()
	$Title.hide()
	$StartFruit.hide()
	$Lifes.show()
	lifes = 1
	game = spawner.instantiate()
	$"..".add_child.call_deferred(game)
	
func stop() -> void:
	$Lifes.hide()
	$Score.hide()
	$"Game Over".show()
	$"Final Score".text = "Puntuación final: "+ str(score)
	$"Final Score".show()
	$Start.show()
	$StartFruit.show()
	game_is_running = false
	audio = load_wav("res://src/assets/sound/Game-over.wav")
	audio.stereo = true
	audio_stream_player.stream = audio
	audio_stream_player.play()
	
func _ready() -> void:
	audio_stream_player = $AudioStreamPlayer
	#audio_stream_player.stream = load_wav("res://src/assets/sound/menu-hd-appear.wav")
	#audio_stream_player.play()

func _on_sword_fruit_contact() -> void:
	score+=1
	$Score.text = "Puntuación: "+ str(score)


func _on_sword_bomb_contact(bomb : Bomb) -> void:
	lifes -= 1
	$Lifes.text = "Vidas restantes: " + str(lifes)
	if lifes == 0:
		bomb.reparent(self)
		$"..".remove_child(game)
		bomb.freeze = true
		audio = load_wav("res://src/assets/sound/Bomb-explode.wav")
		audio_stream_player.stream = audio
		audio_stream_player.play()
		await get_tree().create_timer(4).timeout
		stop()


func _on_sword_button_contact() -> void:
	if not game_is_running:
		game_is_running = true
		start()

func load_mp3(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var sound = AudioStreamMP3.new()
	sound.data = file.get_buffer(file.get_length())
	return sound
	
func load_wav(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var sound = AudioStreamWAV.new()
	sound.format = sound.FORMAT_16_BITS
	sound.mix_rate = 22050
	sound.data = file.get_buffer(file.get_length())
	return sound
