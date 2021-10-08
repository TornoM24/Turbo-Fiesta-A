extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var allies = [1]
var alliesUnit = []
var placeholder = preload("res://data/unit/playerUnit.tscn")
var defaultSprite = preload ("res://gfx/unit/mc1/mc2.png")

var selectedUnit
var isSelecting = false
# Called when the node enters the scene tree for the first time.
func _ready():
	var instance = placeholder.instance()
	add_child(instance)
	instance.position.x = 783
	instance.position.y = 265
	instance.get_node("Sprite").texture = defaultSprite
	alliesUnit.append(instance)

func _process(delta):
	var buttonhost = get_node ("Control/Panel/buttonhost")
	var selector = get_node("Control/Selector")
	for ally in alliesUnit:
		if ally.selected:
			buttonhost.visible = true
			selectedUnit = ally
			isSelecting = true
			selector.visible = true
			selector.position = Vector2(selectedUnit.position.x+16,selectedUnit.position.y-20)
			ally.selected = false
		else:
			if !isSelecting:
				buttonhost.visible = false
			else:
				if Input.is_action_pressed("click"):
					if get_viewport().get_mouse_position().y < 400 && !get_node("Control/Panel/CBPanel").visible:
						isSelecting = false
						selector.visible = false
				pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
