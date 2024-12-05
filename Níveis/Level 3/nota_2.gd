extends Area2D

@onready var nota_canvas = $nota2canvas  # O CanvasLayer para exibir a nota
@onready var botao_interacao_fechar = $nota2canvas/fechar

func _ready():
	nota_canvas.visible = false  # Começa oculto
	botao_interacao_fechar.connect("pressed", Callable(self, "_on_fechar_pressed"))

# Quando o botão de fechar é pressionado
func _on_fechar_pressed() -> void:
	nota_canvas.visible = false
	GlobalSignals.emit_signal("nota_fechada")  # Emite o sinal "nota_fechada"
	print('Nota fechada')

# Quando o player entra na área
func _on_body_entered(body: CharacterBody2D) -> void:
	if body.name == 'Player':
		nota_canvas.visible = true  # Torna a nota visível na tela
		GlobalSignals.emit_signal("nota_aberta")  # Emite o sinal "nota_aberta"
		print('Nota aberta')
