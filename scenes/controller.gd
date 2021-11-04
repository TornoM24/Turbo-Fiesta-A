extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var unitDict
var rng = RandomNumberGenerator.new()

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
const BAR_SPEED = 0.1
func updateStats (delta):
	var inc = 0
	for x in alliesUnit:
		var path = "Control/Panel/CBPanel2/G" + str(inc + 1) + "/"
		x.reference.stats = x.stats
		get_node (path+"RichTextLabel").bbcode_enabled = true
		get_node (path+"RichTextLabel").bbcode_text = x.get_node ("Data").unitDict.name
		get_node (path+"HPLabel").bbcode_text = "[right][color=#ffeeb8]" + str (x.stats.hp)
		get_node (path+"MPLabel").bbcode_text = "[right][color=#edfffa]" + str (x.stats.mp)
		if x.atb_val >= 100:
			get_node (path+"ATBLabel").bbcode_text = "[right]100%"
		else:
			get_node (path+"ATBLabel").bbcode_text = "[right]" + str (int(x.atb_val)) + "%"
		#x.reference.stats.hp += 1
		#print (x.unitName + " " + str(int((float(x.reference.stats.hp)/x.reference.stats.mhp)*100)))
		#print (x.unitName + str(int((float(x.reference.stats.hp)/x.reference.stats.mhp)*100))+ "/" + str(get_node (path+"HPBar").value))
		get_node (path+"HPBar").targetValue = int((float(x.stats.hp)/x.stats.mhp)*100)
		get_node (path+"MPBar").targetValue = int((float(x.stats.mp)/x.stats.mmp)*100)
		if get_node (path+"HPBar").targetValue < get_node (path+"HPBar").value:
			#print ("reducing value")
			get_node (path+"HPBar").value -= delta * 50
		elif get_node (path+"HPBar").targetValue > get_node (path+"HPBar").value:
			#print ("increasing value")
			get_node (path+"HPBar").value += delta * 50
			
		if get_node (path+"MPBar").targetValue < get_node (path+"MPBar").value:
			#print ("reducing value")
			get_node (path+"MPBar").value -= delta * 50
		elif get_node (path+"MPBar").targetValue > get_node (path+"MPBar").value:
			#print ("increasing value")
			get_node (path+"MPBar").value += delta * 50
			
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
	var attackPath = load("res://data/unit/"+instance.unitName+"/art/"+instance.unitName+"_attack.tres")
	instance.add_child (obj)
	instance.get_node ("AnimatedSprite").frames = idlePath
	instance.get_node ("Attack").frames = attackPath
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
	instance.abilities = obj.unitDict.abilities
	instance.stats.name = obj.unitDict.name
	return instance
	pass
var abilityPanels = []
func hide_all():
	for x in abilityPanels:
		print ("hiding")
		x.hide()
	
func show_all():
	for x in abilityPanels:
		print ("showing")
		x.show()
		
func spawnAllies ():
	var incrementer = 0
	for x in range (0,3):
		for y in range (0,3):
			#print (Master.formation [x].len)
			if Master.formation[x][y] != -1:
				print ("spawning " + Master.party[Master.formation[x][y]].name)
				incrementer +=1 
				get_node("Control/Panel/CBPanel2/G" + str(incrementer)).visible = true
				var instance = placeholder.instance()
				
				add_child(instance)
				instance.position.x = 680 + (100*x) + (50*y)
				instance.position.y = 60 + (100*y)
				instance.origin = instance.position
				#instance.get_node("Sprite").texture = defaultSprite
				instance.unitName = Master.party[Master.formation[x][y]].unitName
				instance = attachdata (instance)
				instance.stats = instance.reference.stats
				print ("a "+str(instance.stats.hp))
				print ("b "+str(instance.stats.mhp))
				alliesUnit.append(instance)
				var aPanel = load ("res://ui/combat_abilities.tscn").instance()
				add_child (aPanel)
				aPanel.init (instance)
				abilityPanels.append (aPanel)
				aPanel.position.x += 256 * (incrementer-1)
			
var phBD = {
	"formation": [["geode","geode","geode"],["geode","geode","geode"],["geode","geode","geode"]],
	"field": "plains"
}

