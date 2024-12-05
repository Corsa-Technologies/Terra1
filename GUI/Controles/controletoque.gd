extends CanvasLayer

@onready var esquerda = $Control/Esquerda
@onready var direita = $Control/Direita
@onready var pulo = $Control/Pulo
@onready var descer = $Control/Descer
@onready var tiro = $Control/Tiro
@onready var ataque = $Control/Ataque
@onready var health_text = $Control/HealthText
@onready var dashcontrole =$Control/Dash

func _ready():
	# Conecta os sinais do Dialogic e o sinal global das notas
	Dialogic.timeline_started.connect(_on_timeline_started)
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	GlobalSignals.connect("nota_aberta", Callable(self, "_on_nota_aberta"))
	GlobalSignals.connect("nota_fechada", Callable(self, "_on_nota_fechada"))

func _on_timeline_started():
	descer.visible = false
	esquerda.visible = false
	direita.visible = false
	pulo.visible = false
	tiro.visible = false
	ataque.visible = false
	dashcontrole.visible = false


func _on_timeline_ended():
	# Mostra novamente os nodes de controle após o diálogo
	descer.visible = true
	esquerda.visible = true
	direita.visible = true
	pulo.visible = true
	tiro.visible = true
	ataque.visible = true
	dashcontrole.visible = true

func _on_nota_aberta():
	descer.visible = false
	esquerda.visible = false
	direita.visible = false
	pulo.visible = false
	tiro.visible = false
	ataque.visible = false
	dashcontrole.visible = false
	
func _on_nota_fechada():
	descer.visible = true
	esquerda.visible = true
	direita.visible = true
	pulo.visible = true
	tiro.visible = true
	ataque.visible = true
	dashcontrole.visible = true
	
	
# Atualiza o texto da vida
func update_health_text(current_health: int, max_health: int) -> void:
	health_text.text = "Vida: " + str(current_health) + " / " + str(max_health)

func _on_esquerda_pressed():
	esquerda.modulate.a = 0.5

func _on_esquerda_released():
	esquerda.modulate.a = 1.0

func _on_direita_pressed():
	direita.modulate.a = 0.5

func _on_direita_released():
	direita.modulate.a = 1.0

func _on_pulo_pressed():
	pulo.modulate.a = 0.5

func _on_pulo_released():
	pulo.modulate.a = 1.0

func _on_descer_pressed():
	descer.modulate.a = 0.5

func _on_descer_released():
	descer.modulate.a = 1.0

func _on_tiro_pressed():
	tiro.modulate.a = 0.5

func _on_tiro_released():
	tiro.modulate.a = 1.0

func _on_ataque_pressed():
	ataque.modulate.a = 0.5

func _on_ataque_released():
	ataque.modulate.a = 1.0


func _on_dash_pressed() -> void:
	print('apertado')
