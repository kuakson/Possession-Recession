extends AnimatedSprite2D


@export var speed = 300


func _physics_process(delta):
	var velocity = Vector2(0, 0)
	if Input.is_action_pressed("move down"):
		velocity.y = speed
	if Input.is_action_pressed("move up"):
		velocity.y = -speed
	if Input.is_action_pressed("move right"):
		velocity.x = speed
	if Input.is_action_pressed("move left"):
		velocity.y = -speed
	move_and_slide()
