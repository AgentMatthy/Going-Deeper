extends CharacterBody2D

var speed = 100
var lookspeed = 10
var drag = 0.92
var direction = Vector2(0, 0)

func _process(delta):
	move_and_slide()
	var target = get_global_mouse_position()
	var new_transform = self.transform.looking_at(target)
	self.transform = self.transform.interpolate_with(new_transform, lookspeed * delta)
	

func _physics_process(delta):
	direction = Vector2(0, 0)
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
		velocity.x -= 1 * speed
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
		velocity.x += 1 * speed
	if Input.is_action_pressed("ui_down"):
		direction.y = 1
		velocity.y += 1 * speed
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
		velocity.y -= 1 * speed

	velocity = velocity * drag
