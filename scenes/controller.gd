extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var unitDict

#var allies = [1]

var placeholder = preload("res://data/unit/playerUnit.tscn")
var defaultSprite = preload ("res://gfx/unit/mc1/mc2.png")
var pointN = preload ("res://ui/pointer2.png")
var pointT = preload ("res://ui/pointer_target.png")

onready var skillPanel = get_node("Control/Panel/CBPanel")
onready var tsPanel = get_node("Control/Panel/Panel2")

var selectedUnit
var selectedTarget
var targetAbility

var isSelecting = false

var alliesUnit = []
var enemyUnit = []

var targeting = false

func logSomething (textToAdd):
	var mlog = get_node ("Control/Panel/CBPanel2/Panel/log")
	mlog.bbcode_enabled = true
	mlog.bbcode_text += textToAdd + ""
	pass

func updateStats ():
	var inc = 0
	for x in alliesUnit:
		var path = "Control/Panel/CBPanel2/G" + str(inc + 1) + "/"
		x.reference.stats = x.stats
		get_node (path+"RichTextLabel").bbcode_enabled = true
		get_node (path+"RichTextLabel").bbcode_text = x.get_node ("Data").unitDict.name + " [color=red]" + str(x.reference.stats.hp) + "[/color]" + " | [color=#00c8ff]" + str(x.reference.stats.mp) + "[/color]"
		#x.reference.stats.hp += 1
		#print ((float(x.reference.stats.hp)/x.reference.stats.mhp)*100)
		get_node (path+"HPBar").value = (float(x.reference.stats.hp)/x.reference.stats.mhp)*100
		get_node (path+"MPBar").value = (float(x.reference.stats.mp)/x.reference.stats.mmp)*100
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
		#x.reference.stats = x.stats
		pass
	for x in enemyUnit:
		x.get_node ("HPBar").value = x.hp
		x.get_node ("ATBBar").value = x.atb_val
		if x.get_node ("HPBar").value < 100:
			pass
		else:
			pass
		#inc += 1
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
	var obj = load("res://data/unit/"+instance.unitName+"/"+instance.unitName+"_data.tscn"	).instance()
	var idlePath = load("res://data/unit/"+instance.unitName+"/art/"+instance.unitName+"_idle.tres")
	instance.add_child (obj)
	instance.get_node ("AnimatedSprite").frames = idlePath
	instance.reference = Master.get_node (instance.unitName+"_data")
	instance.stats = instance.reference.stats
	instance.stats.name = instance.reference.stats.name
	print ("attaching " + instance.reference.name)
	return instance
	pass

func attachdataenemy (instance):
	var obj = load("res://data/unit/enemy/"+instance.unitName+"/"+instance.unitName+"_data.tscn").instance()
	var idlePath = load("res://data/unit/enemy/"+instance.unitName+"/art/"+instance.unitName+".png")
	instance.add_child (obj)
	instance.get_node ("UnitSprite").texture = idlePath
	instance.stats = obj.unitDict.stats
	instance.stats.mhp = obj.unitDict.stats.hp
	instance.stats.name = obj.unitDict.name
	return instance
	pass

func spawnAllies ():
	var incrementer = 0
	for x in range (0,3):
		for y in range (0,3):
			if Master.formation[x][y] != -1:
				print ("spawning " + Master.party[Master.formation[x][y]].name)
				incrementer +=1 
				get_node("Control/Panel/CBPanel2/G" + str(incrementer)).visible = true
				var instance = placeholder.instance()
				add_child(instance)
				instance.position.x = 780 + (100*x) + (50*y)
				instance.position.y = 60 + (100*y)
				#instance.get_node("Sprite").texture = defaultSprite
				instance.unitName = Master.party[Master.formation[x][y]].unitName
				instance = attachdata (instance)
				instance.stats = instance.reference.stats
				print ("a "+str(instance.stats.hp))
				print ("b "+str(instance.stats.mhp))
				alliesUnit.append(instance)
			
var phBD = {
	"formation": [["empty","empty","empty"],["empty","geode","empty"],["empty","empty","empty"]],
	"field": "plains"
}

func _ready():
	for x in range (1,5):
		var path = "Control/Panel/CBPanel2/G" + str(x + 1) + "/"
		get_node (path).visible = false
	spawnAllies()
	init_battle(phBD)
	#parseData()


func init_battle (battleData):
	var incrementer = 0
	for x in range (0,3):
		for y in range (0,3):
			if battleData.formation[x][y] != "empty":
				print ("spawning " + battleData.formation[x][y])
				incrementer +=1 
				#get_node("Control/Panel/CBPanel2/G" + str(incrementer)).visible = true
				var instance = placeholder.instance()
				add_child(instance)
				instance.position.x = 80 + (100*x) - (50*y)
				instance.position.y = 60 + (100*y)
				instance.get_node("HPBar").show()
				instance.get_node("ATBBar").show()
				#instance.get_node("MPBar").show()
				#instance.get_node("Sprite").texture = defaultSprite
				instance.unitName = battleData.formation[x][y]
				instance = attachdataenemy (instance)
				enemyUnit.append(instance)

func causeDamage (target,amount):
	target.stats.hp -= amount
	var label = load ("res://ui/dmglabel.tscn")
	var dmgLabel = label.instance()
	add_child (dmgLabel)
	dmgLabel.global_position = target.global_position
	dmgLabel.get_node("RichTextLabel").bbcode_text = "[color=red][wave amp=50 freq=2]"+str(amount)+"[/wave]"
	logSomething (target.stats.name + " takes " + str (amount) + " damage!\n")

func cancelTargeting ():
	targeting = false
	get_node ("Control/Panel/targethelper").visible = false
	get_node ("Control/Panel/buttonhost/").visible=true
	tsPanel.hide()
	

func _process(delta):
	var buttonhost = get_node ("Control/Panel/buttonhost")
	var selector = get_node("Control/Selector")
	
	for enemy in enemyUnit:
		if enemy.selected:
			if targeting:
				selectedTarget = enemy
				print ("targeting " + enemy.unitName + "!!!")
				enemy.selected = false
				cancelTargeting()
				causeDamage (selectedTarget,selectedUnit.reference.stats.atk)
				selectedUnit.atb_val = 0
				isSelecting = false
				selector.visible = false
			else:
				enemy.selected = false
	for ally in alliesUnit:
		if ally.selected:
			if !targeting:
				if !ally.atb_val < 100:
					buttonhost.visible = true
					selectedUnit = ally
					isSelecting = true
					selector.visible = true
					selector.position = Vector2(selectedUnit.position.x+16,selectedUnit.position.y-40)
				else:
					get_node("Control/Panel/readyhelper").modulate.a = 1
				ally.selected = false
			else:
				selectedTarget = ally
				print ("targeting " + ally.unitName + "!!!")
				ally.selected = false
				cancelTargeting()
				causeDamage (selectedTarget,selectedUnit.reference.stats.atk)
				selectedUnit.atb_val = 0
				isSelecting = false
				selector.visible = false
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
