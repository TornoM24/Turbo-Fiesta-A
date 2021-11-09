extends AnimatedSprite


var is_player_inside = false
var is_opened = false

func open_container():
	print(LootTable._init())
	print ("Working")
	pass

func _ready():
	print(LootTable._init())
	pass


func _on_ContainerHitbox_area_entered(area):
	print ("container detected area entered.")
	pass # Replace with function body.
