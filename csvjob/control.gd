extends Control

@onready var job_option = $JobOption
@onready var job_desc = $JobDesc
@onready var skill1 = $Skill1
var data = []

func _ready():
	load_csv()
	fill_option()
	job_option.connect("item_selected", Callable(self, "_on_job_selected"))
	_on_job_selected(0)	
	
func load_csv():
	var file = FileAccess.open("res://Resources/GameJobFile.csv", FileAccess.READ)
	if file:
		file.get_csv_line()
		while not file.eof_reached():
			var line = file.get_csv_line()
			if line.size() >= 4:
				var job = {
					"id": line[0],
					"name": line[1],
					"desc": line[2],
					"skills": line[3].split(";")
				}
				data.append(job)
	
func fill_option():
	for job in data:
		job_option.add_item(job["name"])

func _on_job_selected(index): 
	var job = data[index]
	job_desc.text = job["desc"]
	
	for child in skill1.get_children():
		child.queue_free()
		
	for skill in job["skills"]:
		if skill.strip_edges() != "":
			var label = Label.new()
			label.text = "- " + skill.strip_edges() + "\n"
			skill1.add_child(label)
