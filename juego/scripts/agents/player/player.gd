extends CharacterBody3D

const SPEED = 3.0
const RUN_SPEED = 6.0
const JUMP_VELOCITY = 4.5

@onready var sprite = $Sprite3D

func _physics_process(delta: float) -> void:
	# Aplicar gravedad
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Saltar
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Detectar si Shift está presionado (mantener para correr)
	var is_running := Input.is_key_pressed(KEY_SHIFT)
	var current_speed := RUN_SPEED if is_running else SPEED

	# Dirección de entrada (solo eje X)
	var input_dir := Input.get_axis("ui_left", "ui_right")
	var direction := Vector3(input_dir, 0, 0).normalized()

	# Movimiento
	if direction:
		velocity.x = direction.x * current_speed

		# 🔄 Rotar el sprite según la dirección
		if direction.x > 0:
			sprite.rotation.y = 0  # Mira a la derecha
		elif direction.x < 0:
			sprite.rotation.y = deg_to_rad(180)  # Mira a la izquierda
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Bloquear eje Z
	velocity.z = 0

	move_and_slide()
