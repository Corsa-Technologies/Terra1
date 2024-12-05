extends Node2D

# Função chamada quando um corpo entra na área
func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.name == "Player":
		PlayerData.heals_available += 1  # Aumenta a quantidade de curas disponíveis no singleton
		body.update_heal_display()  # Atualiza a exibição da cura no jogador
		queue_free()  # Remove a seringa da cena
