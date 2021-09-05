extends Node

var screen = OS.get_real_window_size()

var HUD_width = screen.x
var HUD_height = 100

func _ready() -> void:
	$Background.rect_position = Vector2(0, 500)	
	$Background.rect_size = Vector2(HUD_width, HUD_height)
	$Background.color = Color(0, 0, 0)
	
	$ShuffleButton.rect_position = Vector2(screen.x/2 - $ShuffleButton.rect_size.x/2, 500 + 1)
	
	$SortButton.text = "Sort"
	$SortButton.rect_size = $ShuffleButton.rect_size
	$SortButton.rect_position = Vector2(screen.x/2 - $SortButton.rect_size.x/2, 600 - $ShuffleButton.rect_size.y - 1)
