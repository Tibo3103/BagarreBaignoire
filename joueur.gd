extends Area2D
signal hit
var count=0

@export var speed = 400
var screen_size 
var is_ready : bool = true
var touchable = true
var dashing = false
var vivant = true
var vie = 3

	
func _process(delta):
	if vivant :
		var velocity = Vector2.ZERO
		if Input.is_action_pressed("move_right"):
			if Input.is_action_pressed("dash") and is_ready:
				$AnimatedSprite2D.animation="slide_gauche"
				is_ready = false 
				dashing = true
				$DashCooldown.start()
				speed = 1000
				$Dash.start()
				print("dash droite")
			velocity.x += 1
			if not dashing :
				$AnimatedSprite2D.animation="droite"
		if Input.is_action_pressed("move_left"):
			if Input.is_action_pressed("dash") and is_ready:
				$AnimatedSprite2D.animation="slide_droite"
				is_ready = false 
				dashing = true
				$DashCooldown.start()
				speed = 1000
				$Dash.start()
				print("dash gauche")
			velocity.x -= 1
			if not dashing :
				$AnimatedSprite2D.animation="gauche"
		if Input.is_action_pressed("move_backward"):
			if Input.is_action_pressed("dash") and is_ready:
				$AnimatedSprite2D.animation="slide_bas"
				is_ready = false 
				dashing = true
				$DashCooldown.start()
				speed = 1000
				$Dash.start()
				print("dash bas")
			velocity.y += 1
			if not dashing :
				$AnimatedSprite2D.animation="bas"
		if Input.is_action_pressed("move_forward"):
			if Input.is_action_pressed("dash") and is_ready:
				$AnimatedSprite2D.animation="slide_haut"
				
				is_ready = false 
				dashing = true
				$DashCooldown.start()
				speed = 1000
				$Dash.start()
				print("dash haut")
			velocity.y -= 1
			if not dashing :
				$AnimatedSprite2D.animation="haut"
		
	
	
		if velocity.length() > 0:
			velocity = velocity * speed;
			$AnimatedSprite2D.play()
			
		else:
			$AnimatedSprite2D.stop()
	
		position += velocity * delta
	

	

func start(pos):
	position = pos
	vivant = true
	show()
	$CollisionShape2D.disabled=false


func _on_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if touchable and not dashing and vivant:
		#hide()
		$AnimatedSprite2D.animation="blessure"
		print(body.name)
		if body.name == "Bubulle":
			body.queue_free()
			
		print("ça marche")
		hit.emit()
		count=count+1
		print(count)
		#$CollisionShape2D.set_deferred("disabled",true)
		touchable = false
		$CooldownCollision.start()
		vie -= 1
		get_parent().get_node_or_null("HUD").update_vie(vie)
		if count==3:
			vivant = false
			$AnimatedSprite2D.animation="mort"
			$CollisionShape2D.set_deferred("disabled",true)
			get_parent().game_over()
			vie = 3
			get_parent().get_node_or_null("HUD").update_vie(vie)
			count=0
			
	elif  dashing:
		body.queue_free()
		#$hud.ennemi_vaincu()
	


func _on_dash_cooldown_timeout():
	is_ready = true


func _on_dash_timeout():
	speed = 400
	dashing = false


func _on_cooldown_collision_timeout():
	touchable=true
