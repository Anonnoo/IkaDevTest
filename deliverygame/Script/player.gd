extends CharacterBody2D

const SPEED = 120.0
const JUMP_VELOCITY = -300.0

@onready var item = $ItemSprite

var pick_item = false
var curr_item = null
var curr_rec = null
var recipient = []
var score = 0
	
func _ready():
	recipient = get_tree().get_nodes_in_group("recipient")

func _process(delta):
	if pick_item and Input.is_action_just_pressed("interact"):
		if curr_item == null:
			var item_data = ItemData.get_randomize_item()
			curr_item = item_data
			pickUp_item(item_data)
			$Pickup.play()
		else : 
			if !matchWish(curr_item):
				var item_data = ItemData.get_randomize_item()
				curr_item = item_data
				pickUp_item(item_data)
				$Pickup.play()
		
		if curr_rec and Input.is_action_just_pressed("interact") and curr_item:
			if matchItems(curr_item, curr_rec.itemWant):
				$drop.play()
				var particle = preload("res://Scenes/cpu_particles_2d.tscn").instantiate()
				particle.position = position
				particle.emitting = true
				get_tree().current_scene.add_child(particle)
				get_parent().add_score()
				curr_item = null
				item.visible = false
				curr_rec.randomize_item()
			
func pickUp_item(item):
	item.texture = item.texture
	item.visible = true
	
func matchItems(a, b):
	return a.id == b.id
	
func drop_item():
	curr_item = null
	item.visible = false
	
func matchWish(item):
	for r in recipient:
		if r.itemWant.id == item.id:
			return true
		return false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
