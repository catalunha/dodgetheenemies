extends Area2D

signal hit
export var velocity = 100 # Quão rápido o jogador se movimentará em pixels/second
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	start(Vector2(100,100))
	hide()

func _process(delta):
	var movement = Vector2(0,0)
	if Input.is_action_pressed("ui_right"):
		movement.x = movement.x +1
#		movement.x += 1
	if Input.is_action_pressed("ui_left"):
		movement.x -= 1
	if Input.is_action_pressed("ui_down"):
		movement.y += 1
	if Input.is_action_pressed("ui_up"):
		movement.y -= 1
		
	if movement.length() > 0:
		movement = movement.normalized()
		$AnimatedSprite.play()
		if movement.x != 0:
			$AnimatedSprite.animation = "walk"
			$AnimatedSprite.flip_v = false
			$AnimatedSprite.flip_h = movement.x < 0
		elif movement.y != 0:
			$AnimatedSprite.animation = "up"
			$AnimatedSprite.flip_v = movement.y > 0
	else:
		$AnimatedSprite.stop()

	position += movement * (velocity * delta)

#	if position.x < 0:
#		position.x = 0
#	if position.x > screen_size.x:
#		position.x = screen_size.x
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func start(position_start):
	position = position_start
	visible = true
	$CollisionShape2D.disabled = false

func _on_PlayerArea2D_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled",true)
