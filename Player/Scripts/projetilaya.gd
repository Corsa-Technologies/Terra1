extends CharacterBody2D 
@onready var animacao = $AnimatedSprite2D
@export var SPEED = 600
@export var damage = 10  # Dano que o projétil causa

var direction: Vector2  # A direção do projétil

func _ready():
	$AnimatedSprite2D.play('default')
	# Define a rotação do projétil para a direção de movimento
	rotation = direction.angle()  # Ajusta a rotação para a direção

	# Remove o projétil após 1,5s, caso não colida com nada
	await get_tree().create_timer(1.5).timeout
	queue_free()  # Remove o projétil da cena

func _physics_process(delta):
	velocity = direction * SPEED  # Move o projétil na direção especificada
	move_and_slide()

# Função que será chamada quando o projétil colidir com um corpo

func _on_area_2d_body_entered(body: CharacterBody2D):  # Verifica se o objeto que colidiu está no grupo "Player"
	if body is CharacterBody2D:
		var hurtbox = body.get_node("hurtbox")
		if hurtbox:
			hurtbox.get_parent().take_damage(50)
			queue_free()
