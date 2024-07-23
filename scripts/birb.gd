extends CharacterBody2D


const JUMP_VELOCITY = -150.0
const SMALL_GRAVITY = 300.0
const GRAVITY = 600.00
@onready var ani_sprite = $AniSprite


func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		# Rotate the Birb
		ani_sprite.rotation = y_velo_to_rot( velocity.y )
		
		if velocity.y < 0:
			velocity.y += GRAVITY * delta
		else:
			velocity.y += SMALL_GRAVITY * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY
		

	move_and_slide()

func y_velo_to_rot( y_velo : float ) -> float:
	# Result := ((Input - InputLow) / (InputHigh - InputLow)) * (OutputHigh - OutputLow) + OutputLow;
	# Range for velocity -250 to 250, Range for rotation -30 to 30
	
	return ((clamp( y_velo, -200, 200 ) + 200) / 400) * ((PI/2)) + (-PI/4);
