extends Node

var screen_width  := OS.get_window_size().x
var screen_height := OS.get_window_size().y

const column_width = 10
var column_list = []


func _ready() -> void:	
	randomize()
	var column_height_list = []
	
	$HUD/ShuffleButton.connect("pressed", self, "_on_ShuffleButton_pressed")
	$HUD/SortButton.connect("pressed", self, "_on_SortButton_pressed")
	
	for i in range(1, screen_height - $HUD.HUD_height + 1, (screen_height - $HUD.HUD_height)/(screen_width/(column_width + 1))):
		column_height_list.append(i)
	
	for i in screen_width/(column_width + 1) - 1:
		var new_column = ColorRect.new()
#		var column_height_choise = randi()%column_height_list.size()

		new_column.margin_bottom = column_height_list[i]
		new_column.margin_right = column_width
		new_column.rect_position.x = column_width*(i) + i
		new_column.color = Color(1, 0.15, 0.65, 1)
#		new_column.color = Color(rand_range(0,1), rand_range(0,1), rand_range(0,1))
		
		column_list.append(new_column)
		add_child(column_list[i])
		
#		column_height_list.remove(column_height_choise)


func column_select_animation(column):
	column.color.a = 0.3
	yield(get_tree().create_timer(0.003), "timeout")
	column.color.a = 1


func _on_ShuffleButton_pressed() -> void:
	var column_list_margin_bottom_copy = []
	
	for i in column_list:
		column_list_margin_bottom_copy.append(i.margin_bottom)
		
	column_list_margin_bottom_copy.shuffle()
	
	for i in column_list_margin_bottom_copy.size():
		column_list[i].margin_bottom = column_list_margin_bottom_copy[i]


func _on_SortButton_pressed() -> void:
	yield(column_sort(), "completed")
	column_mexican_wave()


func column_swap(column1, column2) -> void:
	var tmp = column1.margin_bottom
	column1.margin_bottom = column2.margin_bottom
	column2.margin_bottom = tmp


func column_sort() -> void:
	for i in range(0, column_list.size()):
		
		for j in range(i+1, column_list.size()):
			
			yield(column_select_animation(column_list[j]), "completed")
			
			
			if(column_list[j].margin_bottom < column_list[i].margin_bottom):
				yield(column_select_animation(column_list[i]), "completed")
				column_swap(column_list[i], column_list[j])


func column_mexican_wave() -> void:
	yield(get_tree().create_timer(0.5), "timeout")
	for c in column_list:
		yield(column_select_animation(c), "completed")
