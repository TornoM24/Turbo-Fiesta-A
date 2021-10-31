extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var ability
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(abi):
	ability = abi
	get_node ("Panel/AbilityName").bbcode_text = ability.name
	get_node ("Panel/Sprite/CostLabel").bbcode_text = "[center]MP [color=#00c8ff]" + str (ability.cost)
	get_node ("Panel/Sprite").texture = load("res://gfx/icons/"+ability.icon+".png")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_DetailButton_pressed():
	var hint = load ("res://ui/ability_hint.tscn").instance()
	hint.generateTip (ability)
	get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().add_child (hint)
	get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().pause_mode = PAUSE_MODE_STOP
	hint.sceneBase = "overworld"
	hint.freePath = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_path()
	hint.global_position = Vector2(-640,-360)
	pass # Replace with function body.
