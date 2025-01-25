extends Area2D
signal hit

@export var speed = 400
var screen_size 

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		$AnimatedSprite2D.animation="droite"
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		$AnimatedSprite2D.animation="gauche"
	if Input.is_action_pressed("move_backward"):
		velocity.y += 1
		$AnimatedSprite2D.animation="bas"
	if Input.is_action_pressed("move_forward"):
		velocity.y -= 1
		$AnimatedSprite2D.animation="haut"
		
	if Input.is_action_pressed("dash"):
		velocity=velocity*2
		print("espace")
	velocity=velocity/2
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed;
		$AnimatedSprite2D.play()
		
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled=false


func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	hide()
	print("ça marche")
	hit.emit()
	$CollisionShape2D.set_deferred("disabled",true)
