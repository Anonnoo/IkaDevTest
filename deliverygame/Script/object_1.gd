extends RigidBody2D

var picked = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if picked == true:
		return
		
	if body.name == "Player":
		picked = true
		
		var CarryItem = body.get_node("CarryItem")
		get_parent().remove_child(self)
		position = Vector2.ZERO
		
