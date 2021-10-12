extends KinematicBody2D

export (int) var speed = 200
const MOVE_SPEED = 1

var velocity = Vector2()

onready var down=get_node ("Down")
onready var side=get_node ("Side")
onready var up=get_node ("Up")

func _ready():
	position = Master.partyPosition
	speed = 200
	side.hide()
	up.hide()

func hideAllBut (x):
	down.hide()
	side.hide()
	up.hide()
	x.show()
	

func _process(delta):
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
		hideAllBut(side)
		side.flip_h = true
		side.playing = true
		side.speed_scale = 1

	if Input.is_action_pressed("left"):
		velocity.x -= 1
		hideAllBut(side)
		side.flip_h = false
		side.playing = true
		side.speed_scale = 1

	if Input.is_action_pressed("down"):
		velocity.y += 1
		hideAllBut(down)
		down.playing = true
		down.speed_scale = 1

	if Input.is_action_pressed("up"):
		velocity.y -= 1
		hideAllBut(up)
		up.speed_scale = 1
	
		
	if (!Input.is_action_pressed("up") && !Input.is_action_pressed("down") && !Input.is_action_pressed("left") && !Input.is_action_pressed("right")):
		down.speed_scale = 0.25
		up.speed_scale = 0.25
		side.speed_scale = 0.25

	velocity = velocity.normalized() * speed
	velocity = move_and_slide(velocity)
	Master.partyPosition = global_position

func _on_Start_pressed():
	show()
	pass # Replace with function body.
