extends Area2D

@export var speed = 400
var screen_size

signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play()	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		$GPUParticles2D.emitting = true
		velocity = velocity.normalized() * speed
	else:
		$GPUParticles2D.emitting = false		
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation	= 'right'
		$AnimatedSprite2D.flip_v = false				
		$AnimatedSprite2D.flip_h = velocity.x < 0
			
	if velocity.y != 0:
		$AnimatedSprite2D.animation	= 'up'
		$AnimatedSprite2D.flip_v = velocity.y > 0		
			
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
	

func _on_body_entered(body):
	hide()
	emit_signal('hit')
	$CollisionShape2D.set_deferred("disabled", true)
