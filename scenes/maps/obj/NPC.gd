extends AnimatedSprite


var is_player_inside = false
var type = "npc"
var dialogType = "flavor"
var npcName = "Derp, Lord of Shadows"
var dialog = ["The spirits awaken from their slumber.", "Also, you smell like frog dookie."]

func _ready():
	pass

func talk ():
	if dialogType == "flavor":
		DialogManager.queue_dialog (self, "overworld", npcName, dialog)

func _on_ContainerHitbox_area_entered(area):
	print ("npc detected area entered.")
	pass # Replace with function body.
