extends CharacterBody2D

#var gravity = 900
#var speed = 200
#var angular_speed = PI
#
#func _process(delta):
	#var new_velocity = Vector2.ZERO
#
	##	rotation += angular_speed * delta
	#if Input.is_action_pressed("Right"):
		#new_velocity += Vector2.RIGHT * speed
		#
	#if Input.is_action_pressed("Left"):
		#new_velocity += Vector2.LEFT * speed
#
	#new_velocity += Vector2.DOWN * gravity
	#
	#var collision = move_and_collide(new_velocity * delta)
	#if collision:
		#velocity = new_velocity.slide(collision.get_normal())
		#move_and_slide()
#
		#if Input.is_action_pressed("Jump"):
			#print("Jump")
			#velocity += Vector2.UP * 1000 * delta
			#move_and_collide(velocity)
			
const WALK_FORCE = 600
const WALK_MAX_SPEED = 200
const STOP_FORCE = 1300
const JUMP_SPEED = 400
const GRAVITY = 300

func _physics_process(delta: float) -> void:
	# Horizontal movement code. First, get the player's input.
	var walk := WALK_FORCE * (Input.get_axis(&"Left", &"Right"))
	# Slow down the player if they're not trying to move.
	if abs(walk) < WALK_FORCE * 0.2:
		# The velocity, slowed down a bit, and then reassigned.
		velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
	else:
		velocity.x += walk * delta
	# Clamp to the maximum horizontal movement speed.
	velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)

	# Vertical movement code. Apply gravity.
	velocity.y += GRAVITY * delta

	# Move based on the velocity and snap to the ground.
	# TODO: This information should be set to the CharacterBody properties instead of arguments: snap, Vector2.DOWN, Vector2.UP
	# TODO: Rename velocity to linear_velocity in the rest of the script.
	move_and_slide()

	# Check for jumping. is_on_floor() must be called after movement code.
	if is_on_floor() and Input.is_action_just_pressed(&"Jump"):
		velocity.y = -JUMP_SPEED
