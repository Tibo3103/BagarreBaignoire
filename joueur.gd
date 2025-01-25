extends Area2D
signal hit
var count=0
@export var speed = 400
var screen_size 
var is_ready : bool = true
var touchable = true

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		if Input.is_action_pressed("dash") and is_ready:
			is_ready = false 
			$DashCooldown.start()
			speed = 1000
			$Dash.start()
			print("dash droite")
		velocity.x += 1
		$AnimatedSprite2D.animation="droite"
	if Input.is_action_pressed("move_left"):
		if Input.is_action_pressed("dash") and is_ready:
			is_ready = false 
			$DashCooldown.start()
			speed = 1000
			$Dash.start()
			print("dash gauche")
		velocity.x -= 1
		$AnimatedSprite2D.animation="gauche"
	if Input.is_action_pressed("move_backward"):
		if Input.is_action_pressed("dash") and is_ready:
			is_ready = false 
			$DashCooldown.start()
			speed = 1000
			$Dash.start()
			print("dash bas")
		velocity.y += 1
		$AnimatedSprite2D.animation="bas"
	if Input.is_action_pressed("move_forward"):
		if Input.is_action_pressed("dash") and is_ready:
			is_ready = false 
			$DashCooldown.start()
			speed = 1000
			$Dash.start()
			print("dash haut")
		velocity.y -= 1
		$AnimatedSprite2D.animation="haut"
		
	
	
	if velocity.length() > 0:
		velocity = velocity * speed;
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
	if touchable:
		#hide()
		print("ça marche")
		hit.emit()
		count=count+1
		print(count)
		#$CollisionShape2D.set_deferred("disabled",true)
		touchable = false
		$CooldownCollision.start()
		if count==3:
			get_parent().game_over()
			count=0
	


func _on_dash_cooldown_timeout():
	is_ready = true


func _on_dash_timeout():
	speed = 400


func _on_cooldown_collision_timeout():
	touchable=true
