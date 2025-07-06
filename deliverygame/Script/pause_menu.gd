extends Control

	
func _process(delta):
	clickEsc()

func _on_continue_pressed() -> void:
	get_tree().paused = false
	
func pause(): 
	get_tree().paused = true
	
func clickEsc():
	if Input.is_action_just_pressed("ui_cancel") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("ui_cancel") and get_tree().paused == true:
		_on_continue_pressed()

func _on_back_main_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_restart_pressed() -> void:
	_on_continue_pressed()
	get_tree().reload_current_scene()
