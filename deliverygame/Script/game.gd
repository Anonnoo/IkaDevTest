extends Node2D

@onready var pause = $CanvasLayer/PauseMenu
@onready var over = $"CanvasLayer2/Game Over"
@onready var time = $Player/Camera2D/Time
@onready var score_label = $Score

var score = 0

func _ready():
	pause.hide()
	over.hide()
	
func _process(delta: float) -> void:
	if time <= 0:
		end_game()

func add_score():
	score += 1
	score_label.text = "Score: %d" % score 
	
func end_game():
	get_node("Player").set_process(false)
	
	var prev_highscore = load_highscore()
	
	if score > prev_highscore:
		save_highscore(score)
	
	$"CanvasLayer2/Game Over".visible = true
		
func load_highscore():
	var config = ConfigFile.new()
	if config.load("") == OK:
		return int(config.get_value("game", "highscore", 0))
	return 0
	
func save_highscore(score):
	var config = ConfigFile.new()
	var path = "user://save_data.cfg"
	
	if config.load(path) == OK:
		var prev = config.get_value("game", "highscore", 0)
		if score > prev:
			config.set_value("game", "highscore", score)
		else :
			config.set_value("game", "highscore", 0)
			
		config.save(path)
	
