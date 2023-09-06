extends KinematicBody2D

onready var animation_tree = $CosmonautAnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

onready var running_particles : Particles2D = $RunningParticles

var velocity = Vector2.ZERO

export var ACCELERATION = 0.05
export var FRICTION = 0.1
export var MAX_SPEED = 500
export var HARD_STOP_VELOCITY = 1.25

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Activate AnimationTree")
	animation_tree.active = true
	print(animation_state)
	print(animation_tree)
		
	
func get_input():
	var input_direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_accept"):
		animation_tree.play_suit_malfunction()
		return input_direction
		
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_up"):	
		input_direction.x += 1
		input_direction.y -= 1
		animation_tree.play_walk_diagonal_to_the_right()
		return input_direction
		
	if Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_up"):	
		input_direction.x -= 1
		input_direction.y -= 1
		animation_tree.play_walk_diagonal_to_the_left()
		return input_direction
	
	if Input.is_action_pressed("ui_right"):
		input_direction.x += 1
		animation_tree.play_walk_right()
	
	if Input.is_action_pressed("ui_left"):
		input_direction.x -= 1
		animation_tree.play_walk_left()
		
	if Input.is_action_pressed("ui_up"):
		input_direction.y -= 1
		animation_tree.play_walk_up()
		
	if Input.is_action_pressed("ui_down"):
		input_direction.y += 1
		animation_tree.play_walk_down()

	return input_direction
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	var direction = get_input()
	
	if direction.length() > 0:
		velocity = lerp(velocity, direction.normalized() * MAX_SPEED, ACCELERATION) 
	else:
		velocity = lerp(velocity,Vector2.ZERO, FRICTION) 
		
	velocity = move_and_slide(velocity)	
	
	# dust particle emitter
	#if velocity.length() != 0:
	#	running_particles.emitting = true
	#	generate_dust_clouds_in_opposite_direction_of_velocity(velocity)
	#else:
	#	running_particles.emitting = false
		
	
		
func generate_dust_clouds_in_opposite_direction_of_velocity(velocity):
	var particlesMaterial  = running_particles.get_process_material() as ParticlesMaterial
	particlesMaterial.set_direction(Vector3(-1 * velocity.x, -1* velocity.y, 0))	
