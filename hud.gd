extends CanvasLayer

signal start_game

func show_message(text):
	$messageLabel.text = text
	$messageLabel.show()
	$messageTimer.start()
	
func show_gameover():
	show_message('Fim de jogo!')
	await $messageTimer.timeout
	
	$messageLabel.text = 'Desvie e sobreviva aos monstros!'
	$messageLabel.show()
	await get_tree().create_timer(1).timeout
	$startButton.show()

func update_score(score):
	$scoreLabel.text = str(score)

func _on_start_button_pressed():
	$startButton.hide()
	emit_signal("start_game")

func _on_message_timer_timeout():
	$messageLabel.hide()
