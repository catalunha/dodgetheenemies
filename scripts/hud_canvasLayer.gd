extends CanvasLayer


signal start_game

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	yield($MessageTimer,"timeout")
	show_message("Dodge the Enemies!")
	yield($MessageTimer,"timeout")
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)


func _on_MessageTimer_timeout():
	$MessageLabel.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
