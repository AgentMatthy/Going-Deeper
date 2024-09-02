extends Node

var attackforce = 10000

@onready var player = %Player
@onready var attackcooldown = $"../../TIMERS/ATTACKCOOLDOWN"
@onready var attackcooldownBar = %AttackCooldownBar

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	attackcooldownBar.value = 1 - attackcooldown.time_left
	
	if Input.is_action_just_pressed("attack") and attackcooldown.time_left == 0:
		player.velocity = Vector2(cos(player.rotation), sin(player.rotation)) * attackforce
		attackcooldown.start()
