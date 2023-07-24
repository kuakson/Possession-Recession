extends CharacterBody2D

@export var max_hp = 1
@export var hp = 1
@export var move_speed = 8 #pixels
@export var death_effect: Callable

@export_category("Ranges")
@export var chase_range = 36 #circle radius in pixels
@export var melee_range = 15 #circle radius in pixels
@export var ranged_range= 50 #circle radius in pixels

enum state {CHASE, DIE, SHAMBLE} 

var State = state.SHAMBLE
var Target: Node2D # The target the current enemy focuses on. determines what will be chased, attacked, etc.


func _ready():
	$HealthBar.max_value = max_hp
	$HealthBar.value = hp
	
	$ChaseArea/ChaseShape.shape.radius = chase_range
	$MeleeArea/MeleeShape.shape.radius = melee_range
	$RangedShape/RangedShape.shape.radius = ranged_range
	

func _physics_process(delta):
	#movement
	match State:
		
		state.CHASE:
			velocity = (Target.global_position - global_position).normalized() * move_speed
			
		state.SHAMBLE:
			## Check if already shambling in some way, if not  choose new shamble parameters
			if $ShambleTimer.get_time_left() == 0:
				## Stop and Reset ShambleTimer
				$ShambleTimer.stop()
				$ShambleTimer.wait_time = randf_range(1.0, 3.0)
				## Pick one of 8 random directions
				var direction = [
					Vector2.UP,
					Vector2.DOWN, 
					Vector2.LEFT, 
					Vector2.RIGHT,
					Vector2.RIGHT + Vector2.UP,
					Vector2.RIGHT + Vector2.DOWN,
					Vector2.LEFT + Vector2.UP,
					Vector2.LEFT + Vector2.DOWN,
					].pick_random()
				## Choose whether to be Idle or to Walk
				var idle = [0, 1].pick_random()
				## Set Direction and speed of walking (0 if idle)
				velocity = direction.normalized() * move_speed * idle
				## Start timer to perform Shamble Walk
				$ShambleTimer.start()
		
		state.DIE:
			pass
			
	move_and_slide()

func take_damage(amount):
	hp -= amount
	if hp < 1:
		die(death_effect)
		
func die(effect):
	if effect != null:
		#do death effect
		pass
	self.queue_free()
	


func _on_chase_area_body_entered(body):
	if body.is_in_group("player"): # If the player entered the chase area
		Target = body
		print("Change state to Chase!")
		State = state.CHASE


func _on_chase_area_body_exited(body):
	if body.is_in_group("player"): # If the player entered the chase area
		print("Change state to Shamble")
		State = state.SHAMBLE
