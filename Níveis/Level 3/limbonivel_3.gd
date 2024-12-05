extends Area2D


@export var teleport_x: float = -1771 # Posição X desejada
@export var teleport_y: float = 3273  # Posição Y desejada

func _on_body_entered(body: CharacterBody2D):
	if body.name == ("Player"):
		transicaotela.transition()
		body.global_position = Vector2(teleport_x, teleport_y)  # Teleporta o jogador
