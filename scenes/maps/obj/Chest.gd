extends AnimatedSprite


var is_player_inside = false
var is_opened = false
var contents = null
var type = "container"

func open_container ():
	frame = 1
	get_node ("Sprite").texture = load ("res://gfx/tileset/obj/chest1_open.png")
	if contents == null:
		DialogManager.queue_dialog (self, "overworld", "", ["Looks like there's nothing inside."])
	else:
		var itemFlavor = ["There are some items inside!"]
		for i in contents:
			itemFlavor.append(i)
		DialogManager.queue_dialog (self, "overworld", "", itemFlavor)
	pass
	is_opened = true

func _ready():
	contents = LootTable.drop()
	pass

func close():
	get_node ("Sprite").texture = load ("res://gfx/tileset/obj/chest1_open.png")

func _on_ContainerHitbox_area_entered(area):
	if area.get_parent().name == "Player":
		modulate = Color (1.2,1.2,1.9,1)
		get_node ("Sprite").show()
	pass # Replace with function body.



func _on_ContainerHitbox_area_exited(area):
	if area.get_parent().name == "Player":
		modulate = Color (1,1,1,1)
		get_node ("Sprite").hide()
	pass # Replace with function body.
