extends Sprite

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var ray = $RayCast2D

var speed = 128
var tile_size = 32
var tile_collision = 48

var last_pos = Vector2.ZERO
var target_pos = Vector2.ZERO
var move_dir = Vector2.ZERO

var can_move = true

func _ready():
	position = position.snapped(Vector2(tile_size, tile_size))
	last_pos = position
	target_pos = position
	
	animationTree.active = true

func _process(delta):
	if can_move:
		#Move
		if ray.is_colliding():
			position = last_pos
			target_pos = last_pos
		else:
			position += speed * move_dir * delta
			
			if position.distance_to(last_pos) >= tile_size - speed * delta:
				position = target_pos
		#Idle
		if position == target_pos:
			get_move_dir()
			last_pos = position
			target_pos += move_dir * tile_size

func get_move_dir():
	var DOWN = Input.is_action_pressed("ui_down")
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	
	move_dir.x = -int(LEFT) + int(RIGHT)
	move_dir.y = -int(UP) + int(DOWN)
	
	if move_dir.x != 0 and move_dir.y != 0:
		move_dir = Vector2.ZERO
	
	if move_dir != Vector2.ZERO:
		ray.cast_to = move_dir * tile_collision / 2
		
		animationTree.set("parameters/Idle/blend_position", move_dir)
		animationTree.set("parameters/Walk/blend_position", move_dir)
		animationState.travel("Walk")
	else:
		animationState.travel("Idle")


