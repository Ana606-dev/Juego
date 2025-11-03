extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var anim := $AnimatedSprite3D

func _physics_process(delta: float) -> void:
	# Aplicar gravedad
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Saltar
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("jump")  # Animación de salto

	# Dirección de movimiento (usando input)
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	# Movimiento
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED

		# Reproducir animación de movimiento
		if anim.animation != "walk":
			anim.play("walk")

		# Hacer que mire hacia donde se mueve
		anim.flip_h = direction.x < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

		# Animación de idle cuando no se mueve
		if is_on_floor() and anim.animation != "idle":
			anim.play("idle")

	# Aplicar el movimiento final
	move_and_slide()