func _ready():
	rng.randomize()
	get_node ("Control/oc/occluder").hide()
	get_node ("Control/oc/occluder").modulate.a = 0
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
				instance.position.x = 140 + (100*x) - (50*y)
				instance.position.y = 60 + (100*y)
				instance.get_node("HPBar").show()
				instance.get_node("ATBBar").show()
				#instance.get_node("MPBar").show()
				#instance.get_node("Sprite").texture = defaultSprite
				instance.unitName = battleData.formation[x][y]
				instance = attachdataenemy (instance)
				enemyUnit.append(instance)
func getPower (block,source):
	var inc = 0
	var fPower = 0
	for x in block.scaling:
		inc += 1
	for x in block.scaling:
		fPower += source.stats[x]/inc
		fPower = ceil(float(fPower * block.power/100))
	return fPower
	
func create_label (amount, pos):
	var dmgLabel = label.instance()
	add_child (dmgLabel)
	dmgLabel.global_position = pos
	dmgLabel.offset()
	dmgLabel.get_node("RichTextLabel").bbcode_text = "[center]"+str(amount)
	dmgLabel.modulate.r = 2
var label = preload ("res://ui/dmglabel.tscn")
func causeEffect (target,source,ability):
	var fPower = 0
	var eff = ability.effects
	#print ("mp first " + str(source.mp))
	source.stats.mp -= ability.cost
	#print ("mp after " + str(source.mp))
	for block in eff:
		if block.type == "damage":
			fPower = getPower (block,source)
			if block.target == "single":
				
				target.stats.hp -= fPower
				if target.stats.hp > target.stats.mhp:
					target.stats.hp = target.stats.mhp
				create_label (fPower,target.global_position + Vector2(0,10))
				logSomething (target.stats.name + " takes [color=red]" + str (fPower) + "[/color] damage!\n")
			if block.target == "self":
				var dmgLabel = label.instance()
				var power = block.power
				source.stats.hp -= power
				if source.stats.hp > source.stats.mhp:
					source.stats.hp = source.stats.mhp
				add_child (dmgLabel)
				dmgLabel.global_position = source.global_position + Vector2 (0, -10)
				dmgLabel.get_node("RichTextLabel").bbcode_text = "[center]"+str(power)
				dmgLabel.modulate.r = 2
				logSomething (source.stats.name + " takes [color=red]" + str (power) + "[/color] damage!\n")
			if block.target == "all enemies":
				for x in enemyUnit:
					var dmgLabel = label.instance()
					var power = fPower
					x.stats.hp -= power
					add_child (dmgLabel)
					dmgLabel.global_position = x.global_position + Vector2 (0, -10)
					dmgLabel.get_node("RichTextLabel").bbcode_text = "[center]"+str(power)
					dmgLabel.modulate.r = 2
					logSomething (x.stats.name + " takes [color=red]" + str (power) + "[/color] damage!\n")
		if block.type == "healing":
			fPower = getPower (block,source)
			if block.target == "single":
				var dmgLabel = label.instance()
				target.stats.hp += fPower
				if target.stats.hp > target.stats.mhp:
					target.stats.hp = target.stats.mhp
				add_child (dmgLabel)
				dmgLabel.global_position = target.global_position+ Vector2 (0, -10)
				dmgLabel.get_node("RichTextLabel").bbcode_text = "[center]"+str(fPower)
				dmgLabel.modulate.g = 2
				logSomething (target.stats.name + " heals for [color=green]" + str (fPower) + "[/color] hp!\n")
			if block.target == "all allies":
				for x in alliesUnit:
					var dmgLabel = label.instance()
					x.stats.hp += fPower
					if x.stats.hp > x.stats.mhp:
						x.stats.hp = x.stats.mhp
					add_child (dmgLabel)
					dmgLabel.global_position = x.global_position+ Vector2 (0, -10)
					dmgLabel.get_node("RichTextLabel").bbcode_text = "[center]"+str(fPower)
					dmgLabel.modulate.g = 2
				logSomething ("All allies heal for [color=green]" + str (fPower) + "[/color] hp!\n")

func cancel_targeting ():
	show_all()
	targeting = false
	get_node ("Control/Panel/targethelper").visible = false
	get_node ("Control/Panel/buttonhost/").visible=true
	for x in get_node ("Control/Panel/CBPanel/specialscroll/Panel").get_children():
		x.queue_free()
	tsPanel.hide()
	
