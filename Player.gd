extends CharacterBody2D


var move_speed : float = 100.0
var jump_force : float = 200.0
var gravity : float = 500.0
var score : int = 0
@onready var debug_text : Label = get_node("CanvasLayer/DebugInfo")
@onready var score_text : Label = get_node("CanvasLayer/ScoreText")


func _process(delta):
	debug_text.text = str("velocity: (", velocity.x, ",", velocity.y, ")
	jump_force: ", jump_force, ", move_speed: ", move_speed, "
	global_position: ", global_position, "
	state: ")
	if is_on_floor(): debug_text.text += "is_on_floor "
	if is_on_wall(): debug_text.text += "is_on_wall "
	if is_on_ceiling(): debug_text.text += "is_on_ceiling "


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	velocity.x = 0
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		velocity.x -= move_speed
		get_node("Sprite2D").set_flip_h(false)
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		velocity.x += move_speed
		get_node("Sprite2D").set_flip_h(true)
	
	# Wall climbing!
	if is_on_wall():
		if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
			velocity.y = -jump_force/2
		elif Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
			velocity.y = jump_force/2
		
	if is_on_floor():
		if Input.is_key_pressed(KEY_SPACE):
			velocity.y = -jump_force
			get_node("Sprite2D").scale.y = 1.2
			get_node("CollisionShape2D").scale.y = 1.2
		
	if Input.is_key_pressed(KEY_SHIFT):
		get_node("Sprite2D").scale.y = 0.8
		get_node("CollisionShape2D").scale.y = 0.8
		jump_force = 150.0
		move_speed = 50.0
	else:
		get_node("Sprite2D").scale.y = 1.0
		get_node("CollisionShape2D").scale.y = 1.0
		jump_force = 200.0
		move_speed = 100.0

	move_and_slide()
	
	if global_position.y > 800:
		game_over()
	
	if Input.is_key_pressed(KEY_ESCAPE):
		game_over()
	
	if Input.is_key_pressed(KEY_SHIFT) and Input.is_key_pressed(KEY_ESCAPE):
		quit_game()


func add_score(amount):
	score += amount
	score_text.text = str("Score: ", score)


func game_over():
	get_tree().reload_current_scene()


func quit_game():
	get_tree().quit()
