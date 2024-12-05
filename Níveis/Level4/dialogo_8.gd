extends Area2D


func _on_body_entered(body: CharacterBody2D):
	if body.name == "Player":
		Dialogic.start('dialogo8')
		queue_free()
	var barreira = get_parent().get_node("barreirasementeira") # Encontra o nó "barreira"
	if barreira:
		barreira.queue_free() # Remove a barreira
