extends Node

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

var amplitude = 0
var priority = 0
var type = ""

onready var target = get_parent().get_node("namedisplay/HPBar")

func start(type = "rect", tar = self.target, duration = 0.2, frequency = 15, amplitude = 16, priority = 0):
	self.target = tar
	if (priority >= self.priority):
		self.priority = priority
		self.amplitude = amplitude
		self.type = type
		$Duration.wait_time = duration
		$Frequency.wait_time = 1 / float(frequency)
		$Duration.start()
		$Frequency.start()

		_new_shake()

func _new_shake():
	var rand = Vector2()
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)
	if type == "rect":
		$ShakeTween.interpolate_property(target, "rect_position", target.rect_position, target.rect_position+rand, $Frequency.wait_time, TRANS, EASE)
	else:
		$ShakeTween.interpolate_property(target, "offset", null, rand, $Frequency.wait_time, TRANS, EASE)
	$ShakeTween.start()

func _reset():
	if type == "rect":
		$ShakeTween.interpolate_property(target, "rect_position", target.rect_position, target.origin, $Frequency.wait_time, TRANS, EASE)
	else:
		$ShakeTween.interpolate_property(target, "offset", null, Vector2 (0,0), $Frequency.wait_time, TRANS, EASE)
	$ShakeTween.start()

	priority = 0


func _on_Frequency_timeout() -> void:
	_new_shake()


func _on_Duration_timeout() -> void:
	_reset()
	$Frequency.stop()
