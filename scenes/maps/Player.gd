extends KinematicBody2D

export (int) var speed = 200
const MOVE_SPEED = 1

var velocity = Vector2()
var stamina = 100
var containerContact = false
var currentObject
var type = "player"
signal inBounds

onready var down=get_node ("Down")
onready var side=get_node ("Side")
onready var up=get_node ("Up")


func _ready():
	Global.player = self
	position = Master.partyPosition
	speed = 200
	side.hide()
	up.hide()
	get_node ("Area2D").rotation_degrees = 180

func hideAllBut (x):
	down.hide()
	side.hide()
	up.hide()
	x.show()
	

func _process(delta):
	get_node ("Camera2D/Control/stamina").value = stamina
	if Input.is_action_pressed("shift"):
		if stamina > 0:
			if velocity != Vector2(0,0):
				speed = 5000
				get_node ("smoke").emitting = true
				stamina -= 0.01
	else:
		if stamina < 100:
			speed = 200
			if velocity != Vector2(0,0):
				get_node ("smoke").emitting = false
			stamina += 0.02
	if stamina <= 0:
		speed = 200
	if stamina <= 0:
		get_node ("smoke").emitting = false
		speed = 200
	velocity = Vector2()
	if !DialogManager.playerStun:
		if Input.is_action_pressed("right"):
			velocity.x += 1
			hideAllBut(side)
			side.flip_h = true
			side.playing = true
			side.speed_scale = 1
			ray.rotation_degrees = 270
			
		if Input.is_action_pressed("left"):
			velocity.x -= 1
			hideAllBut(side)
			side.flip_h = false
			side.playing = true
			side.speed_scale = 1
			ray.rotation_degrees = 90

		if Input.is_action_pressed("down"):
			velocity.y += 1
			hideAllBut(down)
			down.playing = true
			down.speed_scale = 1
			ray.rotation_degrees = 0

		if Input.is_action_pressed("up"):
			velocity.y -= 1
			hideAllBut(up)
			up.playing = true
			up.speed_scale = 1
			ray.rotation_degrees = 180
		
			
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


#func _on_Area2D_area_entered(area):
#	if (area.get_parent().type == "container" or area.get_parent().type == "npc"):
#		containerContact = true
#	currentObject = area.get_parent()
#
#
#func _on_Area2D_area_exited(area):
#	if (area.get_parent().type == "container" or area.get_parent().type == "npc"):
#		containerContact = false
#	currentObject = null
#	pass # Replace with function body.
onready var ray = get_node ("InteractRayCast")
func _input(ev):
	if !DialogManager.playerStun:
		if ev is InputEventKey and ev.is_action_pressed("interact") and not ev.is_echo():
			print ("attempting to check for interactable item")
			if ray.trueColliding:
				currentObject = ray.currentObj
				if currentObject.type == "npc":
					print ("talmking")
					currentObject.talk()
				elif currentObject.type == "container" or currentObject.name == "Chest":
					currentObject.open_container()
			
	pass




func _on_ContactRadius_area_entered(area):
	# Unsure how to call function for enemy
	if (area.get_parent().type == "enemy"):
		if area.name == "Area2D2":
			emit_signal("inBounds", true, area.get_parent())
		if area.name == "Area2D":
			print ("made contact with enemy")
			get_node("/root/Global").goto_scene("res://scenes/combat.tscn")
	pass # Replace with function body.


func _on_ContactRadius_area_exited(area):
	if (area.get_parent().type == "enemy"):
		emit_signal("inBounds", false, area.get_parent())
	pass # Replace with function body.
