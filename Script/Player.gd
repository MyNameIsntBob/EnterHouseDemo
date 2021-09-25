extends KinematicBody2D

var acceleration: = 150
var max_speed := 85
var friction := 0.5

const num_of_directions = 4
var velocity := Vector2(0, 0)

var house = null setget set_house

func set_house(new_house):
	if new_house != null:
		$Prompt.play("KeyPrompt")
		$KeyPrompt.show()
	else:
		$Prompt.stop()
		$KeyPrompt.hide()

	house = new_house

func _ready():
	set_house(null)

func _unhandled_input(event):
	if event is InputEventKey and event.is_action_pressed("interact") and house != null:
		Global.player_outside_pos = global_position
		house.enter()

func _physics_process(delta):
	var mouse = get_viewport().get_mouse_position()
	
	var input_vector = Vector2(0, 0)
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity += input_vector * acceleration * delta
		velocity = velocity.clamped(max_speed)
	else:
		velocity = velocity.linear_interpolate(Vector2.ZERO, friction)
	
	velocity = move_and_slide(velocity)
	
	if input_vector != Vector2.ZERO:
		if $AnimationPlayer.get_current_animation() != "Walking":
			$AnimationPlayer.stop()
			$AnimationPlayer.play("Walking")
	else:
		if $AnimationPlayer.get_current_animation() != "Idle":
			$AnimationPlayer.stop()
			$AnimationPlayer.play("Idle")
			
	var direction = -int(input_vector.normalized().angle() * 
		((num_of_directions / 2)/PI)) + int(num_of_directions / 4)
	
	direction = fposmod(direction, num_of_directions)
	
	if input_vector != Vector2.ZERO:
		$Sprite.frame_coords.y = direction
