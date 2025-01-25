extends RigidBody2D
@export var bubulle_scene: PackedScene
@export var speed: float = 100.0  # Vitesse de déplacement de l'ennemi
@export var is_pouce_pouce = true
func _ready():
	# Vérifie si le TimerBubulle existe et démarre
	if $TimerBubulle:
		$TimerBubulle.start()
		
	else:
		push_error("TimerBubulle introuvable dans la scène.")

func _physics_process(_delta):
	$AnimatedSprite2D.play()
	
	# Essayer de trouver le nœud du joueur
	var player = get_parent().get_node_or_null("Player")
	if player:
		# Calculer la direction vers le joueur
		var direction = (player.global_position - global_position).normalized()
		
		# Appliquer une vitesse au corps rigide
		linear_velocity = direction * speed
	else:
		push_warning("Le nœud 'Player' est introuvable.")

func _on_visible_on_screen_notifier_2d_screen_exited():
	# Supprime l'ennemi lorsqu'il quitte l'écran
	queue_free()

func _on_timer_bubulle_timeout():
	
	$AnimatedSprite2D.play()
	
	# Vérifie que la scène de Bubulle est assignée
	if bubulle_scene == null:
		push_error("bubulle_scene n'est pas assignée dans l'inspecteur.")
		return 
	
	# Instancie une nouvelle Bubulle
	var bubulle = bubulle_scene.instantiate()
	bubulle.position = global_position  # Place la Bubulle à la position actuelle de l'ennemi
	get_parent().add_child(bubulle)  # Ajoute la Bubulle à la scène parent
func extinction():
	queue_free()
