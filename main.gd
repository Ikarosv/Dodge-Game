extends Node

@export var Enemy: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	#new_game()


func game_over():
	$scoreTimer.stop()
	$enemyTimer.stop()
	$HUD.show_gameover()
	$music.stop()
	$deathSong.play()
	
func new_game():
	score = 0
	$Player.start($initialPosition.position)
	$initTimer.start()
	$HUD.show_message('Prepare-se')
	$HUD.update_score(score)
	$music.play()
	

func _on_init_timer_timeout():
	$enemyTimer.start()
	$scoreTimer.start()


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_enemy_timer_timeout():
	$enemyPath/enemySpawn.progress_ratio = randf()
	var enemy = Enemy.instantiate()
	add_child(enemy)
	var direction = $enemyPath/enemySpawn.rotation + PI/2
	enemy.position = $enemyPath/enemySpawn.position
	direction += randf_range(-PI / 4, PI / 4)
	enemy.rotation = direction
	enemy.linear_velocity = Vector2(randf_range(enemy.min_speed, enemy.max_speed), 0)
	enemy.linear_velocity = enemy.linear_velocity.rotated(direction)
