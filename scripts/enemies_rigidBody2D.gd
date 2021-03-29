extends RigidBody2D

export var min_speed = 150
export var max_speed = 250

func _ready():
	var enemies_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = enemies_types[randi() % enemies_types.size()]

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
