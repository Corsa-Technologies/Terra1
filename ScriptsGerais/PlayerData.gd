extends Node

# Variável para armazenar a vida do jogador
var player_health: int = 100
var max_health: int = 100  # Valor máximo de vida do jogador

# Variável para armazenar a quantidade de curas do jogador
var heals_available: int = 3  # Número inicial de curas

# Função para ajustar a vida do jogador, respeitando o valor máximo
func set_health(amount: int):
	player_health = clamp(amount, 0, max_health)

# Função para ajustar a quantidade de curas, respeitando o mínimo de 0
func set_heals(amount: int):
	heals_available = max(amount, 0)
