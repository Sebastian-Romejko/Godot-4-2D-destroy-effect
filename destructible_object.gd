extends Node2D

@export var timeout = 100
@export var gravity = 0.7
@export var scale_modifier = 0.0
@export var width_limit = 8.0
@export var height_limit = 5.0

const FRAGMENT_PATH = "res://object_fragment.tscn"

var exploded = false
var fragments = []
var drops = []
var frames_number = 0
var timer = 0
var obj_height
var obj_width
var obj_animations_frames_h
var obj_animations_frames_v

class Fragmentation:
	var old
	var new
	
	func _init(arg1, arg2):
		old = Vector2(arg1, arg2)
		new = old
		
	func integrate():
		var velocity = velocity()
		old = new
		new += velocity
		
	func velocity():
		return new - old
		
	func move(offset_x, offset_y):
		new += Vector2(offset_x, offset_y)
		
	func get_position():
		return new
			
func _ready():
	init()
	set_to_default()
	set_process_input(true);
	set_process(true)
				
func _process(delta):
	if exploded:
		for i in range(drops.size()):
			drops[i].move(0, gravity)
			drops[i].integrate()
			fragments[i].set_position(Vector2(drops[i].get_position().x, drops[i].get_position().y))
			fragments[i].set_scale(Vector2(max(1, scale_modifier * timer), max(1, scale_modifier * timer)))

			if fragments[i].position.x < 0:
				fragments[i].rotate(randf_range(-0.01, -0.03))
			if fragments[i].position.x > 0:
				fragments[i].rotate(randf_range(0.01, 0.3))
				
		timer += 1
			
		if timer > timeout:
			drops.clear()
			clear()
			timer = 0
			exploded = false
			
func _input(event):
	if Input.is_key_pressed(KEY_SPACE):
		explode()
	
func init():
	var objNode: PackedScene = load(FRAGMENT_PATH)
	var obj_fragment_temp = objNode.instantiate() as Sprite2D;
	obj_height = obj_fragment_temp.texture.get_size().y
	obj_width = obj_fragment_temp.texture.get_size().x
	obj_animations_frames_h = obj_fragment_temp.hframes
	obj_animations_frames_v = obj_fragment_temp.vframes
	frames_number = obj_animations_frames_h * obj_animations_frames_v
	obj_fragment_temp.queue_free()

	for n in range (frames_number):
		fragments.append(objNode.instantiate() as Sprite2D)
		fragments[n].set_frame(n)
		add_child(fragments[n])

func set_to_default():
	var frame = 0
	for x in range(obj_animations_frames_v):
		for y in range(obj_animations_frames_h):
			fragments[frame].set_position(Vector2(y*(obj_width/obj_animations_frames_h), x*(obj_height/obj_animations_frames_v)))
			fragments[frame].set_scale(Vector2(1, 1))
			fragments[frame].set_rotation(0)
			frame += 1

func explode():
	if drops.size() < fragments.size():
		for j in range (fragments.size()):
			var drop = Fragmentation.new(fragments[j].position.x, fragments[j].position.y)
			drop.move(randf_range(-width_limit, width_limit), randf()*(-height_limit)-10)
			drops.push_front(drop)
	
	exploded = true
    


func clear():
	for n in range(frames_number):
		remove_child(fragments[n])
			
	fragments.clear()