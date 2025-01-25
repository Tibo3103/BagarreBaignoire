extends RigidBody2D

@export var speed: float = 150
var player
var direction = Vector2.ZERO  # Initialisation par défaut

func _ready():
	$AnimatedSprite2D.play()
	# Récupère le joueur (s'assure qu'il existe)
	player = get_parent().get_parent().get_node_or_null("Player")
	if player:
		# Calcule la direction vers le joueur
		direction = (player.global_position - global_position).normalized()
	else:
		print("Le nœud 'Player' n'a pas été trouvé !")

func _physics_process(delta):
	$AnimatedSprite2D.play()
	if direction != Vector2.ZERO:
		# Applique une force à l'objet pour qu'il se déplace dans la direction
		# "Linear Velocity" est recommandé pour RigidBody2D
		linear_velocity = direction * speed

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$AnimatedSprite2D.play()
	# Supprime l'objet lorsque celui-ci quitte l'écran
	queue_free()
