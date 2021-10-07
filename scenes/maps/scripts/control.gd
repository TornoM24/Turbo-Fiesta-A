extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const SPEED = 500

onready var skillPanel = get_node("Panel/CBPanel")
onready var tsPanel = get_node("Panel/Panel2")

onready var attackButton = get_node("Panel/attack")
onready var defendButton = get_node("Panel/defend")
onready var specialButton = get_node("Panel/special")
onready var itemButton = get_node("Panel/item")

var sPanelX = 0
var sPanelY = 212

var gTimer = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	
	if skillPanel.visible:
		gTimer += delta
		if gTimer >= 0.01:
			if sPanelX <500:
				sPanelX += SPEED
				#skillPanel.rect_position.x = rect_position.x - (135)/(sPanelX/500)
			#if sPanelY <212:
				#sPanelY += 1
				gTimer = 0
		skillPanel.rect_size = Vector2 (sPanelX,sPanelY)
	else:
		sPanelX = 0
		skillPanel.rect_position.x = 135
		#sPanelY = 0		
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_attack_toggled(button_pressed):
	pass # Replace with function body.

func _on_exit_pressed():
	var skillPanel = get_node("Panel/CBPanel")
	var tsPanel = get_node("Panel/Panel2")
	skillPanel.visible = false
	tsPanel.visible = false
	pass # Replace with function body.

func _on_special_pressed():
	skillPanel.visible = !skillPanel.visible
	tsPanel.visible = !tsPanel.visible


func _on_defend_pressed():
	pass # Replace with function body.


func _on_item_pressed():
	pass # Replace with function body.
