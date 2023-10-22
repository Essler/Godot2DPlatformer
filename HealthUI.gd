extends Control


var hearts = 3 : set = set_hearts, get = get_hearts
var max_hearts = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)

func get_hearts():
	return hearts
	
func set_max_hearts(value):
	max_hearts = max(value, 1)

func get_max_hearts():
	return max_hearts
