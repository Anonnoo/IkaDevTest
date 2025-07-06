extends Control

@onready var score = $HBoxContainer/Score

func _ready() -> void:
	var highscore = load_highscore()
	score.text = "%d" % highscore
	
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
	
func load_highscore():
	var config = ConfigFile.new()
	if config.load("user://save_data.cfg") == OK:
		return int(config.get_value("game", "highscore", 0))
	return 0
