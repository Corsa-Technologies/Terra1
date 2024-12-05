extends Area2D

func _on_body_entered(body: CharacterBody2D):
	if body.name == "Player":
		transicaotela.transition()
		get_tree().change_scene_to_file("res://GUI/Menus/MenuPrincipal/Menuprincipal.tscn")
		queue_free()
