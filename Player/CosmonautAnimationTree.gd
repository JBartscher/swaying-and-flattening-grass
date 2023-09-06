extends AnimationTree

onready var animation_state = self.get("parameters/playback")
var walk_sprite : Sprite
var idle_sprite : Sprite
var slide_sprite : Sprite
var malfunction_sprite : Sprite


func _ready():
	self.active = true
	animation_state = self.get("parameters/playback")
	var parent = get_parent()
	walk_sprite = parent.get_node("Sprites/Walking")


func play_suit_malfunction():
	malfunction_sprite.visible = true
	walk_sprite.visible = false
	idle_sprite.visible = false
	slide_sprite.visible = false
	animation_state.travel("suit_malfunction")

func play_idle():
	idle_sprite.visible = true
	malfunction_sprite.visible = false
	walk_sprite.visible = false
	slide_sprite.visible = false
	animation_state.travel("idle")
	
func __toggle_visibilty_for_walk_animation():
	walk_sprite.visible = true
	
func play_walk_right():
	__toggle_visibilty_for_walk_animation()
	walk_sprite.scale.x = 2
	animation_state.travel("run_sideways(r)")
	
func play_walk_left():
	__toggle_visibilty_for_walk_animation()
	walk_sprite.scale.x = -2		
	animation_state.travel("run_sideways(l)")	

func play_walk_up():
	__toggle_visibilty_for_walk_animation()
	animation_state.travel("run_up")
	
func play_walk_down():
	__toggle_visibilty_for_walk_animation()
	animation_state.travel("run_down")
	
func play_walk_diagonal_to_the_right():
	__toggle_visibilty_for_walk_animation()
	walk_sprite.scale.x = 2
	animation_state.travel("run_diagonaly(tr)")
	
func play_walk_diagonal_to_the_left():
	__toggle_visibilty_for_walk_animation()
	walk_sprite.scale.x = -2
	animation_state.travel("run_diagonaly(tr)")
	
func play_slide_right():
	slide_sprite.visible = true
	walk_sprite.visible = false
	malfunction_sprite.visible = false	
	idle_sprite.visible = false
	slide_sprite.scale.x = 2
	animation_state.travel("slide_sideways")	

func play_slide_left():
	slide_sprite.visible = true
	walk_sprite.visible = false
	malfunction_sprite.visible = false	
	idle_sprite.visible = false
	slide_sprite.scale.x = -2
	animation_state.travel("slide_sideways")		
