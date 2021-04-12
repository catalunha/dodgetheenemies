extends Node

export(PackedScene) var Enemies
var score

func _ready():
	randomize()

func new_game():
	score = 0
	$PlayerArea2D.start($StartPosition2D.position)
	$StartTimer.start()
	$HUDCanvasLayer.update_score(score)
	$HUDCanvasLayer.show_message("Let's Go")
	$MusicAudioStreamPlayer.play()

func game_over():
	print("gameover")
	$MusicAudioStreamPlayer.stop()
	$DeathAudioStreamPlayer.play()
	$ScoreTimer.stop()
	$EnemiesTimer.stop()
	$HUDCanvasLayer.show_game_over()
	get_tree().call_group("enemies","queue_free")

func _on_EnemiesTimer_timeout():
	print("_on_EnemiesTimer_timeout")
	# Choose a random location on Path2D.
	$EnemiesPath2D/EnemiesPathFollow2D.offset = randi()
	print($EnemiesPath2D/EnemiesPathFollow2D.offset)
	# Create a Mob instance and add it to the scene
	var enemies = Enemies.instance()
	add_child(enemies)
	# Set the mob's position to a random location.
	enemies.position = $EnemiesPath2D/EnemiesPathFollow2D.position
	# Set the mob's direction perpendicular to the path direction.
#	print(rad2deg($EnemiesPath2D/EnemiesPathFollow2D.rotation))
	var direction = $EnemiesPath2D/EnemiesPathFollow2D.rotation + PI / 2
#	print(rad2deg(direction))
#	# Add some randomness to the direction.
	direction += rand_range(-PI/4,PI/4)
	print(rad2deg(direction))
	enemies.rotation = direction
#	# Set the velocity (speed & direction).
	enemies.linear_velocity = Vector2(rand_range(enemies.min_speed,enemies.max_speed),0)
	print(enemies.linear_velocity)
	# Rotaciona o enemies na direção do movimenot 
	enemies.linear_velocity = enemies.linear_velocity.rotated(direction)
	print(enemies.linear_velocity)

func _on_EscoreTimer_timeout():
	score += 1
	$HUDCanvasLayer.update_score(score)


func _on_StartTimer_timeout():
	print("_on_StartTimer_timeout")
	$EnemiesTimer.start()
	$ScoreTimer.start()


func _on_HUDCanvasLayer_start_game():
	new_game()
	
func _on_PlayerArea2D_hit():
	print("_on_PlayerArea2D_hit")
	game_over()
