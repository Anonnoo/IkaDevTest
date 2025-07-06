extends Area2D

@export var recipient : Texture
var item = null

func _ready():
	$AnimatedSprite2D.texture = recipient
	randomize_item()
	
func randomize_item():
	item = ItemData.get_random_item()
	$Sprite2D.texture = item.texture

func _on_body_entered(body):
	if body.name == "Player":
		body.current_recipient = self
		
func _on_body_exited(body):
	if body.name == "Player" and body.current_recipient == self:
		body.current_recipient = null
