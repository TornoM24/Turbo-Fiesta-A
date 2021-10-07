extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var allies = [1]
var alliesUnit = []
var placeholder = preload("res://data/unit/playerUnit.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	var instance = placeholder.instance()
	add_child(instance)
	instance.position.x = 783
	instance.position.y = 265
	alliesUnit.append(instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
