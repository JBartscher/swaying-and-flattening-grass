extends Node2D

var noise  = OpenSimplexNoise.new()

var FieldPatch = load("res://Field/Field.tscn")
onready var myYSort

func _ready():
	myYSort = get_tree().get_root().find_node("sorter")
	myYSort = get_parent().get_node("sorter")
	randomize()
	fill_region_with_patches(Vector2(-1000,-1000), Vector2(1000, 1000))

func place_patch(x: int, y: int):
	var patch = FieldPatch.instance()
	patch.position = Vector2(x + rand_range(-10.0, 10.0),y+ rand_range(-10.0, 10.0))
	patch.set_shader_offset(rand_range(0.3,1.5))
	myYSort.add_child(patch)

func fill_region_with_patches(from: Vector2, to: Vector2):
	noise.seed = randi()
	noise.period = 3
	noise.octaves = 1
	
	var grid = {}
	for x in range (from.x, to.x,24/2):
		for y in range (from.y, to.y,32/2):
			var rand := 2*(abs(noise.get_noise_2d(x,y)))
		
			if(rand > 0.5):
				place_patch(x,y)
				
#	for x in range (from.x, to.x):
		#if(x % 32 != 0):
		#	continue
#		for y in range (from.y, to.y):
		#	if(y % 10 != 0):
		#		continue
#			var pos = Vector2(x, y)
			
				
