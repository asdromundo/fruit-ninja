extends Node

var score : int = 0
var lifes : int = 5

var spawner = preload("res://src/scenes/spawner.tscn")
var game : Node
var game_is_running : bool = false

func start() -> void:
	$"Game Over".hide()
	$"Final Score".hide()
	$Score.show()
	$Start.hide()
	$Title.hide()
	$StartFruit.hide()
	$Lifes.show()
	score = 0
	lifes = 1
	game = spawner.instantiate()
	$"..".add_child.call_deferred(game)
	
func stop() -> void:
	$"..".remove_child(game)
	
func _ready() -> void:
	pass

func _on_sword_fruit_contact() -> void:
	score+=1
	$Score.text = "Puntuación: "+ str(score)


func _on_sword_bomb_contact() -> void:
	lifes -= 1
	$Lifes.text = "Vidas restantes: " + str(lifes)
	if lifes == 0:
		stop()
		$Lifes.hide()
		$Score.hide()
		$"Game Over".show()
		$"Final Score".text = "Puntuación final: "+ str(score)
		$"Final Score".show()
		$Start.show()
		$StartFruit.show()
		game_is_running = false


func _on_sword_button_contact() -> void:
	if not game_is_running:
		game_is_running = true
		start()
