extends Node
@export var mob_scene: PackedScene
var score
var vie =3
func _ready():
	# Vérification si la scène du mob est assignée
	if mob_scene == null:
		push_error("mob_scene is not assigned!")
		return
	
	#new_game()

func _on_mob_timer_timeout():
	# Vérification si la scène du mob est assignée
	if mob_scene == null:
		push_error("mob_scene is not assigned!")
		return
		
	
	# Instancier le mob
	var mob = mob_scene.instantiate()
	print(mob)
	# Configurer la position du mob
	var mob_spawn_location = get_node("mobPath/mobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	mob.position = mob_spawn_location.position
	

	
	
	
	# Ajouter le mob à la scène
	add_child(mob)
	
	

func game_over():
	
	$Music.stop()
	$GameOverSound.play()
	$ScoreTimer.stop()
	$mobTimer.stop();
	$HUD.show_game_over()
	for child in get_children():  # Parcourt les enfants directs de "main"
		if child.has_method("extinction") and child.is_pouce_pouce:
			child.extinction()
	
func new_game():
	
	$Music.play()
	score=0
	# Connectez le signal hit du joueur pour gérer les collisions
	$startTimer.start()
	$mobTimer.start()
	$Player.start($startPosition.position)
	$HUD.update_score(score)
	$HUD.show_message("GO")

func _on_start_timer_timeout():
	$mobTimer.start()
	$ScoreTimer.start()
func _on_score_timer_timeout():
	score+=1
	$HUD.update_score(score)
