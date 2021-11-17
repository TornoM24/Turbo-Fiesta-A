extends Navigation2D

export (int) var speed = 250

var path = []
var walk_distance = 0
var enemyPos 
onready var character = $Enemy

func _process(delta):
	var walk_distance = speed * delta
	_update_navigation_path(character.position, Master.partyPosition)
	move_along_path(walk_distance)
	


func move_along_path(distance):
	var last_point = character.position	
	while path.size():
		var distance_between_points = last_point.distance_to(path[0])
		# The position to move to falls between two points.
		if distance <= distance_between_points:
			character.position = last_point.linear_interpolate(path[0], distance / distance_between_points)
			return
		# The position is past the end of the segment.
		distance -= distance_between_points
		last_point = path[0]
		path.remove(0)
	# The character reached the end of the path.
	character.position = last_point
	set_process(false)

func _on_Detection_area_entered(area):
	pass # Replace with function body.

func _update_navigation_path(start_position, end_position):
	path = get_simple_path(start_position, end_position, true)
	path.remove(0)
	set_process(true)

func _on_Collision_body_entered(body):
	pass # Replace with function body.


