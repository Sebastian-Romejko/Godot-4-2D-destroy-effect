extends Node2D

@export var collide = false
@export var force = 5000
@export var timeout = 5
@export var gravity = 0.7
@export var scale_modifier = 0.0
@export var width_limit = 8.0
@export var height_limit = 5.0

const FRAGMENT_PATH = "res://object_fragment.tscn"

var exploded = false
var fragments = []
var frames = 0
var timer = 0
var obj_height
var obj_width
var obj_animations_frames_h
var obj_animations_frames_v
			
func _ready():
	init()
	set_to_default()
				
func _process(delta):
	if exploded:
		for fragment in fragments:
			if scale_modifier != 0:
				fragment.set_scale(Vector2(max(1, scale_modifier * timer), max(1, scale_modifier * timer)))

		timer += delta
		if timer > timeout:
			clear()
			init()
			set_to_default()
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
	frames = obj_animations_frames_h * obj_animations_frames_v
	obj_fragment_temp.queue_free()

	for n in range(frames):
		var rigid_body = RigidBody2D.new()
		add_child(rigid_body)
		rigid_body.freeze = true
		rigid_body.gravity_scale = gravity
		
		var sprite = objNode.instantiate() as Sprite2D
		rigid_body.add_child(sprite)
		sprite.set_frame(n)

		var collision_shape = CollisionShape2D.new()
		rigid_body.add_child(collision_shape)
		collision_shape.shape = RectangleShape2D.new()
		collision_shape.shape.size = Vector2(obj_width/obj_animations_frames_h, obj_height/obj_animations_frames_v)
		if !collide:
			collision_shape.disabled = true
		
		fragments.append(rigid_body)

func set_to_default():
	var frame = 0
	for x in range(obj_animations_frames_v):
		for y in range(obj_animations_frames_h):
			fragments[frame].set_position(Vector2(y*(obj_width/obj_animations_frames_h), x*(obj_height/obj_animations_frames_v)))
			fragments[frame].set_rotation(0)
			frame += 1

func explode():
	for fragment in fragments:
		fragment.freeze = false
		var force_to_apply = Vector2(randf_range(-width_limit, width_limit), randf()*(-height_limit)-10) * force
		
		fragment.apply_force(force_to_apply)

		#fragments.apply_torque_impulse(randf_range(-1, -5))
		
		fragment.set_inertia(1)
		if force_to_apply.x < 0:
			fragment.apply_torque_impulse(randf_range(-1, -5))
		if force_to_apply.x > 0:
			fragment.apply_torque_impulse(randf_range(1, 5))
		fragment.set_inertia(0)

	exploded = true

func clear():
	for n in range(frames):
		remove_child(fragments[n])
			
	fragments.clear()
