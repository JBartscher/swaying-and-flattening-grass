extends Area2D

func _on_Field_body_entered(body):
	$Grown.visible = false
	$Growing.visible = true
	$Growing.frame = 0

func _on_Field_body_exited(body):
	$Growing.play("default")


func _on_Growing_animation_finished():
	$Grown.visible = true
	$Growing.visible = false


func set_shader_offset(offset):
	$Grown.material.set_shader_param("offset", offset)
