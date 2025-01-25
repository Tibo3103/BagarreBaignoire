extends Node

@export var mob_scene: PackedScene


func _ready():
	# Vérification si la scène du mob est assignée
	if mob_scene == null:
		push_error("mob_scene is not assigned!")
		return
	
	new_game()


func new_game():
	$startTimer.start()


func _on_start_timer_timeout():
	$mobTimer.start()


func _on_mob_timer_timeout():
	# Vérification si la scène du mob est assignée
	if mob_scene == null:
		push_error("mob_scene is not assigned!")
		return
	
	# Instancier le mob
	var mob = mob_scene.instantiate()
	
	# Configurer la position du mob
	var mob_spawn_location = get_node("mobPath/mobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	mob.position = mob_spawn_location.position
	
	# Passer la référence du joueur au mob
	var player = get_node_or_null("Player")
	if player == null:
		push_error("Player node not found in the scene!")
		mob.queue_free()
		return
	
	
	
	# Ajouter le mob à la scène
	add_child(mob)

	
	
