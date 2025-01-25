extends Area2D
#signal hit

@export var speed = 400
var screen_size 

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		if Input.is_action_pressed("dash"):
			velocity.x += 20
			print("dash droite")
		velocity.x += 1
		$AnimatedSprite2D.animation="droite"
	if Input.is_action_pressed("move_left"):
		if Input.is_action_pressed("dash"):
			velocity.x -= 20
			print("dash gauche")
		velocity.x -= 1
		$AnimatedSprite2D.animation="gauche"
	if Input.is_action_pressed("move_backward"):
		if Input.is_action_pressed("dash"):
			velocity.y += 20
			print("dash bas")
		velocity.y += 1
		$AnimatedSprite2D.animation="bas"
	if Input.is_action_pressed("move_forward"):
		if Input.is_action_pressed("dash"):
			velocity.y -= 1
			print("dash haut")
		velocity.y -= 1
		$AnimatedSprite2D.animation="haut"
		
	
	
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


func _on_body_shape_entered(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	"""
	hide()
	print("ça marche")
	hit.emit()
	$CollisionShape2D.set_deferred("disabled",true)
	"""
	pass
