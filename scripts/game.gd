extends Node2D


func _process(delta):
	if Input.is_action_just_pressed("quit"):  #press esc to quit
		get_tree().quit()
	elif Input.is_action_pressed("restart"):  #press F5 to reload the scene
		get_tree().reload_current_scene()
