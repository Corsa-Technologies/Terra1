extends Area2D



@onready var botao_interacao_abrir = $abrir
@onready var nota_canvas = $Nota1_canvas  # O CanvasLayer para exibir a nota
@onready var botao_interacao_fechar = $Nota1_canvas/fechar

func _ready():
	nota_canvas.visible = false  # Começa oculto
	botao_interacao_abrir.visible = false
	botao_interacao_abrir.connect("pressed", Callable(self, "_on_touch_screen_button_pressed"))
	botao_interacao_fechar.connect("pressed", Callable(self, "_on_fechar_pressed"))

# Quando o botão de abrir é pressionado
func _on_abrir_pressed():
	nota_canvas.visible = true  # Torna a nota visível na tela
	GlobalSignals.emit_signal("nota_aberta")  # Emite o sinal "nota_aberta"
	print('Nota aberta')
	
# Quando o botão de fechar é pressionado
func _on_fechar_pressed() -> void:
	nota_canvas.visible = false
	GlobalSignals.emit_signal("nota_fechada")  # Emite o sinal "nota_fechada"
	print('Nota fechada')


func _on_body_entered(body: CharacterBody2D) -> void:
	if body.name == 'Player':
		botao_interacao_abrir.visible = true