var phEff = [
	{
		"type": "healing",
		"target": "single",
		"elements": ["physical"],
		"power": 10,
		"acc": 100,
	}
]
var animTimer = 0
func _process(delta):
	var buttonhost = get_node ("Control/Panel/buttonhost")
	var selector = get_node("Control/Selector")
	var deads = 0
	var wins = 0
	for ally in alliesUnit:
		if ally.alive == false:
			ally.stats.hp = 0
			deads += 1
			ally.inDead = true
	
	for enemy in enemyUnit:
		if enemy.alive == false:
			enemy.stats.hp = 0
			enemy.enemyDie()
		if enemy.deathAnimFinished:	
			wins+=1
	

		
	
			
	if deads == alliesUnit.size():
		get_node ("Control/oc/occluder").show()
		#yield(get_tree().create_timer(0.1), "timeout")
		get_node ("Control/oc/occluder").modulate.a += delta
		#print (str(get_node ("Control/oc/occluder").modulate.a))
		if get_node ("Control/oc/occluder").modulate.a > 1:
			get_node("/root/Global").goto_scene("res://scenes/gameover.tscn")
	else:	
		if wins == enemyUnit.size():
			var z = get_node ("Control/oc/occluder")
			z.show()
			animTimer += delta
			if z.modulate.a < 0.5:
				if animTimer > 0.01:
					print (str(z.modulate.a))
					z.modulate.a += 0.01
					animTimer = 0
			if z.modulate.a >= 0.5:
				var vScn = load("res://scenes/VictoryScreen.tscn").instance()
				add_child (vScn)
		else:
			animTimer = 0
		for enemy in enemyUnit:
			if enemy.alive:
				if enemy.selected:
					if targeting:
						selectedTarget = enemy
						print ("targeting " + enemy.unitName + "!!!")
						enemy.selected = false
						cancel_targeting()
						logSomething (selectedUnit.stats.name + " uses " + targetAbility.name + "!\n")
						selectedUnit.sprite_attack (targetAbility, selectedTarget)
						#causeEffect (selectedTarget,targetAbility)
						selectedUnit.atb_val = 0
						isSelecting = false
						selector.visible = false
					else:
						enemy.selected = false
				if enemy.atb_val > 99:
					var ch = rng.randf_range (0,enemy.abilities.size())
					var tar = rng.randf_range (0, alliesUnit.size()) 
					while alliesUnit[tar].stats.hp <= 0:
						tar = rng.randf_range (0, alliesUnit.size())
					logSomething (enemy.stats.name + " uses " + enemy.abilities[ch].name + "!\n")
					#enemy.sprite_attack (enemy.abilities[ch],alliesUnit[tar])
					enemy.glow_cast (enemy.abilities[ch],alliesUnit[tar])
					enemy.atb_val = 0

		for ally in alliesUnit:
			if ally.selected && ally.alive:
				if !targeting:
					if !ally.atb_val < 100:
						if !skillPanel.visible:
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
					cancel_targeting()
					selectedUnit.sprite_attack (targetAbility, selectedTarget)
					#causeEffect (selectedTarget,targetAbility)
					selectedUnit.atb_val = 0
					
					isSelecting = false
					selector.visible = false
			else:
				if !isSelecting:
					buttonhost.visible = false
					get_node ("Control/Panel").self_modulate.a = 0
					get_node ("Control/Panel/namedisplay").modulate.a = 0
				else:
					get_node ("Control/Panel").self_modulate.a = 1
					get_node ("Control/Panel/namedisplay").modulate.a = 1
					get_node ("Control/Panel/namedisplay/RichTextLabel").bbcode_text = "[center]" + selectedUnit.stats.name
					if Input.is_action_pressed("click"):
						if get_viewport().get_mouse_position().y < 400 && !get_node("Control/Panel/CBPanel").visible && !targeting:
							#isSelecting = false
							#selector.visible = false
							pass
					pass
		if targeting:
			Input.set_custom_mouse_cursor(pointT)
			if Input.is_action_pressed("right_click"):
				cancel_targeting()
		else:
			Input.set_custom_mouse_cursor(pointN)
	updateStats(delta)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
