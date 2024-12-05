extends Area2D

func _on_body_entered(body: CharacterBody2D):
	if body.name == "Player":
		Dialogic.start('Dialogo5')
		await get_tree().create_timer(5.0).timeout # Aguarda 2 segundos
		var barreira = get_parent().get_node("barreirafim") # Encontra o nó "barreira"
		if barreira:
			barreira.queue_free() # Remove a barreira
		queue_free() # Remove o Area2D
