extends Node

@export var mob_scene: PackedScene


func _ready():
	if mob_scene == null:
		push_error("mob_scene is not assigned!")
		return
	new_game()


func new_game():
	$startTimer.start()


func _on_start_timer_timeout():
	$mobTimer.start()


func _on_mob_timer_timeout():
	if mob_scene == null:
		push_error("mob_scene is not assigned!")
		return
	
	# Instanciation et placement du mob
	var mob = mob_scene.instantiate()
	var mob_spawn_location = get_node("mobPath/mobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	mob.position = mob_spawn_location.position
	
	# Calcul de la direction et de la vitesse
	var direction = mob_spawn_location.rotation + PI / 2
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# Ajout du mob à la scène
	add_child(mob)
	
	# Suppression automatique après 5 secondes (ajustable)
	mob.call_deferred("queue_free", 5)
