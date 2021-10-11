extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var unitDict

var allies = [1]
var alliesUnit = []
var placeholder = preload("res://data/unit/playerUnit.tscn")
var defaultSprite = preload ("res://gfx/unit/mc1/mc2.png")
var pointN = preload ("res://ui/pointer2.png")
var pointT = preload ("res://ui/pointer_target.png")

onready var skillPanel = get_node("Control/Panel/CBPanel")
onready var tsPanel = get_node("Control/Panel/Panel2")

var selectedUnit
var isSelecting = false

var targeting = false

func updateStats ():
	var inc = 0
	for x in alliesUnit:
		var path = "Control/Panel/CBPanel2/G" + str(inc + 1) + "/"
		get_node (path+"RichTextLabel").text = x.get_node ("Data").unitDict.name + " (" + str(x.hp) + "/" + str(x.mhp) + ")"
		get_node (path+"HPBar").value = x.hp
		get_node (path+"MPBar").value = x.mp
		get_node (path+"ATBBar").value = x.atb_val
		if get_node (path+"HPBar").value < 100:
			#get_node (path+"HPBar").texture_progress = load ("res://gfx/unit/hpbar_decrement.png")
			#get_node (path+"HPBar").stretch_margin_left = 5
			pass
		else:
			#get_node (path+"HPBar").texture_progress = load ("res://gfx/unit/hpbar.png")
			#get_node (path+"HPBar").stretch_margin_left = 1
			pass
		inc += 1
		pass

func parseData():
	var file = File.new()
	file.open("res://data/abilities/abilites.cdb", file.READ)
	var text = file.get_as_text()
	var parse = JSON.parse(text)
	unitDict = parse.result
	file.close()	

# Called when the node enters the scene tree for the first time.
func attachdata (instance):
	var obj = load("res://data/unit/"+instance.unitName+"/"+instance.unitName+"_data.tscn").instance()
	var idlePath = load("res://data/unit/"+instance.unitName+"/art/"+instance.unitName+"_idle.tres")
	instance.add_child (obj)
	instance.get_node ("AnimatedSprite").frames = idlePath
	return instance
	pass

func spawnAllies ():
	var incrementer = 0
	for x in range (0,3):
		for y in range (0,3):
			if Master.formation[x][y] != "empty":
				print ("spawning " + Master.formation[x][y])
				incrementer +=1 
				get_node("Control/Panel/CBPanel2/G" + str(incrementer)).visible = true
				var instance = placeholder.instance()
				add_child(instance)
				instance.position.x = 780 + (100*x) + (50*y)
				instance.position.y = 60 + (100*y)
				#instance.get_node("Sprite").texture = defaultSprite
				instance.unitName = Master.formation[x][y]
				instance = attachdata (instance)
				alliesUnit.append(instance)
			
func _ready():
	for x in range (1,5):
		var path = "Control/Panel/CBPanel2/G" + str(x + 1) + "/"
		get_node (path).visible = false
	spawnAllies()
	#parseData()


func _process(delta):
	var buttonhost = get_node ("Control/Panel/buttonhost")
	var selector = get_node("Control/Selector")
	for ally in alliesUnit:
		if ally.selected && !targeting:
			buttonhost.visible = true
			selectedUnit = ally
			isSelecting = true
			selector.visible = true
			selector.position = Vector2(selectedUnit.position.x+16,selectedUnit.position.y-40)
			ally.selected = false
		else:
			if !isSelecting:
				buttonhost.visible = false
			else:
				if Input.is_action_pressed("click"):
					if get_viewport().get_mouse_position().y < 400 && !get_node("Control/Panel/CBPanel").visible && !targeting:
						#isSelecting = false
						#selector.visible = false
						pass
				pass
	if targeting:
		Input.set_custom_mouse_cursor(pointT)
		if Input.is_action_pressed("right_click"):
			targeting = false
			tsPanel.visible = false
			get_node ("Control/Panel/targethelper").visible = false
			get_node ("Control/Panel/buttonhost/").visible=true
	else:
		Input.set_custom_mouse_cursor(pointN)
	updateStats()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
