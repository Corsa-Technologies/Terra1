extends CharacterBody2D

@export var speed: float = 150.0
@export var gravity: float = 500.0
@export var patrol_tolerance: float = 10.0
@export var max_health: int = 300
@export var damage: int = 15

@onready var health_bar: ProgressBar = $BarradeVida
@onready var damage_timer: Timer = $Timer
@onready var explosao: AnimatedSprite2D = $explosao

var patrol_points: Array = []
var current_patrol_index: int = 0
var player_target: Node = null
var current_health: int = max_health
var player_in_hitbox: Node = null
var is_attacking: bool = false  # Variável para controlar o estado de ataque


func _ready():
	health_bar.max_value = max_health
	health_bar.value = current_health
	health_bar.visible = false
	$explosao.visible = false
	if has_node("patrulha1"):
		var patrol_parent = $patrulha1
		for point in patrol_parent.get_children():
			if point is Marker2D:
				patrol_points.append(point.global_position)
	else:
		$AnimatedSprite2D.play('idle')

func _physics_process(delta):
	if is_attacking:
		# Durante o ataque, o inimigo não se move
		return
	
	velocity.y += gravity * delta

	if player_target:
		# Movimento em direção ao jogador
		var direction = (player_target.global_position - global_position).normalized()
		velocity.x = direction.x * speed

		# Atualiza a rotação do sprite para refletir a direção
		$AnimatedSprite2D.flip_h = direction.x > 0

		move_and_slide()
		$AnimatedSprite2D.play("walk")
	else:
		# Lógica de patrulha entre os pontos globais dos Markers2D
		if patrol_points.size() > 0:
			var target_position = patrol_points[current_patrol_index]
			var direction = (target_position - global_position).normalized()
			velocity.x = direction.x * speed

			# Atualiza a rotação do sprite para refletir a direção
			$AnimatedSprite2D.flip_h = direction.x > 0
			move_and_slide()

			# Verifica se o inimigo chegou ao ponto de patrulha
			if global_position.distance_to(target_position) < patrol_tolerance:
				current_patrol_index = (current_patrol_index + 1) % patrol_points.size()

			$AnimatedSprite2D.play("walk")
		else:
			$AnimatedSprite2D.play("idle")

func _on_detection_area_body_entered(body):
	if body.name == ("Player"):
		player_target = body

func _on_detection_area_body_exited(body):
	if body.name == ("Player"):
		player_target = null

func _on_hitbox_body_entered(body):
	if body.name == "Player" and not is_attacking:
		player_in_hitbox = body
		damage_timer.start()  # Começa o timer para dano periódico
		start_attack()

func _on_hitbox_body_exited(body):
	if body.name == "Player":
		player_in_hitbox = null
		damage_timer.stop()  # Para o timer quando o jogador sai da hitbox

func _on_timer_timeout():
	if player_in_hitbox:
		player_in_hitbox.take_damage(damage)  # Aplica dano periódico

func take_damage(amount: int):
		health_bar.visible = true
		current_health -= amount
		health_bar.value = current_health
		if current_health <= 0:
			die()


func start_attack():
	if is_attacking:
		return  # Evita iniciar outro ataque enquanto já está atacando
	
	is_attacking = true
	velocity = Vector2.ZERO  # Faz o inimigo parar de se mover
	$AnimatedSprite2D.play("attack")  # Toca a animação de ataque
	
	# Aplica dano imediatamente ao jogador
	if player_in_hitbox:
		player_in_hitbox.take_damage(damage)
	
	# Define a duração fixa para o ataque
	await get_tree().create_timer(0.8).timeout  # Ajuste a duração conforme necessário
	
	is_attacking = false  # Retorna ao estado normal

func die():
	get_node("hitbox").queue_free()
	$AnimatedSprite2D.visible = false
	
	# Reproduz a animação de explosão
	explosao.visible = true
	explosao.play("explosao")
	set_physics_process(false)


func _on_explosao_animation_finished() -> void:
	queue_free()
