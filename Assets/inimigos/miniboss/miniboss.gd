extends CharacterBody2D

@export var speed: float = 50.0
@export var gravity: float = 500.0
@export var patrol_tolerance: float = 10.0
@export var max_health: int = 1000
@export var damage: int = 25

@onready var health_bar: ProgressBar = $BarradeVida
@onready var damage_timer: Timer = $Timer # Referência ao Timer

var patrol_points: Array = []
var current_patrol_index: int = 0
var player_target: Node = null
var current_health: int = max_health
var player_in_hitbox: Node = null # Referência ao jogador dentro da hitbox

func _ready():
	health_bar.max_value = max_health
	health_bar.value = current_health
	$explosao.visible = false
	health_bar.visible = false
	if has_node("patrulha1"):
		var patrol_parent = $patrulha1
		for point in patrol_parent.get_children():
			if point is Marker2D:
				patrol_points.append(point.global_position)
	else:
		$AnimatedSprite2D.play('idle')

func _physics_process(delta):
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
	if body.name == "Player":
		player_target = body

func _on_detection_area_body_exited(body):
	if body.name == "Player":
		player_target = null

func _on_hitbox_body_entered(body):
	if body.name == "Player":
		player_in_hitbox = body

		player_in_hitbox.take_damage(damage)

		damage_timer.start()

func _on_hitbox_body_exited(body):
	if body.name == "Player":
		player_in_hitbox = null

		damage_timer.stop()

func _on_timer_timeout():

	if player_in_hitbox:
		player_in_hitbox.take_damage(damage)

func take_damage(amount: int):
	health_bar.visible = true
	current_health -= amount
	health_bar.value = current_health
	if current_health <= 0:
		die()

func die():
	# Esconde o AnimatedSprite2D principal (do inimigo)
	$AnimatedSprite2D.visible = false
	
	# Reproduz a animação de explosão
	$explosao.visible = true
	$explosao.play("explosao")

	# Faz o inimigo parar de se mover
	velocity = Vector2.ZERO
	
	# Remove a barreira (se existir) e a área
	var barreira = get_parent().get_node("barreirafim2")
	if barreira:
		barreira.queue_free()  # Remove a barreira

func _on_explosao_animation_finished() -> void:
	queue_free()  # Remove o inimigo após a animação de explosão
