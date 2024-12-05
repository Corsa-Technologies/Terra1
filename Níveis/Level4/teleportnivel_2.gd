extends Area2D

# Função chamada quando o corpo entra na área
func _on_body_entered(body):
	# Verifica se o corpo que entrou é o jogador (ajuste a verificação conforme o nome do jogador)
	if body.name == "Player":
		# Carrega a cena "nível1"
		transicaotela.transition()
		get_tree().change_scene_to_file("res://Níveis/Level 2/Level 2.tscn")
