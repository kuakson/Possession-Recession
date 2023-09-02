extends CharacterBody2D


@export var speed = 300
@export var dashSpeed = 1000
@export var dashDuration = 0.5
@export var isGhost = true

var dashTimer = 0
var dashDirection = Vector2.ZERO


func setGhost(value: bool):
	
	if value == true:
		isGhost = true
		
		get_collision_mask()
		set_collision_mask_value(1, false)
	else:
		isGhost = false
		set_collision_mask_value(1, true)
		
func _physics_process(delta):

	var direction = Input.get_vector("move left", "move right", "move up", "move down").normalized()
	if direction:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()	
	#dashing for possession
	if dashTimer > 0:
		dashTimer -= delta
		move_and_collide(dashDirection * dashSpeed * delta)
	else:
		var inputVector = Vector2.ZERO
		inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		inputVector = inputVector.normalized()
		move_and_slide()

	if Input.is_action_just_pressed("possess"):
		possession()
		
	if Input.is_action_just_pressed("attack"):
		attack()
		
func possession(): #RMB
	print("I'm possessing")
	var mousePosition = get_global_mouse_position()
	var playerPosition = global_position
	dashDirection = (mousePosition - playerPosition).normalized()
	dashTimer = dashDuration
	setGhost(true)
   
func attack(): #LMB
	print("I'm attacking")
	
	
func take_damage(damage):
	print("It's just a flesh wound!")
#func switchCollision():
	#some code to turn on collision while possessing
	#if !isGhost:
		#set_collision_layer_value(4, true)
