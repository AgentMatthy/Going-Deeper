extends CharacterBody2D

@onready var dashbar = %DashBar
@onready var dashrechargebar = %DashRechargeBar
@onready var dashblockbar = %DashBlock

var speed = 200
var lookspeed = 10
var drag = 0.8
var direction = Vector2(0, 0)

var dash_cooldown = 70
var D_dash_coldown = 70
var dash_amount = 3
var dash_block = 0

func _process(delta):
	move_and_slide()
	var target = get_global_mouse_position()
	var new_transform = self.transform.looking_at(target)
	self.transform = self.transform.interpolate_with(new_transform, lookspeed * delta)
	
	dashbar.value = dash_amount
	dashrechargebar.value = dash_cooldown
	dashblockbar.value = dash_block
	
	if Input.is_action_just_pressed("space") and dash_block == 0:
		dash()

func _physics_process(delta):
	direction = Vector2(0, 0)
	velocity = velocity * drag
	
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
		
	if dash_block > 0:
		dash_block -= 1
	if dash_amount < 3:
		if dash_cooldown > 0:
			dash_cooldown -= 1
		if dash_cooldown == 0:
			dash_cooldown = D_dash_coldown
			dash_amount += 1
		
func dash():
	if velocity.x > 150 or velocity.x < -150 or velocity.y > 150 or velocity.y < -150:
		if dash_amount > 0:
			velocity = velocity * 5
			dash_amount -= 1
			dash_block = 15
		elif dash_amount == 0:
			velocity = velocity * 0

