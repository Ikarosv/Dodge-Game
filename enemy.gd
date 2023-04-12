extends RigidBody2D

@export var min_speed = 150
@export var max_speed = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	var enemyType = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.animation = enemyType[randi() % enemyType.size()]
	#$AnimatedSprite2D.play()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
