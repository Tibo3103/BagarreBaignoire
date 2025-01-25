extends Node

@export var mob_scene: PackedScene


func _ready():
	# Vérification si la scène du mob est assignée
	if mob_scene == null:
		push_error("mob_scene is not assigned!")
		return
	
	new_game()


func _on_start_timer_timeout():
	$mobTimer.start()


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
	
	


	
	


func game_over() -> void:
	#$mobTimer.stop();
	pass
	
func new_game():
	$mobTimer.start()
	$Player.start($startPosition.position)
	
