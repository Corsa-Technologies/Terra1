extends Control

func _on_botão_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Níveis/Level1/level1.tscn")
	transicaotela.transition()
