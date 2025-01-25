extends RigidBody2D

@export var speed: float = 150
var player: Node2D
var direction = Vector2.ZERO

func _ready():
	$AnimatedSprite2D.play()
	# Recherche le joueur dans la hiérarchie
	player = get_parent().get_node_or_null("Player")
	
	if player:
		direction = (player.global_position - global_position).normalized()
	else:
		#push_error("Le nœud 'Player' n'a pas été trouvé ! Le mouvement est désactivé.")
		direction = Vector2.ZERO  # Désactive le mouvement si aucun joueur trouvé

func _physics_process(_delta):
	$AnimatedSprite2D.play()
	if player != null:
		# Recalcule la direction pour suivre le joueur dynamiquement
		
		linear_velocity = direction * speed
	else:
		# Si le joueur n'existe plus, désactive le mouvement
		linear_velocity = Vector2.ZERO

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$AnimatedSprite2D.play()
	queue_free()  # Supprime l'entité lorsqu'elle sort de l'écran
