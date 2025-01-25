extends CanvasLayer
signal start_game
var vie = 3
func show_message(text):
	#Création du message texte
	$Message.text=text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("GAME OVER")
	await $MessageTimer.timeout
	#Réaffiché apres la mort
	$Message.text="BASTON SAVON"
	$Message.show()
	#Mise en place du cooldown pour relancer une partie apres la mort
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	#Fonction qui actualise le score chaque seconde
	
func update_score(score):
	$ScoreLabel.text=str(score)


	
func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()


func _on_message_timer_timeout():
	$Message.hide()
	
