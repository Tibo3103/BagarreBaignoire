extends RigidBody2D

@export var speed: float = 100.0  # Vitesse de déplacement de l'ennemi

func _physics_process(delta):
	# Essayer de trouver le nœud du joueur
	var player = get_parent().get_node_or_null("Player")
	if player:
		# Déplacement vers le joueur
		var direction = (player.global_position - global_position).normalized()
		position += direction * speed * delta
	else:
		push_warning("Le nœud 'Player' est introuvable.")

func _on_visible_on_screen_notifier_2d_screen_exited():
	# Supprime l'ennemi s'il quitte l'écran
	queue_free()
