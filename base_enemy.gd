extends CharacterBody2D

@export var max_hp = 1
@export var hp = 1
@export var speed = 1
@export var death_effect: Callable

func _ready():
	$HealthBar.max_value = max_hp
	$HealthBar.value = hp

func _physics_process(delta):
	#movement
	pass

func take_damage(amount):
	hp -= amount
	if hp < 1:
		die(death_effect)
		
func die(effect):
	if effect != null:
		#do death effect
		pass
	self.queue_free()
	
