extends KinematicBody2D

export (int) var speed = 500

var velocity = Vector2()

func _ready():
	hide()
	speed = 0

func _process(delta):
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	velocity = move_and_slide(velocity)


func _on_Start_pressed():
	show()
	speed = 500
	pass # Replace with function body.
