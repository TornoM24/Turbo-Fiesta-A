extends AnimatedSprite


export (int) var speed = 250

var chasing = true
var path = []


func _process( delta ):
	var walk_distance = speed * delta
	_on_detection_area_entered(walk_distance)


func _unhandled_input(event):
	_update_navigation_path(get_node("Enemy").rect_position, self.position

func _on_detection_area_exited(area):
	pass


func _on_detection_area_entered(distance):
	var playerPos = self.position
	while path.size() and chasing:
		var distance_between_points = playerPos.distance_to(path[0])
		# The position to move to falls between two points.
		if distance <= distance_between_points:
			self.position = playerPos.linear_interpolate(path[0], distance / distance_between_points)
			return
		# The position is past the end of the segment.
		distance -= distance_between_points
		playerPos = path[0]
		path.remove(0)
		print ("working")
	# The character reached the end of the path.
	self.position = playerPos
	chasing = false
	set_process(false)

func _update_navigation_path(start_position, end_position):
	# get_simple_path is part of the Navigation2D class.
	# It returns a PoolVector2Array of points that lead you
	# from the start_position to the end_position.
	path = get_simple_path(start_position, end_position, true)
	# The first point is always the start_position.
	# We don't need it in this example as it corresponds to the character's position.
	path.remove(0)
	set_process(true)
